" Vim syntax file
" Language:           Clojure
" Last Change: 2008-01-01
" Maintainer:  Toralf Wittner <toralf....@gmail.com>

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

setl iskeyword+=?,-,*,!,+,/,=,<,>

syn match clojureComment ";.*$"
syn match clojureKeyword ":\a[a-zA-Z0-9?!\-+*\./]*"
syn region clojureString start=/"/ end=/"/ skip=/\\"/
syn match clojureCharacter "\\."
syn match clojureCharacter "\\space"
syn match clojureCharacter "\\tab"
syn match clojureCharacter "\\newline"

syn match clojureNumber "\<[0-9]\+\>"
syn match clojureRational "\<[0-9]\+/[0-9]\+\>"
syn match clojureFloat "\<[0-9]\+\.[0-9]\+\([eE][-+]\=[0-9]\+\)\=\>"

syn keyword clojureSyntax fn if cond def defn let new recur loop thisfn do quote the-var class instance? throw try-finally set! monitor-enter monitor-exit
syn match clojureSyntax "(\s*\.[^\.]"hs=s+1

syn region clojureDef matchgroup=clojureSyntax start="(\s*\(def[a-zA-Z0-9?!\-\+\.<>=]*\)\s*"hs=s+1 end="\ze\(\[\|(\|)\|\s\)" contains=clojureDefName
syn match clojureDefName "\s*[a-zA-Z0-9?!\-\+\*\./<>=]*" contained

syn region clojureVector matchgroup=Delimiter start="\[" matchgroup=Delimiter end="\]" contains=ALLBUT,clojureDefName
syn region clojureMap matchgroup=Delimiter start="{" matchgroup=Delimiter end="}" contains=ALLBUT,clojureDefName

syn match clojureNil "\<nil\>"
syn match clojureQuote "\('\|`\)"
syn match clojureUnquote "\(\~@\|\~\)"
syn region clojureDispatch start="#^" end=/[ \t\n;("]/
syn region clojureDispatch start="#^{" end=/}/
syn region clojureVarQuote start="#'" end=/[ \t\n;("]/
syn match clojureVarArg "&" containedin=clojureVector

highlight link clojureComment Comment
highlight link clojureString String
highlight link clojureCharacter Character
highlight link clojureNumber Number
highlight link clojureFloat Number
highlight link clojureRational Number
highlight link clojureKeyword PreProc
highlight link clojureSyntax Statement
highlight link clojureDefName Function
highlight link clojureNil Constant
highlight link clojureQuote Delimiter
highlight link clojureVarQuote Delimiter
highlight link clojureUnquote Delimiter
highlight link clojureDispatch Constant
highlight link clojureVarArg Number

if exists("g:clj_highlight_builtins")
    "Highlight Clojure's predefined functions"
    syn keyword clojureFunc ns load-file load
    syn keyword clojureFunc list cons conj defn
    syn keyword clojureFunc vector hash-map sorted-map sorted-map-by
    syn keyword clojureFunc meta with-meta defmacro when when-not
    syn keyword clojureFunc nil? not first rest second
    syn keyword clojureFunc ffirst frest rfirst rrest
    syn keyword clojureFunc eql? str strcat gensym cond
    syn keyword clojureFunc apply list* delay lazy-cons fnseq concat
    syn keyword clojureFunc and or + * / - == < <= > >=
    syn keyword clojureFunc inc dec pos? neg? zero? quot rem
    syn keyword clojureFunc complement constantly identity seq count
    syn keyword clojureFunc peek pop nth get
    syn keyword clojureFunc assoc dissoc find keys vals merge merge-with
    syn keyword clojureFunc scan touch
    syn keyword clojureFunc key val
    syn keyword clojureFunc contains
    syn keyword clojureFunc line-seq sort sort-by comparator
    syn keyword clojureFunc rseq sym name namespace locking .. ->
    syn keyword clojureFunc defmulti defmethod remove-method
    syn keyword clojureFunc binding find-var
    syn keyword clojureFunc ref deref commute alter set ensure sync !
    syn keyword clojureFunc agent agent-of agent-errors clear-agent-errors
    syn keyword clojureFunc await await-for
    syn keyword clojureFunc reduce reverse comp appl
    syn keyword clojureFunc every not-every any not-any
    syn keyword clojureFunc map pmap mapcat filter take take-while drop drop-while
    syn keyword clojureFunc zipmap
    syn keyword clojureFunc cycle split-at split-with repeat replicate iterate range
    syn keyword clojureFunc doseq  dotimes into
    syn keyword clojureFunc eval import unimport refer unrefer in-namespace unintern
    syn keyword clojureFunc into-array array
    syn keyword clojureFunc make-proxy implement
    syn keyword clojureFunc pr prn print println newline *out* *current-namespace*  *print-meta* *print-readably*
    syn keyword clojureFunc doto  memfn
    syn keyword clojureFunc read *in* with-open
    syn keyword clojureFunc time
    syn keyword clojureFunc int long float double short byte boolean char
    syn keyword clojureFunc aget aset aset-boolean aset-int aset-long aset-float aset-double aset-short aset-byte aset-char
    syn keyword clojureFunc make-array alength to-array to-array-2d
    syn keyword clojureFunc macroexpand-1 macroexpand
    syn keyword clojureFunc max min
    syn keyword clojureFunc bit-shift-left bit-shift-right
    syn keyword clojureFunc bit-and bit-or bit-xor bit-not
    syn keyword clojureFunc defstruct struct accessor create-struct
    syn keyword clojureFunc subvec
    highlight link clojureFunc Special
endif

let b:current_syntax = "clojure"
