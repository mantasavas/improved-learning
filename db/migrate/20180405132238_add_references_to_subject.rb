class AddReferencesToSubject < ActiveRecord::Migration[5.1]
  def change
    add_reference :subjects, :user, foreign_key: true
  end
end
