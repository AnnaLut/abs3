using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Clients.Models
{
    public class ClearAddress
    {
        [Key]
        public decimal Rnk { get; set; }
        public decimal CountryId { get; set; }
        public decimal? RegionId { get; set; }
        public decimal? AreaId { get; set; }
        public decimal? SettlementId { get; set; }
        public string FirstName { get; set; }
        public string Address { get; set; }
        public string HouseNum { get; set; }
        public string StreetName { get; set; }
        public string CountryName { get; set; }
        public string SettlementName { get; set; }
        public string Locality { get; set; }
        public string Domain { get; set; }
        public string RegionName { get; set; }
        public string ParentName { get; set; }
        public string SurName { get; set; }
        public string Region { get; set; }
        public string AreaName { get; set; }
        public string TypeName { get; set; }
        public decimal TypeId { get; set; }
        public decimal? LocalityType { get; set; }
        public decimal? HomeType { get; set; }
        public string AddressIndex { get; set; }
        public decimal? StreetType { get; set; }
        public decimal? StreetTypeId { get; set; }
        public string StreetTypeNm { get; set; }
        public string Street { get; set; }
        public string Home { get; set; }
        public string HomePart { get; set; }
        public string Room { get; set; }
        public string Comm { get; set; }
        public string SettlementTypeName { get; set; }
        public string LocalityTypeName { get; set; }
        public string StreetTypeName { get; set; }
        public string HomeTypeName { get; set; }
        public string HomePartTypeName { get; set; }
        public string RoomTypeName { get; set; }
        public decimal? HomePartType { get; set; }
        public decimal? RoomType { get; set; }
        public decimal? SettlementTypeId { get; set; }  
        public decimal? StreetId { get; set; }
        public decimal? HouseId { get; set; }
        public decimal? HomeTypeId { get; set; }
        public decimal? HomePartTypeId { get; set; }
        public decimal? RoomTypeId { get; set; }
        public string HomeTypeNm { get; set; }
        public string HomePartTypeNm { get; set; }
        public string RoomTypeNm { get; set; }
    }      

}