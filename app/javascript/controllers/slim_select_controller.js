import { Controller } from '@hotwired/stimulus'
import SlimSelect from 'slim-select'

// require('slim-select/dist/slimselect.min.css')

export default class extends Controller {

  connect () {
    if (true) {
      this._fillSelect()
    } else {
      this.element.style.resize = 'vertical'
    }
  }

  _fillSelect() {
    new SlimSelect({
      select: this.element,
      settings: { placeholderText: this.element.dataset.placeholder,
                  searchPlaceholder: this.element.dataset.placeholder,
                  searchText: this.element.dataset.noResult }
    })
  }
}
