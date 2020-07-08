# reviewer slack notice
This GitHub Action is Slack notice to reviewer when pull request review requested.

## Usage
coming soon.

## Environment Variables
### Set GitHub Secrets
- SLACK_WEBHOOK_URL : You get slack webhook token

### Make Mapping GitHub Users to Slack MemberID
- file path : repository_root/.github/workflows/slack_notice/reviewer_to_slack.json
- json : {"github-user-login": "<@slack_memberid>"}
- How to get slack user id :
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