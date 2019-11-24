# frozen_string_literal: true

class IndexSiteMember < ActiveRecord::Migration[5.2]
  def change
    change_table :site_members do |t|
      t.index %i[user_id site_id], unique: true
    end
  end
end
