'use strict'

Meteor.publish 'items', (options, searchString) ->
  where =
    'name':
      '$regex': '.*' + (searchString or '') + '.*'
      '$options': 'i'
  Counts.publish this, 'numberOfItems', Items.find(where), noReady: true
  Items.find where, options