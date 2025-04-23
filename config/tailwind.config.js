module.exports = {
  content: [
    "./app/views/**/*.{html.erb,html.haml}",
    "./app/helpers/**/*.rb",
    "./app/assets/javascripts/**/*.js",
    "./app/javascript/**/*.js"
  ],
  theme: {
    extend: {
      colors: {
        primary: "#8eba1c",
        secondary: "#171717",
      }
    }
  },
  plugins: []
}
