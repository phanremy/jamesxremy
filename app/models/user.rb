# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_accessor :skip_password_validation # virtual attribute to skip password validation while saving

  has_many :spaces, class_name: 'Space', foreign_key: :owner_id
  has_many :links, class_name: 'Link', foreign_key: :owner_id, dependent: :destroy

  scope :email_query, lambda { |email|
    return if email.blank?

    where(arel_table[:email].matches("%#{I18n.transliterate(email)}%"))
  }

  scope :by_admin, ->(admin) { admin.blank? ? return : where(admin:) }
  scope :by_confirmed, ->(confirmed) { confirmed.blank? ? return : where(confirmed:) }

  def available_link(space)
    links.where(space:).where('expires_at > ?', DateTime.now).first
  end

  protected

  def password_required?
    return false if skip_password_validation

    super
  end
end
