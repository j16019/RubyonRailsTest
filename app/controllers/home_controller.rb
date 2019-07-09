# 以下のrequireは、railsの自動require機能により不要になる(!)
=begin
require 'net/http'
require 'uri'
require 'json'
=end

require 'net/http'
require 'uri'
require 'json'

class HomeController < ApplicationController
  def top
  end

  def show
    # hash形式でパラメタ文字列を指定し、URL形式にエンコード
    #params = URI.encode_www_form({zipcode: '7830060'})
    # URIを解析し、hostやportをバラバラに取得できるようにする
    #uri = URI.parse("http://zipcloud.ibsnet.co.jp/api/search?#{params}")

    uri = URI.parse("https://api.openweathermap.org/data/2.5/weather?lat=35&lon=13&appid=6d6cc69b9c9eb779ca25c4b18182b33a")

    @uriString = uri
    # リクエストパラメタを、インスタンス変数に格納
    @query = uri.query

    response = Net::HTTP.get_response(uri)

    # 例外処理の開始
    begin
      # responseの値に応じて処理を分ける
      case response
      # 成功した場合
      when Net::HTTPSuccess
        # responseのbody要素をJSON形式で解釈し、hashに変換
        @result = JSON.parse(response.body)
        # 表示用の変数に結果を格納
      # 別のURLに飛ばされた場合
      when Net::HTTPRedirection
        @message = "Redirection: code=#{response.code} message=#{response.message}"
      # その他エラー
      else
        @message = "HTTP ERROR: code=#{response.code} message=#{response.message}"
      end
    # エラー時処理
    rescue IOError => e
      @message = e.message
    rescue TimeoutError => e
      @message = e.message
    rescue JSON::ParserError => e
      @message = e.message
    rescue => e
      @message = e.message
    end
  end

end
