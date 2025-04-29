class PagesController < ApplicationController
  def home
    @dogs = Dog.all
  end
  def breeds
    # não precisa carregar nada do banco, a view é estática
  end
  def about
  end
end
