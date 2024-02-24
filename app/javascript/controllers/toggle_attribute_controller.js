import { Controller } from '@hotwired/stimulus'

/**
 * OBJECTIVE: Toggle attribute of elements betwen their activeValue and inactiveValue when
 * calling the toggle method
 *
 * EXAMPLE 1: Toggles the input value
 * <div data-controller="toggle-attribute">
 *  <%= button_tag(id: 'example', type: 'button', role: 'switch',
      data: { action: 'toggle-attribute#toggle' } do %>
      <input data-toggle-attribute-target="element" value="lorem"
      data-attribute-change="value" data-active-value="lorem" data-inactive-value="ipsum">
    <% end %>
 * </div>
 * EXAMPLE 2: Toggles the input type
 * <div data-controller="toggle-attribute">
 *  <%= button_tag(id: 'example', type: 'button', role: 'switch',
      data: { action: 'toggle-attribute#toggle' } do %>
      <input type="text" data-toggle-attribute-target="element" value="lorem"
      data-attribute-change="type" data-active-value="text" data-inactive-value="number">
    <% end %>
 * </div>
 * Add 'Category' to link button and element in cas of multiple elements and multiple
 * triggers
 */

export default class extends Controller {
  static targets = ['element', 'form']

  toggle () {
    let category = event.currentTarget.dataset.category

    this.elementTargets.forEach(element => {
      if ((category) && (element.dataset.category !== category))
        return

      let attributeChange = element.dataset.attributeChange
      if (attributeChange && (element.dataset.activeValue || element.dataset.inactiveValue)) {
        if (element.getAttribute(attributeChange) === element.dataset.activeValue) {
          element.setAttribute(attributeChange, element.dataset.inactiveValue)
        } else {
          element.setAttribute(attributeChange, element.dataset.activeValue)
        }
      }
    })

    if (this.hasFormTarget) {
      this.formTarget.dispatchEvent(new Event('change'))
    }
  }
}
