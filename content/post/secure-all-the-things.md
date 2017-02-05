+++
date = "2017-01-31T09:03:56Z"
title = "Secure All The Things"
tags = []
draft = true

+++

With all the recent talk of election hacking and vulnerabilities in popular messaging apps,
I decided spend a few days attempting to add extra layers of security to my development process.

Tinfoil hats at the ready people.

<!-- more -->

### Secure Passphrases

This is a simple one, but it's frightening how often even the most experienced developers use poor passwords,
and worse use the same one for all their services.

In general I try to choose long (12 characters or more) passphrases and make sure you use a different one
for each service/system you set up.

Most websites will protect your account from repeated external brute force attempts, but note
the distinction between this and an offline resource such as a passphrase protected SSH key; An attacker can make
as many attempts as they like against an offline resource. For these, a
[Diceware Passphrase](https://www.rempe.us/diceware/) should be considered.

### Multi-factor Authentication

Two factor authentication adds the requirement for a one-time-passcode along with your password, generated using a
registered device such as your laptop or smartphone. Without access to this device, a potential attacker will be
unable to authenticate against your accounts even if they have your password.

Using two factor authentication greatly improves the security of your online accounts, and it's trivial to set
up and use.

....

### Harden SSH Keys

### Sign / Encrypt with GnuPG

### Encrypt Hard Disk

### Considerations

Don't forget that you are protected as far as
