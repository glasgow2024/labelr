class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :lock_version, :created_at, :updated_at,
             :locked_at, :sign_in_count, :last_sign_in_at,
             :last_sign_in_ip, :is_locked, 
             :name, :email, :role
end
