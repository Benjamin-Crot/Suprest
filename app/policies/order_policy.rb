class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    return true
  end

  def list_orders?
    return true
  end

  def modal_details_orders_supplier?
    return true
  end

end
