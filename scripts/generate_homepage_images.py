#!/usr/bin/env python3
"""Generate homepage redesign imagery for the Align website.

Adapted from marketing-os/scripts/generate_character_images.py. Generates
character cutouts, one scene illustration, and photographic backgrounds with
the Gemini image API (direct mode, inline reference images), post-processes
alpha for cutouts, and exports webp files into Resources/img/home/.

Set GOOGLE_API_KEY before running.
"""

from __future__ import annotations

import argparse
import base64
import json
import mimetypes
import os
import sys
import time
import urllib.error
import urllib.request
from collections import deque
from pathlib import Path

MODEL = "gemini-2.5-flash-image"
API_BASE = "https://generativelanguage.googleapis.com/v1beta"
TRANSIENT = {408, 409, 429, 500, 502, 503, 504}

WEBSITE_DIR = Path(__file__).resolve().parent.parent
OUTPUT_DIR = WEBSITE_DIR / "Resources" / "img" / "home"
RAW_DIR = WEBSITE_DIR / "scripts" / "generated-raw"
REFERENCE_DIR = WEBSITE_DIR.parent / "marketing-os" / "reference characters"
APP_SCREENSHOT = WEBSITE_DIR / "Resources" / "img" / "iphone-screenshot-light.webp"

CHARACTER_REFERENCES = [
    REFERENCE_DIR / "Screenshot 2026-05-28 at 17.53.22.png",
    REFERENCE_DIR / "Screenshot 2026-05-28 at 17.57.00.png",
    REFERENCE_DIR / "Screenshot 2026-05-28 at 17.57.27.png",
    REFERENCE_DIR / "Screenshot 2026-05-28 at 17.57.42.png",
]

STYLE_DIRECTION = """Visual direction:
- Use the attached reference images as the style guide for proportions, simplification level, line/shape language, and editorial mood.
- Do not recreate any exact reference composition; adapt the visual system to this pose and situation.
- Align style: editorial calm productivity, modern lifestyle illustration, Scandinavian editorial warmth, soft mid-century-inspired flat forms.
- Minimal facial details, fashion-inspired proportions, soft geometric shapes, subtle paper texture or grain, calm spacious composition.
- Palette must harmonize with a warm ivory (#F8F5EF) website: warm terracotta, dusty coral, muted teal, olive and leafy green, mustard amber, soft denim blue, charcoal linework, cream. Medium saturation — warm and cozy, never neon, never washed-out beige.
- The person should feel calm, emotionally grounded, slightly aspirational, and relatable."""

CUTOUT_DIRECTION = """- Create a reusable transparent-background PNG cutout, not a full environment or scene.
- If true alpha transparency is unavailable, use a single plain pure white background with no texture, horizon, frame, gradient, or scene elements so it can be removed cleanly.
- Never draw a transparency checkerboard pattern.
- Keep the character centered, fully visible, uncropped, with generous padding around the silhouette.
- No floors, walls, rooms, windows, background cards, decorative floating shapes, or shadows cast onto a surface.

Avoid:
- No visible words, labels, UI text, captions, logos, signatures, or watermark-like marks.
- No cartoon mascot style, anime style, corporate vector art, exaggerated expressions, harsh gradients, busy clutter.

Generate the final isolated asset only."""

PHOTO_STYLE = """Photography direction:
- Editorial lifestyle photograph, soft natural lighting, warm shadows, slightly cinematic, calm and intimate, clean but lived-in.
- Warm ivory / soft beige / muted terracotta tones that harmonize with a warm ivory (#F8F5EF) website background. Muted contrast, slight film grain, warm exposure.

Avoid: neon colors, pure white backgrounds, saturated blues, harsh gradients, HDR look, oversaturated colors, corporate stock-photo feel, visible brand logos, readable text."""


def character_asset(slug: str, description: str, aspect: str = "4:5") -> dict:
    prompt = f"""Create one standalone editorial lifestyle character asset for Align, a calm time-blocking planner for real life.

Subject:
{description}

{STYLE_DIRECTION}
{CUTOUT_DIRECTION}"""
    return {
        "slug": slug,
        "prompt": prompt,
        "aspect_ratio": aspect,
        "transparent": True,
        "references": CHARACTER_REFERENCES,
    }


