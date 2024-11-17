---
layout: post
title: "Adding the Aspire Dashboard stand-alone to my side project"
date: 2024-11-17 00:00
comments: true
categories: [coding]
---

My side project(codename: Budgeteer) is a web application I am developing to track my personal finances. You can import transactions via csv exports from your bank, create categories and have smart rules to place transactions in the right category. It can also provide insights such as spending trends and other metrics. I like to be in a position to track how much things like groceries cost over time and see if I can optimize my spending.

The project uses the following technologies.
- ASP.NET Core Web APIs
- Vue.js
- Aspire
- Postgres

[Aspire](https://learn.microsoft.com/en-us/dotnet/aspire/get-started/aspire-overview) has made the development experience a joy. It enables me to add containerized dependencies locally and have them all come up with F5 so I can quickly work through features.

This is the app with fake transactions.

![Budgeteer Sample](/images/posts/aspire-dashboard-standalone/image.png)

I have the project deployed locally on a docker-compose setup. One of the things I miss though is the Aspire Dashboard. Through Open Telemetry, it gives loads of information on telemetry and logs and makes troubleshooting issues a breeze. When working through an IDE and by using an AppHost, the dashboard comes for free. In my setup though, I had to deploy it as stand alone and configure the open telemetry parts in order to get everything wired up.

![Aspire Dashboard](/images/posts/aspire-dashboard-standalone/budgeteer-aspire-dashboard.png)

Here's what I did in case you are looking to do the same.

If you are running on a Docker Compose, this is how the dashboard service needs to look like:

```yaml
  dashboard:
    image: mcr.microsoft.com/dotnet/aspire-dashboard:9.0
    ports:
      - 18888:18888
      - 4317:18889
    restart: unless-stopped
    environment:
      - Dashboard__Frontend__BrowserToken=${DASHBOARD_FRONTEND_BROWSER_TOKEN}
      - ASP_NETCORE_ENVIRONMENT=${ASPNETCORE_ENVIRONMENT}
      - DOTNET_HOSTNAME=${DOTNET_HOSTNAME}
      - DOTNET_APPLICATION_URL=${DOTNET_APPLICATION_URL}
      - Dashboard__Otlp__AuthMode=${DASHBOARD_OTLP_AUTHMODE}
      - Dashboard__Otlp__PrimaryApiKey=${DASHBOARD_OTLP_PRIMARY_APIKEY}
```
The ASP.NET Core Web API service needs to look like so.
Notice the OTEL settings.

```yaml
  api:
    image: budgeteer-api:latest
    environment:
      - ASPNETCORE_ENVIRONMENT=${ASPNETCORE_ENVIRONMENT}
      - ASPNETCORE_URLS=http://*:8080/
      - ASPNETCORE_HTTP_PORTS=8080
      - OTEL_EXPORTER_OTLP_ENDPOINT=${OTEL_EXPORTER_OTLP_ENDPOINT}
      - OTEL_SERVICE_NAME=api
      - OTEL_EXPORTER_OTLP_HEADERS=x-otlp-api-key=${DASHBOARD_OTLP_PRIMARY_APIKEY}
```
Then, your docker-compose .env file should look like so:
```
    ASPNETCORE_ENVIRONMENT=Development
    OTEL_EXPORTER_OTLP_ENDPOINT=http://dashboard:18889
    DASHBOARD_FRONTEND_BROWSER_TOKEN=yourDashboardToken
    DOTNET_HOSTNAME=dashboard
    DOTNET_APPLICATION_URL=http://localhost:8081
    DASHBOARD_OTLP_AUTHMODE=ApiKey
    DASHBOARD_OTLP_PRIMARY_APIKEY=yourApiKey
```

The above example assumes that your project is based off the Aspire project template. If it's not, then your'll need to add the OpenTelemetry configuration in your ASP.NET Core project yourself which is beyond the scope of this post.
