if [ -z "$1" ] || [ -z "$2" ]
	then
		echo "sh ./flashlight-runner.sh <testFile> <RN Version>"
		echo "example: sh ./flashlight-runner.sh tti.yml 0.69.8"
		exit 1
fi

# removes .yml from the test command
TEST_COMMAND="${1/.yml}"

DURATION=0
if [ "$TEST_COMMAND" == "tti" ]
	then
		DURATION=3000
elif [ "$TEST_COMMAND" == "tti_loggedin" ]
	then
		DURATION=10000
elif [ "$TEST_COMMAND" == "clear_cache" ]
	then
		DURATION=0
fi

# creates the results folder if it doesn't exist
mkdir -p ./results/$TEST_COMMAND

# runs the test
flashlight test --bundleId chat.rocket.reactnative --testCommand "maestro test $1" --resultsTitle "$TEST_COMMAND, $2" --resultsFilePath "./results/$TEST_COMMAND/$2.json" --record --duration $DURATION