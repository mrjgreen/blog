+++
date = "2017-02-04T09:03:56Z"
title = "Sign Your Commits with PGP Keys"
tags = []

+++

Did you know that anyone with access to a Git repository can commit code as you, just by changing their git user details?

Imagine if a disgruntled colleague introduced a critical security vulnerability, or added malicious code under your name... how would you be able to prove it wasn't you?

<!-- more -->

### PGP Keys

"Pretty Good Privacy" (PGP) and the compatible GPL licensed "GNU Privacy Guard" (GPG) are encryption programs
offering:

 * Cryptographic privacy via encryption
 * Authentication via signatures (we will be looking at this one today!)

We can use PGP to sign all kinds of data, such as e-mails, documents and pretty much any kind of "digital message"
you can think of, which under the right circumstances verifies that this data was in fact created by you and has
not been altered since you signed it.

So how does this help us?

### Signed Commits

A git commit is nothing more than a "digital message" and as such it makes sense that we should be able to use our
PGP key to verify that the commit really does belong to us.

You can even upload the "public" half of your PGP key to GitHub so that each time you push a signed commit, they will
use the key to verify the signature.

![Verified Git Commit](/images/sign-commits-with-pgp/verified-commit-github.png)

### Generating Your PGP Key

To get started, lets install the GPG program via your package manager. On macOS we will also need to install a program
to manage a secure password prompt for the gpg program:

    # macOS users:
    brew install gpg
    brew install pinentry-mac

    # Ubuntu users:
    apt-get install gnupg

Check the program installed correctly by running `gpg --version` in your terminal:

~~~
$ gpg --version
gpg (GnuPG) 2.0.30
libgcrypt 1.7.6
Copyright (C) 2015 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
# etc...
~~~

Now you have GPG installed, we can create our PGP key using the command:

    gpg --gen-key

You will be greeted with a prompt:

~~~
Please select what kind of key you want:
   (1) RSA and RSA (default)
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
Your selection?
~~~
Hit enter to select the default of "RSA and RSA"

~~~
What keysize do you want? (2048)
~~~
We want to select the longest value, so type in "4096" and hit enter

~~~
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0)
~~~
Hit enter to select the default of "0" (key does not expire). This may seem like a bad idea, but in actual fact having
your key expire does little in and of itself to add security here.

~~~
Key does not expire at all
Is this correct? (y/N) y
~~~
Type "y" and hit enter to confirm.

Follow the rest of the on-screen instructions, which require you to enter your name and email address.
Be sure to leave the comment blank.

~~~
GnuPG needs to construct a user ID to identify your key.

Real name: Joe G
Email address: joe@...
Comment:
You selected this USER-ID:
    "Joe G <joe@...>"

Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? O
You need a Passphrase to protect your secret key.
~~~

Type "O" to accept, and then enter a **secure** passphrase when prompted. In the event of your key being lost, this
passphrase is the only thing protecting your key from being used.

Now you should be able to list your key by running `gpg --list-keys`

~~~
$ gpg --list-keys
/Users/joegreen/.gnupg/pubring.gpg
----------------------------------
pub   4096R/0DA169E9 2017-02-03
uid       [ultimate] Joe G <joe...>
sub   4096R/BC6E7C42 2017-02-03
~~~

### Using Your Key With Git

Now you have an active PGP key you will be able to use it to sign your commits.

In order to allow us to enter our passphrase on macOS we will need to enable the pinentry program we installed earlier.

    echo "pinentry-program /usr/local/bin/pinentry-mac" > ~/.gnupg/gpg-agent.conf


> Provided you have used the same email address in your PGP key identity as you have in your git user config,
your key will automatically be detected when you perform a git commit.

    git commit --gpg-sign -m "Commit message here"

Alternatively you can enable automatic commit signing by running:

   git config --global commit.gpgsign true

### Some Considerations

##### Signature Omission

Signed commits only provide evidence that a commit with a valid signature was made by you.
In the case of a commit being made under your name with no signature, your PGP key will go no way at all to proving
it wasn't you.

For this system of signed commits to work, there must exist a policy to prevent or immediately investigate
any instance of a commit with a missing or invalid signature. This can even be automated using git commit hooks.

##### Keep Your Private Key Safe

PGP signing keys are in fact made up of two parts: a private key allowing you to sign messages and a public key
allowing others to verify your signature is valid.

As the names suggest, you can (and in fact must) freely distribute your public key, but it is essential that your
private key is never ever revealed.

The validity of your signatures is only as good as the security of your private key. If your key is compromised, then
anyone can sign messages on your behalf and what's more, the presence of the signature is strong evidence that it really
did originate from you!

If you lose your private key, you should revoke it immediately using a revocation key which you must store and
keep in a safe place. This is beyond the scope of this post, but I intend to cover PGP keys in more detail in
future posts. In the meantime there plenty of great resources out there already.
