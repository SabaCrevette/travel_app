import { Application } from '@hotwired/stimulus'

import SliderController from "./slider_controller"

const application = Application.start()
application.register("slider", SliderController)