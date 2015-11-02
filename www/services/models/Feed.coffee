angular.module('stream.models.feed', [])

.factory 'Feed', ($http, $q, STREAM_API_ENDPOINT, STREAM_API_BOTTLE_ENDPOINT) ->

  StockFeeds = []

  return {
    getSeedFeeds: ->

      deffered = $q.defer()
      $http
        method: 'GET',
        url: "#{STREAM_API_ENDPOINT}/posts"
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

    loadStockReadability: (feed) ->

      deffered = $q.defer()
      $http
        method: 'GET',
        url: "#{STREAM_API_BOTTLE_ENDPOINT}/api/readability?url=#{feed.url}"
      .success (data) ->
        stock_data = {
          feed_id: feed.id
          title: feed.title
          content: data
        }
        StockFeeds.push stock_data
        deffered.resolve(data)
      .error (data) ->
        deffered.reject(data)

      return deffered.promise

    getStockContent: (feed_id) ->
      for stock_feed in StockFeeds
        if stock_feed.feed_id is feed_id
          return stock_feed
      return false

    deleteStockContent: (feed_id) ->
      StockFeeds.some (v, i) ->
        if v.feed_id is feed_id
          StockFeeds.splice i,1
  }
