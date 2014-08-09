define ['backbone', 'IndexView'], (Backbone, IndexView) ->

    AppView = Backbone.View.extend
    
        el: 'body'
        initialize: () ->
            @render()
        render: () ->
            (new IndexView()).render()
            NProgress.done()

    return AppView