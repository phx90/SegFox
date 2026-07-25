class AdminArea::DogsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_dog, only: [ :edit, :update, :destroy ]
  before_action :set_dogs_collection, only: [ :new, :create, :edit, :update ]

  def index
    @dogs = Dog.with_attached_images.order(:name)
  end

  def new
    @dog = Dog.new(available: true)
  end

  def create
    @dog = Dog.new(dog_params)
    if @dog.save
      redirect_to admin_area_dogs_path, notice: "Cão criado com sucesso."
    else
      flash.now[:alert] = "Revise os campos destacados."
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @dog.update(dog_params)
      redirect_to admin_area_dogs_path, notice: "Cão atualizado com sucesso."
    else
      flash.now[:alert] = "Revise os campos destacados."
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @dog.destroy!
    redirect_to admin_area_dogs_path, notice: "Cão excluído com sucesso.", status: :see_other
  rescue ActiveRecord::DeleteRestrictionError
    redirect_to admin_area_dogs_path, alert: "Este cão possui descendentes e não pode ser excluído."
  end

  private

  def set_dog
    @dog = Dog.find(params[:id])
  end

  def set_dogs_collection
    @all_dogs = Dog.where.not(id: @dog&.id).order(:name)
  end

  def dog_params
    params.require(:dog).permit(:name, :breed, :birth_date, :description, :father_id, :mother_id, :available, images: [])
  end
end
