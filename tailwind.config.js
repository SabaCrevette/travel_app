module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        'custom-header': '#CBE6F3',
        'custom-body': '#C8EDF0',
        'custom-footer': '#CBE6F3',
      },
      keyframes: {
        slideA: {
          '0%': { transform: 'translateX(100%)' },
          '100%': { transform: 'translateX(-100%)' },
        },
        slideB: {
          '0%': { transform: 'translateX(-100%)' },
          '100%': { transform: 'translateX(100%)' },
        },
        "slide-in-fwd-center": {
          "0%": {
            transform: "translateZ(-1400px)",
            opacity: "0"
          },
          to: {
            transform: "translateZ(0)",
            opacity: "1"
          }
        },
        flashFade: {
          "0%": { transform: "translateX(180px)", opacity: 0 },
          "20%": { transform: "translateX(0)", opacity: 1 },
          "80%": { transform: "translateX(0)", opacity: 1 },
          "100%": { transform: "translateX(180px)", opacity: 0 },
        },
      },
      animation: {
        "slide-in-fwd-center": "slide-in-fwd-center 3.0s cubic-bezier(0.250, 0.460, 0.450, 0.940) both",
        flash: "flashFade 7.0s forwards",
        slideA: 'slideA 30s linear infinite',
        slideB: 'slideB 30s linear infinite',
      }
    }
  },
  plugins: [
    require("daisyui")
  ],
  daisyui: {
    darkTheme: false,
  },
}

