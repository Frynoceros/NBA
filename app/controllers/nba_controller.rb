class NbaController < ApplicationController

  def index
    @players_data = fetch_players
  end

end
