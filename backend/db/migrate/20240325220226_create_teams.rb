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

class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams, :options => 'ENGINE=InnoDB' do |t|
      t.string :image, limit: 191, null: true
      t.string :name, limit: 191, null: false
      t.string :email, limit: 191, null: false
      t.string :position_name, limit: 191, null: false
      t.string :phone, limit: 191, null: false
      t.string :twitter, limit: 191, null: true
      t.string :facebook, limit: 191, null: true
      t.string :instagram, limit: 191, null: true
      t.string :linked_in, limit: 191, null: true
      t.text :address,  null: true
      t.integer :sort, :default => 0
      t.integer :status, :default => 0, :limit => 2
      t.timestamps
    end
    add_index :teams, :image
    add_index :teams, :name
    add_index :teams, :email
    add_index :teams, :position_name
    add_index :teams, :twitter
    add_index :teams, :facebook
    add_index :teams, :instagram
    add_index :teams, :linked_in
    add_index :teams, :sort
    add_index :teams, :status
    add_index :teams, :created_at
    add_index :teams, :updated_at
  end
end
