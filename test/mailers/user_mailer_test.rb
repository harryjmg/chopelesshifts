require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "activation_needed_email" do
    user = users(:not_activated)
    mail = UserMailer.activation_needed_email(user)
    assert_equal "Lien d'activation ton compte", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["support@joincodingnow.com"], mail.from
    assert_match user.activation_token, mail.body.encoded
  end

  test "activation_success_email" do
    user = users(:not_activated)
    mail = UserMailer.activation_success_email(user)
    assert_equal "Ton compte est activé", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["support@joincodingnow.com"], mail.from
  end

  test "reset_password_email" do
    user = users(:not_activated)
    mail = UserMailer.reset_password_email(user)
    assert_equal "Réinitialiser ton mot de passe", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["support@joincodingnow.com"], mail.from
  end
end
