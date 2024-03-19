class Registration::Registrant < Registration::RegistrationRecord
  # We get the name of the table for registrants from the ENV variable
  self.table_name = "#{ENV.fetch("REG_DB_TABLE")}"

  # Make sure that the data is treated as read only
  def readonly?
    true
  end
end
