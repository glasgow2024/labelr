class Registration::Staff < Registration::RegistrationRecord
  # We get the name of the table for registrants from the ENV variable
  self.table_name = "#{ENV.fetch("REG_DB_TABLE")}"
  # default scope - where product_id != 1 ????
  #'{"op":"all","queries":[["product_id", "!=", "1"], ["product_id", "!=", "25"], ["product_id", "!=", "35"]]}'
  # 25 - WSFS only supporting
  # 35 - Chengdu members
  # 52 - Staff members
  # attending status
  # TODO: get new data and change the product id for staff product
  default_scope { where("product_id = 52") }

  belongs_to :product, class_name: 'Registration::Product'

  # Change to filter on type
  has_many :impressions,
            -> {
              where("impressions.label_type = 'staff'")
            },
            class_name: "Impression", foreign_key: "registrant_id"

  # Make sure that the data is treated as read only
  def readonly?
    true
  end
end
