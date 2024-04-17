#
class Registration::StaffPolicy < ApplicationPolicy
  def index?
    allowed?(action: :index)
  end

  def columns?
    allowed?(action: :columns)
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end