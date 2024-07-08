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

class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts, :options => 'ENGINE=InnoDB' do |t|
      t.string :name, limit: 191, null: true
      t.string :email, limit: 191, null: true
      t.string :subject, limit: 191, null: true
      t.text :message,  null: true
      t.integer :status, :default => 0, :limit => 2
      t.timestamps
    end
    add_index :contacts, :name
    add_index :contacts, :email
    add_index :contacts, :subject
    add_index :contacts, :status
    add_index :contacts, :created_at
    add_index :contacts, :updated_at
  end
end
