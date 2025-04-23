class PagesController < ApplicationController
  def home
    @dogs = Dog.all
  end

  def about
  end
end
