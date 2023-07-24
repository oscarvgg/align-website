/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['Sources/TaskManagementAppWebsite/Theme/*.swift'],
  theme: {
    extend: {},
  },
  variants: {},
  plugins: [
      require('@tailwindcss/typography'),
      require("daisyui")
  ],
}
