class EnqueueJobs
  def self.perform
    start_time = (Time.current + 70.minutes).beginning_of_hour
    (0..59).each do |i|
      CoinbaseCrawlerJob.set(wait_until: start_time + i.minutes).perform_later
      CexCrawlerJob.set(wait_until: start_time + i.minutes).perform_later
      BitfinexCrawlerJob.set(wait_until: start_time + i.minutes).perform_later
    end
  end
end
