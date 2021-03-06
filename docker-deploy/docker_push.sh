#! /bin/bash

# Push only if it's not a pull request
if [ -z "$TRAVIS_PULL_REQUEST" ] || [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
    if [ "$TRAVIS_BRANCH" == "master" ] ; then
        # Build and push
        docker --version
        pip install --user awscli
	aws ecr create-repository --repository-name john
        export PATH=$PATH:$HOME/.local/bin
        eval $(aws ecr get-login --no-include-email --region ap-south-1)
	#docker login -u AWS -p $(/usr/local/bin/aws ecr get-login-password --region ap-south-1) 037368072271.dkr.ecr.ap-south-1.amazonaws.com
	aws --version
        docker build -t "$LIVE_APP_NAME" .
        docker tag "$LIVE_APP_NAME:latest" "$AWS_URL/$LIVE_APP_NAME:$TRAVIS_COMMIT"
        docker tag "$LIVE_APP_NAME:latest" "$AWS_URL/$LIVE_APP_NAME:latest"
        docker push "$AWS_URL/$LIVE_APP_NAME:$TRAVIS_COMMIT"
        docker push "$AWS_URL/$LIVE_APP_NAME:latest"
	#docker tag john 037368072271.dkr.ecr.ap-south-1.amazonaws.com/john
	#docker push 037368072271.dkr.ecr.ap-south-1.amazonaws.com/john
    fi
fi
