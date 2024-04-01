param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectName
)

$PublishPath = "./$ProjectName.publish"

cd "../../example_code/$ProjectName"
dotnet publish -c Release -o $PublishPath
Compress-Archive -Path "$PublishPath/*" -DestinationPath "$PublishPath.zip" -Force
