class CreateBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :brands do |t|

      #t.references :parent, index: true, foreign_key: true
      t.string :name, null: false
      t.string :slug_url
      t.string :state, null: false

    end
  end
end
