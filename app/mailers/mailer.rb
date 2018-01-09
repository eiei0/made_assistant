class Mailer < ApplicationMailer
  default from: 'wholesale@madelr.com'

  def initial_intro(business)
    @business_name = business.company_name
    @stacy_email = ENV["stacy_email"]
    @stacy_phone = ENV["stacy_phone"]

    attachments['made_linesheet.pdf'] = File.read('db/data/made_linesheet.pdf')
    mail(to: business.email, subject: "Arkansas Quartz Jewelry")
  end

  def first_follow_up(business)
    @business_name = business.company_name
    @stacy_email = ENV["stacy_email"]
    @stacy_phone = ENV["stacy_phone"]

    attachments['made_linesheet.pdf'] = File.read('db/data/made_linesheet.pdf')
    mail(to: business.email, subject: "Arkansas Quartz Jewelry")
  end

  def second_follow_up(business)
    @business_name = business.company_name
    @stacy_email = ENV["stacy_email"]
    @stacy_phone = ENV["stacy_phone"]

    attachments['made_linesheet.pdf'] = File.read('db/data/made_linesheet.pdf')
    mail(to: business.email, subject: "Arkansas Quartz Jewelry")
  end

  def post_purchase_check_in(business)
    @business_name = business.company_name
    @stacy_email = ENV["stacy_email"]
    @stacy_phone = ENV["stacy_phone"]

    mail(to: business.email, subject: "Order Followup")
  end

  def admin_response_notification(business)
    @business_name = business.company_name

    mail(to: ENV['wholesale_email'], subject: "#{@business_name} response notification")
  end
end
