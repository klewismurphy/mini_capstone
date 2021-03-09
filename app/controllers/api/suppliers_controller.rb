class Api::SuppliersController < ApplicationController
  def index
    @message = "hello!"
    render "index.json.jb"
  end
end
