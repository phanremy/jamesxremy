import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [ 'element' ]
  static values = { className: String }

  proceed () {
    this.elementTargets.forEach(element => {
      element.classList.toggle(element.dataset.toggleClassName || this.classNameValue)
    })
  }
}
