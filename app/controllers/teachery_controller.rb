class TeachersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'teachers/signup'
    else
      redirect to '/my_students'
    end
  end

  post '/signup' do
    if params[:name] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
      #error message should show up on the page
    else
      @teacher = Teacher.new(:name => params[:name], :email => params[:email], :password => params[:password])
      @teacher.save
      session[:user_id] = @teacher.id
      redirect to '/my_students'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'teachers/login'
    else
      redirect to '/my_students'
    end
  end

  post '/login' do
    teacher = Teacher.find_by(:name => params[:name])
    if teacher && teacher.authenticate(params[:password])
      session[:user_id] = @teacher.id
      redirect to '/my_students'
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end


end
