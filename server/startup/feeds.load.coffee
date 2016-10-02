Meteor.startup ->
  if Feeds.find().count() == 0
    feeds = [
      {
        'url': 'http://feeds.feedburner.com/HarmontownPodcast'
        'lastChecked': new Date().setHours(new Date().getHours() - 2)
      }
      {
        'url': 'http://feeds.soundcloud.com/users/soundcloud:users:4483139/sounds.rss'
        'lastChecked': new Date().setHours(new Date().getHours() - 2)
      }
    ] 
    feeds.forEach (feed) ->
      Feeds.insert feed