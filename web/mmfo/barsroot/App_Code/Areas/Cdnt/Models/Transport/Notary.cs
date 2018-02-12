﻿using System;
using System.Collections.Generic;

// ReSharper disable once CheckNamespace
namespace BarsWeb.Areas.Cdnt.Models.Transport
{
    public class Notary
    {
        public int Id { get; set; }
        public string Tin { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string DateOfBirth { get; set; }
        public int DocumentType { get; set; }
        public string PassportSeries { get; set; }
        public string PassportNumber { get; set;}
        public string PassportIssuer { get; set; }
        public DateTime? PassportIssued { get; set; }
        public decimal? IdcardDocumentNumber { get; set; }
        public string IdcardNotationNumber { get; set; }
        public DateTime? PassportExpiry { get; set; }
        public string Address { get; set; }
        public string PhoneNumber { get; set; }
        public string MobilePhoneNumber { get; set; }
        public string Email { get; set; }
        public List<Accreditation> Accreditations { get; set; }
        public decimal? NotaryType { get; set; }
        public string CertNumber { get; set; }
        public DateTime? CertIssueDate { get; set; }
        public DateTime? CertCancDate { get; set; }
    }
}