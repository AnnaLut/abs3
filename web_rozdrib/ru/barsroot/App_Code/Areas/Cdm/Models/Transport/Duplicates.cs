namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class Duplicates
    {
        public BatchParams Request { get; set; }
        public DupClient[] DuplicateClients { get; set; }
    }
}