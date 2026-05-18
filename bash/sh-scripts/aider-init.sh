#!/bin/bash

export MISTRAL_API_KEY=P9UtoQmE9ZjH4vjy34NlY7ZQ7eaZ6jde

# aider --subtree-only --no-git --model mistral/mistral-large-latest
# aider --no-git --model mistral/mistral-large-latest
if [ "$1" == "browser" ]; then
  aider --model mistral/mistral-large-latest --browser
else
  aider --model mistral/mistral-large-latest
fi
