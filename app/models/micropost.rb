class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence:true
  validates :content, presence:true, length: { maxinum:140 }
end
