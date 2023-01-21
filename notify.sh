#!/bin/bash

#  user id. Can be obtained using @GetMyIdBot
TELEGRAM_USER_ID=722828510
TELEGRAM_BOT_TOKEN=5975522929:AAHuxcWCXDfAIwtSJ6exdDy6-ynu97WLcVg  

# STAGE_NAME=$1
# STAGE_STATUS=$2
# STAGE_URL=$3

TIME="10"
URL="https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage"
TEXT="Deploy status: $1%0A%0AProject:+$CI_PROJECT_NAME%0AURL:+$CI_PROJECT_URL/pipelines/$CI_PIPELINE_ID/%0ABranch:+$CI_COMMIT_REF_SLUG"
# TEXT="You fucking cocksucker! Holy shit, motherfuckers"



# TEXT="STAGE: $STAGE_NAME%0A%0ASTATUS:+$STATUS%0AURL:+$STAGE_URL/pipelines/$CI_PIPELINE_ID/%0ABranch:+$CI_COMMIT_REF_SLUG"


curl -s --max-time $TIME -d "chat_id=$TELEGRAM_USER_ID&disable_web_page_preview=1&text=$TEXT" $URL > /dev/null