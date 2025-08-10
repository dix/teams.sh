#!/bin/bash

WEBHOOK_URL=""

echo "Calling teams.sh..."

# Default test
./teams.sh --webhook-url "$WEBHOOK_URL"

# Detailed test
./teams.sh --webhook-url "$WEBHOOK_URL" \
--title "Test teams.sh 🐱"  \
--username "team.sh"  \
--avatar "https://raw.githubusercontent.com/dix/teams.sh/refs/heads/main/teams.sh.png" \
--description "Hello World!" \
--style "accent" \
--field "Field A;Value A"  \
--field "Field B;Value B"  \
--link "Repo URL;https://github.com/dix/teams.sh"  \
--link "EC;https://escapecollective.com/"

echo "Call complete."
