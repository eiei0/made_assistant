class Email < ApplicationRecord
  belongs_to :business

  validates :classification, presence: true

  scope :scheduled, -> { where('delivery_date > ?', DateTime.now) }

  enum classification: {
    initial_intro: 0,
    first_follow_up: 1,
    second_follow_up: 2,
    retry_intro: 3,
    inbound: 4,
    post_purchase_check_in: 5,
  }

  def schedule_mailer
    jid = MailerWorker.perform_in(delivery_date, id)
    update_attribute(:jid, jid)
    business.create_notification!(business.company_name, "fa-clock-o")
  end

  def deliver!
    # consider switching this to MailerWorker.perform_async(classification.to_sym, id)
    mailer = Mailer.public_send(classification.to_sym, business)

    if mailer.deliver!
      update_records
      business.create_notification!(business.company_name, "fa-envelope")
    end
  end

  def schedule_or_deliver
    if scheduled?
      schedule_mailer
    else
      deliver!
    end
  end

  def self.mailers_delivered(start_date)
    where(scheduled: false).where('delivery_date > ?', start_date)
  end

  def self.notify_admin(business)
    Mailer.admin_response_notification(business).deliver!
  end

  private

  def update_records
    update_attributes(scheduled: false, delivery_date: DateTime.now)
    business.update_after_mailer_delivery(classification)
  end
end
