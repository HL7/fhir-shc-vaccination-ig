# Minimal safe bash template from https://betterdev.blog/minimal-safe-bash-script-template/
set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

usage() {
  cat <<EOF
Usage: script/validate-examples

Validates all the examples in the IG.

EOF
  exit
}

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  # script cleanup here
}

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
  else
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
  fi
}

msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}

setup_colors

# Make sure validator JAR is available
if [ ! -f input-cache/validator_cli.jar ]; then
    msg "${RED}input-cache/validator_cli.jar not found${NOFORMAT}\n\nDownload from https://github.com/hapifhir/org.hl7.fhir.core/releases/latest/download/validator_cli.jar"
    exit 1
fi

validate_example() {
  msg "\n\n----------------------------------------------------------------"
  msg "Validating $1 against $2..."
  temp_file=$(mktemp)
  java -jar input-cache/validator_cli.jar -version 4.0.1 -ig output/package.tgz $1 -profile http://hl7.org/fhir/uv/smarthealthcards-vaccination/StructureDefinition/$2 > $temp_file || true
  result=$(cat "$temp_file" | grep FAILURE || [[ $? == 1 ]] )

  if [ -n "$result" ]; then
    msg "${RED}$result${NOFORMAT}"
    cat "$temp_file" | grep "Error @" ||[[ $? == 1 ]]
    cat "$temp_file" | grep "Warning @" ||[[ $? == 1 ]]
  else
    result=$(cat "$temp_file" | grep "Success: 0 errors" ||[[ $? == 1 ]] )
    msg "${GREEN}$result${NOFORMAT}"
    cat "$temp_file" | grep "Warning @" || [[ $? == 1 ]]
  fi
  rm "$temp_file"
}
