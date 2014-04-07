@echo off

:: TODO: install the autohotkey script in the startup folder

:: install vimrc (just copy over old one :-/)
call cp .vimrc %home%\_vimrc

:: install vundle
if not exist "%home%\.vim\bundle\vundle\" (
   mkdir -p %home%\.vim\bundle\vundle\
   git clone https://github.com/gmarik/vundle.git %home%\.vim\bundle\vundle\
   vim +BundleInstall! +qall
) else (
   echo "Run vim +BundleInstall! +qall to upgrade vim plugins"
)

:: Configure git
git config --global color.ui true
git config --global user.name "Philip Jagielski"
git config --global user.email "philipjagielski@gmail.com"
git config --global core.editor vim
git config --global merge.tool vimdiff

:: install mercurial stuff
call cp mercurial\mercurial.ini %home%\mercurial.ini
call cp mercurial\hgignore.ini %home%\hgignore.ini
