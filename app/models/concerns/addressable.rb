# app/models/concerns/addressable.rb
module Addressable
  extend ActiveSupport::Concern

  included do
    before_save :set_area_id, if: ->(obj) { obj.will_save_change_to_address? }
  end

  def set_area_id
    city_name = extract_city_from_address
    area_mapping = AreaMapping.find_by(prefecture_id:, city: city_name)
    self.area_id = area_mapping&.area_id
  end

  private

  def extract_city_from_address
    address_without_prefecture = address.sub(/\A.*?[都道府県]/, '')
    address_without_county = address_without_prefecture.sub(/.*?郡/, '')
    city_name = address_without_county.split(/市|区|町|村/).first.strip
    city_name += '市' if address.include?("#{city_name}市")
    city_name += '区' if address.include?("#{city_name}区")
    city_name += '町' if address.include?("#{city_name}町")
    city_name += '村' if address.include?("#{city_name}村")
    city_name
  end
end
