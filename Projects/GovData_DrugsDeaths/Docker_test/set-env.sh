#!/bin/bash

# Source the .env file
set -a  # automatically export all variables
source .env
set +a

# Set the environment (prod or test)
ENV=${ENV:-prod}

# Export the correct variables based on environment
#if [ "$ENV" = "prod" ]; then
    export KAFKA_PORT=$PROD_KAFKA_PORT
    export ZOOKEEPER_PORT=$PROD_ZOOKEEPER_PORT
    export SPARK_UI_PORT=$PROD_SPARK_UI_PORT
    export KAFKA_CONTAINER=$PROD_KAFKA_CONTAINER
    export ZOOKEEPER_CONTAINER=$PROD_ZOOKEEPER_CONTAINER
    export SPARK_CONTAINER=$PROD_SPARK_CONTAINER
#else
    export KAFKA_PORT=$TEST_KAFKA_PORT
    export ZOOKEEPER_PORT=$TEST_ZOOKEEPER_PORT
    export SPARK_UI_PORT=$TEST_SPARK_UI_PORT
    export KAFKA_CONTAINER=$TEST_KAFKA_CONTAINER
    export ZOOKEEPER_CONTAINER=$TEST_ZOOKEEPER_CONTAINER
    export SPARK_CONTAINER=$TEST_SPARK_CONTAINER
#fi