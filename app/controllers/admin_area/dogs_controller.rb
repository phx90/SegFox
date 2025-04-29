class AdminArea::DogsController < ApplicationController
  before_action :set_dogs_collections, only: [ :new, :create, :edit, :update ]
  before_action :set_dog, only: [ :edit, :update ]

  def index
    @dogs = Dog.all
  end

  def new
    @dog = Dog.new
  end

  def create
    @dog = Dog.new(dog_params)
    if @dog.save
      redirect_to admin_area_dogs_path, notice: "Cão criado com sucesso!"
    else
      flash.now[:alert] = "Falha ao criar cão"
      render :new
    end
  end

  def edit
  end

  def update
    if @dog.update(dog_params)
      redirect_to admin_area_dogs_path, notice: "Cão atualizado com sucesso!"
    else
      flash.now[:alert] = "Falha ao atualizar cão"
      render :edit
    end
  end

  def destroy
    @dog = Dog.find(params[:id])
    if @dog.destroy
      redirect_to admin_area_dogs_path, notice: "Cão excluído com sucesso!"
    else
      redirect_to admin_area_dogs_path, alert: "Falha ao excluir cão."
    end
  end
  private

  def set_dog
    @dog = Dog.find(params[:id])
  end

  def set_dogs_collections
    @all_dogs = Dog.all
  end

  def dog_params
    params.require(:dog).permit(:name, :breed, :birth_date, :description, :father_id, :available, :mother_id, images: [])
  end
end
