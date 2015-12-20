require 'minitest/autorun'
require 'email_collector'

class EmailCollectorTest < Minitest::Unit::TestCase

  def test_filter_at
    assert_equal "name@domain.com", EmailCollector.filter_at("name at domain.com")
    assert_equal "name@domain.ru", EmailCollector.filter_at("name et domain.ru")
    assert_equal "name@domain.moscow", EmailCollector.filter_at("name (at) domain.moscow")
    assert_equal "name@domain.moscow", EmailCollector.filter_at("name+at+domain.moscow")
  end
  
  def test_search
  @logger = Logger.new $stderr
  @logger.debug(EmailCollector.search('dataved alexei.fedotov', :small))
  end

end