# Description:
#   FooBot gets you tip top information from the PHP documentation
#
# Commands:
#   <nick?> !docs <query> - Perform a Google search against PHP docs
#
# Notes:
#   None

cheerio   = require 'cheerio'
htmlStrip = require 'htmlstrip-native'

TARGET_VERSION = '4.2'
SEARCH_URL = 'https://www.google.com/search'
USER_AGENT = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36'

module.exports = (robot) ->
  getQueryUrl = (query) ->
      "site:php.net/manual/en #{query}"

  fetchResult = (query, callback) ->
    robot.http(SEARCH_URL)
      .header('User-Agent', USER_AGENT)
      .query(q: query)
      .get() (err, res, body) ->
        $ = cheerio.load body
        result = $('li.g').first()
        # Jump To Link ? Main Link
        url = result.find('.st .f a').attr('href') ? result.find('h3.r a').attr('href')
        callback url if callback

  docFetcher = (msg) ->
    [user, query] = msg.match[1..2]

    fetchResult getQueryUrl(query), (url) ->
      return msg.send "No results for \"#{query.substr(0,30)}\"" unless url

      response = url
      response = "#{user}: #{response}" if user

      if /function/.test url
        robot.http(url).get() (err, res, body) ->
          $ = cheerio.load body
          methodSigContent = htmlStrip.html_strip $('.methodsynopsis').html(), compact_whitespace : true
          msg.send "#{response} | #{methodSigContent}"
      else
        msg.send response

  robot.respond /show (?:([^\s!]+) )?docs for (.+)/i, docFetcher
  robot.hear /(?:([^:,\s!]+)[:,\s]+)?!docs (?:\s?(.+))/i, docFetcher
