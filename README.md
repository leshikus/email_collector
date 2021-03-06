[![Gem Version](https://badge.fury.io/rb/email_collector.png)](http://badge.fury.io/rb/email_collector)
# Email Collector

Helper utility for getting a number of email addresses based on a search request to Google. You may think of it as a search engine for emails.

## Installation

Install the gem using the following command:

```sh
$ gem install email_collector
```

## Usage

To collect a number of emails email_collector sends a specified search request to Google and parses response pages. You can specify a domain of a specific email provider (e.g. gmail.com, outlook.com) to improve matching. Of course, you should be connected to Internet to be able to send queries to Google.

For example, to get a number of developer emails, you can run

```ruby
emails = EmailCollector.collect('site:github.com', 'gmail.com')
```

or

```sh
$ irb
require 'email_collector'
EmailCollector.keywords = ['']
emails = EmailCollector.collect('site:moikrug.ru', 'yandex.ru')
=> ["events@yandex.ru", "music@yandex.ru", "company@yandex.ru", "api@yandex.ru"]

```


You can verify emails further by querring the correspondent mail server.
	
Please send questions to [alexei.fedotov@gmail.com](mailto:alexei.fedotov@gmail.com). Contribute via pull requests.

## Contributors

* Alexei Fedotov ([leshikus](https://github.com/leshikus))
