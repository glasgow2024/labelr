# frozen_string_literal: true
class Registration::ProductsController < ResourceController
  SERIALIZER_CLASS = 'Registration::ProductSerializer'.freeze
  POLICY_CLASS = 'Registration::ProductPolicy'.freeze
  POLICY_SCOPE_CLASS = 'Registration::ProductPolicy::Scope'.freeze

  def paginate
    false
  end
end
