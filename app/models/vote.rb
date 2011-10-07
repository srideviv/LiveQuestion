class Vote < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  def self.destroyCascade(vote)
    vote.destroy
  end
end
