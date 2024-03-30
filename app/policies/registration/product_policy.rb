#
class Registration::ProductPolicy < ApplicationPolicy
  def index?
    allowed?(action: :index)
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end