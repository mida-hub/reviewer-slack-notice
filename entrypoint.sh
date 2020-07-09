#!/bin/bash

get_reviewer_to_slack_json(){
    json=$(curl -H "Authorization: token ${github_token}" https://api.github.com/repos/${github_repository}/contents/${configuration_path})
    reviewer_to_slack_json=$(echo ${json} | tr -d '[:cntrl:]' | jq -r '.content' | base64 --decode)
    echo ${reviewer_to_slack_json}
}

fetch_requested_reviewers(){
    requested_reviewers_tmp=$(curl -H "Authorization: token ${github_token}" https://api.github.com/repos/${github_repository}/pulls/${github_event_pull_request_number}/requested_reviewers)
    requested_reviewer_users=$(echo ${requested_reviewers_tmp} | jq -r .users)
    num_reviewer=$(echo ${requested_reviewer_users} | jq length)

    echo ${requested_reviewers_tmp}
    echo ${requested_reviewer_users}
    echo ${num_reviewer}
}

make_text_for_slack(){
    if test ${num_reviewer} -ge 1; then
        text_for_slack="https://github.com/${github_repository}/pull/${github_event_pull_request_number} \n"
        
        for i in $( seq 0 $((${num_reviewer}-1)) )
        do
            login=$(echo ${requested_reviewer_users} | jq -r .[$i].login)
            slack_user_id=$(echo ${reviewer_to_slack_json} | jq -r ".[\"${login}\"]")
            echo "${login}:${slack_user_id}"

            text_for_slack="${text_for_slack}${slack_user_id} "
        done

        text_for_slack="${text_for_slack} :review: "
        
        echo ${text_for_slack}
      fi
}

slack_notice(){
    if test ${num_reviewer} -ge 1; then
        text_json="{ \"text\": \"${text_for_slack}\" }"
        curl -s -X POST \
            -H 'Content-Type: application/json' \
            -d "${text_json}" \
            ${slack_webhook_url}
    fi
}

main(){
    get_reviewer_to_slack_json
    fetch_requested_reviewers
    make_text_for_slack
    slack_notice
}

configuration_path=$1
github_token=$2
github_repository=$3
github_event_pull_request_number=$4
slack_webhook_url=$5

set -e

main

exit 0
