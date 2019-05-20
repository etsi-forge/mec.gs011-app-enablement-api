#!/bin/bash

specfiles=$(ls | egrep "^[^.]*.(json|yaml)")

fres=0
for i in $specfiles ; do
    echo "-- Validating and linting OpenAPI file $i..."
    swagger-cli validate "$i"
    res=$?
    speccy lint "$i"
    res2=$?
    fres=$(($fres||$res||$res2))
    echo "--- Validator returned $res, linter returned $res2."
done

echo "-- Final validation returns $fres."

exit $fres