class Phone < ApplicationRecord
  belongs_to :contact

  validates :number, presence: true, uniqueness: { case_sensitive: false }, numericality: { only_integer: true }
end
