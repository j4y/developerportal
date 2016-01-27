# Affdex Developer Portal

The developer portal is hosted on GitHub.io ..
To develop using the portal, either host locally using jekyll
or host on s3 using s3_website.

[![Build Status](https://travis-ci.org/Affectiva/developerportal.svg?branch=gh-pages)](https://travis-ci.org/Affectiva/developerportal)


**How to run locally**

Assuming, you have Ruby and bundle installed. If you don't, a good place to start [would be here.](https://www.codecademy.com/learn/ruby)

```shell
$ bundle install #installs gems needed.
```

Build the website, and start a local server for live preview.
```shell
$ jekyll serve
```

or

```shell
$ bundle exec jekyll serve
```

Output should look something like this, at which point you can point your browser to `http://127.0.0.1:4006/` to see the website.

```
 Auto-regeneration: enabled for /Users/amahmoud/Affectiva/repos/developerportal
Configuration file: /Users/amahmoud/Affectiva/repos/developerportal/_config.yml
    Server address: http://127.0.0.1:4006/
  Server running... press ctrl-c to stop.
```

**How to build host on S3**

[s3_website](https://github.com/laurilehmijoki/s3_website) is a ruby gem that can be used to publish static websites to S3.

```s3_website.yml``` uses env variables to read S3 creds and the bucket to publish to.

```shell
$ export SANDBOX_S3_KEY=YOUR SANDBOX AWS KEY
$ export SANDBOX_S3_SECRET_KEY=YOUR SANDBOX AWS SECRET KEY
$ export DEV_WEB_BUCKET_NAME=A BUCKET NAME
```

Create the bucket (if it doesn't exist) and configures it. This will change the permission on your bucket to make it publicly available.

```shell
$ s3_website cfg apply
```

Generates the website pages

```shell
$ jekyll build
```

Publish the generated website to s3.

```shell
$ s3_website push
```
