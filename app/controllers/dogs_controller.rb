class DogsController < ApplicationController
  PER_PAGE = 12

  before_action :set_dog, only: :show

  def index
    @breeds = Dog.where.not(breed: [ nil, "" ]).distinct.order(:breed).pluck(:breed)
    dogs = Dog.with_attached_images.where(available: true).order(:name)
    dogs = dogs.where("name ILIKE ?", "%#{Dog.sanitize_sql_like(params[:query])}%") if params[:query].present?
    dogs = dogs.where(breed: params[:breed]) if params[:breed].present?

    @current_page = [ params.fetch(:page, 1).to_i, 1 ].max
    @total_pages = [ (dogs.count.to_f / PER_PAGE).ceil, 1 ].max
    @current_page = @total_pages if @current_page > @total_pages
    @dogs = dogs.offset((@current_page - 1) * PER_PAGE).limit(PER_PAGE)
  end

  def show
  end

  def terrier_brasileiro
    @dogs = breed_dogs("Terrier Brasileiro")
  end

  def pastor_da_mantiqueira
    @dogs = breed_dogs("Pastor da Mantiqueira")
  end

  private

  def set_dog
    @dog = Dog.with_attached_images.find(params[:id])
  end

  def breed_dogs(breed)
    Dog.with_attached_images.where(breed: breed, available: true).order(:name)
  end
end
