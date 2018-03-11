class ImagesController < ApplicationController
  def index
    require 'twitter'

    @client = Twitter::REST::Client.new do |config|
      config.consumer_key         = ""
      config.consumer_secret      = ""
    end

    word = "シャム猫" + " exclude:retweets"
    count = 0
    @client.search(word, :result_type => "recent", :include_entities => true).each do |tweet|
    tweet.media.each do |media|
    break if count > 9
    puts media.media_url
    count += 1
  end
end
end

 helper_method :index

end
