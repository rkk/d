#!/bin/bash
usage() {
  script_name=$(basename ${0})
  cat << EOF
Usage: ${script_name} COMMAND [ARGUMENTS]

Runs Drush commands using site aliases specified
in the environment variable DHOST.

VARIABLES:
  DHOST - The Drush site aliases to run COMMAND on
  DFLAG - Default Drush arguments (optional)
  DROOT - The root directory of the Drush installation (optional)

EXAMPLES:
Running the command 'drush @somehost -y --verbose updb' using Drush
installed at '/usr/local/drush6/drush' is reduced to 'd updb' by
setting the following,

  export DHOST="somehost"
  export DFLAG="-y --verbose"
  export DROOT="/usr/local/drush6"

Running the command 'drush cc all' on the site aliases 'host1' and
'host2' is reduced to 'd cc all' by setting the following,

  export DHOST="host1 host2"

Note: Any host set in DHOST is blindly assumed to be a valid site alias
EOF
}

if [ ${#} -lt 1 ]; then
  usage
  exit 0
fi

if [ "x$DHOST" == "x" ]; then
  usage
  exit 1
fi

if [ "x$DFLAG" == "x" ]; then
  DFLAG=""
fi

drush_bin="drush"
if [ ! -z $DROOT ]; then
  if [ -f $DROOT/drush ]; then
    drush_bin=${DROOT}/drush
  fi
fi

for host in $DHOST
do
  ${drush_bin} @${host} ${DFLAG} ${@}
done

