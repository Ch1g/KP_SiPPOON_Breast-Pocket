#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './CRUD'
require 'net/ftp'

configure do
  enable :sessions
end

get '/' do
  erb :blog
end

before '/admin/*' do
  unless session[:identity]
    @access = 'Подтвердите права доступа для посещения ' + request.path
    halt erb(:login)
  end
end

not_found do
  erb :not_found
end

get '/admin/:table/:id/delete' do
  if session[:identity]
    case params[:table]
    when 'versions'
      CRUD::Version.find(params[:id]).delete
    when 'crms'
      CRUD::Crm.find(params[:id]).delete
    else
      redirect to not_found
    end
    $message = [true, params[:table]]
    redirect to "/admin/page"
  end
end

get '/registration' do
  erb :registration
end

get '/login' do
  if session[:identity]
    erb "<div class='alert alert-danger text-center'>Вы уже авторизованы!</div>"
  else
    erb :login
  end
end

get '/logout' do
  if !session[:identity]
    erb "<div class='alert alert-danger text-center'>Чтобы выйти следует прежде авторизоваться!</div>"
  else
    session.delete(:identity)
    erb "<div class='alert alert-success text-center'>До свидания!</div>"
  end
end

post '/admin/versions/new' do
  CRUD::Version.create(version: params[:version], version_change: params[:infos])
  @access = "Информация о версии добавлена!"
  erb :admin
end

post '/feedback' do
  CRUD::Crm.create(name: params[:name], mail: params[:email], feedback: params[:message])
  @access = "Ваш отзыв учтен! Спасибо!"
  erb :blog
end

get '/admin/page' do
  $message && $message[0] == true ? $message[0] = false : $message = nil
  erb :admin
end

get '/download' do
  Net::FTP.open('localhost', 'ftp-usr', '85856864') do |ftp|
    puts 'retrieving "find" module.'
    puts ftp.nlst('backup.*')
    puts 'Starting Download...'
    ftp.nlst('*.zip').each do |file|
      ftp.getbinaryfile(file, "#{Dir.pwd}/#{file}")
      puts "#{file} saved as #{Dir.pwd}/#{file}"
    end
    ftp.close
    puts 'Done.'
  end
  erb "<div class='alert alert-success text-center'>Файл успешно загружен!</div>"
end

post '/login' do
  if CRUD::User.find_by(login: params[:login]) && params[:pass] == CRUD::User.find_by(login: params[:login]).password
    session[:identity] = params[:login]
    erb "<div class='alert alert-success text-center'>Авторизация успешна!</div>"
  else
    @access = "Неверное имя пользователя или пароль"
    erb :login
  end
end