'use strict'
request = require 'request'
FeedParser = require 'feedparser'

Meteor.startup ->
  fetchFeed = (feed, cb) ->
    console.log 'fetching', feed.url
    feedparser = new FeedParser()
    req = request feed.url
    req.on 'response', (res) ->
      @pipe feedparser
    feedparser.on 'readable', Meteor.bindEnvironment ->
      while item = feedparser.read()
        if not Items.findOne(pubDate:item.pubDate)
          item.feedId = feed._id
          Items.insert item
    feedparser.on 'end', Meteor.bindEnvironment ->
      Feeds.update
        _id: feed._id
      , $set:
        lastChecked: new Date()
      cb()
  pollFeeds = ->
    feeds = Feeds.find
      lastChecked:
        $lt: new Date().setHours(new Date().getHours() - 1)
    .fetch()
    console.log 'checking', feeds.length, if feeds.length is 1 then 'feed' else 'feeds'
    counter = 0
    fetchNext = ->
      if counter < feeds.length
        fetchFeed feeds[counter++], fetchNext
      else
        console.log 'done'
    fetchNext()
  pollFeeds()
  Meteor.setInterval pollFeeds, 4 * 60 * 1000