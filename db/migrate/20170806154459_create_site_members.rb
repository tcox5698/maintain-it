# frozen_string_literal: true

class CreateSiteMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :site_members do |t|
      t.string :nick_name
      t.references :user, foreign_key: true
      t.references :site, foreign_key: true

      t.timestamps
    end
  end
end
