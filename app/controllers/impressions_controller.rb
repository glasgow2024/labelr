# frozen_string_literal: true
class ImpressionsController < ResourceController
  SERIALIZER_CLASS = 'ImpressionSerializer'.freeze
  POLICY_CLASS = 'ImpressionPolicy'.freeze
  POLICY_SCOPE_CLASS = 'ImpressionPolicy::Scope'.freeze

  def before_save
    @object.date_printed = DateTime.now() unless @object.date_printed
    
    begin
      registrant = @object.registable
      product = registrant.product
      @object.product_id = product.id
      @object.product_list_name = product.list_name
    rescue Exception => ex
      # Do nowt
    end
  end

  def allowed_params
    %i[
      id
      lock_version
      registable_id
      registable_type
      user_id
      date_printed
      label_used
      user_name
      label_type
    ]
  end
end
