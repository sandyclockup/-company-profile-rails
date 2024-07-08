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

class CreatePortfolioImages < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolio_images, :options => 'ENGINE=InnoDB' do |t|
      t.bigint :portfolio_id, null: false
      t.string :image, limit: 191, null: false
      t.integer :status, :default => 0, :limit => 2
      t.timestamps
    end
    add_index :portfolio_images, :portfolio_id
    add_index :portfolio_images, :image
    add_index :portfolio_images, :status
    add_index :portfolio_images, :created_at
    add_index :portfolio_images, :updated_at
    add_foreign_key :portfolio_images, :portfolios, column: :portfolio_id
  end
end
