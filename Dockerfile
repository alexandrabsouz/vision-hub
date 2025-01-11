#####################
# Build stage       #
#####################
FROM elixir:1.14.4-alpine AS build

RUN apk update && apk add --no-cache build-base git

COPY . .

RUN mix local.hex --force && mix local.rebar --force && mix deps.get

RUN mix release

#####################
# Deployment Stage  #
#####################
FROM erlang:25-alpine

WORKDIR /app

ENV TZ="Etc/UTC"

RUN mkdir -p /app && chown nobody:nobody /app
USER nobody:nobody

COPY --from=build /app/_build/prod/rel/vision_hub /app

CMD ["bin/vision_hub", "start"]

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=2 \
    CMD wget --spider --quiet --tries=1 --timeout=2 http://localhost:4000 || exit 1
