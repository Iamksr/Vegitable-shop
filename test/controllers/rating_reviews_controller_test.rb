require 'test_helper'

class RatingReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rating_review = rating_reviews(:one)
  end

  test "should get index" do
    get rating_reviews_url
    assert_response :success
  end

  test "should get new" do
    get new_rating_review_url
    assert_response :success
  end

  test "should create rating_review" do
    assert_difference('RatingReview.count') do
      post rating_reviews_url, params: { rating_review: { product_id: @rating_review.product_id, rating: @rating_review.rating, review: @rating_review.review, user_id: @rating_review.user_id } }
    end

    assert_redirected_to rating_review_url(RatingReview.last)
  end

  test "should show rating_review" do
    get rating_review_url(@rating_review)
    assert_response :success
  end

  test "should get edit" do
    get edit_rating_review_url(@rating_review)
    assert_response :success
  end

  test "should update rating_review" do
    patch rating_review_url(@rating_review), params: { rating_review: { product_id: @rating_review.product_id, rating: @rating_review.rating, review: @rating_review.review, user_id: @rating_review.user_id } }
    assert_redirected_to rating_review_url(@rating_review)
  end

  test "should destroy rating_review" do
    assert_difference('RatingReview.count', -1) do
      delete rating_review_url(@rating_review)
    end

    assert_redirected_to rating_reviews_url
  end
end
