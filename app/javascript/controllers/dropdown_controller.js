import { Controller } from '@hotwired/stimulus'

// <!--
//   Dropdown menu, show/hide based on menu state.

//   Entering: "transition ease-out duration-100"
//     From: "transform opacity-0 scale-95"
//     To: "transform opacity-100 scale-100"
//   Leaving: "transition ease-in duration-75"
//     From: "transform opacity-100 scale-100"
//     To: "transform opacity-0 scale-95"
// -->

export default class extends Controller {
  static targets = [ "button", "content" ]
  static values = { listenClick: { type: Boolean, default: false } }

  connect () {
    if (this.listenClickValue) {
      this.setClickListenerOutOfContent()
    }
  }

  process () {
    if (this.contentTarget.style.width === '0px') {
    } else {
      this.contentTarget.classList.toggle('hidden')
    }
  }

  setClickListenerOutOfContent () {
    window.addEventListener('click', (e) => {

      if (this.contentTarget.classList.contains('hidden')) {
        return
      }

      if (this.buttonTarget.contains(e.target)) {
        return
      }

      if (!this.contentTarget.contains(e.target)) {
        this.process()
      }
    })
  }
}
