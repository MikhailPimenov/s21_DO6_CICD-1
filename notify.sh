#!/bin/bash

#  user id. Can be obtained using @GetMyIdBot
TELEGRAM_USER_ID=722828510
#  user id. Is obtained when creating bot via @BotFather
TELEGRAM_BOT_TOKEN=5975522929:AAHuxcWCXDfAIwtSJ6exdDy6-ynu97WLcVg  

MY_CI_PROJECT_NAME='elviaatt DO6 CI/CD'

TIME="10"
URL="https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage"
TEXT="Status:+$CI_JOB_STATUS%0A
Pipeline:+$CI_PIPELINE_IID%0A
Stage:+$CI_JOB_STAGE%0A
Job:+$CI_JOB_NAME%0A%0A
Project:+$MY_CI_PROJECT_NAME%0A
URL:+$CI_PROJECT_URL/pipelines/$CI_PIPELINE_ID/%0A
Branch:+$CI_COMMIT_REF_SLUG%0A
Message:+$CI_COMMIT_MESSAGE"



curl -s --max-time $TIME -d "chat_id=$TELEGRAM_USER_ID&disable_web_page_preview=1&text=$TEXT" $URL > /dev/null