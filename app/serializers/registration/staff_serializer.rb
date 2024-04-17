require 'fast_jsonapi/attribute'

class Registration::StaffSerializer
  include JSONAPI::Serializer

  def self.attributes(*attributes_list, &block)
    self.attributes_to_serialize = {}

    Registration::Staff.column_names.each do |attr_name|
      method_name = attr_name
      key = run_key_transform(method_name)
      attributes_to_serialize[key] = FastJsonapi::Attribute.new(
        key: key,
        method: method_name,
        options: {}
      )
    end
  end
  attributes :id # Dummy, the class method will get the values from the Registrant table

  attribute :product_name do |obj|
    obj.product.list_name
  end

  attribute :printed do |obj|
    obj.impressions.count > 0
  end

  has_many :impressions, serializer: ImpressionSerializer
end