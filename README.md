# schroot-utils
Some helpers for quickly creating and removing chroot envs to give some isolation to try out changes.

I've referred to them as jails to make a distinction in the command names, but they have nothing to do with bsd jails.

### Dependencies
chroot, schroot, debootstrap, rsync

You need a folder called Jails in your home dir.

### Make a chroot
`sudo mkjail.sh my-dev-env`

This will 
 - download bionic beaver filesystem into a folder called `cache` in the Jails dir. 
 - copy the filesystem to a folder called my-dev-env
 - create a schroot config for a minimal profile chroot (only mounts sys and proc)
 - set up a home dir for the current user inside the chroot (so confs dont leak out)
 
### Remove a chroot
`sudo rmjail.sh my-dev-env`

This will
 - stop any existing chroot session
 - remove the schroot config
 - remove the Jails/my-dev-env folder

### Enter a chroot
`jail.sh my-dev-env`

Starts a session in the my-dev-env chroot

### Stop a chroot session
From inside the session run `logout`
From outside the session run `stopjail.sh my-dev-env`

This will
 - find the session id by name
 - terminate the session
 - leave the filesystem to re-enter later
