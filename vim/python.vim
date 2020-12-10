syntax enable
let b:pymode_python='python3'
let b:pymode_options_max_line_length=119
let b:pymode_lint_options_pep8 = {'max_line_length': g:pymode_options_max_line_length}
let b:pymode_virtualenv=1
let b:pymode_run_bind='<leader>E'
let b:pymode_rope_completion=0
let b:pymode_doc_bind='<C->k'
let b:pymode_doc=0
let b:pymode_folding=0
let b:pymode_rope=1
let b:pymode_rope_goto_definition_bind='<leader>g'
let b:pymode_rope_rename_bind = '<leader>r'
let b:pymode_rope_goto_definition_cmd='new'
nmap <silent><buffer> K <Plug>(kite-docs)