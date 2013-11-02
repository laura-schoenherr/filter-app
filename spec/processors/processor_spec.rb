require "spec_helper"
describe Processor, type: :model do
  let(:feed_source) {FeedSource.create!(url: "...", name: "..") }

  specify "legt an - mit original url", freeze_time: "2013-11-02 12:00:00"  do
    VCR.use_cassette "feed-url" do
      feed_source.url = 'http://www.online-recruiting.net/feed/'
      feed_source.full_text_selector = '#singlepage'
      Processor.process(feed_source)
      NewsItem.first.tap do |i|
        i.should be_present
        i.url.should == "http://www.online-recruiting.net/7-fragen-an-jobs-automobilwoche-de-das-portrait/"
        i.full_text.should be_present
      end
    end
  end

  specify "Haufe.de", freeze_time: "2013-11-02 12:00:00"  do
    VCR.use_cassette "feed-urlhaufe" do
      feed_source.url = 'https://www.haufe.de/xml/rss_129150.xml'
      feed_source.full_text_selector = '#col1_content .floatbox'
      Processor.process(feed_source)
      NewsItem.first.tap do |i|
        i.should be_present
        i.full_text.length.should > 200
        i.url.should == 'https://www.haufe.de/personal/hr-management/arbeitsmarkt-spezialisten-gesucht-arbeitslose-bleiben_80_205864.html'
      end
    end
  end

  specify 'Crosswater', freeze_time: '2013-11-02 12:00' do
    VCR.use_cassette 'feed-crosswater' do
      feed_source.url = 'http://crosswater-job-guide.com/feed'
      feed_source.full_text_selector = '.art-PostContent:nth-child(3)'
      Processor.process(feed_source)
      NewsItem.first.full_text.length.should > 200
    end
  end

end
