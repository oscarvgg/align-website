/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: 'media',
  content: [
    'layouts/**/*.html',
    'Content/**/*.md'
  ],
  theme: {
    extend: {
      fontFamily: {
        serif: [
          'New York',
          'Libre Baskerville',
          'Iowan Old Style',
          'Palatino Linotype',
          'Book Antiqua',
          'Georgia',
          'serif'
        ],
        sans: [
          'Inter',
          'SF Pro Text',
          '-apple-system',
          'BlinkMacSystemFont',
          'Segoe UI',
          'sans-serif'
        ]
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
          "primary": "#121212",
          "primary-content": "#FFFFFF",
          "secondary": "#FFFFFF",
          "secondary-content": "#121212",
          "accent": "#DA5841",
          "accent-content": "#121212",
          "neutral": "#F4EFE6",
          "neutral-content": "#2A2A2A",
          "base-100": "#FBF8F1",
          "base-200": "#F4EFE6",
          "base-300": "#E6E0D6",
          "base-content": "#121212",
          "info": "#F4EFE6",
          "success": "#EAF4EA",
          "warning": "#DA5841",
          "error": "#E07A5F"
        },
      },
      {
        dark: {
          ...require("daisyui/src/theming/themes")["[data-theme=dark]"],
          "primary": "#FFFFFF",
          "primary-content": "#121212",
          "secondary": "#1F1F1F",
          "secondary-content": "#FFFFFF",
          "accent": "#CF4C34",
          "accent-content": "#121212",
          "neutral": "#181818",
          "neutral-content": "#EAEAEA",
          "base-100": "#121212",
          "base-200": "#181818",
          "base-300": "#2A2A2A",
          "base-content": "#FFFFFF",
          "info": "#1F1F1F",
          "success": "#253527",
          "warning": "#CF4C34",
          "error": "#D96B4B",
        },
      },
    ],
  },
}
