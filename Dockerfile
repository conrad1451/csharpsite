# Stage 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY ["StudentRecordsBackend/StudentRecordsBackend.csproj", "StudentRecordsBackend/"]
# If you have multiple projects in your solution, copy them all and restore
# COPY ["AnotherProject/AnotherProject.csproj", "AnotherProject/"]
RUN dotnet restore "StudentRecordsBackend/StudentRecordsBackend.csproj"

COPY . .
WORKDIR "/src/StudentRecordsBackend"
RUN dotnet build "StudentRecordsBackend.csproj" -c Release -o /app/build

# Stage 2: Publish the application
FROM build AS publish
RUN dotnet publish "StudentRecordsBackend.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Stage 3: Run the application
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app
EXPOSE 8080 
# Or whatever port your application listens on, often 80/443 in production
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "StudentRecordsBackend.dll"]