class Registration::Registrant < Registration::RegistrationRecord
  # We get the name of the table for registrants from the ENV variable
  self.table_name = "#{ENV.fetch("REG_DB_TABLE")}"
  # default scope - where product_id != 1 ????
  #'{"op":"all","queries":[["product_id", "!=", "1"], ["product_id", "!=", "25"], ["product_id", "!=", "35"]]}'
  # 25 - WSFS only supporting
  # 35 - Chengdu members
  # attending status
  default_scope { where("attending_status != 1 and attending_status != 6") }

  belongs_to :product, class_name: 'Registration::Product'

  # Change to filter on type
  has_many :impressions,
            -> {
              where("impressions.label_type = 'member'")
            },
            as: :registable,
            class_name: "Impression", foreign_key: "registable_id"

  # Make sure that the data is treated as read only
  def readonly?
    true
  end
end
