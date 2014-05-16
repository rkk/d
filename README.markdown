# D
D is a (very) simple Drush wrapper, with very specific features,

  - Reduce the amount of arguments and typing
  - Enable running the same Drush command on multiple targets
  - Support switching between multiple Drush versions

## Reduce arguments and typing
Drush commands often consist of multiple arguments and parameters,
eg:

    drush @somehost -y --verbose updb

Drush site aliases are fantastic, but working for longer
periods on the same project, constantly specifying the same
site aliases and arguments becomes tedious.

D allows you to set the site alias using an environment variable
that will be used instead of having to specify it as a parameter
when calling Drush.

The same applies to arguments, so the above example can be
significantly reduced by setting the variables accordingly,

    export DHOST="somehost"
    export DFLAG="-y --verbose"

Thus `drush @somehost -y --verbose updb` is reduced to,

    d updb

If you briefly need to run Drush on another host, you can always
call Drush directly, like you'd normally do,

    drush @someotherhost pm-list

D does not interfere with the default Drush settings.

## Running Drush on multiple targets
By setting `DHOST` to multiple site aliases, the given command
and arguments are run on each of the site aliases,

    export DHOST="host1 host2"

Thus `d cc all` runs the following commands in sequence,

    drush @host1 cc all
    drush @host2 cc all

## Multiple concurrent Drush versions
Often, multiple versions of Drush are installed at your local
development environment. Instead of having to explicitly call
the desired version with an absolute path to the `drush` script,
this can be done by setting the `DROOT` variable to the directory
containing the desired Drush version.

    export DROOT="/usr/local/drush6"
    export DHOST="somehost"

Thus `d dd` runs `/usr/local/drush6/drush @somehost dd`.  
Of course,
`DFLAG` is also used, if set.


## Installation
Put this somewhere in your `PATH` variable, and make sure
it's executable.  
Some shells define an alias for `d`, so you might need to
add `unalias d` to your shell configuration file
(`~/.bash_profile` or `~/.zshrc`) for D to work.

D blindly assumes that whatever you put in `DHOST` is
a valid Drush site alias, and makes no attempt of validating
this exists. If you do not set `DROOT`, Drush is assumed
to be available in `PATH`.


## Troubleshooting
Call D directly with an absolute path, eg. `/home/you/bin/d`
if you suspect that your shell alias for `d` might kick in.

If you encounter strange behavior when running the script,
add `-x` to the first line to enable debugging mode. Thus
the first line goes from,

    #/bin/bash

to,

    #/bin/bash -x

Adding `--debug` and `--verbose` to `DFLAG` also enables
very verbose debug messages to be printed when Drush runs.


## Recommendations
Set `DHOST` and `DFLAG` in your shell configuration file
(`~/.bash_profile` or `~/.zshrc`) to reduce the amount of times
you have to set these.

Better yet, use a session configurator like tmuxinator and create
a session for each project, in which these variables are set.  
That allows for rapidly switching between projects and ensuring
that the environment is properly configured.


## Disclaimer
Use this at your own risk.  
Take care and type less.