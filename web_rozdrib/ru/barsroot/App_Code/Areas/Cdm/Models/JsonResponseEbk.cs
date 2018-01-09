using BarsWeb.Models;
namespace BarsWeb.Areas.Cdm.Models
{
    public class JsonResponseEbk : JsonResponse
    {
        JsonResponseEbk() : base() { }

        public JsonResponseEbk(string status): base(status){ }
        
        public string EbkOnlineStatus { get; set; }
    }
}