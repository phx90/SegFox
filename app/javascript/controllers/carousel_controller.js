import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slide"]
  static values = { index: Number }

  connect() { this.show() }
  previous() { this.indexValue = (this.indexValue - 1 + this.slideTargets.length) % this.slideTargets.length; this.show() }
  next()     { this.indexValue = (this.indexValue + 1) % this.slideTargets.length;                  this.show() }

  show() {
    this.slideTargets.forEach((el, i) => el.classList.toggle("hidden", i !== this.indexValue))
  }
}