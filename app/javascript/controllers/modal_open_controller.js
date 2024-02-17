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
  static targets = ['modal']

  process () {
    if (document.getElementById('post_form_modal'))
      return

    document.getElementById('main').insertAdjacentHTML('afterbegin', this.modalTarget.innerHTML)
  }
}
