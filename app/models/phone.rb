class Phone < ApplicationRecord
  belongs_to :contact

  validates :number, presence: true, numericality: { only_integer: true }
end
