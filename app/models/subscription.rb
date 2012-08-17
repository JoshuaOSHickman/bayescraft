class Subscription < ActiveRecord::Base
  attr_accessible :email, :stripe_customer_token, :stripe_card_token, :user_id, :trial
  has_one :user

  def save_with_payment(password)
    if valid?
      plan = trial? ? "TRIALBAYES29" : "BAYESCRAFT29"
      customer = Stripe::Customer.create(description: email, plan: plan, card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
      user = User.new(:password => password, :subscription_id => self.id)
      user.save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
end
