# == Schema Information
#
# Table name: authors
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#  string     :string
#

class Author < ApplicationRecord
    has_many :sources, :dependent => :destroy
    has_many :indicators, :through => :sources, :source => :indicator
end
