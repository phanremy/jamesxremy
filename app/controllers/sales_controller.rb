# frozen_string_literal: true

class SalesController < ApplicationController
  load_and_authorize_resource

  before_action :set_space

  def index; end

  def show
    @sale = Sale.find(params[:id])
  end

  private

  def set_space
    @space = Space.find(params[:space_id])
  end
end
