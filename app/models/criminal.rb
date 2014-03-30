class Criminal < ActiveRecord::Base
  has_attached_file :foto, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :foto, :content_type => /\Aimage\/.*\Z/

  has_many :comparisons
end
