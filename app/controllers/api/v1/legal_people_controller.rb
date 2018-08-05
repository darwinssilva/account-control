class Api::V1::LegalPeopleController < ApplicationController
  before_action :set_legal_person, only: [:show, :update, :destroy]

  # GET /legal_people
  def index
    @legal_people = LegalPerson.all

    render json: @legal_people
  end

  # GET /legal_people/1
  def show
    render json: @legal_person
  end

  # POST /legal_people
  def create
    @legal_person = LegalPerson.new(legal_person_params)

    if @legal_person.save
      render json: @legal_person, status: :created, location: @legal_person
    else
      render json: @legal_person.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /legal_people/1
  def update
    if @legal_person.update(legal_person_params)
      render json: @legal_person
    else
      render json: @legal_person.errors, status: :unprocessable_entity
    end
  end

  # DELETE /legal_people/1
  def destroy
    @legal_person.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_legal_person
      @legal_person = LegalPerson.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def legal_person_params
      params.require(:legal_person).permit(:cnpj, :company_name, :fantasy_name)
    end
end
