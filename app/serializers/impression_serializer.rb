class ImpressionSerializer
  include JSONAPI::Serializer

  attributes :id, :lock_version, :created_at, :updated_at,
             :registrant_id, :user_id, :date_printed, :label_used, :user_name,
             :label_type
end
