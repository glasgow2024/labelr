#
class Impression < ApplicationRecord
  # Polymorphic Registration::Registrant or Registration::Staff
  belongs_to :registable, polymorphic: true

  belongs_to :user, class_name: "User"

  enum label_type: {
    member: 'member',
    staff: 'staff'
  }
end
