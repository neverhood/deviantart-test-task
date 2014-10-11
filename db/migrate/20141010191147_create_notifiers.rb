class CreateNotifiers < ActiveRecord::Migration
  def change
    create_table :notifiers do |t|
      t.string :path, null: false, default: String.new
      t.string :pattern, null: false, default: String.new

      t.timestamps
    end

    add_index :notifiers, :path, unique: true
  end
end
