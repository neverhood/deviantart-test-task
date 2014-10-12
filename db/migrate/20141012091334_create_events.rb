class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer  :notifier_id
      t.string   :file_name
      t.datetime :file_mtime
      t.string   :absolute_file_path
      t.string   :ownership

      t.timestamps
    end

    add_index :events, [:notifier_id, :file_name], unique: true
  end
end
