#! /bin/bash

# Push only if it's not a pull request
if [ -z "$TRAVIS_PULL_REQUEST" ] || [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
    if [ "$TRAVIS_BRANCH" == "master" ] ; then
        # Build and push
        docker --version
        #pip install --user awscli
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
	sudo ./aws/install
        export PATH=$PATH:$HOME/.local/bin
        eval $(aws ecr get-login --no-include-email --region ap-south-1)
	docker login -u AWS -p $(aws ecr get-login-password --region ap-south-1) 037368072271.dkr.ecr.ap-south-1.amazonaws.com
	aws --version
        docker build -t "$LIVE_APP_NAME" .
        #docker tag "$LIVE_APP_NAME:latest" "$AWS_URL/$LIVE_APP_NAME:$TRAVIS_COMMIT"
        #docker tag "$LIVE_APP_NAME:latest" "$AWS_URL/$LIVE_APP_NAME:latest"
        #docker push "$AWS_URL/$LIVE_APP_NAME:$TRAVIS_COMMIT"
        #docker push "$AWS_URL/$LIVE_APP_NAME:latest"
	#docker tag john 037368072271.dkr.ecr.ap-south-1.amazonaws.com/john
	#docker push 037368072271.dkr.ecr.ap-south-1.amazonaws.com/john
	docker tag john:latest public.ecr.aws/u2z3j2j0/john:latest
	docker push public.ecr.aws/u2z3j2j0/john:latest
    fi
fi
