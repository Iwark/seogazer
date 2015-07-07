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

FactoryGirl.define do
  factory :ranking do
    keyword nil
number 1
  end

end
