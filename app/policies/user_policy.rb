#
class UserPolicy < ApplicationPolicy

  def me?
    true
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if @user && @user.admin?
        scope.all
      else # return no records
        scope.where(id: nil)
      end      
    end
  end

end