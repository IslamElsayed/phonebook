class Contact < ApplicationRecord
  has_many :phones
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :phones, presence: true

  accepts_nested_attributes_for :phones, allow_destroy: true
end
