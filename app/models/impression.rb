# t.integer :registrant_id
# t.uuid :user_id
# t.datetime :date_printed
# t.jsonb :label_used
class Impression < ApplicationRecord
  belongs_to :registrant, class_name: "Registration::Registrant", foreign_key: "registrant_id"
  belongs_to :user, class_name: "User"

  enum label_type: {
    member: 'member',
    staff: 'staff'
  }
end
