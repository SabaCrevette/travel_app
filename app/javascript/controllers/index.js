import { application } from "./application"

import SliderController from "./slider_controller"
application.register("slider", SliderController)

import TopSliderController from "./top_slider_controller"
application.register("top_slider", TopSliderController)

import MapController from "./map_controller"
application.register("map", MapController)

import { Autocomplete } from "stimulus-autocomplete"
application.register("autocomplete", Autocomplete)

import TagAutocompleteController from "./tag_autocomplete_controller"
application.register("tag-autocomplete", TagAutocompleteController)
