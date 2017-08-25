# == Schema Information
#
# Table name: ourmodels
#
#  id            :integer          not null, primary key
#  model_weight  :string
#  ourmodel_name :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  description   :string
#

class Ourmodel < ApplicationRecord
    has_many :variables, :dependent => :nullify
    #, :dependent => :destroy
    has_many :indicators, :through => :variables, :source => :indicator


end
