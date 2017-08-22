# == Schema Information
#
# Table name: ourmodels
#
#  id            :integer          not null, primary key
#  model_weight  :string
#  ourmodel_name :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Ourmodel < ApplicationRecord
    has_many :variables, :dependent => :destroy
    has_many :indicators, :through => :variables, :source => :indicator


end
