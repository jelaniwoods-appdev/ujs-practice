class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.text :content, null: false
      t.string :status, default: "not_yet_started", null: false
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
