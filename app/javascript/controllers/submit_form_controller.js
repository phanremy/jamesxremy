import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static values = { autoSubmit: { type: Boolean, default: false },
                    preventValidation: { type: Boolean, default: false } }

  connect () {
    this.form = this.element.closest('form')

    this.oldValue = this.element.type === 'radio' ? this.element.checked : this.element.value
  }

  submit() {
    this.autoSubmitValue ? this.#autoSubmit() : this.#defaultSubmit()
  }

  #autoSubmit() {

    const elementValue = this.element.type === 'radio' ? this.element.checked : this.element.value

    if (elementValue === this.oldValue) return

    if (this.preventValidationValue) {
      this.#preventFormValidation()
    }
    const fieldSubmitter = document.getElementById('field_submitter')
    fieldSubmitter.value = this.#inputElementName(this.element.name)
    this.form.requestSubmit()
  }

  #defaultSubmit() {
    this.form.submit()
  }

  #preventFormValidation() {
    this.form.setAttribute('novalidate', '')
  }

  #inputElementName(htmlInputElementName) {
    let match = htmlInputElementName.match(/\[([^\]]+)\]$/);
    return match ? match[1] : null
  }
}
