#
class ImpressionPolicy < ApplicationPolicy

  class Scope < ApplicationPolicy::Scope
    # TODO: perhaps change for reporting or admin?
    def resolve
      if @user
        scope.where(id: @user.id)
      else
        # return no records
        scope.where(id: nil)
      end
    end
  end
end