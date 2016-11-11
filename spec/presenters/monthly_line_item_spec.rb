require "spec_helper"
require "./app/presenters/monthly_line_item"

RSpec.describe MonthlyLineItem do
  describe "#subtotal_in_dollars" do
    it "returns the amount in dollars" do
      coupon = double("Stripe::Coupon")
      discount = double("Stripe::Discount")
      subscription = double("PaymentGatewaySubscription")
      subtotal = 49.00
      item = MonthlyLineItem.new(subscription)

      allow(coupon).to receive(:amount_off).once.with(no_args).and_return(0)
      allow(coupon).to receive(:percent_off).once.with(no_args).and_return(0)
      allow(coupon).to receive(:valid).with(no_args).and_return(true)
      allow(discount).to receive(:coupon).with(no_args).and_return(coupon)
      allow(subscription).to receive(:discount).with(no_args).
        and_return(discount)
      allow(subscription).to receive(:plan_amount).once.with(no_args).
        and_return(4900)
      allow(subscription).to receive(:quantity).once.with(no_args).and_return(1)

      expect(item.subtotal_in_dollars).to eq subtotal
    end
  end
end
