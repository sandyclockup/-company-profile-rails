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

class CreateTestimonials < ActiveRecord::Migration[7.0]
  def change
    create_table :testimonials, :options => 'ENGINE=InnoDB' do |t|
      t.bigint :customer_id, null: false
      t.string :image, limit: 191, null: true
      t.string :name, limit: 191, null: false
      t.string :position, limit: 191, null: false
      t.text :quote,  null: false
      t.integer :sort, :default => 0
      t.integer :status, :default => 0, :limit => 2
      t.timestamps
    end
    add_index :testimonials, :customer_id
    add_index :testimonials, :image
    add_index :testimonials, :name
    add_index :testimonials, :position
    add_index :testimonials, :sort
    add_index :testimonials, :status
    add_index :testimonials, :created_at
    add_index :testimonials, :updated_at
    add_foreign_key :testimonials, :customers, column: :customer_id
  end
end
