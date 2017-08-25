# == Schema Information
#
# Table name: models
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  mname      :string
#

class Model < ApplicationRecord
    
    belongs_to :user
    has_many :variables, :dependent => :nullify
    #, :dependent => :destroy
    has_many :indicators, :through => :variables, :source => :indicator
end
