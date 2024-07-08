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

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, :options => 'ENGINE=InnoDB' do |t|
      t.string :email, limit: 191, null: false
      t.string :phone, limit: 20, null: true
      t.string :password_digest
      t.string :image, limit: 191, null: true
      t.string :first_name, limit: 64, null: true
      t.string :last_name, limit: 191, null: true
      t.string :gender, limit: 2, null: true
      t.string :country, limit: 64, null: true
      t.text :address,  null: true
      t.text :about_me,  null: true
      t.integer :status, :default => 0, :limit => 2
      t.string :reset_token, limit: 191, null: true
      t.string :confirm_token, limit: 191, null: false
      t.timestamps
    end
    add_index :users, :email
    add_index :users, :phone
    add_index :users, :password_digest
    add_index :users, :image
    add_index :users, :first_name
    add_index :users, :last_name
    add_index :users, :gender
    add_index :users, :country
    add_index :users, :reset_token
    add_index :users, :confirm_token
    add_index :users, :status
    add_index :users, :created_at
    add_index :users, :updated_at
  end
end
