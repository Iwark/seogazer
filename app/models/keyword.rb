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

class Keyword < ActiveRecord::Base
  has_many :rankings

  def record
    self.rankings.order(:number).first
  end

end
