class TweetsController < ApplicationController
  def search
    respond_to do |format|
      format.html # show.html.erb
    end

    require 'twitter'
    require 'fastimage'

    client = Twitter::REST::Client.new do |config|
      config.consumer_key         = Rails.application.secrets.consumerkey
      config.consumer_secret      = Rails.application.secrets.consumer_secret

    word = "猫" + " exclude:retweets"
    count = 0
    client.search(word, :result_type => "recent", :include_entities => true).each do |tweet|
    tweet.media.each do |media|
    break if count > 9
    puts media.media_url
    count += 1
    end
    end
