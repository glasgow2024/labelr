# frozen_string_literal: true
class ImpressionsController < ResourceController
  SERIALIZER_CLASS = 'ImpressionSerializer'.freeze
  POLICY_CLASS = 'ImpressionPolicy'.freeze
  POLICY_SCOPE_CLASS = 'ImpressionPolicy::Scope'.freeze

  def before_save
    @object.date_printed = DateTime.now() unless @object.date_printed
  end

  def allowed_params
    %i[
      id
      lock_version
      registrant_id
      user_id
      date_printed
      label_used
      user_name
      label_type
    ]
  end
end
