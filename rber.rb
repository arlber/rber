require 'rubygems'
require 'sinatra'
require 'haml'
require 'data_mapper'
require 'json'

class Rber < Sinatra::Application

  DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/rber.db")

  class Question
    include DataMapper::Resource

    property :id, Serial
    property :question, Text
    property :answer, Text
  end

  DataMapper.finalize.auto_upgrade!

  get '/' do
    haml :index
  end


  get '/questions' do
    @questions = Question.all
    haml :'questions/index'
  end

  get '/questions/new' do
    haml :'questions/new'
  end

  get '/questions/:id' do
    @question = Question.get(params[:id])
    haml :'questions/show'
  end

  get '/questions/:id/edit' do
    @question = Question.get!(params[:id])
    haml :'questions/edit'
  end

  get '/random.json' do
    content_type :json
    q = Question.first(:offset => rand(Question.count))
    { :question => q.question, :answer => q.answer }.to_json
  end

  post '/questions' do
    q = Question.new(params[:question])
  
    if q.save
      redirect '/questions'
    else
      redirect '/questions/new'
    end
  end

  put '/questions/:id' do
    q = Question.get!(params[:id])
    success = q.update!(params[:question])
    
    if success
      redirect "/questions/#{params[:id]}"
    else
      redirect "/questions/#{params[:id]}/edit"
    end
  end

  delete '/questions/:id' do
    q = Question.get!(params[:id])
    q.destroy!
    redirect "/questions"
  end
end

