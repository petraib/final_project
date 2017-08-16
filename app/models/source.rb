# == Schema Information
#
# Table name: sources
#
#  id           :integer          not null, primary key
#  author_id    :integer
#  name         :string
#  url          :string
#  indicator_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Source < ApplicationRecord
    belongs_to :indicator
    belongs_to :author

end
