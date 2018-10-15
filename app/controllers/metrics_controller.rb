class MetricsController < ApplicationController
  def show
    time_period = params[:date_range] || 'last-30-days'
    base_path = params[:base_path]

    curr_period = DateRange.new(time_period)
    prev_period = DateRange.new(time_period, Date.parse(curr_period.from))

    curr_period_data = FetchSinglePage.call(
      base_path: base_path,
      from: curr_period.from,
      to: curr_period.to
    )
    prev_period_data = FetchSinglePage.call(
      base_path: base_path,
      from: prev_period.from,
      to: prev_period.to
    )

    @performance_data = SingleContentItemPresenter.new(curr_period_data, curr_period)
  end

  rescue_from GdsApi::HTTPNotFound do
    render file: Rails.root.join('public', '404.html'), status: :not_found
  end
end
