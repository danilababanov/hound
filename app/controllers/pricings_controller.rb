class PricingsController < ApplicationController
  def index
    @pricings = Pricing.all.map do |pricing|
      PricingPresenter.new(pricing: pricing, user: current_user)
    end

    @repo = Repo.find(pricing_params[:repo_id])
  end

  private

  def pricing_params
    params.permit(:repo_id)
  end
end
