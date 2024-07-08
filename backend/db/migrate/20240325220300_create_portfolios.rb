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

class CreatePortfolios < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolios, :options => 'ENGINE=InnoDB' do |t|
      t.bigint :customer_id, null: false
      t.bigint :reference_id, null: false
      t.string :title, limit: 255, null: false
      t.text :description, limit: 4294967295, null: false
      t.date :project_date, null: true
      t.text :project_url,  null: true
      t.integer :sort, :default => 0
      t.integer :status, :default => 0, :limit => 2
      t.timestamps
    end
    add_index :portfolios, :customer_id
    add_index :portfolios, :reference_id
    add_index :portfolios, :title
    add_index :portfolios, :project_date
    add_index :portfolios, :sort
    add_index :portfolios, :status
    add_index :portfolios, :created_at
    add_index :portfolios, :updated_at
    add_foreign_key :portfolios, :customers, column: :customer_id
    add_foreign_key :portfolios, :references, column: :reference_id
  end
end
