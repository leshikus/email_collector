require 'minitest/autorun'
require 'email_collector'

class EmailCollectorTest < Minitest::Unit::TestCase
  SKIP_SLOW_TESTS = true
  @@logger = Logger.new $stderr

  def test_filter_at
    assert_equal "name@domain.com", EmailCollector.filter_at("name at domain.com")
    assert_equal "name@domain.ru", EmailCollector.filter_at("name et domain.ru")
    assert_equal "name@domain.moscow", EmailCollector.filter_at("name (at) domain.moscow")
    assert_equal "name@domain.moscow", EmailCollector.filter_at("name+at+domain.moscow")
  end
  
  def test_filter_exclam
    assert_equal "name@my.domain.com", EmailCollector.filter_exclam("name@my:domain!com")
  end

  def test_filter_b
    assert_equal "name@domain.com", EmailCollector.filter_b("<b>name</b>@<b>domain.com</b>")
  end

  AUTHOR_EMAIL = 'alexei.fedotov@gmail.com'
  EMAILS = [AUTHOR_EMAIL]
  PATTERNS = ['wikipedia']
  
  def test_search
    return if SKIP_SLOW_TESTS
    EmailCollector.size = :small
    
    (PATTERNS + EMAILS).each do |pattern|
  	  x = EmailCollector.google_search("\"#{pattern}\"").join('').gsub(/ /, '')
      #@@logger.debug("PATTERN = #{pattern}")
      #@@logger.debug("x = " << x)
      #@@logger.debug(x.match(/#{pattern}/i))
      assert(x.match(/#{Regexp.quote(pattern)}/i))
	end
  end
  
  def test_collect_plain
    return if SKIP_SLOW_TESTS
    EmailCollector.size = :small
    
    res = EmailCollector.collect_plain("openmeetings #{AUTHOR_EMAIL}", get_domain(AUTHOR_EMAIL)).flatten
    @@logger.debug(res)
    assert(res.include? AUTHOR_EMAIL)
  end
  
  def test_collect_plain_nodomain
    return if SKIP_SLOW_TESTS
    EmailCollector.size = :small
    
    res = EmailCollector.collect_plain("openmeetings #{AUTHOR_EMAIL}").flatten
    #@@logger.debug(res)
    assert(res.include? AUTHOR_EMAIL)
  end
  
  def test_collect
    return if SKIP_SLOW_TESTS
    
    EmailCollector.size = :small
    EmailCollector.keywords = ['harmony']
    
    EMAILS.each do |email|
      res = EmailCollector.collect("\"#{email}\"")
      #@@logger.debug(res)
  	  assert(res.include? email)
      res = EmailCollector.collect("\"#{email}\"", get_domain(email))
      #@@logger.debug(res)
      assert(res.include? email)
	end
  end

  private
  def get_domain(email)
    return email.gsub(/.*@/, '')
  end

end
