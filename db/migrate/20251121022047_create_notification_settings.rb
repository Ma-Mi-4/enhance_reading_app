class CreateNotificationSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :notification_settings do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :enabled, null: false, default: true
      t.time :notify_time, null: false, default: "09:00"

      t.timestamps
    end

    add_index :notification_settings, :notify_time
  end
end
