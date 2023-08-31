class Nba::PlayerController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'

  def show
    @player_data = fetch_player_profile(params[:id])
    @player_image_url = @player_data.dig('bio', 'bustImageUrl')
    @players_backgroundColor = @player_data.dig('bio', 'team', 'colors', 'backgroundColor')
    @players_foregroundColor = @player_data.dig('bio', 'team', 'colors', 'foregroundColor')
    @players_stat_columns = @player_data.dig('stats', 'grid', 'columns')
    @players_stat_rows = @player_data.dig('stats', 'grid', 'rows')
    @active_player = @player_data.dig('recentGames')
    @recent_games_columns = @player_data.dig('recentGames', 'grid', 'columns')
    @recent_games_rows = @player_data.dig('recentGames', 'grid', 'rows')
    @player_images = @player_data.dig('bio', 'bustImageUrlGallery')
  end

  private

  def fetch_player_profile(player_id)
    uri = URI.parse("https://api.statmuse.com/players/v2/nba/#{player_id}/profile")
    response = Net::HTTP.get_response(uri)

    # Check if request was successful
    if response.is_a?(Net::HTTPSuccess)
      # Parse JSON response into Ruby Hash
      data = JSON.parse(response.body)
      return data
    else
      pp "Error: #{response.code} #{response.message}"
      return nil
    end
  end
end
