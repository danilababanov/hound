require "spec_helper"
require "./app/models/pricing"

RSpec.describe Pricing do
  describe ".all" do
    it "returns all of the pricings" do
      pricings = Pricing.all

      expect(pricings.count).to eq 4

      pricing = pricings[0]
      expect(pricing.allowance).to eq 0
      expect(pricing.id).to eq "basic"
      expect(pricing.price).to eq 0
      expect(pricing.title).to eq "Hound"

      pricing = pricings[1]
      expect(pricing.allowance).to eq 4
      expect(pricing.id).to eq "tier1"
      expect(pricing.price).to eq 49
      expect(pricing.title).to eq "Chihuahua"

      pricing = pricings[2]
      expect(pricing.allowance).to eq 10
      expect(pricing.id).to eq "tier2"
      expect(pricing.price).to eq 99
      expect(pricing.title).to eq "Labrador"

      pricing = pricings[3]
      expect(pricing.allowance).to eq 30
      expect(pricing.id).to eq "tier3"
      expect(pricing.price).to eq 249
      expect(pricing.title).to eq "Great Dane"
    end
  end

  describe ".where" do
    it "returns the pricing where the count is in range" do
      pricings = Pricing.where(count: 7)

      expect(pricings.count).to eq 1

      pricing = pricings[0]
      expect(pricing.allowance).to eq 10
      expect(pricing.id).to eq "tier2"
      expect(pricing.price).to eq 99
      expect(pricing.title).to eq "Labrador"
    end
  end

  describe "#==" do
    it "returns true" do
      allowance = 4
      id = "tier1"
      price = 49
      range = 1..allowance
      title = "Chihuahua"
      pricing_1 = Pricing.new(id: id, price: price, range: range, title: title)
      pricing_2 = Pricing.new(id: id, price: price, range: range, title: title)

      expect(pricing_1 == pricing_2).to be(true)
    end

    context "when the pricings have different identifiers" do
      it "returns false" do
        allowance = 4
        id = "tier1"
        price = 49
        range = 1..allowance
        title = "Chihuahua"
        pricing_1 = Pricing.new(
          id: id,
          price: price,
          range: range,
          title: title,
        )
        pricing_2 = Pricing.new(
          id: "tier2",
          price: price,
          range: range,
          title: title,
        )

        expect(pricing_1 == pricing_2).to be(false)
      end
    end
  end

  describe "#allowance" do
    it "returns the upper bound of the range" do
      allowance = 4
      id = "tier1"
      price = 49
      range = 1..allowance
      title = "Chihuahua"
      pricing = Pricing.new(id: id, price: price, range: range, title: title)

      expect(pricing.allowance).to eq allowance
    end
  end

  describe "#id" do
    it "returns the initialised identifier" do
      allowance = 4
      id = "tier1"
      price = 49
      range = 1..allowance
      title = "Chihuahua"
      pricing = Pricing.new(id: id, price: price, range: range, title: title)

      expect(pricing.id).to eq id
    end
  end

  describe "#open_source?" do
    it "returns true" do
      pricing = Pricing.new(
        id: "basic",
        price: 0,
        range: 0..0,
        title: "Hound",
      )

      expect(pricing).to be_open_source
    end

    context "when the price is positive" do
      it "returns false" do
        pricing = Pricing.new(
          id: "tier1",
          price: 49,
          range: 1..4,
          title: "Chihuahua",
        )

        expect(pricing).to_not be_open_source
      end
    end
  end

  describe "#price" do
    it "returns the initialised price" do
      allowance = 4
      id = "tier1"
      price = 49
      range = 1..allowance
      title = "Chihuahua"
      pricing = Pricing.new(id: id, price: price, range: range, title: title)

      expect(pricing.price).to eq price
    end
  end

  describe "#title" do
    it "returns the initialised title" do
      allowance = 4
      id = "tier1"
      price = 49
      range = 1..allowance
      title = "Chihuahua"
      pricing = Pricing.new(id: id, price: price, range: range, title: title)

      expect(pricing.title).to eq title
    end
  end
end
