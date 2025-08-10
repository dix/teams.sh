# teams.sh

* [Presentation](#presentation "Presentation")
* [Dependencies](#dependencies "Dependencies")
* [Acknowledgements](#acknowledgements "Acknowledgements")

## Presentation

A pure bash script sending Microsoft Teams notifications through Workflows' webhooks.

Works with (group) conversations or channels.

## Dependencies

* [jq](https://jqlang.org/ "JQLang")

## Usage

1. Create a Workflow and get a webhook URL (see [Getting a webhook URL](#getting-a-webhook-url "Getting a webhook URL"))
2. Download `teams.sh` and make sure it has the `execute` authorization (`chmod +x teams.sh`)
3. Call `teams.sh --webhook-url $WEBHOOK_URL` to test it
4. Fully configure your notifications using the whole set of options described below

## Options

TO COMPLETE

## Getting a webhook URL

The goal is to create a Workflow on PowerAutomate that is going to publish messages on Teams, in the form of an [Adaptive Card](https://adaptivecards.io/ "Microsoft"), using a webhook as a trigger.

The official [Microsoft Support documentation](https://support.microsoft.com/en-us/office/create-incoming-webhooks-with-workflows-for-microsoft-teams-8ae491c7-0394-4861-ba59-055e33f75498 "Microsoft") works but can be quite cumbersome.

A more straightforward way to get a webhook URL is to open Teams, right-click on the (group) conversation or channel in which you want to publish notifications, and choose `Workflows`.
Next: 
* Search `webhook`
* Choose `Send webhook alerts to a chat/channel`
* Put an explicit `Name` (useful for its maintenance later on; not displayed in the notifications)
* `Next`
* `Add workflow`
* Wait a few seconds and copy the webhook URL provided under `Workflow added successfully!`

### Maintenance/debug

All the workflows created on your Microsoft account are available on [PowerAutomate](https://make.powerautomate.com/ "Microsoft") under the `My flows` section.

By clicking on a given workflow, you can see its execution history, turn it On/Off, delete it, update its details and also by clicking on `Edit`, open the workflow editor and by clicking on the `When a Teams webhook request is received`, access the `HTTP URL` of the webhook used to trigger the flow.

## Limitations

In its current iteration, the script uses relies on some hard-coded settings that can't be changed through parameters and require important changes to the source code, mainly:
- timezones for the notifications
- content of the [Adaptive Card](https://adaptivecards.io/ "Microsoft")

## Acknowledgements

Heavily inspired by [fieu/discord.sh](https://github.com/fieu/discord.sh "GitHub").