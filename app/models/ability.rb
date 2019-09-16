class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    user.present? ? user_ability(user) : guest_ability
  end

  private

  def guest_ability
    cannot :crud, Order
    can :read, Book
    can :read, Category
    can :read, Review
    can %i[update], Coupon
  end

  def user_ability(user)
    can :read, Book
    can %i[create read], Review
    can :manage, User do |compare_user|
      compare_user.id == user.id
    end
    can %i[update read], Order, user_id: user.id
    can %i[update read], CreditCard, user_id: user.id
    can %i[create destroy update], OrderItem
    can :manage, :all if user.admin
  end
end
