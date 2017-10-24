namespace BarsWeb.Areas.Ndi.Models
{
    /// <summary>
    /// Summary description for FileResult
    /// </summary>
    public class GetFileResult
    {
        public GetFileResult()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public string Result { get; set; }
        public string FileBody { get; set; }
        public string FileName { get; set; }
    }
}