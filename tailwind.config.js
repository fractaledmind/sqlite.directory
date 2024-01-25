module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [
    require("@tailwindcss/forms")
  ],
  theme: {
    extend: {
      keyframes: {
        bouncing: {
          '25%': { transform: 'translateY(-15%)' },
          '40%': { transform: 'translateY(-3%)' },
          '0%, 60%, 100%': { transform: 'translateY(0)' },
        }
      },
      animation: {
        bouncing: 'bouncing 2s cubic-bezier(.5, -.3, .1, 1.5) infinite',
      }
    }
  }
}
