'use strict'

Meteor.publish 'feeds', (options, searchString) ->
  where =
    'name':
      '$regex': '.*' + (searchString or '') + '.*'
      '$options': 'i'
  Counts.publish this, 'numberOfFeeds', Feeds.find(where), noReady: true
  Feeds.find where, options