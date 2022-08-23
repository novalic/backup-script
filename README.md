# backup-script

- Tested in Ubuntu 20.04.4 LTS.
- The backup consists of the `backup_data.sh` file. The idea is to execute this backup periodically with anacron.
- The file contains a generic structure idea that can be adapted to personal needs.
- For this you need to setup a personal repository, private or public.
- Any change you make to the `backup_data.sh` file in your machine will be saved in the repository.

## Installation

The example shows how the backup will be executed with an anacron task weekly, from the home folder.

1. Copy the backup script:
```
$ cp path/to/repo/backup_data.sh ~/
```
2. Give the file execution rights:
```
$ sudo chmod +x ~/backup_data.sh
```
3. Add configuration to anacron to execute the script weekly:
```
sudo su
echo "@weekly 15 backup.weekly /bin/bash ~/backup_data.sh" >> /etc/anacrontab
```
Or edit the file `/etc/anacrontab` manually adding the configuration: `@weekly 15 backup.weekly /bin/bash ~/backup_data.sh`

**Anacron reference**

In the example `@weekly 15 backup.weekly /bin/bash ~/backup_data.sh`:

- *@weekly* is the execution period, other possible values:
@daily, @monthly, 1, 5, n (any number of days)

- *15* is the delay in minutes before the task is executed. If the computer is turned off and the task needs to be executed, it will execute after this amount of minutes. 

- *backup.weekly* is the job's name.

- */bin/bash ~/backup_data.sh* is the command to be executed.
