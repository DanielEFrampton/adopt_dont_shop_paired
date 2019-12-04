class ApplicationsController < ApplicationController
  def new
    @favorites = Pet.find(cookies[:favorites].split(','))
  end
end
