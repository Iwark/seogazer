# == Schema Information
#
# Table name: rankings
#
#  id         :integer          not null, primary key
#  keyword_id :integer
#  number     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_rankings_on_keyword_id  (keyword_id)
#

class Ranking < ActiveRecord::Base
  belongs_to :keyword
end
