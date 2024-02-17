# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  validates :title, :body, presence: true, allow_blank: true
end
