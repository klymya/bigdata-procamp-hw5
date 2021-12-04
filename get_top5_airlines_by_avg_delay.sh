usage() {
  echo -e "Usage: $0 [-s <name>]\n"\
       "where\n"\
       "-s defines an shecma name\n"\
       "\n"\
        1>&2
  exit 1
}


while getopts ":s:" opt; do
    case "$opt" in
        s)  SCHEMA=${OPTARG} ;;
        *)  usage ;;
    esac
done

if [[ -z "$SCHEMA" ]];
then
  SCHEMA="flight_delays"
fi


THIS_FILE=$(readlink -f "$0")
THIS_PATH=$(dirname "$THIS_FILE")
BASE_QUERY_PATH="$THIS_PATH/get_top5_airlines_by_avg_delay.hql"
QUERY_PATH="$THIS_PATH/tmp.hql"

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
echo "THIS_FILE = $THIS_FILE"
echo "THIS_PATH = $THIS_PATH"
echo "-------------------------------------"
echo "INPUT_PATH = $INPUT_PATH"
echo "SCHEMA = $SCHEMA"
echo "-------------------------------------"

QUERY=$(sed -e "s/\${SCHEMA}/${SCHEMA}/" ${BASE_QUERY_PATH})

echo "$QUERY" > "$QUERY_PATH"

SUBMIT_CMD="hive -f ${QUERY_PATH}"

echo "$SUBMIT_CMD"
${SUBMIT_CMD}

rm "$QUERY_PATH"

echo "-------------------------------------"
echo "results saved to the table 'flight_delays.avg_delay_result'"
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
