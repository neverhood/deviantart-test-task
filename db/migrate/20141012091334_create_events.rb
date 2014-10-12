class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :notifier_id
      t.string  :file_name
      t.time    :file_ctime
      t.string  :absolute_file_path
      t.string  :ownership

      t.timestamps
    end

    add_index :events, [:notifier_id, :file_name], unique: true
  end
end
