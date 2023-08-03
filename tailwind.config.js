/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    'Sources/TaskManagementAppWebsite/Theme/*.swift',
    'Sources/TaskManagementAppWebsite/Theme/**/*.swift'
  ],
  theme: {
    extend: {
      fontFamily: {
        'serif': 'ui-serif, -apple-system-ui-serif, Charter, serif'
      },
      screens: {
        'sm': '320px',
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
          "base-100": "#1C1C1E",
        },
      },
    ],
  },
}
