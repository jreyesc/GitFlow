module Front::ShareHelper

	def fb_share(picture, caption, description, link, redirect_uri)  
		app_id = "1494523237489998"
		redirect_uri = "http://development.tektonlabs.com/athena_development/"
		url = "https://www.facebook.com/dialog/feed?app_id=#{app_id}&caption=#{caption}&link=#{link}&redirect_uri=#{redirect_uri}&picture=#{picture}&description=#{description}"
		return url
				
	end

end


