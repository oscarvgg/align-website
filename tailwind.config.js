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
}
