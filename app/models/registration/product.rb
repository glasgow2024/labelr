class Registration::Product < Registration::RegistrationRecord
  self.table_name = "products" #"#{ENV.fetch("REG_DB_TABLE")}"

  has_many :registrant, class_name: 'Registration::Registrant'

  # Make sure that the data is treated as read only
  def readonly?
    true
  end
end
