FROM mcr.microsoft.com/dotnet/core/sdk:3.1.201-alpine AS build-env
WORKDIR /app
COPY . .

RUN dotnet restore
RUN dotnet build -c Release -o /out
RUN dotnet publish -c Release -o /out

# Runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1.3-alpine
WORKDIR /app
COPY --from=build-env /out .
ENTRYPOINT ["dotnet", "WebApplication1.dll"]