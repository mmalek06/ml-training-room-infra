public static class ListBlobsFunction
{
    [FunctionName("ListBlobsFunction")]
    public static async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Function, "get", Route = null)] HttpRequest req,
        ILogger log)
    {
        var connectionString = Environment.GetEnvironmentVariable("AzureWebJobsStorage");
        var blobServiceClient = new BlobServiceClient(connectionString);
        var containerClient = blobServiceClient.GetBlobContainerClient("your-container-name");
        var blobCount = 0;
        
        await foreach (var blobItem in containerClient.GetBlobsAsync()) {
            blobCount++;
        }

        return new OkObjectResult($"Total blobs in container: {blobCount}");
    }
}
