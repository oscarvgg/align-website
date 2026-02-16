# Align: The time blocking app

## Unlock your productivity potential.
Align is your personal time management tool helping you revolutionize your daily routine.

## Development
- Build the static site: `hugo --cleanDestinationDir`
- Run locally: `hugo server`
- Rebuild styles: `npx tailwindcss -i Sources/Theme/theme.css -o Resources/styles.css`

## Deployment
- Deployment is handled by GitHub Actions via `.github/workflows/deploy-hugo.yml`.
- On every push to `main`, the workflow builds Tailwind + Hugo and publishes `Output/` to the `prod` branch.

### GitHub Pages setup checklist
1. Go to `Settings` → `Pages` in this repository.
2. Set `Source` to `Deploy from a branch`.
3. Set branch to `prod` and folder to `/ (root)`.
4. Keep `main` as the development/default branch (workflow trigger source).
5. Confirm the custom domain is set to `align.day`.
6. Keep `Resources/CNAME` in the repo with `align.day`.
7. If DNS was changed, verify records at the DNS provider:
   - `A` records for apex (`align.day`) point to GitHub Pages IPs.
   - `CNAME` for `www` points to `<org-or-user>.github.io` if `www` is used.
8. In `Pages`, verify deployment status is green and HTTPS is enabled.

## A time management and productivity source of knowledge
Get periodic time management and productivity tips with our blog.

Organize Your Day Effectively with [Align - The Time Blocking App](https://align.day)

[Available on the App Store](https://apps.apple.com/app/align-time-blocking-planner/id6740183716)
