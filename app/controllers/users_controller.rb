# frozen_string_literal: true
require 'securerandom'

class UsersController < ResourceController
  SERIALIZER_CLASS = 'UserSerializer'.freeze
  POLICY_CLASS = 'UserPolicy'.freeze
  POLICY_SCOPE_CLASS = 'UserPolicy::Scope'.freeze

  # need to add includes etc to speed up query
  skip_before_action :load_resource, only: [:me]
  skip_before_action :authenticate_user!, only: [:me]

  # no before action
  def me
    me = current_user
    authorize me, policy_class: policy_class

    render_object(me, serializer: UserSessionSerializer)
  end

  def before_save
    @object.password = SecureRandom.hex(16) unless @object.password
  end

  def allowed_params
    %i[
      id
      lock_version
      name
      email
      user
      password
      password_confirmation
      role
    ]
  end
end
