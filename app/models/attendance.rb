class Attendance < ActiveRecord::Base
  # TODO: Make sure this is correct
  validates :performance_date_id, uniqueness: { scope: :user_id,
    message: "Performance date already added to calendar!" }
  
  belongs_to :user
  belongs_to :performance_date
  has_one :event, through: :performance_date
end
