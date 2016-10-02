angular.module 'pollingFeedsApp', [
  'angular-meteor'
  'ui.router'
  'angularUtils.directives.dirPagination'
  'accounts.ui'
]

onReady = () ->
  angular.bootstrap document, ['pollingFeedsApp']
  
if Meteor.isCordova
  angular.element(document).on 'deviceready', onReady
else
  angular.element(document).ready onReady