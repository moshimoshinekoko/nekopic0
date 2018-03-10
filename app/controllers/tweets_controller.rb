class TweetsController < ApplicationController
  def search
    respond_to do |format|
      format.html # show.html.erb
    end

    client = Twitter::REST::Client.new do |config|
      # 事前準備で取得したキーのセット

      config.consumer_key         = "sznhA6doIXhXzj6yEtMJcMnpA"
      config.consumer_secret      = "8v4RXZDYd3J5DyqduU3WbUh16a3cKt6Kr7qcg2DnpZ176yyLbC"
    end

    @tweets = []
    since_id = nil
    # 検索ワードが存在していたらツイートを取得
    if params[:keyword].present?
      # リツイートを除く、検索ワードにひっかかった最新10件のツイートを取得する
      tweets = client.search(params[:keyword], count: 10, result_type: "recent", exclude: "retweets", since_id: since_id)
      # 取得したツイートをモデルに渡す
      tweets.take(10).each do |tw|
        tweet = Tweet.new(tw.full_text)
        @tweets << tweet
      end
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tweets } # jsonを指定した場合、jsonフォーマットで返す
    end
  end
end
