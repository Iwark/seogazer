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

require 'rails_helper'

RSpec.describe Ranking, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
