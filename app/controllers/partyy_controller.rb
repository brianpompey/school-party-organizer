class PartiesController < ApplicationController

  get '/parties' do
    if logged_in?
      @parties = Student.all
      erb :'parties/parties'
    else
      redirect to '/login'
    end
  end

  get '/parties/new' do
    if logged_in?
      erb :'parties/new'
    else
      redirect to '/login'
    end
  end

  post '/parties' do
    if logged_in?
      if params[:venue] == ""
        redirect to '/students/new'
      else
        @party = @current_user.parties.create(:venue => params[:venue]
        @party.save
        redirect to '/parties'
      end
    else
      redirect to '/login'
    end
  end

  get '/parties/:id/edit' do
    if logged_in?
      @party = Party.find_by_id(params[:id])
#      if @party && @party.student == current_user
        erb :'parties/edit'
      else
        erb :'/parties'
      end
    else
      redirect to '/login'
    end
  end

  patch '/parties/:id' do
    if logged_in?
      if params[:venue] == ""
        redirect to '/parties/#{params[:id]}/edit'
      else
        @party = Party.find_by_id(params[:id])
#      if @party && @party.student == current_user
          if @party.update(venue: params[:venue])
            redirect to "/parties/#{@party.id}"
          else
            redirect to "/parties/#{@party.id}/edit"
          end
        else
          redirect to '/parties'
        end
      end
    else
      redirect to '/login'
    end
  end

  delete '/parties/:id/delete' do
    if logged_in?
      @party = Party.find_by_id(params[:id])
#      if @party && @party.student == current_user
        @party.delete
      end
      redirect to '/parties'
    else
      redirect to '/login'
    end
  end
