PzformatView = require './pzformat-view'
{CompositeDisposable} = require 'atom'

module.exports = Pzformat =
  pzformatView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @pzformatView = new PzformatView(state.pzformatViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @pzformatView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'pzformat:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @pzformatView.destroy()

  serialize: ->
    pzformatViewState: @pzformatView.serialize()

  toggle: ->
    console.log 'Pzformat was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
