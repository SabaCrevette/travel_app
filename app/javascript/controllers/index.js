import { application } from "./application"

import SliderController from "./slider_controller"
application.register("slider", SliderController)

import TopSliderController from "./top_slider_controller"
application.register("top_slider", TopSliderController)

import MapController from "./map_controller"
application.register("map", MapController)