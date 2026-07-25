class PagesController < ApplicationController
  def home
    @dogs = Dog.with_attached_images.where(available: true).order(created_at: :desc).limit(6)
  end
  def breeds
    # não precisa carregar nada do banco, a view é estática
  end
  def about
  end
end
