# frozen_string_literal: true

class CreateNotificationChannels < ActiveRecord::Migration[5.2]
  def change
    create_table :notification_channels do |t|
      t.string :channel_type
      t.boolean :enabled
      t.references :site_member, foreign_key: true

      t.timestamps
    end
  end
end
