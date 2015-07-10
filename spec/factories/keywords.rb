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

FactoryGirl.define do
  factory :keyword do
    name "MyString"
url "MyString"
  end

end
