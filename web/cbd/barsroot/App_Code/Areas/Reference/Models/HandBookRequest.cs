namespace BarsWeb.Areas.Reference.Models
{
    public class HandBookRequest
    {
        public string Id { get; set; }
        public string Clause { get; set; }
        public bool MultiSelect { get; set; }
        public string[] Columns { get; set; }
    }

}
