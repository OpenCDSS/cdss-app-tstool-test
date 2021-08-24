#!/bin/sh

# Convert WQX JSON files to nicer format that is easier to review.
# The original data URLs don't seem to be available so these formats are frozen in time.

py -m json.tool wqx-results-data.json > wqx-results-data-nice.json
py -m json.tool wqx-monitoring-location-data.json > wqx-monitoring-location-data-nice.json
