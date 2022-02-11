class PeopleController < ApplicationController
  def index
    @people = Person.all
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.create(first_name: params[:person][:first_name],
                            last_name: params[:person][:last_name])
    redirect_to people_path
  end

  def show
    @person = Person.find(params[:id])
  end
end