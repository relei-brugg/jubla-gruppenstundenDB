# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|

  config.wrappers :bootstrap3, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.wrapper :controls, tag: 'div', class: 'col-sm-8' do |ba|
      ba.use :input
      ba.use :error, wrap_with: { tag: 'span', class: 'help-inline' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  config.default_wrapper = :bootstrap3
  config.button_class = 'btn btn-primary'
  config.error_notification_class = 'alert alert-danger'

  config.label_class = 'control-label col-sm-2'
  config.input_class = 'form-control'

  config.browser_validations = false

  SimpleForm.bootstrap3 = true

end
