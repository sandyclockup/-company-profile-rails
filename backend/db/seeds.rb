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

require 'faker'

def create_user()

    total_user = User.count
    if total_user === 0

        for i in 1..10 do
        
            gender = rand(1..2)
            email = Faker::Internet.email

            first_name = Faker::Name.male_first_name
            last_name = Faker::Name.last_name
            gender_index = "undefined"

            if gender === 1
                gender_index = "M"
            else
                gender_index = "F"
            end
            
            user = User.new(
                :email => email,
                :password=> "p4ssw0rd!",
                :phone=> Faker::PhoneNumber.cell_phone,
                :first_name=> first_name,
                :last_name=> last_name,
                :gender=> gender_index,
                :address=> Faker::Address.full_address,
                :about_me=> Faker::Lorem.paragraph,
                :confirm_token=>Faker::Internet.uuid,
                :country=> Faker::Address.country,
                :status=> 1
            )
            user.save!
    
        end

    end
    
end

def create_reference()

    articles = Array[
        "Health and wellness",
        "Technology and gadgets",
        "Business and finance",
        "Travel and tourism",
        "Lifestyle and fashion"
    ]

    tags = Array[
        "Mental Health",
        "Fitness and Exercise",
        "Alternative Medicine",
        "Artificial Intelligence",
        "Network Security",
        "Cloud Computing",
        "Entrepreneurship",
        "Personal Finance",
        "Marketing and Branding",
        "Travel Tips and Tricks",
        "Cultural Experiences",
        "Destination Guides",
        "Beauty and Fashion Trends",
        "Celebrity News and Gossip",
        "Parenting and Family Life",
    ]

    portfolio = Array[
        "3D Modeling",
        "Web Application",
        "Mobile Application",
        "Illustrator Design",
        "UX Design"
    ]

    total_rows = Reference.count

    if total_rows === 0

        articles.each do |row|
            slug = row.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
            ar = Reference.new(
               :slug=> slug,
               :name=> row,
               :description=> Faker::Lorem.paragraph,
               :type_data=> 1,
               :status=> 1
            )
            ar.save!
        end

        tags.each do |row|
            slug = row.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
            tg = Reference.new(
               :slug=> slug,
               :name=> row,
               :description=> Faker::Lorem.paragraph,
               :type_data=> 2,
               :status=> 1
            )
            tg.save!
        end

        portfolio.each do |row|
            slug = row.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
            pp = Reference.new(
               :slug=> slug,
               :name=> row,
               :description=> Faker::Lorem.paragraph,
               :type_data=> 3,
               :status=> 1
            )
            pp.save!
        end

    end

end

def create_contact()

    total_rows = Contact.count

    if total_rows === 0
        for i in 1..10
            cc = Contact.new(
                :name=> Faker::Name.name,
                :email=> Faker::Internet.email,
                :subject=> Faker::Lorem.sentence,
                :message=> Faker::Lorem.paragraph(sentence_count: 5),
                :status=> 0
            )
            cc.save!
        end
    end

end

def create_customer()

    total_rows = Customer.count

    if total_rows === 0
        for i in 1..10
            cs = Customer.new(
                :image=> "customer"+(i.to_s)+".jpg",
                :name=> Faker::Company.name,
                :email=> Faker::Internet.email,
                :phone=> Faker::PhoneNumber.cell_phone,
                :address=> Faker::Address.full_address,
                :sort=> i,
                :status=> 1
            )
            cs.save!
        end
    end

end

def create_faq()

    total_rows = Faq.count

    if total_rows === 0
        for i in 1..10
            ff = Faq.new(
                :question=> Faker::Lorem.paragraph(sentence_count: 5),
                :answer=> Faker::Lorem.paragraph(sentence_count: 10),
                :status=> 1,
                :sort=> i
            )
            ff.save!
        end
    end

end

def create_service()

    icons = Array[
        "bi bi-bicycle",
        "bi bi-bookmarks",
        "bi bi-box",
        "bi bi-building-add",
        "bi bi-calendar2-check",
        "bi bi-cart4",
        "bi bi-clipboard-data",
        "bi bi-gift",
        "bi bi-person-bounding-box",
    ]

    total_rows = Service.count
    if total_rows === 0
        icons.each do |row, index|
            sort = index.to_i + 1
            ss = Service.new(
                :icon=> row,
                :title=> Faker::Lorem.paragraph(sentence_count: 2),
                :description=> Faker::Lorem.paragraph(sentence_count: 5),
                :status=> 1,
                :sort=> sort
            )
            ss.save!
        end
    end

