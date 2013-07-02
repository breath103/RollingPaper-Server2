class CreateInvitation < ActiveRecord::Migration
	def change
	  create_table :invitations do |t|
	    t.integer :sender_id
		t.integer :paper_id
		t.string  :frined_facebook_id
	    t.timestamps
	  end
	end
end
