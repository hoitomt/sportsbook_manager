Tag = ->
  init = ->
    console.log "Tag Init"

  return {
    go: ->
      init()
  }

$ ->
  Tag.go