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

class CreateArticleComments < ActiveRecord::Migration[7.0]
  def change
    create_table :article_comments, :options => 'ENGINE=InnoDB' do |t|
      t.bigint :parent_id, null: true
      t.bigint :article_id, null: false
      t.bigint :user_id, null: false
      t.text :comment, limit: 4294967295, null: false
      t.timestamps
    end
    add_index :article_comments, :parent_id
    add_index :article_comments, :article_id
    add_index :article_comments, :user_id
    add_index :article_comments, :created_at
    add_index :article_comments, :updated_at
    add_foreign_key :article_comments, :article_comments, column: :parent_id
    add_foreign_key :article_comments, :users, column: :user_id
    add_foreign_key :article_comments, :articles, column: :article_id
  end
end
