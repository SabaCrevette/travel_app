import { Controller } from "@hotwired/stimulus"
import 'swiper/css/bundle'

// Connects to data-controller="slider"
export default class extends Controller {
  static targets = ["slider"]
  currentIndex = 0

  connect() {
    console.log("Slider Controller connected");
    this.showSlide(this.currentIndex)
  }

  next() {
    this.currentIndex = (this.currentIndex + 1) % this.slideTargets.length
    this.showSlide(this.currentIndex)
  }

  previous() {
    this.currentIndex = (this.currentIndex - 1 + this.slideTargets.length) % this.slideTargets.length
    this.showSlide(this.currentIndex)
  }

  showSlide(index) {
    console.log(`Showing slide: ${index}`);
    this.slideTargets.forEach((el, i) => {
      el.style.display = i === index ? "block" : "none"
    })
  }
}
