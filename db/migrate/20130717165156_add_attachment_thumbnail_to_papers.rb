class AddAttachmentThumbnailToPapers < ActiveRecord::Migration
  def self.up
    change_table :papers do |t|
      t.attachment :thumbnail
    end
  end

  def self.down
    drop_attached_file :papers, :thumbnail
  end
end