ASSETS = [
    character_asset(
        "hero-character",
        """An adult woman with long dark wavy hair sitting cross-legged on the floor,
relaxed and serene, holding a warm ceramic mug with both hands near her chest,
eyes softly closed with a content smile. She wears a relaxed terracotta-coral
sweater and dark trousers, barefoot or with simple socks. Full body, three-quarter view.
Emotional goal: calm, grounded, at ease with her day.""",
    ),
    character_asset(
        "pain-rushing",
        """An adult woman mid-stride rushing somewhere, carrying a large tote bag with
papers and a baguette-like roll of documents poking out, one hand raised slightly in mild
alarm, glancing back over her shoulder. White blouse, mustard-yellow wide trousers,
crossbody strap. Full body side view, sense of hurried motion.
Emotional goal: schedule collapsing after one interruption — flustered but relatable, not cartoonish.""",
    ),
    character_asset(
        "pain-optimist",
        """An adult woman joyfully skipping with a jump rope mid-air, cheerful and a bit
naive, wearing a bright patterned pink-coral jacket and soft blue wide-leg trousers,
hair in motion. Full body side view, playful energy.
Emotional goal: planning perfect days that never happen — overly optimistic energy.""",
    ),
    character_asset(
        "pain-stressed-laptop",
        """An adult woman sitting on the floor cross-legged with an open laptop, one hand
pressed to her forehead, slight overwhelm, a few loose paper notes scattered and floating
around her. Cream sweater, dark hair in a loose bun, warm-toned skin. Full body, front view.
Emotional goal: the calendar became a source of stress, not help. Mild overwhelm, never despair.""",
    ),
    character_asset(
        "pain-yoga",
        """An adult person in a yoga downward-dog stretch pose on a small rolled mat,
athletic but relaxed, wearing a sage-green top and charcoal leggings, with a small black
cat standing beside them mimicking the stretch with an arched back. Full body side view.
Emotional goal: endlessly rearranging your entire day — starting over again and again, wry and exhausted but warm.""",
    ),
    character_asset(
        "solution-sitting",
        """An adult woman with dark hair in a high bun sitting relaxed on a simple wooden
chair in side profile, legs crossed, holding a coffee mug and looking forward calmly.
Loose cream long-sleeve top and warm mustard-yellow trousers, simple flats. A small
leafy potted plant sits on the floor beside the chair. The chair and plant are part of
the cutout; nothing else around.
Emotional goal: when life changes, she adapts — unhurried confidence.""",
    ),
    character_asset(
        "features-armchair",
        """An adult woman lounging comfortably in a rounded beige armchair, legs tucked up,
holding a smartphone in one hand and glancing at it with a soft smile, a black cat curled
on her lap. Forest-green sweater, dark hair past her shoulders. The armchair is part of
the cutout; nothing else around.
Emotional goal: seeing her day at a glance, cozy and in control.""",
    ),
    character_asset(
        "testimonial-walking",
        """An adult woman walking confidently to the side, one hand in pocket, carrying a
soft shoulder bag, mustard-amber oversized jacket over a white tee, relaxed blue jeans,
white sneakers, hair in a low bun. Full body side view, mid-step.
Emotional goal: in charge of her day, not the other way around.""",
    ),
    {
        "slug": "plant-decor",
        "prompt": f"""Create one standalone decorative illustration asset for the Align website: a tall
potted plant with slender branches and sparse soft leaves (olive / dried-botanical style),
in a simple terracotta ceramic vase. Matches a calm Scandinavian editorial illustration
system with subtle paper grain, soft geometric shapes, muted warm palette (olive green,
terracotta, cream, charcoal) that harmonizes with a warm ivory website background.

{CUTOUT_DIRECTION}""",
        "aspect_ratio": "4:5",
        "transparent": True,
        "references": CHARACTER_REFERENCES,
    },
    {
        "slug": "philosophy-scene",
        "prompt": f"""Create one editorial scene illustration for Align, a calm time-blocking planner.

Scene: an adult woman with long dark hair, wearing a forest-green sweater, sits at a warm
wooden desk writing in an open paper journal with a pen. On the desk: a dark articulated
desk lamp casting soft light, a small potted plant, a cup of coffee. A black cat sleeps
curled up on the desk beside her. Background is a single flat warm cream wall with subtle
paper grain — spacious, quiet, evening-calm.

{STYLE_DIRECTION}

Composition:
- Landscape composition, subject slightly left of center, generous negative space.
- Flat warm cream background (#F3ECE3 family), no windows, no clutter, no text anywhere.
- Soft shadows only, calm visual hierarchy.

Avoid: visible words or letters, logos, anime or cartoon mascot style, busy composition, harsh gradients.""",
        "aspect_ratio": "4:3",
        "transparent": False,
        "references": CHARACTER_REFERENCES,
    },
    {
        "slug": "hero-backdrop",
        "prompt": f"""An editorial lifestyle photograph for the hero of a calm planner-app website:
a warm, slightly out-of-focus home scene — a wooden table edge with a handmade ceramic
coffee mug, soft linen textures, a leafy green houseplant catching soft window light in
the background, warm morning sun with gentle shadows. No people, no screens, no text.
The center of the frame stays soft and uncluttered so a phone mockup can be overlaid.

{PHOTO_STYLE}""",
        "aspect_ratio": "4:5",
        "transparent": False,
        "references": [],
    },
    {
        "slug": "cta-photo",
        "prompt": f"""An editorial lifestyle photograph: a person's hand holding an iPhone in the
foreground showing exactly the app screen from the attached reference image (a calm
time-blocking calendar app — reproduce its layout and warm colors faithfully on the
screen, slightly angled in perspective). Cozy warm living-room setting behind: a beige
linen sofa with a black cat sleeping curled up, soft warm evening light, shallow depth
of field so the background is gently blurred. The left side of the frame stays soft and
uncluttered so a headline can be overlaid.

{PHOTO_STYLE}""",
        "aspect_ratio": "16:9",
        "transparent": False,
        "references": [APP_SCREENSHOT],
    },
]


