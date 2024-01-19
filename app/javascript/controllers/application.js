import { Application } from "@hotwired/stimulus"
import 'swiper/css/bundle'

const application = Application.start()
application.debug = false
window.Stimulus = application

export { application }
