# frozen_string_literal: true

# Http requests for the dashboard
class DashboardController < ApplicationController
  def index
    @mailers_count = DashboardBuilder.mailers_count
    @mailers_scheduled = DashboardBuilder.mailers_scheduled
    @unresponsive = DashboardBuilder.unresponsive
    @new_responses = DashboardBuilder.new_responses
  end
end
