class FormTag < Liquid::Block
  SYNTAX = /(#{Liquid::QuotedFragment})?/

  def initialize(tag_name, markup, context)
    super

    if markup =~ SYNTAX
      @form_name = Regexp.last_match(1).delete('\'')
    else
      raise SyntaxError,
            "Syntax Error in tag '#{tag_name}' - " \
            "Valid syntax: #{tag_name} '[form_name]'"
    end
  end

  # rubocop:disable Lint/EmptyWhen,Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/MethodLength
  def render(context)
    view = context.registers[:view]
    case @form_name
    when 'activate_customer_password'
      # {% form 'activate_customer_password' %}
    when 'create_customer'
      view.form_for(:customer, url: view.new_customer_registration_path) do |_f|
        safe_join[super]
      end
    when 'customer_address'
      # {% form 'customer_address', customer.new_address %}
      # {% form 'customer_address', address %}
    when 'customer_login'
      view.form_for(:customer, url: view.new_customer_session_path) do |_f|
        safe_join[super]
      end
    when 'guest_login'
    when 'new_comment'
      # {% form "new_comment", article %}
    when 'recover_customer_password'
    when 'reset_customer_password'
    end
  end
end

Liquid::Template.register_tag('form', FormTag)
