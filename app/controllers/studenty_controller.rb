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
      if params[:student_name] == "" || params[:student_birthday] == ""
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

  get '/students/:id/edit' do
    if logged_in?
      @student = Student.find_by_id(params[:id])
      if @student && @student.teacher == current_user
        erb :'students/edit_students'
      else
        erb :'/my_students'
      end
    else
      redirect to '/login'
    end
  end

  patch '/students/:id' do
    if logged_in?
      if params[:student_name] == "" || params[:student_birthday] == ""
        redirect to '/students/#{params[:id]}/edit'
      else
        @student = Student.find_by_id(params[:id])
        if @student && @student.teacher == current_user
          if @student.update(student_name: params[:student_name]) || (student_birthday: params[:student_birthday])
            redirect to "/students/#{@student.id}"
          else
            redirect to "/students/#{@student.id}/edit"
          end
        else
          redirect to '/my_students'
        end
      end
    else
      redirect to '/login'
    end
  end

  delete '/my_students/:id/delete' do
    if logged_in?
      @student = Student.find_by_id(params[:id])
      if @student && @student.teacher == current_user
        @student.delete
      end
      redirect to '/my_students'
    else
      redirect to '/login'
    end
  end
