require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  test 'review should belong to a user' do
    review = Review.new(stars: 3, comment: 'Great!')
    assert_not review.valid?
    assert_includes review.errors.full_messages, 'User doit exister'
  end

  test 'review should have stars between 1 and 10' do
    review = reviews(:one)
    review.stars = 12
    assert_not review.valid?
    assert_includes review.errors.full_messages, "Stars n'est pas inclus(e) dans la liste"
  end

  test 'user should have only one review' do
    user = users(:one)
    first_review = Review.create(user: user, stars: 4, comment: 'Good!')
    duplicate_review = Review.new(user: user, stars: 3, comment: 'Okay!')
    assert_not duplicate_review.valid?
    assert_includes duplicate_review.errors.full_messages, 'User est déjà utilisé(e)'
  end

  test 'user can update their review' do
    review = reviews(:one)
    review.comment = 'Updated comment'
    assert review.save
  end
end
