class Registration::RegistrationRecord < ActiveRecord::Base
  self.abstract_class = true
  connects_to database: { writing: :registration, reading: :registration }
end
