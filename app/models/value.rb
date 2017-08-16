# == Schema Information
#
# Table name: values
#
#  id           :integer          not null, primary key
#  indicator_id :integer
#  date         :date
#  value        :float
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Value < ApplicationRecord

belongs_to :indicator

end
