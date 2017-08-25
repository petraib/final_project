# == Schema Information
#
# Table name: variables
#
#  id           :integer          not null, primary key
#  indicator_id :integer
#  model_id     :integer
#  weight       :string
#  ourmodel_id  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Variable < ApplicationRecord
    belongs_to :indicator
    belongs_to :model, :required => false
    belongs_to :ourmodel, :required => false
end
