---
title:  That Github's API makes it so easy to fetch a user's starred repo history
description: |
    How to quickly compile a list of everything you've ever starred (and when) on Github. Python script included.
date:   2020-10-29 11:45:00
categories:
    - github
    - apis
---

<div class="alert alert-info tldr">
  <strong>tl;dr:</strong> you can collect and wrangle your own starred repo data with this Python script I've written: <a href="https://gist.github.com/dannguyen/650cb0d8ca21db77f48f828fe2342d55">fetch_ghstars.py</a>
</div>


Made a [joke tweet to Max Woolf](https://twitter.com/dancow/status/1321853042338287620), re: how much a repo's quality/usefulness actually correlates with number of Github stars (Max maintains [minimaxir/big-list-of-naughty-strings repo](https://github.com/minimaxir/big-list-of-naughty-strings), an extravagantly starred repo that also happens to be extremely useful). And Max mentioned something about the Github API that I hadn't known nor bothered to investigate\*: You can fetch a list of all repos starred by a user, and that data will include *when* the user starred the repo. Just in case you wanted to analyze, say, how the languages you're interested in have changed over your programming career.




(*I never bothered to check out Github's starred API for timestamps because I'm used to the way Twitter does things, i.e. providing you basically zero meta information about your [favorites](https://developer.twitter.com/en/docs/twitter-api/v1/tweets/post-and-engage/api-reference/get-favorites-list), [followings](https://developer.twitter.com/en/docs/twitter-api/v1/accounts-and-users/follow-search-get-users/api-reference/get-friends-ids), and [bookmarks](https://apievangelist.com/2019/12/30/pulling-your-twitter-bookmarks-via-the-twitter-api/)*)


Googling around, I found the [Github API docs on starring](https://docs.github.com/en/free-pro-team@latest/rest/reference/activity#starring), and this [helpful gist from user jasonrudolph](https://gist.github.com/jasonrudolph/102c9d2a5de6cefb7ae4), which contains a working cURL invocation:

```sh
$ curl -H "Accept: application/vnd.github.v3.star+json" \
    https://api.github.com/users/glaforge/starred
```


The result is a JSON list of objects:

```json
[
  {
    "starred_at": "2020-10-29T15:31:41Z",
    "repo": {
      "id": 52855516,
      "node_id": "MDEwOlJlcG9zaXRvcnk1Mjg1NTUxNg==",
      "name": "homebrew-core",
      "full_name": "Homebrew/homebrew-core",
      "private": false,
      "owner": {
        "login": "Homebrew",
        "id": 1503512,
        "node_id": "MDEyOk9yZ2FuaXphdGlvbjE1MDM1MTI=",
        "avatar_url": "https://avatars2.githubusercontent.com/u/1503512?v=4",
        "gravatar_id": "",
        "url": "https://api.github.com/users/Homebrew",
        "html_url": "https://github.com/Homebrew",
        /*  the rest of the repo data returned by a standard API response for listing repos */
  }
]
```

The per-repo data is quite voluminous – [look here](https://gist.github.com/dannguyen/650cb0d8ca21db77f48f828fe2342d55#file-response-example-json) to see how big even just 3 records is, with all the data fields the API returns. By default, the API returns 30 repo records for each call, and the JSON (prettified by default) is roughly 175KB.


## Observations about the Github API


One thing about the Github API that sticks out to me is how it handles a lot of [configuration/customization through headers](https://docs.github.com/en/free-pro-team@latest/rest/reference/activity#custom-media-types-for-starring).  For example, in this current usecase, we must include an `Accept` header set to `application/vnd.github.v3.star+json`; omitting it when doing a GET request to the `https://api.github.com/users/octocat/starred`  will omit the `starred_at` data point.



## A quickie fetch and filtering script

This bit of API knowledge is super timely and helpful for me, because I've been wanting to filter the [1,700+ Github repos](https://github.com/dannguyen?tab=stars) that I've starred over the years. Ideally, I'd like my Github stars to be more personally useful, e.g. a curated up-to-date list of repos I actually use, as opposed to a messy pile of bookmarks of repos that piqued my interest on HN/Twitter but that I may or may not have actually used or liked.


Unfortunately, Github's starred API doesn't return *everything* in a single request. However, it does have [the url parameters `page` and `per_page`](https://docs.github.com/en/free-pro-team@latest/rest/reference/activity#list-stargazers--parameters), which, respectively, are used to paginate and to increase the number of per-page results to a maximum of **100**. 


Getting the data for all 1,700+ of my starred repos could be as easy as this shell loop:


```sh
_USERNAME=SOME_USER_NAME
_HEADER="Accept: application/vnd.github.v3.star+json"
for i in $(seq 1 18); do 
  url="https://api.github.com/users/${_USERNAME}/starred?per_page=100&page=${i}"
  fname="ghstars-${_USERNAME}-${i}.json"
  printf '%s: %s\n' "${fname}" "${url}"

  curl -H  "${_HEADER}" "${url}" > "${fname}"
done
```

However, I prefer the flexibility and explicitness and maintainability of Python whenever I have to touch a remote API. Also, as I mentioned earlier, the [API is extremely verbose in its response](https://gist.github.com/dannguyen/650cb0d8ca21db77f48f828fe2342d55#file-response-example-json) – and 90% of the data is just neither interesting nor relevant for what I want to analyze.

For example, of the sample fields below, only a few, such as `description`, `stargazers_count` and `language`, are interesting. The rest of the bulky text is only helpful to automation scripts:

```json
{
      /* .... */
      "description": "\ud83c\udf7b Default formulae for the missing package manager for macOS",
      "fork": false,
      "url": "https://api.github.com/repos/Homebrew/homebrew-core",
      "forks_url": "https://api.github.com/repos/Homebrew/homebrew-core/forks",
      "keys_url": "https://api.github.com/repos/Homebrew/homebrew-core/keys{/key_id}",      "compare_url": "https://api.github.com/repos/Homebrew/homebrew-core/compare/{base}...{head}",
      "merges_url": "https://api.github.com/repos/Homebrew/homebrew-core/merges",
      "archive_url": "https://api.github.com/repos/Homebrew/homebrew-core/{archive_format}{/ref}",
      "downloads_url": "https://api.github.com/repos/Homebrew/homebrew-core/downloads",
      "issues_url": "https://api.github.com/repos/Homebrew/homebrew-core/issues{/number}",
      "pulls_url": "https://api.github.com/repos/Homebrew/homebrew-core/pulls{/number}",
      "milestones_url": "https://api.github.com/repos/Homebrew/homebrew-core/milestones{/number}",
      "notifications_url": "https://api.github.com/repos/Homebrew/homebrew-core/notifications{?since,all,participating}",
      "labels_url": "https://api.github.com/repos/Homebrew/homebrew-core/labels{/name}",
      "releases_url": "https://api.github.com/repos/Homebrew/homebrew-core/releases{/id}",
      "deployments_url": "https://api.github.com/repos/Homebrew/homebrew-core/deployments",
      "created_at": "2016-03-01T06:58:36Z",
      "updated_at": "2020-10-29T20:54:52Z",
      "pushed_at": "2020-10-29T20:45:46Z",
      "git_url": "git://github.com/Homebrew/homebrew-core.git",
      "ssh_url": "git@github.com:Homebrew/homebrew-core.git",
      "clone_url": "https://github.com/Homebrew/homebrew-core.git",
      "svn_url": "https://github.com/Homebrew/homebrew-core",
      "homepage": "https://brew.sh",
      "size": 338391,
      "stargazers_count": 8210,
      "watchers_count": 8210,
      "language": "Ruby",
      "has_issues": true,
        /* .... */
}
```

Also, JSON is a pain in the ass when wanting to do low-friction interactive analysis with spreadsheets. Luckily, wrangling JSON into CSV is easy enough. Here's an [example of what the flattened, simplified data could look like](https://gist.github.com/dannguyen/650cb0d8ca21db77f48f828fe2342d55#file-wrangled-example-csv).

So here's a quickie command-line Python script, which I've named [fetch_ghstars.py](https://gist.github.com/dannguyen/650cb0d8ca21db77f48f828fe2342d55#file-fetch_ghstars-py). It can be called like this:

```sh
$ ./fetch_ghstars.py  USER_NAME
```

And the result is:

- For the given user account named `USER_NAME`, fetch all the user's starred repo data, 100 records per request.
- Wrangle all the records into a [single flat CSV file](https://gist.github.com/dannguyen/650cb0d8ca21db77f48f828fe2342d55#file-wrangled-example-csv), keeping only the most interesting fields.
- Save each API response as [individual JSON files](https://gist.github.com/dannguyen/650cb0d8ca21db77f48f828fe2342d55#file-response-example-json), in case I want to tweak what I actually wrangle


For convenience, I created a gist that contains `fetch_ghstars.py` and the sample data files:

[https://gist.github.com/dannguyen/650cb0d8ca21db77f48f828fe2342d55](https://gist.github.com/dannguyen/650cb0d8ca21db77f48f828fe2342d55)


Also, because Github's no-auth rate limit per IP address can be pretty stringent – [60 requests per hour](https://docs.github.com/en/free-pro-team@latest/rest/overview/resources-in-the-rest-api#rate-limiting) – I embiggened my simple script to accept an optional second argument – an OAuth2 personal access token – to make authenticated requests, which allow 5,000 requests per hour per token:


```sh
$ ./fetch_ghstars.py  USER_NAME  AUTH_TOKEN
```

The equivalent individual cURL call would be something like this:

```sh
$ curl -H "Authorization: token AUTH_TOKEN"  \
       -H "Accept: application/vnd.github.v3.star+json" \
        https://api.github.com/users/octocat/starred
```


You can create OAuth2 read-only personal access tokens here: https://github.com/settings/tokens/
