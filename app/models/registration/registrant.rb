class Registration::Registrant < Registration::RegistrationRecord
  # We get the name of the table for registrants from the ENV variable
  self.table_name = "#{ENV.fetch("REG_DB_TABLE")}"
  # TODO: id ???

  # default scope - where product_id != 1 ????
  #'{"op":"all","queries":[["product_id", "!=", "1"], ["product_id", "!=", "25"], ["product_id", "!=", "35"]]}'
  # 25 - WSFS only supporting
  # 35 - Chengdu members
  # attending status
  default_scope { where("attending_status != 1") }

  # Make sure that the data is treated as read only
  def readonly?
    true
  end
end
