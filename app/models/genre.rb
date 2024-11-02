class Genre < ApplicationRecord
  has_many :characterizations, dependent: :destroy
  has_many :flicks, through: :characterizations

  validates :name, presence: true, uniqueness: true

  before_save :set_lookup_code

  def to_param
    lookup_code
  end

  private

  def set_lookup_code
    self.lookup_code = name.parameterize
  end

end
