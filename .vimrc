"dedian-овая рунтаим либы лучшебы от них избавится точно все не нужны
"runtime! debian.vim
set nocompatible "отключает совместилость с vi
set ruler "Показывать положение курсора всё время.
set autoindent "Автоматический отступ
set expandtab "Преобразование Таба в пробелы
set shiftwidth=2 "Размер табулации по умолчанию
set softtabstop=2
set tabstop=2
set showcmd "Показывать незавершённые команды в статусбаре
set ai "включим автоотступы для новых строк
set cin "включим отступы в стиле Си
colorscheme slate "Устанавливаем цветовую гамму
set ffs=unix,dos,mac "Порядок применения кодировок и формата файлов
set fencs=utf-8 ",cp1251,koi8-ru,ucs-2,cp866
set list " включить подсветку
set listchars=tab:>-,trail:- " установить символы, которыми будет осуществляться подсветка
set noswapfile " не использовать своп-файл (в него скидываются открытые буферы)
set browsedir=current
set nobackup " выключить сохранение резервных копий
set novisualbell " Отключение звукового сигнала (на всякий случай - системный динамик у меня всегда отключен уже в ядре)
set mouse-=a " Выключение перехода в визуальный режим при выделении мышю

" Кое-какие автозамены
iabbrev ### ############################################################################
iabbrev --- ----------------------------------------------------------------------------


"НАСТРОЙКИ СВОРАЧИВАНИЯ БЛОКОВ КОДА (фолдинг)
set foldenable " включить фолдинг
"set foldmethod=syntax " определять блоки на основе синтаксиса файла
set foldmethod=indent " определять блоки на основе отступов
"set foldcolumn=3 " показать полосу для управления сворачиванием
"set foldlevel=1 " Первый уровень вложенности открыт, остальные закрыты
"set foldopen=all " автоматическое открытие сверток при заходе в них
set foldopen=block,hor,mark,percent,quickfix,search,tag,undo " автоматическое открытие сверток призаходе в них
"set tags=tags\ $VIMRUNTIME/systags " искать теги в текущй директории и в указанной (теги генерируются ctags)

"" Применять типы файлов
filetype on
filetype plugin on
filetype indent on

"set langmap=Ж:,йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ъ],фa,ыs,вd,аf,пg,рh,оj,лk,дl,э',яz,чx,сc,мv,иb,тn,ьm,б\,,ю.,ё` "возможность использовать команды при русской раскладке
if filereadable(expand("$VIMRUNTIME/keymap/russian-jcukenwin.vim"))
   set keymap=russian-jcukenwin
endif
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan
"setlocal spell spelllang=ru_yo,en_us

set langmenu=ru_ru "Настройки русской локали для VIM
set helplang=ru,en
"Опять же, системы сборки для разных платформ могут быть переопределены:
set smartindent "Включаем "умные" отспупы ( например, автоотступ после {)
"set number "показывает номера строк; для программирования очень полезно. 
syntax on "активирует syntax highlighting для огромного числа языков программирования, это число можно ещё увеличить с помощью плагинов.
set termencoding=utf-8 "Кодировка текста по умолчанию
set hidden "Не выгружать буфер, когда переключаемся на другой. Это позволяет редактировать несколько файлов в один и тот же момент без необходимости сохранения каждый раз когда переключаешься между ними
"inoremap { {<CR>}<Esc>O { 
"inoremap { {<CR>}<Esc>O  
"кнопки

"   По умолчанию проверка орфографии выключена.
setlocal spell spelllang=
setlocal nospell
function ChangeSpellLang()
	if &spelllang =~ "en_us"
		setlocal spell spelllang=ru
		echo "spelllang: ru"
	elseif &spelllang =~ "ru"
		setlocal spell spelllang=
		setlocal nospell
		echo "spelllang: off"
	else
		setlocal spell spelllang=en_us
		echo "spelllang: en"
	endif
endfunc
" map spell on/off for English/Russian
map <F2> <Esc>:call ChangeSpellLang()<CR>

" F2 - быстрое сохранение
"nmap <F2> :w<cr>
"vmap <F2> <esc>:w<cr>i
"imap <F2> <esc>:w<cr>i
" F3 - просмотр ошибок
"nmap <F3> :copen<cr>
"vmap <F3> <esc>:copen<cr>
"imap <F3> <esc>:copen<cr>
" F5 - просмотр списка буферов
"nmap <F5> <Esc>:buffers<CR>
"vmap <F5> <esc>:buffers<CR>
"imap <F5> <esc><esc>:buffers<CR>
set pastetoggle=<F5>
" F6 - предыдущий буфер
map <F6> :bp<cr>
vmap <F6> <esc>:bp<cr>i
imap <F6> <esc>:bp<cr>i
" F7 - следующий буфер
map <F7> :bn<cr>
vmap <F7> <esc>:bn<cr>i
imap <F7> <esc>:bn<cr>i
" F8 - список закладок
"map <F8> :MarksBrowser<cr>
"vmap <F8> <esc>:MarksBrowser<cr>
"imap <F8> <esc>:MarksBrowser<cr>
" F9 - "make" команда
"map <F9> :make<cr>
"vmap <F9> <esc>:make<cr>i
"imap <F9> <esc>:make<cr>i
" F10 - удалить буфер
"map <F10> :bd<cr>
"vmap <F10> <esc>:bd<cr>
"imap <F10> <esc>:bd<cr>
" F11 - включить-выключить нумерацию строк
imap <F11> <Esc>:set<Space>nu!<CR>a
nmap <F11> :set<Space>nu!<CR>
" F11 - показать окно Taglist
"map <F11> :TlistToggle<cr>
"vmap <F11> <esc>:TlistToggle<cr>
"imap <F11> <esc>:TlistToggle<cr>
" F12 - обозреватель файлов
map <F12> :Ex<cr>
vmap <F12> <esc>:Ex<cr>i
imap <F12> <esc>:Ex<cr>i
" Редко когда надо [ без пары =)
imap [ []<LEFT>
" Аналогично и для {
"imap {<CR> {<CR>}<Esc>O
imap { {}<LEFT>
" Автозавершение слов по tab =)
function InsertTabWrapper()
     let col = col('.') - 1
     if !col || getline('.')[col - 1] !~ '\k'
         return "\<tab>"
     else
         return "\<c-p>"
     endif
endfunction
imap <tab> <c-r>=InsertTabWrapper()<cr>
" Слова откуда будем завершать
set complete=""
" Из текущего буфера
set complete+=.
" Из словаря
set complete+=k
" Из других открытых буферов
set complete+=b
" из тегов 
set complete+=t
