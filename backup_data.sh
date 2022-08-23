#!/bin/bash

# remote repo variables
GITHUB_USER='..your username..'
DOCUMENTS_REPOSITORY_NAME='..your repository..'
DOCUMENTS_REPOSITORY_SSH="git@github.com:$GITHUB_USER/$DOCUMENTS_REPOSITORY_NAME.git"

# backup variables
CONFIG_FILES_GIT_FOLDER_NAME='configuration'
CRYPT_FILES_GIT_FOLDER_NAME='encrypted'
DOCUMENTS_GIT_FOLDER_NAME='documents'


clean_repo_folder() {
    rm -rf ~/$DOCUMENTS_REPOSITORY_NAME/$1
    mkdir ~/$DOCUMENTS_REPOSITORY_NAME/$1
}

copy_to_backup_root() {
    cp $1 ~/$DOCUMENTS_REPOSITORY_NAME/
}

copy_crypt_file() {
    cp $1 ~/$DOCUMENTS_REPOSITORY_NAME/$CRYPT_FILES_GIT_FOLDER_NAME/
}

copy_config_file() {
    cp $1 ~/$DOCUMENTS_REPOSITORY_NAME/$CONFIG_FILES_GIT_FOLDER_NAME/
}

copy_folder() {
    cp -R $1 ~/$DOCUMENTS_REPOSITORY_NAME/$DOCUMENTS_GIT_FOLDER_NAME
}

commit_and_cleanup() {
    cd ~/$DOCUMENTS_REPOSITORY_NAME
    git add .
    git commit -m "updates personal data backup on $(date)" --quiet
    git push --quiet origin master
    cd
    rm -rf ~/$DOCUMENTS_REPOSITORY_NAME
}


# Clone github repository to store the backup
echo "Cloning documents repository..."
git -C ~ clone $DOCUMENTS_REPOSITORY_SSH --quiet


echo "Updating documents repository..."

# 0 - Backup data script
# ----------------------

copy_to_backup_root ~/backup_data.sh

# 1 - Config files
# ----------------

clean_repo_folder $CONFIG_FILES_GIT_FOLDER_NAME
# ADD FILES HERE to include them in the backup, use full path. e.g. ~/.vimrc
copy_config_file "..FILE.."

# 2 - Encrypted files
# -------------------

clean_repo_folder $CRYPT_FILES_GIT_FOLDER_NAME
# ADD FILES HERE to include them in the backup, use full path. e.g. ~/Documents/secrets/my_passwords.crypt
copy_crypt_file "..FILE.."

# 3 - Documents
# -------------

clean_repo_folder $DOCUMENTS_GIT_FOLDER_NAME
# ADD FOLDERS HERE to include them in the backup, use full path. e.g. ~/Documents/guitar_tabs/
copy_folder "..FOLDER.."

# Add configuration as needed

# X - Commit, push, cleanup
# -------------------------
echo "Adding changes to repository..."
commit_and_cleanup


echo "Backup finished."
