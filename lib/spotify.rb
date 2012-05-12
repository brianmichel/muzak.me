SPOTIFY_API_VERSION = 1
module Muzak
  class Spotify
  	include HTTParty
  	base_uri 'ws.spotify.com'

	def self.track_id_from_term(term)
		call_service_for_term(term.gsub!(' ', '+'))
	end
private
	def call_service_for_term(term)
		self.get("/search/#{SPOTIFY_API_VERSION}/track.json?q=#{term}")
 	end	
  end  
end