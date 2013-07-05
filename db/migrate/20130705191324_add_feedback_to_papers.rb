class AddFeedbackToPapers < ActiveRecord::Migration
  def change
    add_column :papers, :is_feedback_sended, :boolean, :default => false
  end
end
