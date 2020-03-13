class StudentsController < ApplicationController

  get '/my_students' do
    if logged_in?
      @students = Student.
      erb :'students/my_students'
    else
      redirect to '/login'
    end
  end

  get '/students/new' do
    if logged_in?
      erb :'students/new'
    else
      redirect to '/login'
    end
  end

  post '/students' do
    if logged_in?
      if params[:student_name] == "" || params[:student_birthday]
        redirect to '/students/new'
      else
        @student = @current_user.students.create(:student_name => params[:student_name], :student_birthday => params[:student_birthday])
        @student.save
        redirect to '/my_students'
      end
    else
      redirect to '/login'
    end
  end
