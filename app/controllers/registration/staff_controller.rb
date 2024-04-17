# frozen_string_literal: true
class Registration::StaffController < ResourceController
  SERIALIZER_CLASS = 'Registration::StaffSerializer'.freeze
  POLICY_CLASS = 'Registration::StaffPolicy'.freeze
  POLICY_SCOPE_CLASS = 'Registration::StaffPolicy::Scope'.freeze

  def serializer_includes
    [
      :impressions
    ]
  end

  # Method to get the column names
  def columns
    authorize current_user, policy_class: policy_class

    render json: Registration::Staff.column_names,
        adapter: :json,
        content_type: 'application/json'
  end
end
