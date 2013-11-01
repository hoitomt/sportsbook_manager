class Tag
  constructor: (@selector) ->
    @data = $(@selector).data()

  url: ->
    @data.href

  name: ->
    @data.name

  postData: ->
    @data

  id: ->
    @data.id

  tagContainer: ->
    $(@selector).parents('#ticket-tags')

  setAmount: (amount) ->
    @data.amount = amount

  amount: ->
    @data.amount

TagService =

  newTagDialog: '#dialog-new-tag-form'
  deleteTagDialog: '#dialog-delete-tag-confirm'

  init: ->
    @setClickHandlers()
    # @setListeners()

  setClickHandlers: ->
    $(document).on 'click', 'a.add-tag', (e) =>
      data = $(e.target).closest('a')
      @addNewTagDialog(new Tag(data))

    $(document).on 'click', 'a.remove-tag', (e) =>
      data = $(e.target).closest('a')
      @confirmDeleteTagDialog(new Tag(data))

  # setListeners: ->
  #   $(document).on 'deleteTag', '.remove-tag', (e) =>
  #     @removeTag(new Tag(e.target))

  #   $(document).on 'addTag', '.add-tag', (e) =>
  #     @addTag(new Tag(e.target))

  addTag: (tag) ->
    $.ajax tag.url(),
      type: 'POST'
      dataType: 'html'
      data: tag.postData()
      success: (data) ->
        c = tag.tagContainer()
        c.html(data)
      fail: ->
        console.log("Fail")

  removeTag: (tag) ->
    $.ajax tag.url(),
      type: 'POST'
      dataType: 'html'
      data: tag.postData()
      success: (data) ->
        c = tag.tagContainer()
        c.html(data)
      fail: ->
        console.log("Fail")

  setLinkListeners: (tag) ->
    $('a.js-amount-link').off('click').on 'click', (e) =>
      console.log "Add Tag"
      tag.setAmount($(e.target).data('amount'))
      @addTag(tag)
      $.modal.close()

    $('a.confirm-delete').off('click').on 'click', (e) =>
      console.log "Remove Tag"
      @removeTag(tag)
      $.modal.close()

    $('a.cancel').off('click').on 'click', (e) =>
      $.modal.close()

  addNewTagDialog: (tag) ->
    @setLinkListeners(tag)
    $(@newTagDialog).modal()
    $(@newTagDialog).find('#tag-name').html(tag.name())

  confirmDeleteTagDialog: (tag) ->
    @setLinkListeners(tag)
    $(@deleteTagDialog).modal()

$ ->
  TagService.init()
