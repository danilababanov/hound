class Home
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def open_source_pricings
    select.map { |pricing| present(pricing) }
  end

  def private_pricings
    reject.map { |pricing| present(pricing) }
  end

  private

  def present(pricing)
    PricingPresenter.new(pricing: pricing, user: user)
  end

  def pricings
    Pricing.all
  end

  def reject
    pricings.reject(&:open_source?)
  end

  def select
    pricings.select(&:open_source?)
  end
end