end

def create_slider()
    total_rows = Slider.count

    if total_rows === 0
        for i in 1..5
            slider = Slider.new(
                :image=> "slider"+(i.to_s)+".jpg",
                :title=> Faker::Lorem.paragraph(sentence_count: 5),
                :description=> Faker::Lorem.paragraph(sentence_count: 10),
                :status=> 1,
                :sort=> i
            )
            slider.save!
        end
    end

end

def create_team()

    total_rows = Team.count

    if total_rows === 0
        for i in 1..5
            team = Team.new(
                :image=> "team"+(i.to_s)+".jpg",
                :name=> Faker::Company.name,
                :email=> Faker::Internet.email,
                :phone=> Faker::PhoneNumber.cell_phone,
                :position_name=> Faker::Job.title,
                :address=> Faker::Address.full_address,
                :twitter=> Faker::Internet.username,
                :linked_in=> Faker::Internet.username,
                :instagram=> Faker::Internet.username,
                :facebook=> Faker::Internet.username,
                :status=> 1,
                :sort=> i
            )
            team.save!
        end
    end
end

def create_testimonial()
    
    total_rows = Testimonial.count

    if total_rows === 0
        customer = Customer.all
        customer.each_with_index do |row, index|
            sort = index.to_i + 1
            testimonial = Testimonial.new(
                :customer_id=> row.id,
                :image=> "testimonial"+(sort.to_s)+".jpg",
                :name=> Faker::Company.name,
                :position=> Faker::Job.title,
                :quote=> Faker::Lorem.paragraph(sentence_count: 6),
                :status=> 1,
                :sort=> sort
            )
            testimonial.save!
        end
    end

end

def create_portfolio()

    total_rows = Portfolio.count
    if total_rows === 0
        for i in 1..9

            sort = i
            i_category = Reference.where("type_data = 3").count
            customer = Customer.offset(rand(Customer.count)).first
            category = Reference.where("type_data = 3").offset(rand(i_category)).first

            pp = Portfolio.new(
                :customer_id=> customer.id,
                :reference_id=> category.id,
                :title=> Faker::Lorem.paragraph(sentence_count: 2),
                :description=> Faker::Lorem.paragraph(sentence_count: 8),
                :project_date=> Faker::Date.between_except(from: 10.year.ago, to: 1.year.from_now, excepted: Date.today),
                :project_url=> Faker::Internet.url,
                :status=> 1,
                :sort=> i
            )
            pp.save!

            for j in 1..4

                active = -1
                if j === 1
                    active = 1
                else
                    active = 0
                end

                pi = PortfolioImage.new(
                    :portfolio_id=> pp.id,
                    :image=> "portfolio"+(j.to_s)+".jpg",
                    :status=> active
                )
                pi.save!
            end

        end
    end

end

def create_article()

    total_rows = Article.count

    if total_rows === 0

        users = User.all
        users.each_with_index do |row, index|

            i_category = Reference.where("type_data = 1").count
            categories = Reference.where("type_data = 1").limit(3).offset(rand(i_category))

            i_tag = Reference.where("type_data = 2").count
            tags = Reference.where("type_data = 2").limit(5).offset(rand(i_tag))

            number = index.to_i + 1
            title = Faker::Lorem.paragraph(sentence_count: 2)
            slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
            article = Article.new(
                :user_id=> row.id,
                :image=> "article"+(number.to_s)+".jpg",
                :title=> title,
                :slug=> slug,
                :description=> Faker::Lorem.paragraph(sentence_count: 8),
                :content=> Faker::Lorem.paragraph(sentence_count: 50),
                :status=> 1
            )
            article.save!

            article.reference = categories
            article.save()
           
            article.reference = tags
            article.save()

            i_comment = User.where("id != "+(row.id).to_s).count
            comments = User.where("id != "+(row.id).to_s).offset(rand(i_comment)).limit(2)
            comments.each do |cc|
                comment = ArticleComment.new(
                    :article_id=> article.id,
                    :user_id=> cc.id,
                    :comment=> Faker::Lorem.paragraph(sentence_count: 3),
                )
                comment.save!
            end
        
        end


    end

end

puts "Begin instalation, please wait for a minute..."
create_user()
create_reference()
create_contact()
create_customer()
create_faq()
create_service()
create_slider()
create_team()
create_testimonial()
create_portfolio()
create_article()
puts "Your application has been instaled :)"