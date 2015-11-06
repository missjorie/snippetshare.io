class Snippet < ActiveRecord::Base
  belongs_to :user
  belongs_to :language
  belongs_to :editor
  has_many :favorites, dependent: :destroy
  
  validates :name, :description, :code, :language_id, :editor_id, presence: true
  validates :code, uniqueness: true
  validates :name,  length: { in: 1..40 }
  validates :description,  length: { maximum: 140 }
end
