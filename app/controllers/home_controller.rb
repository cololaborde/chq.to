class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @regular_links = RegularLink.all.where({ user_id: current_user.id})
    # @temporal_links = TemporalLink.all.where(user_id: current_user.id)
    # @private_links = PrivateLink.all.where(user_id: current_user.id)
    # @ephemeral_links = EphemeralLink.all.where(user_id: current_user.id)
  end
end
