using BarsWeb.Areas.Clients.Models.Enums;

namespace BarsWeb.Areas.Clients.Models
{
    public class GeneralClearAddress
    {
        public decimal? Ncount { get; set; }
        public string Domain { get; set; }
        public string RegionName { get; set; }
        public string Region { get; set; }
        public string AreaName { get; set; }
        public string Locality { get; set; }
        public string SettlementName { get; set; }
        public string Street { get; set; }
        public string StreetName { get; set; }
        public decimal? RegionId { get; set; }
        public decimal? AreaId { get; set; }
        public decimal? SettlementId { get; set; }
        public decimal? StreetId { get; set; }
        public GeneralClearAddressType Type { get; set; }
        public string SettlementTypeName { get; set; }
        public string StreetTypeName { get; set; }
        
    }
}