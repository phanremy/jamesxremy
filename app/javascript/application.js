// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails'
import { Application } from '@hotwired/stimulus'
import Autosave from 'stimulus-rails-autosave'

import DropdownController from 'controllers/dropdown_controller'
import ModalDisplayController from 'controllers/modal_display_controller'
import ModalOpenController from 'controllers/modal_open_controller'
import RemoveController from 'controllers/remove_controller'
import SlimSelectController from 'controllers/slim_select_controller'
import SubmitFormController from 'controllers/submit_form_controller'
import ToggleAttributeController from 'controllers/toggle_attribute_controller'
import ToggleClassController from 'controllers/toggle_class_controller'

window.Stimulus = Application.start()
Stimulus.register('autosave', Autosave)
Stimulus.register('dropdown', DropdownController)
Stimulus.register('modal-display', ModalDisplayController)
Stimulus.register('modal-open', ModalOpenController)
Stimulus.register('remove', RemoveController)
Stimulus.register('slim-select', SlimSelectController)
Stimulus.register('submit-form', SubmitFormController)
Stimulus.register('toggle-attribute', ToggleAttributeController)
Stimulus.register('toggle-class', ToggleClassController)