def inline_part(path: Path) -> dict:
    mime, _ = mimetypes.guess_type(path)
    return {
        "inline_data": {
            "mime_type": mime or "image/png",
            "data": base64.b64encode(path.read_bytes()).decode("ascii"),
        }
    }


def generate(api_key: str, asset: dict, timeout: float = 240.0, retries: int = 3) -> bytes:
    parts = [inline_part(p) for p in asset["references"] if Path(p).exists()]
    parts.append({"text": asset["prompt"]})
    payload = {
        "contents": [{"role": "user", "parts": parts}],
        "generationConfig": {
            "responseModalities": ["TEXT", "IMAGE"],
            "imageConfig": {"aspectRatio": asset["aspect_ratio"]},
        },
    }
    url = f"{API_BASE}/models/{MODEL}:generateContent"
    body = json.dumps(payload).encode("utf-8")

    for attempt in range(retries + 1):
        request = urllib.request.Request(
            url=url,
            data=body,
            headers={"Content-Type": "application/json", "x-goog-api-key": api_key},
            method="POST",
        )
        try:
            with urllib.request.urlopen(request, timeout=timeout) as response:
                result = json.loads(response.read().decode("utf-8"))
            break
        except urllib.error.HTTPError as error:
            details = error.read().decode("utf-8", errors="replace")[:300]
            if error.code in TRANSIENT and attempt < retries:
                delay = 3 * 2**attempt
                print(f"  HTTP {error.code}, retrying in {delay}s...", file=sys.stderr)
                time.sleep(delay)
                continue
            raise RuntimeError(f"HTTP {error.code}: {details}") from error
        except urllib.error.URLError as error:
            if attempt < retries:
                time.sleep(3 * 2**attempt)
                continue
            raise
    else:
        raise RuntimeError("Exhausted retries.")

    texts = []
    for candidate in result.get("candidates", []):
        for part in candidate.get("content", {}).get("parts", []):
            if "text" in part:
                texts.append(part["text"])
            inline = part.get("inlineData") or part.get("inline_data")
            if inline and inline.get("data"):
                return base64.b64decode(inline["data"])
    raise RuntimeError(f"No image returned. Text: {' '.join(texts)[:300] or '<empty>'}")


def has_visible_alpha(image) -> bool:
    if image.mode not in {"LA", "RGBA"} and "transparency" not in image.info:
        return False
    alpha = image.convert("RGBA").getchannel("A")
    transparent = sum(1 for v in alpha.getdata() if v < 250)
    return transparent / (alpha.width * alpha.height) > 0.05


