require 'spec_helper'

describe CNB::DailyCurRatesParser do
  before(:each) do
    @parser = CNB::DailyCurRatesParser.new
    @parser.stub(:cur_rates_filepath) { File.join('spec', 'examples', 'daily_cur_rates.txt') }
  end

  it 'returns date from the exchange rates file' do
    expect(@parser.date).to eq Date.parse('24.2.2014')
  end

  describe '#cur_rate' do
    it 'returns currency rate' do
      expect(@parser.cur_rate('USD')).to eq(19.927)
    end

    it 'raises error if currency with given code is not included in the exchange rates file' do
      expect{@parser.cur_rate('USX')}.to raise_error(StandardError)
    end
  end

  it 'returns country name' do
    expect(@parser.cur_name('USD')).to eq('dolar')
  end

  it 'returns currency name' do
    expect(@parser.cur_country('USD')).to eq('USA')
  end
end
