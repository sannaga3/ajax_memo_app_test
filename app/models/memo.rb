class Memo < ApplicationRecord
  validates :content, presence: true, length: { in: 1..100 }
end
