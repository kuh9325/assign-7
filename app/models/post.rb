class Post < ActiveRecord::Base
    belongs_to :account
    has_many :comments
    validates :title, presence: { message: "게시물 제목을 입력하세요." }
end
