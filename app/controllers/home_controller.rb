class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @regular_links = get_top_links(RegularLink)
    @temporal_links = get_top_links(TemporalLink)
    @private_links = get_top_links(PrivateLink)
    @ephemeral_links = get_top_links(EphemeralLink)
  end

  private

  def get_top_links(link_type)
    link_type
      .left_outer_joins(:link_accesses)
      .where(user_id: current_user.id)
      .group('links.id')
      .order('COUNT(link_accesses.id) DESC')
      .limit(5)
  end
end
