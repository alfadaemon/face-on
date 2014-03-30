class Comparison < ActiveRecord::Base
  belongs_to :criminal #, :class_name => "Criminal", :foreign_key => "criminal_id"
end
