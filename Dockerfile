# https://hub.docker.com/_/microsoft-dotnet-core
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
RUN apt update
RUN apt upgrade -y
WORKDIR ./sources

# copy everything else and build app
COPY MyWebApp3/. ./sources/MyWebApp3/
WORKDIR ./sources/MyWebApp3
RUN dotnet publish -c release -o /app 

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
RUN apt update
RUN apt upgrade -y
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "MyWebApp3.dll"] 
