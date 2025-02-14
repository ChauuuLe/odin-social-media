class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.text :content
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
