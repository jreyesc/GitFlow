class AddAttachmentGoalToRecommendation < ActiveRecord::Migration
  def self.up
    change_table :recommendations do |t|
      t.attachment :goal_image
    end
  end

  def self.down
    remove_attachment :recommendations, :goal_image
  end
end