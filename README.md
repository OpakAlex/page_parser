# PageParser

## Task:
```
Write a function ​fetch(url)​ that fetches the page corresponding to the url and returns an object that has the following attributes:
● Assets - a collection of urls present in the img tags on the page
● Links - a collection of urls present in the anchor tags on the page
Assume that the code will run on a server.
Assume that this work is a part of a web app that needs to be built further by multiple development teams.
Assume that it will be maintained and evolved for several years in the future.
In addition to these, make any assumptions necessary, but list those assumptions explicitly.
```

## Run:
 * `mix deps.get`
 * `mix deps.compile`
 * `mix test`

## Add to project:

```
extra_applications: [:page_parser]
```

```
defp deps do
  {:page_parser, git: "https://github.com/OpakAlex/page_parser.git"}
end
```
