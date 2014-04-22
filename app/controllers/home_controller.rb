class HomeController < ApplicationController

  def main
  end

  def search
    @theorem = Theorem.find_by_name(params[:name])
  end

end