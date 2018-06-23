# systemd\_automount

Manage systemd automounts with Puppet

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with systemd_automount](#setup)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)

## Description

This Puppet module can be used to manage Systemd automount units.

### Supported Puppet versions

* **Puppet >= 4**

### Tested OS Versions

Currently only these OS variants are tested, altought other OS distributions with **systemd** should also work.

* Redhat/CentOS >= 7
* SLES >= 12
* openSUSE Leap >= 42

## Usage

### Example: Using Code

You can use the funtionality of this module in your own .pp files by using the defined resource type `systemd_automount::config`.
The list of associated parameters can be found here: [Parameters](####systemd\_automount::config)

The code below will mount the remote NFSv3 share `192.168.100.1:/share` at the local directory `/mnt`.

```
 systemd_automount::config { '/mnt' :
  source  => '192.168.100.1:/share',
  fstype  => 'nfs',
  options => 'vers=3'
 } 
```
### Example: Using YAML (Hiera)

The main class `systemd_automount` provides the parameter `mounts` which only accecpts a hash value.
The list of associated parameters can be found here: [Parameters](####systemd\_automount::config)

The following example will mount the remote CIFS/SMB share `//192.168.100.1/smb` at the local directory `/dir_A` and the NFS4 share `192.168.200.2:/exports/nfs4` at the directory `/dir_B`.

```
 systemd_automount::mounts:
   '/dir_A:
     'source'  : '//192.168.100.1/smb'
     'fstype'  : 'cifs'
     'running' : 'false'
   '/dir_B':
     'source'  : '192.168.200.2:/exports/nfs4'
```
## Reference

### Public Classes

#### systemd\_automount

Main class

##### Parameters

* `auto_mounts` : This parameter accepts an hash describing one or multiple Systemd automount entries. Have a look at class [systemd\_automount::config](####systemd\_automount::config) to get informations about the posible parameters.

#### systemd\_automount::config

Realizes the configuration of the systemd automount units

##### Parameters

* `mountpoint` : Directory to use as mountpoint for the source device.
<br>Type: *string*
<br>Default: *undef*
<br>Example: *'/mnt'*
* `source` : Source device or network filesystem
<br>Type: *string*
<br>Default: *undef*
<br>Example: *'nfsserver:/my/share', 'cifsserver://share'*
* `fstype` : Filesystem type
<br>Type: *string*
<br>Default: *nfs4*
<br>Example: *'nfs', 'cifs'*
* `options` : Mount options seperated by ","
<br>Type: *string*
<br>Default: *empty*
<br>Example: *'sec=krb5p,intr,noacl'*
* `ensure` : Set this parameters value to "absent" to remove the automount entry.
<br>Type: *string*
<br>Default: *present*
* `dump` : fstab dump entry. See "man fstab".
<br>Type: *integer*
<br>Default: *0*
* `pass` : fstab pass entry. See "man fstab".
<br>Type: *integer*
<br>Default: *0*
* `atboot` : Set this to "false" if you don't want the filesystem to be active after reboot or when "mount -a" is given.
<br>Type: *boolean*
<br>Default: *true*
* `running` : Set this to false to disable the systemd mount unit.
<br>Type: *boolean*
<br>Default: *true*

### Private Classes

#### systemd\_automount::params

Parameter class. Default parameters are defined here.

## Limitations

* This Module is limited to Puppet Version >= 4
* This Module only supports systemd automount configurations
