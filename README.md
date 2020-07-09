# reviewer slack notice
This GitHub Action is Slack notice to reviewer when pull request review requested.

## Usage
```
name: slack_notice
  on: 
    pull_request:
      types:
        - review_requested
jobs:
  notice:
    runs-on: ubuntu-18.04
    steps:
      - uses: mida-hub/reviewer-slack-notice@v1.0.0
        with:
          configuration_path: ".github/workflows/slack_notice/reviewer_to_slack.json"
          slack_webhook_url: ${{ secrets.SLACK_WEBHOOK_URL }}
```

## Environment Variables
### Set GitHub Secrets
- slack_webhook_url : Set your Slack Incoming Webhook URL

### Make json for Mapping GitHub Users to Slack MemberID
- configuration_path : your_repository_root/.github/workflows/slack_notice/reviewer_to_slack.json


If you give args with `configuration_path` you can change path.


- json : {"github-user-login": "<@slack_memberid>"}
- How to get slack member id :
Slack > Profile > Other > MemberID


- Example
```
{
    "mida-hub": "<@hogehoge1>",
    "yourname": "<@your_memberid>",
}

```

## License
[MIT](LICENSE) © 2020 mida-hub