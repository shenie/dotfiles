	" my filetype file
	if exists("did_load_filetypes")
	  finish
	endif
	augroup filetypedetect
	  au! BufRead,BufNewFile *.rhtml  setfiletype html
	  au! BufRead,BufNewFile *.rake   setfiletype ruby
	  au! BufRead,BufNewFile irbrc    setfiletype ruby
	augroup END

