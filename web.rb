require 'sinatra'
require 'json'
require 'open-uri'

get '/' do
  content_type :text
  "dockerのWebHookをLingrに通知するためのBotです。"
end

post '/' do
  ""
end

get '/:room' do
  content_type :text
  "http://lingr.com/room/#{params[:room]} 用のエンドポイントです。\nhttp://lingr.com/bot/dockerを部屋に追加してから、http://docker-lingrbot.herokuapp.com/#{params[:room]} をDockerのリポジトリのWebHookのURLに設定してください"
end

post '/:room' do
  content_type :text
  docker = JSON.parse(prams[:payload])
  repo = docker['repository']
  status = docker['status_message']
  open("http://lingr.com/api/room/say?room=#{params[:room]}&bot=docker&text=[#{repo['repo_name']}]#{repo['repo_url']}&bot_verifier=255c91a32fc7e70b3421129ad0251df6c2c897d4").read
end
