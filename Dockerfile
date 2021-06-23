# NuGet restore
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY *.sln .
COPY EmployeeTest/*.csproj EmployeeTest/
COPY EmployeeApi/*.csproj EmployeeApi/
RUN dotnet restore
COPY . .

# testing
FROM build AS testing
WORKDIR /src/EmployeeApi
RUN dotnet build
WORKDIR /src/EmployeeTest
RUN dotnet test

# publish
FROM build AS publish
WORKDIR /src/EmployeeApi
RUN dotnet publish -c Release -o /src/publish

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS runtime
WORKDIR /app
COPY --from=publish /src/publish .
# ENTRYPOINT ["dotnet", "EmployeeApi.dll"]
# heroku uses the following
CMD ASPNETCORE_URLS=http://*:$PORT dotnet EmployeeApi.dll