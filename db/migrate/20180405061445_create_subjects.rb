# frozen_string_literal: true

class CreateSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :subjects do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
