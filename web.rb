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
  docker = JSON.parse(params[:payload])
  repo = docker['repository']
  open("http://lingr.com/api/room/say?room=#{params[:room]}&bot=docker&text=[#{repo['repo_name']}]#{repo['repo_url']}&bot_verifier=939ed21d76213881b45e2326ac89a99d64478d67").read
end
