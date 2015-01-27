class PerformanceDate < ActiveRecord::Base
  belongs_to :event
  has_many :attendances
  has_many :users, through: :attendances

  def to_s
    "#{self.time} #{self.date}"
  end
end