class DogsController < ApplicationController
  before_action :authenticate_admin!, except: [ :index, :show, :terrier_brasileiro, :pastor_da_mantiqueira ]
  before_action :set_dog,               only:   [ :show, :edit, :update, :destroy ]
  # GET /dogs or /dogs.json
  def index
    @breeds = Dog.pluck(:breed).uniq.sort
    @dogs = Dog.where(available: true)
    @dogs = @dogs.where("name ILIKE ?", "%#{params[:query]}%") if params[:query].present?
    @dogs = @dogs.where(breed: params[:breed]) if params[:breed].present?
  end

  # GET /dogs/1 or /dogs/1.json
  def show
    @dog = Dog.find(params[:id])
  end

  def terrier_brasileiro
    @dogs = Dog.with_attached_images.where(breed: "Terrier Brasileiro")
  end

  def pastor_da_mantiqueira
    @dogs = Dog.with_attached_images.where(breed: "Pastor da Mantiqueira")
  end

  # GET /dogs/new
  def new
    @dog = Dog.new
  end

  # GET /dogs/1/edit
  def edit
  end

  # POST /dogs or /dogs.json
  def create
    @dog = Dog.new(dog_params)

    respond_to do |format|
      if @dog.save
        format.html { redirect_to @dog, notice: "Dog was successfully created." }
        format.json { render :show, status: :created, location: @dog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dogs/1 or /dogs/1.json
  def update
    respond_to do |format|
      if @dog.update(dog_params)
        format.html { redirect_to @dog, notice: "Dog was successfully updated." }
        format.json { render :show, status: :ok, location: @dog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dogs/1 or /dogs/1.json
  def destroy
    @dog = Dog.find(params[:id])
    if @dog.destroy
      redirect_to admin_area_dogs_path, notice: "Cão excluído com sucesso!"
    else
      redirect_to admin_area_dogs_path, alert: "Falha ao excluir cão."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dog
      @dog = Dog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dog_params
      params.require(:dog).permit(:name, :description, :breed, :birth_date, :father_id, :mother_id, :available, images: [])
    end
end
