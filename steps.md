Problems to fix

1.- Unable to ping www.google.com

	Removing nsswitch.conf file, removing the /etc/hosts reference to google.com

2.- Unable to successfully run the command mysql < /tmp/world.sql

 	I found that frm files don't have correct premisions

 		chown -R mysql:mysql your-mysql-data-dir-here
 		/etc/init.d/mysql restart

3.- The user problemz cannot write to the file /home/problemz/tasks.txt

	Changed atributes with chattr -i tasks.txt (immutable variable)

4.- The disk mounted at /mnt/saysfullbutnot cannot be written to despite claiming to have space available

	The system have no free inodes available "df -i /mnt/saysfullbutnot"
	Too many small or 0 sized files on disk, removed them and remount the partition.

		mount -o remount,rw /mnt/saysfullbutnot/

5.- The user someadmin cannot sudo up to root

	Is not in the sudoers file just adding 
	someadmin ALL=(ALL) NOPASSWD:ALL

6.- The software raid array under /dev/mda is reporting an error

	I found it's degradated performance. It's a raid 1 so its suposed to have 2 disks and only found one.

		 mdadm -D /dev/md0 /dev/md0:
		/dev/md0:
		        Version : 1.2
		  Creation Time : Tue Dec 15 15:28:49 2015
		     Raid Level : raid1
		     Array Size : 10176 (9.94 MiB 10.42 MB)
		  Used Dev Size : 10176 (9.94 MiB 10.42 MB)
		   Raid Devices : 2
		  Total Devices : 1
		    Persistence : Superblock is persistent

		    Update Time : Tue Dec 15 17:06:43 2015
		          State : clean, degraded
		 Active Devices : 1
		Working Devices : 1
		 Failed Devices : 0
		  Spare Devices : 0

		           Name : techtask:0  (local to host techtask)
		           UUID : eee336d4:698584d1:52b640e9:9b3d3417
		         Events : 45

		    Number   Major   Minor   RaidDevice State
		       0       7        6        0      active sync   /dev/loop6
		       1       0        0        1      removed

	Add the disk to the loop again.
	
		mdadm --manage /dev/md0 --add /dev/loop6	       

7.- A server error is produced when loading http://172.16.2.12

	Modyfied the following lines to /etc/php5/fpm/pool.d/www.conf

		listen.owner = www-data
		listen.group = www-data
		listen.mode = 0666

		Restart nginx and php5-fpm