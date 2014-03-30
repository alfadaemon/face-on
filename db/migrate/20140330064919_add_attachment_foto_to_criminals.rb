class AddAttachmentFotoToCriminals < ActiveRecord::Migration
  def self.up
    change_table :criminals do |t|
      t.attachment :foto
    end
  end

  def self.down
    drop_attached_file :criminals, :foto
  end
end
