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
      }
    },
  },
  variants: {},
  plugins: [
      require('@tailwindcss/typography'),
      require("daisyui")
  ],
}
