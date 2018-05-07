namespace BarsWeb.Core.Models
{
    public class SqlRequest
    {
        public string SqlText { get; set; }
        public object[] SqlParams { get; set; }
    }
}
