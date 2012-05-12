SPOTIFY_API_VERSION = 1

module Muzak
	class Spotifier
		def self.track_id_from_term(term)
			call_service_for_term(term.gsub!(' ', '+'))
		end
		private
		def call_service_for_term(term)
			url = "http://ws.spotify.com/search/#{SPOTIFY_API_VERSION}/track.json?q=#{term}"
		end	
		end
	end
end