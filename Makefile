all:

build:
	rm -fr public/*
	hugo

deploy:
	aws s3 sync public s3://joeg.uk --delete --acl public-read