class AddTopicReferenceToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_reference :questions, :topic, foreign_key: true
  end
end
