# == Schema Information
#
# Table name: indicators
#
#  id            :integer          not null, primary key
#  name          :string
#  description   :string
#  expected_sign :integer
#  database_key  :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Indicator < ApplicationRecord
    
    has_many :values, :dependent => :destroy
    has_many :sources, :dependent => :destroy
    has_many :variables, :dependent => :destroy
    has_many :authors, :through => :sources, :source => :author
    has_many :models, :through => :variables, :source => :model
    has_many :ourmodels, :through => :variables, :source => :ourmodel
end
