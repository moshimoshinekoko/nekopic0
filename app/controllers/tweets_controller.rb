class TweetsController < ApplicationController
  def search
    respond_to do |format|
      format.html # show.html.erb
    end

    require 'twitter'
    require 'fastimage'

    client = Twitter::REST::Client.new do |config|
      # 事前準備で取得したキーのセット

      config.consumer_key         = "sznhA6doIXhXzj6yEtMJcMnpA"
      config.consumer_secret      = "8v4RXZDYd3J5DyqduU3WbUh16a3cKt6Kr7qcg2DnpZ176yyLbC"
    end




    tweets = client.search(params[:keyword], count: 10, result_type: "recent", exclude: "retweets",since_id: since_id)
    imgs = tweets.flat_map { |s| s.media}.map { |m| m.media_url.to_s}


    @imgs = []
    # 検索ワードが存在していたらツイートを取得
    if params[:keyword].present?
      # リツイートを除く、検索ワードにひっかかった最新10件のツイートを取得する

      imgs.concat tweets.flat_map { |s| s.media }.flat_map { |m|
                    case m
                    when Twitter::Media::AnimatedGif
                      m.video_info.variants.map { |v| v.url.to_s }
                    when Twitter::Media::Photo
                      m.media_url.to_s
                    else
                      []
                    end
                  }
      imgs.concat tweets.flat_map { |s| s.urls }.flat_map { |u|
                    case FastImage.type(u.url.to_s)
                    when :bmp, :gif, :jpeg, :png, :webm
                      u.expanded_url.to_s
                    else
                      []
                    end
                  }
      # 取得したツイートをモデルに渡す
      imgs.take(10).each do |tw|
        imgs = Img.new
        @imgs << img
      end
    end

  end
end
