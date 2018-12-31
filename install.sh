echo "Configuring bashrc..."
# Append bashrc to existing .bashrc. If it is already in the file, replace it.
BASHRC_FILE=$HOME/.bashrc
CONFIG_START=`grep -n abapst_config_start $BASHRC_FILE | cut -d : -f 1`
CONFIG_END=`grep -n abapst_config_end $BASHRC_FILE | cut -d : -f 1`

if [ $CONFIG_START ] & [ $CONFIG_END ]
then
  CONFIG_START=$((CONFIG_START-2))
  CONFIG_END=$((CONFIG_END+1))
  sed -i $BASHRC_FILE -re $CONFIG_START","$CONFIG_END"d"
fi

cat bashrc >> $BASHRC_FILE

echo "Configuring tmux..."
cp .tmux.conf $HOME/.
cp .cyan.tmuxtheme $HOME/.

echo "Configuring vim..."
# Clone vimrc repo
git clone --recursive https://github.com/abapst/vimrc.git $HOME/.vim

# Redirect vimrc to .vim folder
echo "runtime vimrc" > $HOME/.vimrc

echo "Done!"
