#!/bin/sh

npm run test &> test/out.log

for expectedContent in "ok 1 - should pass on truthy synchronous property" "ok 2 - should pass on truthy asynchronous property" "not ok 3 - should fail on falsy synchronous property" "not ok 4 - should fail on falsy asynchronous property" "ok 5 - should pass as the property fails" "not ok 6 - should fail as the property passes" "ok 7 - should never be executed # SKIP"
do
    cat test/out.log | grep "${expectedContent}" >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        cat test/out.log
        echo "=== TEST FAILED ==="
        echo "Unable to find: ${expectedContent}"
        exit 1
    fi
done

echo "TEST PASSED"