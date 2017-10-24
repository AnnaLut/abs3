﻿using System;
using System.ComponentModel.DataAnnotations;
using Newtonsoft.Json;

namespace BarsWeb.Areas.CorpLight.Models
{
    /// <summary>
    /// Summary description for NbsAccType
    /// </summary>
    public class RelatedCustomer
    {
        public RelatedCustomer()
        {
        }
        [Key]
        public decimal? Id { get; set; }
        [Key]
        public decimal? CustId { get; set; }

        public string TaxCode { get; set; }
        public decimal? NoInn { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string SecondName { get; set; }
        public string DocType { get; set; }
        public string DocSeries { get; set; }
        public string DocNumber { get; set; }
        public string DocOrganization { get; set; }
        public DateTime? DocDate { get; set; }
        public DateTime? BirthDate { get; set; }
        public string CellPhone { get; set; }
        public string Email { get; set; }
        public decimal? SignNumber { get; set; }

        [JsonIgnore]
        public decimal? AcskActual { get; set;}
        
        public bool? IsAcskActual
        {
            get { return AcskActual == 1; }
        }
        

        //public string Address { get; set; }
        public decimal? AddressRegionId { get; set; }
        public string AddressRegionName { get; set; }
        public string AddressCity { get; set; }
        public string AddressStreet { get; set; }
        public string AddressHouseNumber { get; set; }
        public string AddressAddition { get; set; }


        public string UserId { get; set; }

        public bool? LockoutEnabled { get; set; }
        [JsonIgnore]
        public decimal? IsApprovedDecimal { get; set; }

        public bool? IsApproved
        {
            get { return IsApprovedDecimal == 1; }
        }

        public string ApprovedType { get; set; }

        public decimal? Rnk { get; set; }
        public decimal? RelId { get; set; }


        //Acsk
        public decimal? AcskRegistrationId { get; set; }
        public DateTime? AcskRegistrationDate { get; set; }
        public string AcskUserId { get; set; }

        [JsonIgnore]
        public decimal? HasAllSignesDecimal { get; set; }
        public bool? HasAllSignes
        {
            get { return HasAllSignesDecimal == 1; }
        }
    }
}
