module CNB
  class MonthlyCurRatesParser < CurRatesParser
    def initialize(month, year)
      @month = month
      @year = year

      raise 'Invalid year given' unless valid_month?
      raise 'Invalid month given' unless valid_year?

      @currencies = {}
      @cur_rates_url = "#{CUR_RATES_URL}/kurzy_ostatnich_men/kurzy.txt?mesic=#{month}&rok=#{year}"
      @cur_rates_filepath = "#{CONFIG['exchange_rates_dir']}/monthly_cur_rates_#{year}_#{month}.txt"

      parse
    end

    private

    def parse
      download_cur_rates(@cur_rates_url) unless File.exist?(@cur_rates_filepath)
      super(@cur_rates_filepath)
    end

    def valid_month?
      @month.to_i >= 1 && @month.to_i <= 12
    end

    def valid_year?
      @year.to_i >= 2004 && @year.to_i <= Time.now.year
    end
  end
end
