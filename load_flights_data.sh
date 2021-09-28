usage() {
  echo -e "Usage: $0 [-i <path>] [-s <name>]\n"\
       "where\n"\
       "-i defines an input path. use escape character for slash '\/'\n"\
       "-s defines an shecma name\n"\
       "\n"\
        1>&2
  exit 1
}


while getopts ":i:s:" opt; do
    case "$opt" in
        i)  INPUT_PATH=${OPTARG} ;;
        s)  SCHEMA=${OPTARG} ;;
        *)  usage ;;
    esac
done

if [[ -z "$INPUT_PATH" ]];
then
  INPUT_PATH="\/bdpc\/hadoop_mr\/2015_Flight_Delays_and_Cancellations\/input\/"
fi

if [[ -z "$SCHEMA" ]];
then
  SCHEMA="flight_delays"
fi


THIS_FILE=$(readlink -f "$0")
THIS_PATH=$(dirname "$THIS_FILE")
BASE_QUERY_PATH="$THIS_PATH/load_flights_data.hql"
QUERY_PATH="$THIS_PATH/tmp.hql"

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
echo "THIS_FILE = $THIS_FILE"
echo "THIS_PATH = $THIS_PATH"
echo "-------------------------------------"
echo "INPUT_PATH = $INPUT_PATH"
echo "SCHEMA = $SCHEMA"
echo "-------------------------------------"

QUERY=$(sed -e "s/\${SCHEMA}/${SCHEMA}/" -e "s/\${INPUT_PATH}/${INPUT_PATH}/" ${BASE_QUERY_PATH})

echo "$QUERY" > "$QUERY_PATH"

SUBMIT_CMD="hive -f ${QUERY_PATH}"

echo "$SUBMIT_CMD"
${SUBMIT_CMD}

rm "$QUERY_PATH"
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"