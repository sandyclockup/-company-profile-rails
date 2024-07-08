=begin
 * This file is part of the Sandy Andryanto Company Profile Website.
 *
 * @author     Sandy Andryanto <sandy.andryanto.dev@gmail.com>
 * @copyright  2024
 *
 * For the full copyright and license information,
 * please view the LICENSE.md file that was distributed
 * with this source code.
=end

class CreateSliders < ActiveRecord::Migration[7.0]
  def change
    create_table :sliders, :options => 'ENGINE=InnoDB' do |t|
      t.string :image, limit: 191, null: true
      t.string :title, limit: 191, null: false
      t.text :description,  null: true
      t.string :link, limit: 191, null: true
      t.integer :sort, :default => 0
      t.integer :status, :default => 0, :limit => 2
      t.timestamps
    end
    add_index :sliders, :image
    add_index :sliders, :title
    add_index :sliders, :link
    add_index :sliders, :sort
    add_index :sliders, :status
    add_index :sliders, :created_at
    add_index :sliders, :updated_at
  end
end
