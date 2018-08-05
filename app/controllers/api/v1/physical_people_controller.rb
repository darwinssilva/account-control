class Api::V1::PhysicalPeopleController < ApplicationController
  before_action :set_physical_person, only: [:show, :update, :destroy]

  # GET /physical_people
  def index
    @physical_people = PhysicalPerson.all

    render json: @physical_people
  end

  # GET /physical_people/1
  def show
    render json: @physical_person
  end

  # POST /physical_people
  def create
    @physical_person = PhysicalPerson.new(physical_person_params)

    if @physical_person.save
      render json: @physical_person, status: :created, location: @physical_person
    else
      render json: @physical_person.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /physical_people/1
  def update
    if @physical_person.update(physical_person_params)
      render json: @physical_person
    else
      render json: @physical_person.errors, status: :unprocessable_entity
    end
  end

  # DELETE /physical_people/1
  def destroy
    @physical_person.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_physical_person
      @physical_person = PhysicalPerson.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def physical_person_params
      params.require(:physical_person).permit(:cpf, :name, :birthdate)
    end
end
