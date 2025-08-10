# teams.sh

* [Presentation](#presentation "Presentation")
* [Dependencies](#dependencies "Dependencies")
* [Usage](#usage "Usage")
* [Options](#options "Options")
* [Getting a webhook URL](#getting-a-webhook-url "Getting a webhook URL")
* [Limitations](#limitations "Limitations")
* [Acknowledgements](#acknowledgements "Acknowledgements")

## Presentation

A pure bash script sending Microsoft Teams notifications through Workflows' webhooks.

[![Notification example](./static/notification_example.png#center "Notification example")](./static/notification_example.png)

Works with (group) conversations or channels.

## Dependencies

* [jq](https://jqlang.org/ "JQLang")

## Usage

1. Create a Workflow and get a webhook URL (see [Getting a webhook URL](#getting-a-webhook-url "Getting a webhook URL"))
2. Download `teams.sh` and make sure it has the `execute` authorization (`chmod +x teams.sh`)
3. Call `teams.sh --webhook-url $WEBHOOK_URL` to test it
4. Fully configure your notifications using the whole set of options described below

## Options

[![Notification content](./static/notification_content.png#center "Notification content")](./static/notification_content.png)

1. `--title`
2. `--username`
3. `--avatar`
4. `--description`
5. `--style`
6. `--field`
7. `--link`

⚠️ **None of those parameters are required** ⚠️

### `--title STRING`

Set a title to the notification

### `--username STRING`

Set an author to the notification

### `--avatar URL`

Set a custom avatar for the notification author

### `--description STRING`

Add a text description to the notification

### `--style (emphasis/accent/good/attention/warning)`

Set the style of the notification card.

Inherited from the [Container.style](https://adaptivecards.io/explorer/Container.html "Microsoft") property.

### `--field STRING;STRING`

Add a field `NAME: Value` to the notification.

This option can be provided O to n times to add n fields.

### `--link STRING;URL`

Add a link in the form of a clickable button to the notification.

This option can be provided O to n times to add n links.

## Getting a webhook URL

The goal here is to create a Workflow on PowerAutomate that is going to publish messages on Teams, in the form of an [Adaptive Card](https://adaptivecards.io/ "Microsoft"), using a webhook as a trigger.

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