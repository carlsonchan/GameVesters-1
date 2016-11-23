class LeaderboardsController < ApplicationController
  before_action :logged_in_user, only: [:show]

  def show
    @leaders = sort_by_percent_increase
    @first = @leaders[0]
    @second = @leaders[1]
    @third = @leaders[2]

    rank_leaders_after_third
  end

  private

  def sort_by_percent_increase
    sorted_leaders = User.order('percent_increase desc').pluck(:name, :percent_increase)
  end

  def rank_leaders_after_third
    rank = 4
    @leaders = @leaders[3..19]

    @leaders.each do |user|
      user.push(rank)
      rank += 1
    end
  end
end
