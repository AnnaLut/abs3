using System;
using System.Xml.Serialization;
using BarsWeb.Areas.Cdm.Models.Transport.Individual;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using BarsWeb.Areas.Cdm.Models.Transport.Legal;
using BarsWeb.Areas.Cdm.Models.Transport.PrivateEn;
using System.Runtime.Serialization;
using System.Globalization;
using System.Linq;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    [XmlRoot("card")]
    [DataContract]
    public class CardDataV2 : ICard
    {
        private static readonly string DateTimeFormatString = "yyyy-MM-ddTHH:mm:ss.fffzzz";
        private static readonly DateTimeStyles DtStyle = DateTimeStyles.RoundtripKind;
        private static readonly CultureInfo Culture = CultureInfo.InvariantCulture;

        // Час останньої модифікації картки в ЕБК
        [XmlIgnore]
        public DateTimeOffset? ModificationTimestamp;
        [XmlElement("modificationTimestamp")]
        public string ModificationTimestampForXml
        {
            get
            {
                return null == ModificationTimestamp
                    ? null
                    : ((DateTimeOffset) ModificationTimestamp).ToString(DateTimeFormatString);
            }
            set
            {
                DateTimeOffset a;
                ModificationTimestamp = DateTimeOffset.TryParse(value, Culture, DtStyle, out a)
                    ? (DateTimeOffset?) a
                    : null;
            }
        }
        public DateTimeOffset? LastChangeDt { get; set; }


        //[XmlElement("person", typeof(Person))]
        [XmlElement("individualPerson", typeof(IndividualPersonV2))]
        [XmlElement("legalPerson", typeof(LegalPersonV2))]
        [XmlElement("privateEntrepreneur", typeof(PrivateEntrepreneurV2))]
        public PersonV2 Person { get; set; }
        public bool ShouldSerializePerson() { return null != Person; }

        [XmlElement("cardAnalysis")]
        public ClientAnalysisV2 CardAnalysis { get; set; }

        // Перелік дублікатів до картки
        [XmlArray("duplicates")]
        [XmlArrayItem("duplicate")]
        public List<DuplicatesV2> Duplicates { get; set; }
        public bool ShouldSerializeDuplicates() { return null != Duplicates; }

        // Код РУ (код МФО)
        [XmlAttribute("kf")]
        [DataMember(IsRequired = true)]
        [Required]
        public int Kf { get; set; }

        // Реєстраційний номер
        [XmlAttribute("rnk")]
        [DataMember(IsRequired = true)]
        [Required]
        public long Rnk { get; set; }

        // Ідентифікатор майстер-запису
        [XmlAttribute("gcif")]
        public string Gcif { get; set; }

        // Ідентифікатор майстер-запису майстер-картки
        [XmlAttribute("masterGcif")]
        public string MasterGcif { get; set; }

        public BufClientData ToBufClientData()
        {
            if (!(Person is IndividualPersonV2)) { return null; }
            var ip = (IndividualPersonV2)Person;
            var b = new BufClientData
            {
                AddInfo = (null==ip.AddInfo)? new PersonAddInfo() : new PersonAddInfo
                {
                    Chorn = ip.AddInfo.Chorn,
                    Cigpo = ip.AddInfo.Cigpo,
                    Publp = ip.AddInfo.Publp,
                    Samz = ip.AddInfo.Samz,
                    Spmrk = ip.AddInfo.Spmrk,
                    VipK = ip.AddInfo.VipK,
                    Workb = ip.AddInfo.Workb,
                    WorkPlace = ip.AddInfo.WorkPlace
                },
                Address = (null==ip.Address)? new PersonAddress() : new PersonAddress
                {
                    Adr = ip.Address.Adr,
                    Fgadr = ip.Address.Fgadr,
                    Fgdst = ip.Address.Fgdst,
                    Fgobl = ip.Address.Fgobl,
                    Fgtwn = ip.Address.Fgtwn,
                    UrAddress = ip.Address.UrAddress,
                    UrDomain = ip.Address.UrDomain,
                    UrHome = ip.Address.UrHome,
                    UrHomepart = ip.Address.UrHomepart,
                    UrHomepartType = ip.Address.UrHomepartType,
                    UrHomeType = ip.Address.UrHomeType,
                    UrLocality = ip.Address.UrLocality,
                    UrLocalityType = ip.Address.UrLocalityType,
                    UrRegion = ip.Address.UrRegion,
                    UrRoom = ip.Address.UrRoom,
                    UrRoomType = ip.Address.UrRoomType,
                    UrStreet = ip.Address.UrStreet,
                    UrStreetType = ip.Address.UrStreetType,
                    UrTerritoryId = ip.Address.UrTerritoryId,
                    UrZip = ip.Address.UrZip
                },
                Bday = ip.Bday,
                Bplace = ip.Bplace,
                Branch = ip.Branch,
                ChornDesc = ip.Branch,
                Codcagent = ip.Codcagent,
                Contact = (null==ip.Contact)? new PersonContact() : new PersonContact
                {
                    Cellphone = ip.Contact.Cellphone,
                    Email = ip.Contact.Email,
                    Mpno = ip.Contact.Mpno,
                    Teld = ip.Contact.Teld,
                    Telw = ip.Contact.Telw
                },
                Country = ip.Country,
                DateOff = ip.DateOff,
                DateOn = ip.DateOn,
                Document = (null==ip.Document)? new PersonDocument() : new PersonDocument
                {
                    ActualDate = ip.Document.ActualDate,
                    DatePhoto = ip.Document.DatePhoto,
                    EddrId = ip.Document.EddrId,
                    Numdoc = ip.Document.Numdoc,
                    Organ = ip.Document.Organ,
                    Passp = ip.Document.Passp,
                    PcZ1 = ip.Document.PcZ1,
                    PcZ2 = ip.Document.PcZ2,
                    PcZ3 = ip.Document.PcZ3,
                    PcZ4 = ip.Document.PcZ4,
                    PcZ5 = ip.Document.PcZ5,
                    Pdate = ip.Document.Pdate,
                    Ser = ip.Document.Ser
                },
                Fs = ip.Fs,
                Gcif = ip.Gcif,
                Ise = ip.Ise,
                IsOkpoExclusion = ip.IsOkpoExclusion,
                K013 = ip.K013,
                K050 = ip.K050,
                Kf = ip.Kf,
                LastChangeDt = ip.LastChangeDt,
                Nmk = ip.Nmk,
                Nmkv = ip.Nmkv,
                Okpo = ip.Okpo,
                Prinsider = ip.Prinsider,
                Product = (null==ip.Product)?new PersonProduct() : new PersonProduct
                {
                    BankCard = ip.Product.BankCard,
                    Credit = ip.Product.Credit,
                    CurrentAccount = ip.Product.CurrentAccount,
                    Deposit = ip.Product.Deposit,
                    Other = ip.Product.Other
                },
                RelatedPerson = new List<RelatedPerson>(ip.RelatedPersons.Select(p => new RelatedPerson
                {
                    ActualDate = p.ActualDate,
                    Address = p.Address,
                    BirthDay = p.BirthDay,
                    BirthPlace = p.BirthPlace,
                    DocIssueDate = p.DocIssueDate,
                    DocNumber = p.DocNumber,
                    DocOrgan = p.DocOrgan,
                    DocSer = p.DocSer,
                    DocType = p.DocType,
                    EddrId = p.EddrId,
                    Email = (null != p.Emails) ? p.Emails.FirstOrDefault() : string.Empty,
                    IsOkpoExclusion = p.IsOkpoExclusion ? "1" : "0",
                    K014 = p.K014,
                    K040 = p.K040.ToString(),
                    K051 = p.K051,
                    K070 = p.K070,
                    K080 = p.K080,
                    K110 = p.K110,
                    Name = p.Name,
                    Notes = p.Notes,
                    Okpo = p.Okpo,
                    RegionCode = p.RegionCode.ToString(),
                    RelSign = p.RelSign,
                    Rel_Rnk = p.Rel_Rnk,
                    Sex = p.Sex,
                    Telephone = (null != p.Telephones) ? p.Telephones.FirstOrDefault() : string.Empty,
                })),
                Rnk = ip.Rnk,
                Sex = ip.Sex,
                SnFn = ip.SnFn,
                SnGc = ip.SnGc,
                SnLn = ip.SnLn,
                SnMn = ip.SnMn,
                Tgr = ip.Tgr,
                Ved = ip.Ved
            };

            return b;
        }

        public LegalPerson ToLegalPerson()
        {
            if (!(Person is LegalPersonV2)) { return null; }
            var p = (LegalPersonV2)Person;
            var l = new LegalPerson
            {
                ActualAddress = (null==p.ActualAddress)? new LegalPersonActualAddress() : new LegalPersonActualAddress
                {
                    Aa_Area = p.ActualAddress.Area,
                    Aa_FullAddress = p.ActualAddress.FullAddress,
                    Aa_Index = p.ActualAddress.Index,
                    Aa_K040 = p.ActualAddress.K040,
                    Aa_Region = p.ActualAddress.Region,
                    Aa_Settlement = p.ActualAddress.Settlement,
                    Aa_TerritoryCode = p.ActualAddress.TerritoryCode
                },
                AdditionalDetails = (null==p.AdditionalDetails)? new AdditionalDetails() : new AdditionalDetails
                {
                    AuthorizedCapitalSize = p.AdditionalDetails.AuthorizedCapitalSize,
                    EconomicActivityType = p.AdditionalDetails.EconomicActivityType,
                    EssenceCharacter = p.AdditionalDetails.EssenceCharacter,
                    EvaluationReputation = p.AdditionalDetails.EvaluationReputation,
                    FirstAccDate = p.AdditionalDetails.FirstAccDate,
                    GroupAffiliation = p.AdditionalDetails.GroupAffiliation,
                    IncomeTaxPayerRegDate = p.AdditionalDetails.IncomeTaxPayerRegDate,
                    InitialFormFillDate = p.AdditionalDetails.InitialFormFillDate,
                    K013 = p.AdditionalDetails.K013,
                    NationalProperty = p.AdditionalDetails.NationalProperty,
                    NoTaxpayerSign = p.AdditionalDetails.NoTaxpayerSign,
                    RevenueSourcesCharacter = p.AdditionalDetails.RevenueSourcesCharacter,
                    RiskLevel = p.AdditionalDetails.RiskLevel,
                    SeparateDivCorpCode = p.AdditionalDetails.SeparateDivCorpCode,
                    VipSign = p.AdditionalDetails.VipSign
                },
                AdditionalInformation = (null==p.AdditionalInformation)?new AdditionalInformation() : new AdditionalInformation
                {
                    BorrowerClass = p.AdditionalInformation.BorrowerClass.TryParseDec(),
                    RegionalHoldingNumber = p.AdditionalInformation.RegionalHoldingNumber
                },
                BuildStateRegister = p.BuildStateRegister,
                CustomerDetails = (null==p.CustomerDetails)? new CustomerDetails() : new CustomerDetails
                {
                    NameByStatus = p.CustomerDetails.NameByStatus
                },
                DateOff = p.DateOff,
                DateOn = p.DateOn,
                EconomicRegulations = (null==p.EconomicRegulations)? new LegalPersonEconomicRegulations() : new LegalPersonEconomicRegulations
                {
                    K050 = p.EconomicRegulations.K050,
                    K051 = p.EconomicRegulations.K051,
                    K070 = p.EconomicRegulations.K070,
                    K080 = p.EconomicRegulations.K080,
                    K110 = p.EconomicRegulations.K110
                },
                FullName = p.FullName,
                FullNameAbbreviated = p.FullNameAbbreviated,
                FullNameInternational = p.FullNameInternational,
                Gcif = p.Gcif,
                IsOkpoExclusion = p.IsOkpoExclusion?"1":"0",
                K014 = p.K014,
                K030 = p.K030,
                K040 = p.K040,
                K060 = p.K060,
                Kf = p.Kf,
                LastChangeDt = p.LastChangeDt,
                LegalAddress = (null==p.LegalAddress)?new LegalPersonAddress() : new LegalPersonAddress
                {
                    La_Area = p.LegalAddress.Area,
                    La_FullAddress = p.LegalAddress.FullAddress,
                    La_Index = p.LegalAddress.Index,
                    La_K040 = p.LegalAddress.K040,
                    La_Region = p.LegalAddress.Region,
                    La_Settlement = p.LegalAddress.Settlement,
                    La_TerritoryCode = p.LegalAddress.TerritoryCode
                },
                OffBalanceDepCode = p.OffBalanceDepCode,
                OffBalanceDepName = p.OffBalanceDepName,
                Okpo = p.Okpo,
                Rcif = string.Empty, // TODO Уточнить насчет поля Rcif: у старого LegalPerson оно есть, у нового - нет.
                RelatedPersons = new List<RelatedPerson>(p.RelatedPersons.Select(r => new RelatedPerson
                {
                    ActualDate = r.ActualDate,
                    Address = r.Address,
                    BirthDay = r.BirthDay,
                    BirthPlace = r.BirthPlace,
                    DocIssueDate = r.DocIssueDate,
                    DocNumber = r.DocNumber,
                    DocOrgan = r.DocOrgan,
                    DocSer = r.DocSer,
                    DocType = r.DocType,
                    EddrId = r.EddrId,
                    Email = (null != r.Emails) ? r.Emails.FirstOrDefault() : string.Empty,
                    IsOkpoExclusion = r.IsOkpoExclusion?"1":"0",
                    K014 = r.K014,
                    K040 = r.K040.ToString(),
                    K051 = r.K051,
                    K070 = r.K070,
                    K080 = r.K080,
                    K110 = r.K110,
                    Name = r.Name,
                    Notes = r.Notes,
                    Okpo = r.Okpo,
                    RegionCode = r.RegionCode.ToString(),
                    RelSign = r.RelSign,
                    Rel_Rnk = r.Rel_Rnk,
                    Sex = r.Sex,
                    Telephone = (null != r.Telephones) ? r.Telephones.FirstOrDefault() : string.Empty
                })),
                Rnk = p.Rnk,
                TaxpayerDetails = (null==p.TaxpayerDetails)? new TaxpayersDetails() : new TaxpayersDetails
                {
                    AdmRegAuthority = p.TaxpayerDetails.AdmRegAuthority,
                    AdmRegDate = p.TaxpayerDetails.AdmRegDate,
                    AreaPi = p.TaxpayerDetails.AreaPi,
                    DpaRegNumber = p.TaxpayerDetails.DpaRegNumber,
                    DpiRegDate = p.TaxpayerDetails.DpiRegDate,
                    PiRegDate = p.TaxpayerDetails.PiRegDate,
                    RegionalPi = p.TaxpayerDetails.RegionalPi,
                    VatCertNumber = p.TaxpayerDetails.VatCertNumber,
                    VatData = p.TaxpayerDetails.VatData
                }
            };

            return l;
        }

        public PrivateEnPerson ToPrivateEnPerson()
        {
            if (!(Person is PrivateEntrepreneurV2)) { return null; }
            var p = (PrivateEntrepreneurV2)Person;
            var e = new PrivateEnPerson
            {
                ActualAddress = (null==p.ActualAddress)? new PrivateEnActualAddress() : new PrivateEnActualAddress
                {
                    Aa_ApartmentsNumber = p.ActualAddress.ApartmentsNumber,
                    Aa_Area = p.ActualAddress.Area,
                    Aa_HouseNumber = p.ActualAddress.HouseNumber,
                    Aa_Index = p.ActualAddress.Index,
                    Aa_Notes = p.ActualAddress.Notes,
                    Aa_Region = p.ActualAddress.Region,
                    Aa_SectionNumber = p.ActualAddress.SectionNumber,
                    Aa_Settlement = p.ActualAddress.Settlement,
                    Aa_Street = p.ActualAddress.Street,
                    Aa_territoryCode = p.ActualAddress.TerritoryCode
                },
                additionalDetails = (null==p.AdditionalDetails)? new PrivateEnAdditionalDetails() : new PrivateEnAdditionalDetails
                {
                    Email = p.AdditionalDetails.Email,
                    EmploymentStatus = p.AdditionalDetails.EmploymentStatus,
                    GroupAffiliation = p.AdditionalDetails.GroupAffiliation,
                    K013 = p.AdditionalDetails.K013
                },
                AdditionalInformation = (null==p.AdditionalInformation)? new PrivateEnAdditionalInformation() : new PrivateEnAdditionalInformation
                {
                    BorrowerClass = p.AdditionalInformation.BorrowerClass.TryParseDec(),
                    SmallBusinessBelonging = p.AdditionalInformation.SmallBusinessBelonging
                },
                buildStateRegister = p.BuildStateRegister,
                CustomerDetails =(null==p.CustomerDetails)? new PrivateEnCustomerDetails() : new PrivateEnCustomerDetails
                {
                    ActualDate = p.CustomerDetails.ActualDate,
                    BirthDate = p.CustomerDetails.BirthDate,
                    BirthPlace = p.CustomerDetails.BirthPlace,
                    DocIssueDate = p.CustomerDetails.DocIssueDate,
                    DocNumber = p.CustomerDetails.DocNumber,
                    DocOrgan = p.CustomerDetails.DocOrgan,
                    DocSer = p.CustomerDetails.DocSer,
                    DocType = p.CustomerDetails.DocType,
                    EddrId = p.CustomerDetails.EddrId,
                    MobilePhone = p.CustomerDetails.MobilePhone,
                    Sex = p.CustomerDetails.Sex
                },
                DateOff = p.DateOff,
                DateOn = p.DateOn,
                economicRegulations = (null==p.EconomicRegulations)? new EconomicRegulations() : new EconomicRegulations
                {
                    K050 = p.EconomicRegulations.K050,
                    K051 = p.EconomicRegulations.K051,
                    K070 = p.EconomicRegulations.K070,
                    K080 = p.EconomicRegulations.K080,
                    K110 = p.EconomicRegulations.K110
                },
                fullName = p.FullName,
                fullNameAbbreviated = p.FullNameAbbreviated,
                fullNameInternational = p.FullNameInternational,
                Gcif = p.Gcif,
                IsOkpoExclusion = p.IsOkpoExclusion,
                K010 = (short?)p.K010,
                K014 = p.K014,
                K040 = p.K040,
                K060 = p.K060,
                Kf = p.Kf,
                LastChangeDt = p.LastChangeDt,
                LegalAddress = (null==p.LegalAddress)? new PrivateEnAddress() : new PrivateEnAddress
                {
                    La_apartmentsNumber = p.LegalAddress.ApartmentsNumber,
                    La_Area = p.LegalAddress.Area,
                    La_HouseNumber = p.LegalAddress.HouseNumber,
                    La_Index = p.LegalAddress.Index,
                    La_Notes = p.LegalAddress.Notes,
                    La_Region = p.LegalAddress.Region,
                    La_SectionNumber = p.LegalAddress.SectionNumber,
                    La_Settlement = p.LegalAddress.Settlement,
                    La_Street = p.LegalAddress.Street,
                    La_TerritoryCode = p.LegalAddress.TerritoryCode
                },
                Okpo = p.Okpo,
                RelatedPersons = new List<RelatedPerson>(p.RelatedPersons.Select(r => new RelatedPerson
                {
                    ActualDate = r.ActualDate,
                    Address = r.Address,
                    BirthDay = r.BirthDay,
                    BirthPlace = r.BirthPlace,
                    DocIssueDate = r.DocIssueDate,
                    DocNumber = r.DocNumber,
                    DocOrgan = r.DocOrgan,
                    DocSer = r.DocSer,
                    DocType = r.DocType,
                    EddrId = r.EddrId,
                    Email = (null != r.Emails) ? r.Emails.FirstOrDefault() : string.Empty,
                    IsOkpoExclusion = r.IsOkpoExclusion?"1":"0",
                    K014 = r.K014,
                    K040 = r.K040.ToString(),
                    K051 = r.K051,
                    K070 = r.K070,
                    K080 = r.K080,
                    K110 = r.K110,
                    Name = r.Name,
                    Notes = r.Notes,
                    Okpo = r.Okpo,
                    RegionCode = r.RegionCode.ToString(),
                    RelSign = r.RelSign,
                    Rel_Rnk = r.Rel_Rnk,
                    Sex = r.Sex,
                    Telephone = (null != r.Telephones) ? r.Telephones.FirstOrDefault() : string.Empty
                })),
                Rnk = p.Rnk,
                TaxpayersDetail = (null==p.TaxpayerDetails)?new PrivateEnTaxpayersDetail() : new PrivateEnTaxpayersDetail
                {
                    AdmRegAuthority = p.TaxpayerDetails.AdmRegAuthority,
                    AdmRegDate = p.TaxpayerDetails.AdmRegDate,
                    AdmRegNumber = p.TaxpayerDetails.AdmRegNumber,
                    AreaPi = p.TaxpayerDetails.AreaPi,
                    Piregdate = p.TaxpayerDetails.PiRegDate,
                    PiRegNumber = p.TaxpayerDetails.PiRegNumber,
                    RegionalPi = p.TaxpayerDetails.RegionalPi,
                    TP_K050 = p.TaxpayerDetails.K050.TryParseDec()
                }
            };
            return e;
        }
    }


    public static class Extensions
    {
        public static decimal? TryParseDec(this string numStr)
        {
            decimal d;
            return decimal.TryParse(numStr, out d) ? d : (decimal?)null;
        }
    }
}