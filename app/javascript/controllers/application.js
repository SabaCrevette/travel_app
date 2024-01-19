import { Application } from "@hotwired/stimulus"
import "./application"
import "./slider_controller"
import "./index.js"

const application = Application.start()
application.debug = false
window.Stimulus = application

export { application }
