# frozen_string_literal: true

class SalesController < ApplicationController
  load_and_authorize_resource

  def show
    @space = Space.find(params[:space_id])
    @sale = Sale.find(params[:id])
  end
end
