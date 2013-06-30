class AddAttachmentImageToImageContents < ActiveRecord::Migration
  def self.up
    change_table :image_contents do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :image_contents, :image
  end
end
