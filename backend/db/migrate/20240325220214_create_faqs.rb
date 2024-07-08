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

class CreateFaqs < ActiveRecord::Migration[7.0]
  def change
    create_table :faqs, :options => 'ENGINE=InnoDB' do |t|
      t.string :question
      t.text :answer,  null: false
      t.integer :sort, :default => 0
      t.integer :status, :default => 0, :limit => 2
      t.timestamps
    end
    add_index :faqs, :question
    add_index :faqs, :sort
    add_index :faqs, :status
    add_index :faqs, :created_at
    add_index :faqs, :updated_at
  end
end
