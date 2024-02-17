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
  static targets = ['background', 'panel']

  initialize () {
    setTimeout(() => {
      this.setDynamicBackground()
    }, 100)
    setTimeout(() => {
      this.setDynamicPanel()
      this.setClickListenerOutOfPanel()
    }, 300)
  }

  setDynamicBackground () {
    this.backgroundTarget.classList.remove('opacity-0')
    this.backgroundTarget.classList.add('opacity-100')
  }

  setDynamicPanel () {
    this.panelTarget.classList.remove('opacity-0')
    this.panelTarget.classList.remove('translate-y-4')
    this.panelTarget.classList.remove('sm:translate-y-0')
    this.panelTarget.classList.remove('sm:scale-100')
    this.panelTarget.classList.add('opacity-100')
    this.panelTarget.classList.add('translate-y-0')
    this.panelTarget.classList.add('sm:scale-100')
  }

  setClickListenerOutOfPanel () {
    window.addEventListener('click', (e) => {
      if (!this.panelTarget.contains(e.target)) {
        this.close()
      }
    })
  }

  close () {
    this.element.remove()
  }
}
