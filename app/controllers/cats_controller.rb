class CatsController < ApplicationController
  def index
end

# -*- coding: utf-8 -*-
require "twitter"

# 変数
limit   = 100     # 取得するツイートの上限数
keyword = "サビ猫"   # ハッシュタグによる検索を行う際のキーワード


# Twitter APIによるリクエスト
client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "[sznhA6doIXhXzj6yEtMJcMnpA]"
    config.consumer_secret     = "[8v4RXZDYd3J5DyqduU3WbUh16a3cKt6Kr7qcg2DnpZ176yyLbC]"
    config.access_token        = "[863641428596973568-CP24mYioXOWiCTyIr1CMtnMMuCVPGTf]"
    config.access_token_secret = "[rwHQp3xYqvs03WymrQpaSKlesFhy7j3dsKkrQgKb3myq6]"
end



# キーワードを含むハッシュタグの検索
def twitterserch
begin
    # limitで指定された数だけツイートを取得
    client.search("#{keyword} -rt", :locale => "ja", :result_type => "recent", :include_entity => true).take(limit).map do |tweet|
        # entities内にメディア(画像等)を含む場合の処理
        if tweet.media? then
            tweet.media.each do |value|
                puts value.media_uri
            end
        end
    end
  end

# 検索ワードでツイートを取得できなかった場合の例外処理
rescue Twitter::Error::ClientError
    puts "ツイートを取得できませんでした"

# リクエストが多すぎる場合の例外処理
rescue Twitter::Error::TooManyRequests => error
    sleep error.rate_limit.reset_in
    retry
end
end
