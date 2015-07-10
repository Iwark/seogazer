# == Schema Information
#
# Table name: keywords
#
#  id         :integer          not null, primary key
#  name       :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  memo       :string
#

require 'rails_helper'

RSpec.describe Keyword, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
