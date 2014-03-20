{EditorView, ScrollView} = require 'atom'

module.exports =
class MinimapEditorView extends ScrollView

  @content: ->
    @div class: 'minimap-editor editor editor-colors', =>
      @div class: 'scroll-view', outlet: 'scrollView', =>
        @div class: 'lines', outlet: 'lines'

  constructor: ->
    super

  initialize: ->
    super

  # Current editorView
  editorView: null

  setEditorView: (@editorView) ->

  getEditorView: ->
    @editorView

  update: ->
    start = Date.now()
    ###
    screenLines = grammar.tokenizeLines(text)
    html = []
    for tokens in screenLines
      html.push(EditorView.buildLineHtml({
        tokens: tokens,
        text: text,
        attributes: { 'class': 'line' },
        htmlEolInvisibles: '&nbsp;'
      }))
    @lines.html(html.join(''))
    html = displayBuffer = screenLines = null
    ###

    # FIXME: If the file is very large, the tokenizes doesn't generate completely,
    # so doesn't have the syntax highlight until a new view is activated in the same pane.
    numLines = @editorView.getModel().displayBuffer.getLines().length
    lines = @editorView.buildLineElementsForScreenRows(0, numLines)
    @lines.html ''
    @lines.append lines
    @lines.css fontSize: "#{@editorView.getFontSize()}px"

    console.log('Update MinimapEditorView response time:', (Date.now() - start) + 'ms')

  getClientRect: ->
    sv = @scrollView[0]
    {
      width: sv.scrollWidth,
      height: sv.scrollHeight
    }
