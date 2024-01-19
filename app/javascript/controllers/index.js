import { Application } from '@hotwired/stimulus'
import Carousel from 'stimulus-carousel'
import 'swiper/css/bundle'

import SliderController from "./slider_controller"

const application = Application.start()
application.register("slider", SliderController)