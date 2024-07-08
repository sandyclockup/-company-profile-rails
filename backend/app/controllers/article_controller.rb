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

class ArticleController < ApplicationController

    before_action :authorize_request, except: %i[list detail comment_list] 

    def list

        page = params.has_key?(:page) ? params[:page] : 1
        limit = page.to_i * 3

        article = Article.select("
            articles.*,
            users.first_name,
            users.last_name,
            users.gender,
            users.image,
            users.about_me,
            (
                SELECT 
                    GROUP_CONCAT(r.name SEPARATOR ',') AS r 
                    FROM `references` r
                    WHERE r.id IN (
                        SELECT reference_id
                        FROM articles_references
                        WHERE article_id = articles.id
                    )
            ) as categories
        ")
        .joins("INNER JOIN users ON users.id = articles.user_id")

        new_article = article.where("articles.status = 1").order("articles.id desc").first
        new_articles = article.where("articles.status = 1 AND articles.id != ?", new_article.id).limit(3).order("articles.id desc")
        stories = article.where("articles.status = 1")
        total_stories = Article.where("articles.status = 1").count

        data = {
            continue: limit <= total_stories,
            new_article: new_article,
            new_articles: new_articles,
            page: page,
            stories: stories
        }

        response = {
            message: "ok",
            status: true,
            data: data
        }
        render :json => response, :status => :ok

    end

    def detail

        slug = params[:slug]

        article = Article.select("
            articles.*,
            users.first_name,
            users.last_name,
            users.gender,
            users.image,
            users.about_me,
            (
                SELECT 
                    GROUP_CONCAT(r.name SEPARATOR ',') AS r 
                    FROM `references` r
                    WHERE r.id IN (
                        SELECT reference_id
                        FROM articles_references
                        WHERE article_id = articles.id
                    )
            ) as categories
        ")
        .joins("INNER JOIN users ON users.id = articles.user_id")
        .where("articles.slug = ?", slug)
        .first

        if(article == nil)
            payload = {
                message: "The record with slug "+slug+" was not found in our record !!",
                status: false,
                data: nil
            }
            render :json => payload, :status => :bad_request
            return
        end

        response = {
            message: "ok",
            status: true,
            data: article
        }
        render :json => response, :status => :ok
        return

    end

    def comment_list
        article_id = params[:id]
        data = build_tree(article_id, nil)
        response = {
            message: "ok",
            status: true,
            data: data
        }
        render :json => response, :status => :ok
    end

    def comment_create

        if(!params.has_key?(:comment))
            payload = {
                message: "The field 'comment' can not be empty!",
                status: false,
                data: nil
            }
            render :json => payload, :status => :bad_request
            return
        end

        article_id = params[:id]
        user_id = @current_user.id
        comment = params[:comment]

        article_comment = ArticleComment.new(
            :article_id => article_id,
            :user_id=> user_id,
            :comment => comment
        )
        article_comment.save!

        response = {
            message: "ok",
            status: true,
            data: article_comment
        }
        render :json => response, :status => :ok
        return

    end

    def build_tree(article_id, parent_id)

        result = Array[]
        comments = ArticleComment.select("
            article_comments.*,
            users.first_name,
            users.last_name,
            users.gender,
            users.image,
            users.about_me
        ")
        .joins("INNER JOIN users ON users.id = article_comments.user_id")
        .order("article_comments.id desc")

        if(parent_id == nil)
            comments = comments.where("article_comments.article_id = ? AND article_comments.parent_id IS NULL ", article_id)
        else
            comments = comments.where("article_comments.article_id = ? AND article_comments.parent_id = ? ", article_id, parent_id)
        end

        comments.each do |row|
           comment = {
              id: row.id,
              parent_id: row.parent_id,
              comment: row.comment,
              created_at: row.created_at,
              first_name: row.first_name,
              last_name: row.last_name,
              gender: row.gender,
              image: row.image,
              about_me: row.about_me
           }
           comment["children"] = build_tree(article_id, row.id)
           result.push(comment)
        end

        return result

    end

end
