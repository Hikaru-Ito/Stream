angular.module('stream.controllers.main', [])

.controller 'MainCtrl', ($scope, $timeout, $ionicScrollDelegate, $ionicLoading, Feed) ->

  $scope.recommendFeeds = []
  $scope.seedFeeds = []
  $scope.seedFeedsSwiper
  $scope.autoplaying = false

  # SeedFeedsを取得する
  $scope.initSeedFeed = ->
    $ionicLoading.show
      animation: 'fade-in'
      showBackdrop: true

    Feed.getSeedFeeds().then (data)->
      $scope.seed_processing_time = data.processing_time
      $scope.seedFeeds = data.data
      $scope.getRecommendFeeds $scope.seedFeeds[0]
    ,(error)->
      console.log error

  # SeedFeedsを初期化する
  $scope.initSeedFeed()

  # SeedFeedsSwiperの初期化
  $scope.$on 'ngRepeatFinished', ->
    console.log 'hoge'
    $scope.seedFeedsSwiper = new Swiper '.swiper-container',
      slidesPerView: 'auto',
      centeredSlides: true,
      spaceBetween: 8,
      mousewheelControl: true,
      onSlideChangeEnd: (swiper) ->
        $scope.getRecommendFeeds $scope.seedFeeds[swiper.activeIndex]
        $ionicScrollDelegate.scrollTop()
        $scope.seedFeedsSwiper.update true

  # 自動再生スタート
  $scope.seedFeedsAutoPlayStart = ->
    $scope.seedFeedsSwiper.params.autoplay = 2000
    $scope.seedFeedsSwiper.startAutoplay()
    $scope.autoplaying = true

  # 自動再生ストップ
  $scope.seedFeedsAutoPlayStop = ->
    $scope.seedFeedsSwiper.stopAutoplay()
    $scope.autoplaying = false

  # 推薦記事の取得
  $scope.getRecommendFeeds = (feed) ->
    seed_feed_title = feed.title
    Feed.getRecommendFeeds(seed_feed_title).then (data) ->
      $scope.recommend_processing_time = data.processing_time
      console.log "推薦:#{$scope.recommend_processing_time}"
      $scope.recommendFeeds = data.data
      $ionicLoading.hide()
    , (error)->
      console.log error

  # SeedFeedsを推奨記事からInsert
  $scope.insertSeedFeed = (feed) ->
    seedfeed_activeindex =  $scope.seedFeedsSwiper.activeIndex
    $scope.seedFeeds.splice seedfeed_activeindex+1, 0, feed
    $scope.seedFeedsSwiper.update true
    $scope.seedFeedsSwiper.slideNext true, 400

  # SeedFeedを移動
  $scope.seedFeedNext = ->
    $scope.seedFeedsSwiper.slideNext true, 400

  $scope.seedFeedPrev = ->
    $scope.seedFeedsSwiper.slidePrev true, 400

  # BrowserOpenTrigger
  $scope.openPage = (feed) ->
    console.log feed
    $scope.openUrl feed.url, true

  # InAppBrowser
  $scope.openUrl = (url, readerMode) ->
    if typeof(SafariViewController) isnt 'undefined'
      SafariViewController.isAvailable (available) ->
        if available
          SafariViewController.show
            'url': url,
            'enterReaderModelIfAvailable': readerMode
        else
          window.open url, '_blank', 'location=yes'
    else
      window.open url, '_blank', 'location=yes'
      return true
