{CompositeDisposable} = require 'atom'
{vsprintf} = require './sprintf'

module.exports = Pzformat =

  activate: (state) ->
    atom.commands.add 'atom-text-editor',
      'pzformat:format': (event) ->
        saparator = /[,，;]/g
        atom.commands.dispatch(atom.views.getView(atom.workspace.getActiveTextEditor()), 'editor:split-selections-into-lines')
        selections = @getModel().getSelections()

        formatStr = atom.clipboard.read()
        for selection in selections
          if selection.isEmpty()
            continue
          args = selection.getText().replace(saparator, ' ').trim().split(/\s+/g)
          selection.insertText(vsprintf(formatStr, args))
