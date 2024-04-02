# frozen_string_literal: true
class Registration::RegistrantsController < ResourceController
  SERIALIZER_CLASS = 'Registration::RegistrantSerializer'.freeze
  POLICY_CLASS = 'Registration::RegistrantPolicy'.freeze
  POLICY_SCOPE_CLASS = 'Registration::RegistrantPolicy::Scope'.freeze

  def serializer_includes
    [
      :impressions
    ]
  end

  # Method to get the column names
  def columns
    authorize current_user, policy_class: policy_class

    render json: Registration::Registrant.column_names,
        adapter: :json,
        content_type: 'application/json'
  end
end
