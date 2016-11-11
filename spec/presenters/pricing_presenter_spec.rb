require "rails_helper"

RSpec.describe PricingPresenter do
  describe "#allowance" do
    it "returns the pricing's allowance" do
      user = create(:user)

      pricing = Pricing.new(
        id: "tier1",
        price: 49,
        range: 1..4,
        title: "Chihuahua",
      )
      presenter = PricingPresenter.new(pricing: pricing, user: user)
      expect(presenter.allowance).to eq pricing.allowance
    end
  end

  describe "#as_json" do
    it "returns the pricing as a hash" do
      user = create(:user)

      pricing = Pricing.new(
        id: "tier1",
        price: 49,
        range: 1..4,
        title: "Chihuahua",
      )
      presenter = PricingPresenter.new(pricing: pricing, user: user)
      expect(presenter.as_json).to eq(
        current: presenter.current?,
        name: pricing.title,
        price: pricing.price,
        upto: pricing.allowance,
      )
    end
  end

  describe "#current?" do
    it "returns true" do
      membership = create(:membership)
      user = membership.user
      create(:subscription, repo: membership.repo, user: user)

      pricing = Pricing.new(
        id: "tier1",
        price: 49,
        range: 1..4,
        title: "Chihuahua",
      )
      presenter = PricingPresenter.new(pricing: pricing, user: user)
      expect(presenter.current?).to be(true)
    end

    context "when the pricing does not match the user's current pricing" do
      it "returns false" do
        membership = create(:membership)
        user = membership.user
        create(:subscription, repo: membership.repo, user: user)

        pricing = Pricing.new(
          id: "tier2",
          price: 99,
          range: 5..10,
          title: "Labrador",
        )
        presenter = PricingPresenter.new(pricing: pricing, user: user)
        expect(presenter.current?).to be(false)
      end
    end
  end

  describe "#next?" do
    it "returns true" do
      membership = create(:membership)
      user = membership.user
      create(:subscription, repo: membership.repo, user: user)

      pricing = Pricing.new(
        id: "tier1",
        price: 49,
        range: 1..4,
        title: "Chihuahua",
      )
      presenter = PricingPresenter.new(pricing: pricing, user: user)
      expect(presenter.next?).to be(true)
    end

    context "when the pricing does not match the user's next pricing" do
      it "returns false" do
        membership = create(:membership)
        user = membership.user
        create(:subscription, repo: membership.repo, user: user)

        pricing = Pricing.new(
          id: "tier2",
          price: 99,
          range: 5..10,
          title: "Labrador",
        )
        presenter = PricingPresenter.new(pricing: pricing, user: user)
        expect(presenter.next?).to be(false)
      end
    end
  end

  describe "#open_source?" do
    it "returns the pricing's open source state" do
      pricing = instance_double(Pricing, open_source?: true)
      user = instance_double(User)
      presenter = PricingPresenter.new(pricing: pricing, user: user)

      expect(presenter).to be_open_source
    end
  end

  describe "#price" do
    it "returns the pricing's price" do
      user = create(:user)

      pricing = Pricing.new(
        id: "tier1",
        price: 49,
        range: 1..4,
        title: "Chihuahua",
      )
      presenter = PricingPresenter.new(pricing: pricing, user: user)
      expect(presenter.price).to eq pricing.price
    end
  end

  describe "#to_partial_path" do
    it "returns 'pricings/open_source'" do
      pricing = instance_double(Pricing, open_source?: true)
      user = instance_double(User)
      presenter = PricingPresenter.new(pricing: pricing, user: user)

      expect(presenter.to_partial_path).to eq("pricings/open_source")
    end

    context "when the pricing is for private repos" do
      it "returns 'pricings/private'" do
        pricing = instance_double(Pricing, open_source?: false)
        user = instance_double(User)
        presenter = PricingPresenter.new(pricing: pricing, user: user)

        expect(presenter.to_partial_path).to eq("pricings/private")
      end
    end
  end

  describe "#title" do
    it "returns the pricing's title" do
      user = create(:user)

      pricing = Pricing.new(
        id: "tier1",
        price: 49,
        range: 1..4,
        title: "Chihuahua",
      )
      presenter = PricingPresenter.new(pricing: pricing, user: user)
      expect(presenter.title).to eq pricing.title
    end
  end
end
