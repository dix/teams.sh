#!/bin/bash

########################
############ Variables
########################
WEBHOOK_URL=""
TITLE="team.sh notification"
AVATAR="https://raw.githubusercontent.com/dix/teams.sh/refs/heads/main/teams.sh.png"
USERNAME="teams.sh"
CURRENT_DATE=$(TZ='Europe/Paris' date +"%Y-%m-%d")
CURRENT_TIME=$(TZ='Europe/Paris' date +"%H:%M:%S")
DESCRIPTION=""
STYLE="default"
declare -a FACTS=()
declare -a LINKS=()

########################
############ Functions
########################
usage() {
  echo "Usage: $0 --webhook-url WEBHOOK_URL [--title TITLE] [--username USERNAME] [--avatar AVATAR] [--description DESCRIPTION] [--style STYLE(emphasis/accent/good/attention/warning)] --field \"KEY;VALUE\" [--field \"KEY2;VALUE2\" ...] --link \"TITLE;URL\" [--link \"TITLE2;URL2\" ...]"
  exit 0
}

parse_arguments() {
  while [[ $# -gt 0 ]]; do
    case $1 in
    --webhook-url)
      WEBHOOK_URL="$2"
      shift 2
      ;;
    --title)
      TITLE="$2"
      shift 2
      ;;
    --avatar)
      AVATAR="$2"
      shift 2
      ;;
    --username)
      USERNAME="$2"
      shift 2
      ;;
    --description)
      DESCRIPTION="$2"
      shift 2
      ;;
    --style)
      STYLE="$2"
      shift 2
      ;;
    --field)
      IFS=';' read -r key value <<<"$2"
      FACTS+=("{\"title\":\"$key:\",\"value\":\"$value\"}")
      shift 2
      ;;
    --link)
      IFS=';' read -r key value <<<"$2"
      LINKS+=("{\"type\": \"Action.OpenUrl\", \"title\":\"$key\",\"url\":\"$value\"}")
      shift 2
      ;;
    *)
      usage
      ;;
    esac
  done
}

check_arguments() {
  if [[ -z "$WEBHOOK_URL" ]]; then
    usage
  fi
}

join_arrays() {
  FACTS_JSON=$(
    IFS=,
    echo "${FACTS[*]}"
  )

  LINKS_JSON=$(
    IFS=,
    echo "${LINKS[*]}"
  )
}

generate_payload() {
  PAYLOAD=$(jq -n \
    --arg title "$TITLE" \
    --arg avatar "$AVATAR" \
    --arg username "$USERNAME" \
    --arg current_date "$CURRENT_DATE" \
    --arg current_time "$CURRENT_TIME" \
    --arg description "$DESCRIPTION" \
    --arg style "$STYLE" \
    --arg facts "[$FACTS_JSON]" \
    --arg links "[$LINKS_JSON]" \
    '{
      type: "message",
      attachments: [
        {
          contentType: "application/vnd.microsoft.card.adaptive",
          contentUrl: null,
          content: {
            type: "AdaptiveCard",
            body: [
              {
                type: "Container",
                items: [
                  {
                    type: "TextBlock",
                    size: "Large",
                    weight: "Bolder",
                    text: $title
                  },
                  {
                    type: "ColumnSet",
                    columns: [
                      {
                        type: "Column",
                        items: [
                          {
                            type: "Image",
                            style: "Person",
                            url: $avatar,
                            altText: $username,
                            size: "Small"
                          }
                        ],
                        width: "auto"
                      },
                      {
                        type: "Column",
                        items: [
                          {
                            type: "TextBlock",
                            weight: "Bolder",
                            text: $username,
                            wrap: true
                          },
                          {
                            type: "TextBlock",
                            spacing: "None",
                            text: "\($current_date) \($current_time)",
                            isSubtle: true,
                            wrap: true
                          }
                        ],
                        width: "stretch"
                      }
                    ]
                  },
                  {
                    type: "TextBlock",
                    text: $description,
                    wrap: true
                  },
                  {
                    type: "FactSet",
                    facts: ($facts | fromjson)
                  },
                  {
                    "type": "ActionSet",
                    "actions": ($links | fromjson)
                  }
                ],
                bleed: true,
                style: $style
              }
            ],
            "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
            version: "1.5"
          }
        }
      ]
    }')

}

send_notification() {
  curl \
    --header "Content-Type: application/json" \
    --request POST \
    --data "${PAYLOAD}" \
    "${WEBHOOK_URL}"
}

########################
############ Main Content
########################
parse_arguments "$@"

check_arguments

join_arrays

generate_payload

send_notification
