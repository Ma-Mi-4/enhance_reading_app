class CreateNotificationSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :notification_settings do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :enabled
      t.time :notify_time

      t.timestamps
    end
  end
end
