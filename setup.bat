@echo off

:: TODO: install the autohotkey script in the startup folder

:: install vimrc (just copy over old one because windows vim doesn't create a default one)
cp .vimrc %USERPROFILE%\_vimrc

:: install vundle
if not exist "%USERPROFILE%\.vim\bundle\vundle\" (
   mkdir -p %USERPROFILE%\.vim\bundle\vundle\
   git clone https://github.com/gmarik/vundle.git %USERPROFILE%\.vim\bundle\vundle\
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
cp mercurial\mercurial.ini %USERPROFILE%\mercurial.ini
cp mercurial\hgignore.ini %USERPROFILE%\hgignore.ini
