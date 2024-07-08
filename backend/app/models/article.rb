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

class Article < ApplicationRecord
    belongs_to :user
    has_many :article_comments
    has_many :article_references
    has_many :reference, through: :article_references
end
