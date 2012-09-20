
class Photo extends Backbone.View
  template: (require 'templates/photo')
  className: "post"
  render: =>
    ($ @el).html @template(@model.toJSON())
    return this

class InstagramView extends Backbone.View

  el: "#instagram .photos"

  initialize: (options) ->
    @collection.on "reset", @all
    @collection.on "add", @add

  add: (model) =>
    ($ @el).append (new Photo model: model).render().el

  all: =>
    ($ @el).html ""
    @add(model) for model in @collection.models


class Aldin

  views: {}
  collections: {}

  ready: ->

    @collections.instagram = new Backbone.Collection
    @views.instagram = new InstagramView collection: @collections.instagram

    venue = '14382443'
    client = '884e7789f06e4b4988aa05b37fd7e77d'

    $.ajax
      url: "https://api.instagram.com/v1/locations/#{venue}/media/recent?count=20&client_id=#{client}"
      dataType: "jsonp"
      success: (data, status) =>
        @collections.instagram.reset data.data

  initialize: (options) ->
    $ =>
      @ready this

module.exports = new Aldin