def postprocess_alpha(path: Path, threshold: int = 36) -> None:
    """Flood-fill the edge-connected plain background to transparent."""
    from PIL import Image

    with Image.open(path) as source:
        if has_visible_alpha(source):
            return
        image = source.convert("RGBA")

    width, height = image.size
    pixels = image.load()

    samples = []
    edge = min(12, width, height)
    for x in range(edge):
        for y in range(edge):
            for px, py in ((x, y), (width - 1 - x, y), (x, height - 1 - y), (width - 1 - x, height - 1 - y)):
                samples.append(pixels[px, py][:3])
    bg = tuple(int(sum(s[c] for s in samples) / len(samples)) for c in range(3))
    threshold_sq = threshold * threshold

    def is_bg(x: int, y: int) -> bool:
        r, g, b, _ = pixels[x, y]
        return (r - bg[0]) ** 2 + (g - bg[1]) ** 2 + (b - bg[2]) ** 2 <= threshold_sq

    queue: deque = deque()
    visited = set()
    for x in range(width):
        for y in (0, height - 1):
            if is_bg(x, y):
                queue.append((x, y))
                visited.add((x, y))
    for y in range(height):
        for x in (0, width - 1):
            if (x, y) not in visited and is_bg(x, y):
                queue.append((x, y))
                visited.add((x, y))

    while queue:
        x, y = queue.popleft()
        r, g, b, _ = pixels[x, y]
        pixels[x, y] = (r, g, b, 0)
        for nx, ny in ((x - 1, y), (x + 1, y), (x, y - 1), (x, y + 1)):
            if 0 <= nx < width and 0 <= ny < height and (nx, ny) not in visited and is_bg(nx, ny):
                visited.add((nx, ny))
                queue.append((nx, ny))

    if visited:
        image.save(path)
        print(f"  alpha-processed: {path.name}")


def export_webp(raw_path: Path, out_path: Path, max_width: int, quality: int = 88) -> None:
    from PIL import Image

    with Image.open(raw_path) as image:
        if image.width > max_width:
            ratio = max_width / image.width
            image = image.resize((max_width, round(image.height * ratio)), Image.LANCZOS)
        image.save(out_path, "WEBP", quality=quality)
    print(f"  saved {out_path} ({out_path.stat().st_size // 1024} KB)")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--only", action="append", default=[], help="Only assets whose slug contains this. Repeatable.")
    parser.add_argument("--force", action="store_true", help="Regenerate even if the raw PNG exists.")
    parser.add_argument("--skip-generate", action="store_true", help="Only post-process and export existing raw PNGs.")
    args = parser.parse_args()

    assets = ASSETS
    if args.only:
        assets = [a for a in assets if any(o in a["slug"] for o in args.only)]
    if not assets:
        print("No assets matched.", file=sys.stderr)
        return 1

    api_key = os.environ.get("GOOGLE_API_KEY") or os.environ.get("GEMINI_API_KEY")
    if not api_key and not args.skip_generate:
        print("GOOGLE_API_KEY is not set.", file=sys.stderr)
        return 1

    RAW_DIR.mkdir(parents=True, exist_ok=True)
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    failures = []
    for index, asset in enumerate(assets, start=1):
        slug = asset["slug"]
        raw_path = RAW_DIR / f"{slug}.png"
        print(f"[{index}/{len(assets)}] {slug}")
        if not args.skip_generate and (args.force or not raw_path.exists()):
            try:
                raw_path.write_bytes(generate(api_key, asset))
            except Exception as error:
                print(f"  FAILED: {error}", file=sys.stderr)
                failures.append(slug)
                continue
            time.sleep(1)
        elif not raw_path.exists():
            print("  no raw PNG, skipping.", file=sys.stderr)
            continue

        if asset["transparent"]:
            postprocess_alpha(raw_path)
            export_webp(raw_path, OUTPUT_DIR / f"{slug}.webp", max_width=900)
        else:
            max_width = 1600 if asset["aspect_ratio"] == "16:9" else 1200
            export_webp(raw_path, OUTPUT_DIR / f"{slug}.webp", max_width=max_width, quality=85)

    if failures:
        print(f"\nFailed: {', '.join(failures)}", file=sys.stderr)
        return 1
    print("\nAll assets generated.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
