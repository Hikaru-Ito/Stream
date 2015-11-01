angular.module('stream.models.feed', [])

.factory 'Feed', ($http, $q, STREAM_API_ENDPOINT) ->

  return {
    getSeedFeeds: ->

      deffered = $q.defer()
      $http
        method: 'GET',
        url: "#{STREAM_API_ENDPOINT}posts"
      .success (data) ->
        deffered.resolve(data)
      .error (data) ->
        deffered.reject(data)

      return deffered.promise

    getRecommendFeeds: (title) ->

      deffered = $q.defer()
      $http
        method: 'GET',
        url: "#{STREAM_API_ENDPOINT}/recommender?title=#{title}"
      .success (data) ->
        deffered.resolve(data)
      .error (data) ->
        deffered.reject(data)

      return deffered.promise
      
  }
