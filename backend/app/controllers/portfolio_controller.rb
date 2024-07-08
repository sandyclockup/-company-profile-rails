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

class PortfolioController < ApplicationController

    def list

        portfolios = Portfolio.select("
            portfolios.*,
            customers.name customer_name,
            `references` .name category_name
        ")
        .where("portfolios.status = 1")
        .joins("INNER JOIN customers ON customers.id = portfolios.customer_id")
        .joins("INNER JOIN `references` ON `references` .id = portfolios.reference_id")
        .order("portfolios.id desc")

        response = {
            message: "ok",
            status: true,
            data: {
                portfolios: portfolios
            }
        }
        render :json => response, :status => :ok
    end

    def detail

        id = params[:id]

        portfolio = Portfolio.select("
            portfolios.*,
            customers.name customer_name,
            `references` .name category_name
        ")
        .where("portfolios.id = ?", id)
        .joins("INNER JOIN customers ON customers.id = portfolios.customer_id")
        .joins("INNER JOIN `references` ON `references` .id = portfolios.reference_id")
        .first

        if(portfolio == nil)
            payload = {
                message: "The record with id "+id+" was not found in our record !!",
                status: false,
                data: nil
            }
            render :json => payload, :status => :bad_request
            return
        end

        response = {
            message: "ok",
            status: true,
            data: {
                portfolio: portfolio,
                images: PortfolioImage.where("portfolio_id = ?", id).order("id desc")
            }
        }
        render :json => response, :status => :ok
        return

    end


end
