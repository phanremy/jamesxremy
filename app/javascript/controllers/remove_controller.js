import { Controller } from '@hotwired/stimulus'

/*
 * Values:
 *
 * Notes:
 *
 * Example:
 *
 */
export default class extends Controller {
  static values = { closeIfClickOutOfPanel: { type: Boolean, default: false } }

  initialize () {
    if (this.closeIfClickOutOfPanelValue) {
      this.setClickListenerOutOfPanel()
    }
  }

  setClickListenerOutOfPanel () {
    window.addEventListener('click', (e) => {
      if (!this.element.contains(e.target)) {
        this.proceed()
      }
    })
  }

  proceed () {
    this.element.remove()
  }
}
