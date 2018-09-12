class UserMailer < ApplicationMailer
  def order_success order
    @order_details = order.order_details
    mail to: order.user.email, subject: t("user_mailer.order_success.order_success")
  end
end
