class NotifyTierChange extends React.Component {
  getCurrentPlan() {
    return this.getPlan(this.getCurrentPlanIndex());
  }

  getCurrentPlanIndex() {
    return _.findIndex(this.getPlans(), { current: true });
  }

  getCurrentPrice() {
    return this.getCurrentPlan().price;
  }

  getExtraCharge() {
    return this.getNewPrice() - this.getCurrentPrice();
  }

  getNewPlan() {
    return this.getPlan(this.getCurrentPlanIndex() + 1);
  }

  getNewPrice() {
    return this.getNewPlan().price;
  }

  getPlan(id) {
    return this.getPlans()[id];
  }

  getPlans() {
    return this.props.plans;
  }

  getTierUsage() {
    return this.getCurrentPlan().upto;
  }

  renderTierPlans() {
    return (
      this.getPlans().map(plan => (
        <TierPlan
          isCurrent={plan === this.getCurrentPlan()}
          isNew={plan === this.getNewPlan()}
          key={plan.name}
          plan={plan}
        />
      ))
    );
  }

  render() {
    const { authenticity_token, repo_id, repo_name } = this.props;

    return (
      <section className="tier-change-container">
        <aside className="tier-change-plans">
          <h3>Plans</h3>
          {this.renderTierPlans()}
        </aside>
        <div className="tier-change-content">
          <h1>Pricing: Change of Plans</h1>
          <section className="tier-change-description">
            <div className="allowance large">
              Private Repos
              <strong>{this.getTierUsage()}/{this.getTierUsage()}</strong>
            </div>
            <p>
              <strong>
                Activating "{repo_name}" will change the price you pay per month.<br/>
              </strong>
              You'll be charged an extra ${this.getExtraCharge()} a month
              (${this.getNewPrice()} total).
            </p>
            <p>
              Upgrade to continue or cancel to deactivate "{repo_name}"
            </p>
          </section>

          <UpgradeSubscriptionLink
            authenticityToken={authenticity_token}
            repoId={repo_id}
          />
          <a className="button tier-change-cancel" href="/repos">Cancel</a>
        </div>
      </section>
  );
  }
}
