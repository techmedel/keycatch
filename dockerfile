FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-stretch-slim AS base
WORKDIR /app
EXPOSE 80
 
FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch AS build
WORKDIR /src
COPY ["keycatch.csproj", ""]
RUN dotnet restore "keycatch.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet build "*.csproj" -c Release -o /app
 
FROM build AS publish
RUN dotnet publish "keycatch.csproj" -c Release -o /app
 
FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "keycatch.dll"]