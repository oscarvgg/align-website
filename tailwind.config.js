/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    'Sources/AlignWebsite/Theme/*.swift',
    'Sources/AlignWebsite/Theme/**/*.swift'
  ],
  theme: {
    extend: {
      fontFamily: {
        'serif': 'ui-serif, -apple-system-ui-serif, Charter, serif'
      },
      screens: {
        'sm': '320px',
      },
      typography: {
        quoteless: {
          css: {
            'blockquote p:first-of-type::before': { content: 'none' },
            'blockquote p:first-of-type::after': { content: 'none' },
          },
        },
      },
    },
  },
  variants: {
    extend: {
      mainScreen: ['dark'],
    },
  },
  plugins: [
      require('@tailwindcss/typography'),
      require("daisyui")
  ],
  daisyui: {
    themes: [
      {
        light: {
          ...require("daisyui/src/theming/themes")["[data-theme=light]"],
          "primary": "#ffffff",
          "secondary": "#000000",
          "accent": "#EF6351",
          "neutral": "#f3f4f6"
        },
      },
      {
        dark: {
          ...require("daisyui/src/theming/themes")["[data-theme=dark]"],
          "primary": "#000000",
          "secondary": "#ffffff",
          "accent": "#EF6351",
          "base-100": "#0f172a",
          "h1, h2, h3, h4, h5, h6": {
            "color": "#E2E8F0",
          },
        },
      },
    ],
  },
}