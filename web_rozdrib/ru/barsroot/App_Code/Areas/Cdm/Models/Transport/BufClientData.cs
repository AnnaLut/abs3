using System;
using System.ComponentModel.DataAnnotations;
using System.Runtime.Serialization;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class BufClientData
    {
        //Код Філії - МФО
        [XmlElement("kf")]
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 12, MinimumLength = 6)]
        public string Kf { get; set; }

        //Реєстраційний номер клієнта
        [XmlElement("rnk")]
        [DataMember(IsRequired = true)]
        public decimal? Rnk { get; set; }

        //Дата реєстрації
        [XmlElement("dateOn")]
        [DataMember(IsRequired = true)]
        public DateTime? DateOn { get; set; }
        public bool ShouldSerializeDateOn()
        {
            return DateOn.HasValue;
        }

        //Дата закриття
        [XmlElement("dateOff")]
        [DataMember]
        public DateTime? DateOff { get; set; }
        public bool ShouldSerializeDateOff()
        {
            return DateOff.HasValue;
        }

        //Найменування кліента
        [XmlElement("nmk")]
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 70)]
        public string Nmk { get; set; }
        public bool ShouldSerializeNmk()
        {
            return !string.IsNullOrEmpty(Nmk);
        }

        //Прізвище клієнта
        [XmlElement("snLn")]
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 500)]
        public string SnLn { get; set; }
        public bool ShouldSerializeSnLn()
        {
            return !string.IsNullOrEmpty(SnLn);
        }

        //Ім'я
        [XmlElement("snFn")]
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 500)]
        public string SnFn { get; set; }
        public bool ShouldSerializeSnFn()
        {
            return !string.IsNullOrEmpty(SnFn);
        }

        //По-батькові
        [XmlElement("snMn")]
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string SnMn { get; set; }
        public bool ShouldSerializeSnMn()
        {
            return !string.IsNullOrEmpty(SnMn);
        }

        //Найменування кліента (міжнародне)
        [XmlElement("nmkv")]
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 70)]
        public string Nmkv { get; set; }
        public bool ShouldSerializeNmkv()
        {
            return !string.IsNullOrEmpty(Nmkv);
        }

        //Найменування кліента в родовому відмінку
        [XmlElement("snGc")]
        [DataMember]
        [StringLength(maximumLength: 70)]
        public string SnGc { get; set; }
        public bool ShouldSerializeSnGc()
        {
            return !string.IsNullOrEmpty(SnGc);
        }

        //Характеристика клієнта (К010)
        [XmlElement("codcagent")]
        [DataMember(IsRequired = true)]
        [Range(typeof(decimal), "0", "9")]
        public decimal? Codcagent { get; set; }
        public bool ShouldSerializeCodcagent()
        {
            return Codcagent != null;
        }

        //Код виду клієнта (K013)
        [XmlElement("k013")]
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string K013 { get; set; }
        public bool ShouldSerializeK013()
        {
            return !string.IsNullOrEmpty(K013);
        }

        //країна клієнта (К040)
        [XmlElement("country")]
        [DataMember(IsRequired = true)]
        [Range(typeof(decimal), "0", "999")]
        public decimal? Country { get; set; }
        public bool ShouldSerializeCountry()
        {
            return Country != null;
        }

        //ознака інсайдера (К060)
        [DataMember(IsRequired = true)]
        [XmlElement("prinsider")]
        public decimal? Prinsider { get; set; }
        public bool ShouldSerializePrinsider()
        {
            return Prinsider != null;
        }


        //тип держ. реєстру
        [XmlElement("tgr")]
        [DataMember(IsRequired = true)]
        [Range(typeof(decimal), "0", "9")]
        public decimal? Tgr { get; set; }
        public bool ShouldSerializeTgr()
        {
            return Tgr != null;
        }

        //Ідентифікаційний код
        [XmlElement("okpo")]
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 14)]
        public string Okpo { get; set; }
        public bool ShouldSerializeOkpo()
        {
            return !string.IsNullOrEmpty(Okpo);
        }

        //вид документу 
        [XmlElement("passp")]
        [DataMember(IsRequired = true)]
        public decimal? Passp { get; set; }
        public bool ShouldSerializePassp()
        {
            return Passp != null;
        }

        //Серія документу
        [XmlElement("ser")]
        [DataMember]
        [StringLength(maximumLength: 10)]
        public string Ser { get; set; }
        public bool ShouldSerializeSer()
        {
            return !string.IsNullOrEmpty(Ser);
        }

        //Номер документу
        [XmlElement("numdoc")]
        [DataMember]
        [StringLength(maximumLength: 20)]
        public string Numdoc { get; set; }
        public bool ShouldSerializeNumdoc()
        {
            return !string.IsNullOrEmpty(Numdoc);
        }

        //Орган що видав документ
        [XmlElement("organ")]
        [DataMember]
        [StringLength(maximumLength: 70)]
        public string Organ { get; set; }
        public bool ShouldSerializeOrgan()
        {
            return !string.IsNullOrEmpty(Organ);
        }

        //Дата видачі документу
        [XmlElement("pdate")]
        [DataMember]
        public DateTime? Pdate { get; set; }
        public bool ShouldSerializePdate()
        {
            return Pdate != null;
        }

        //Дата вклеювання фото в паспорт
        [XmlElement("datePhoto")]
        [DataMember]
        public DateTime? DatePhoto { get; set; }
        public bool ShouldSerializeDatePhoto()
        {
            return DatePhoto != null;
        }

        //Дата народження 
        [XmlElement("bday")]
        [DataMember]
        public DateTime? Bday { get; set; }
        public bool ShouldSerializeBday()
        {
            return Bday != null;
        }

        //місце народження
        [XmlElement("bplace")]
        [DataMember]
        [StringLength(maximumLength: 70)]
        public string Bplace { get; set; }
        public bool ShouldSerializeBplace()
        {
            return !string.IsNullOrEmpty(Bplace);
        }

        //Стать
        [XmlElement("sex")]
        [DataMember]
        [StringLength(maximumLength: 1)]
        public string Sex { get; set; }
        public bool ShouldSerializeSex()
        {
            return !string.IsNullOrEmpty(Sex);
        }

        //код. безбалансового відділення
        [XmlElement("branch")]
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 30)]
        public string Branch { get; set; }
        public bool ShouldSerializeBranch()
        {
            return !string.IsNullOrEmpty(Branch);
        }

        //Адреса (єдине поле)
        [XmlElement("adr")]
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 70)]
        public string Adr { get; set; }

        //Юридична адреса: Індекс
        [XmlElement("urZip")]
        [DataMember]
        [StringLength(maximumLength: 30)]
        public string UrZip { get; set; }
        public bool ShouldSerializeUrZip()
        {
            return !string.IsNullOrEmpty(UrZip);
        }

        //Юридична адреса: Область
        [XmlElement("urDomain")]
        [DataMember]
        [StringLength(maximumLength: 30)]
        public string UrDomain { get; set; }
        public bool ShouldSerializeUrDomain()
        {
            return !string.IsNullOrEmpty(UrDomain);
        }

        //Юридична адреса: Регіон
        [XmlElement("urRegion")]
        [DataMember]
        [StringLength(maximumLength: 30)]
        public string UrRegion { get; set; }
        public bool ShouldSerializeUrRegion()
        {
            return !string.IsNullOrEmpty(UrRegion);
        }

        //Юридична адреса: Населений пукт
        [XmlElement("urLocality")]
        [DataMember]
        [StringLength(maximumLength: 30)]
        public string UrLocality { get; set; }
        public bool ShouldSerializeUrLocality()
        {
            return !string.IsNullOrEmpty(UrLocality);
        }

        //Юридична адреса: Адреса(вулиця, будинок, квартира)
        [XmlElement("urAddress")]
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 100)]
        public string UrAddress { get; set; }
        public bool ShouldSerializeUrAddress()
        {
            return !string.IsNullOrEmpty(UrAddress);
        }

        //Юридична адреса: Код адреси
        [XmlElement("urTerritoryId")] //!
        [DataMember]
        public decimal? UrTerritoryId { get; set; }
        public bool ShouldSerializeUrTerritoryId()
        {
            return UrTerritoryId != null;
        }

        //Юридична адреса: Тип населеного пункта
        [XmlElement("urLocalityType")]
        [DataMember]
        public decimal? UrLocalityType { get; set; }
        public bool ShouldSerializeUrLocalityType()
        {
            return UrLocalityType != null;
        }

        //Юридична адреса: Тип вулиці
        [XmlElement("urStreetType")]
        [DataMember]
        public decimal? UrStreetType { get; set; }
        public bool ShouldSerializeUrStreetType()
        {
            return UrStreetType != null;
        }

        //Юридична адреса: Вулиця
        [XmlElement("urStreet")]
        [DataMember]
        [StringLength(maximumLength: 100)]
        public string UrStreet { get; set; }
        public bool ShouldSerializeUrStreet()
        {
            return !string.IsNullOrEmpty(UrStreet);
        }

        //Юридична адреса: Тип будинку
        [XmlElement("urHomeType")]
        [DataMember]
        public decimal? UrHomeType { get; set; }
        public bool ShouldSerializeUrHomeType()
        {
            return UrHomeType != null;
        }

        //Юридична адреса: № будинку
        [XmlElement("urHome")]
        [DataMember]
        [StringLength(maximumLength: 100)]
        public string UrHome { get; set; }
        public bool ShouldSerializeUrHome()
        {
            return !string.IsNullOrEmpty(UrHome);
        }

        //Юридична адреса: Тип частини будинку
        [XmlElement("urHomepartType")]
        [DataMember]
        public decimal? UrHomepartType { get; set; }
        public bool ShouldSerializeUrHomepartType()
        {
            return UrHomepartType != null;
        }

        //Юридична адреса: № частини будинку
        [XmlElement("urHomepart")]
        [DataMember]
        [StringLength(maximumLength: 100)]
        public string UrHomepart { get; set; }
        public bool ShouldSerializeUrHomepart()
        {
            return !string.IsNullOrEmpty(UrHomepart);
        }

        //Юридична адреса: Тип житлового приміщення
        [XmlElement("urRoomType")]
        [DataMember]
        public decimal? UrRoomType { get; set; }
        public bool ShouldSerializeUrRoomType()
        {
            return UrRoomType != null;
        }

        //Юридична адреса: № житлового приміщення
        [XmlElement("urRoom")]
        [DataMember]
        [StringLength(maximumLength: 100)]
        public string UrRoom { get; set; }
        public bool ShouldSerializeUrRoom()
        {
            return !string.IsNullOrEmpty(UrRoom);
        }

        //Адр:вулиця,буд.,кв.
        [XmlElement("fgadr")]
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string Fgadr { get; set; }
        public bool ShouldSerializeFgadr()
        {
            return !string.IsNullOrEmpty(Fgadr);
        }

        //Адреса: район
        [XmlElement("fgdst")]
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string Fgdst { get; set; }
        public bool ShouldSerializeFgdst()
        {
            return !string.IsNullOrEmpty(Fgdst);
        }

        //Адреса: область
        [XmlElement("fgobl")]
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string Fgobl { get; set; }
        public bool ShouldSerializeFgobl()
        {
            return !string.IsNullOrEmpty(Fgobl);
        }

        //Адреса: населений пункт
        [XmlElement("fgtwn")]
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string Fgtwn { get; set; }
        public bool ShouldSerializeFgtwn()
        {
            return !string.IsNullOrEmpty(Fgtwn);
        }

        //Мобільний телефон
        [XmlElement("mpno")]
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string Mpno { get; set; }
        public bool ShouldSerializeMpno()
        {
            return !string.IsNullOrEmpty(Mpno);
        }

        //мобіьний тел.
        [XmlElement("cellphone")]
        [DataMember]
        [StringLength(maximumLength: 20)]
        public string Cellphone { get; set; }
        public bool ShouldSerializeCellphone()
        {
            return !string.IsNullOrEmpty(Cellphone);
        }

        //домашній тел.
        [XmlElement("teld")]
        [DataMember]
        [StringLength(maximumLength: 20)]
        public string Teld { get; set; }
        public bool ShouldSerializeTeld()
        {
            return !string.IsNullOrEmpty(Teld);
        }

        //робочий тел.
        [XmlElement("telw")]
        [DataMember]
        [StringLength(maximumLength: 20)]
        public string Telw { get; set; }
        public bool ShouldSerializeTelw()
        {
            return !string.IsNullOrEmpty(Telw);
        }

        //Адреса електронної пошти
        [XmlElement("email")]
        [DataMember]
        [DataType(DataType.EmailAddress)]
        [StringLength(maximumLength: 500)]
        public string Email { get; set; }
        public bool ShouldSerializeEmail()
        {
            return !string.IsNullOrEmpty(Email);
        }

        //інст.сектор.економіки (К070)
        [XmlElement("ise")]
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 5)]
        public string Ise { get; set; }
        public bool ShouldSerializeIse()
        {
            return !string.IsNullOrEmpty(Ise);
        }

        //форма власності (К080)
        [XmlElement("fs")]
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 2)]
        public string Fs { get; set; }
        public bool ShouldSerializeFs()
        {
            return !string.IsNullOrEmpty(Fs);
        }

        //вид ек. діяльності (К110)
        [XmlElement("ved")]
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 5)]
        public string Ved { get; set; }
        public bool ShouldSerializeVed()
        {
            return !string.IsNullOrEmpty(Ved);
        }

        //форма господарювання (К050)
        [XmlElement("k050")]
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 3)]
        public string K050 { get; set; }
        public bool ShouldSerializeK050()
        {
            return !string.IsNullOrEmpty(K050);
        }

        //БПК. Закордонний паспорт. Номер
        [XmlElement("pcZ2")]
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string PcZ2 { get; set; }
        public bool ShouldSerializePcZ2()
        {
            return !string.IsNullOrEmpty(PcZ2);
        }

        //БПК. Закордонний паспорт. Серія
        [XmlElement("pcZ1")]
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string PcZ1 { get; set; }
        public bool ShouldSerializePcZ1()
        {
            return !string.IsNullOrEmpty(PcZ1);
        }

        //БПК. Закордонний паспорт. Коли виданий
        [XmlElement("pcZ5")]
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string PcZ5 { get; set; }
        public bool ShouldSerializePcZ5()
        {
            return !string.IsNullOrEmpty(PcZ5);
        }

        //БПК. Закордонний паспорт. Ким виданий
        [XmlElement("pcZ3")]
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string PcZ3 { get; set; }
        public bool ShouldSerializePcZ3()
        {
            return !string.IsNullOrEmpty(PcZ3);
        }

        //БПК. Закордонний паспорт. Дійсний до
        [XmlElement("pcZ4")]
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string PcZ4 { get; set; }
        public bool ShouldSerializePcZ4()
        {
            return !string.IsNullOrEmpty(PcZ4);
        }

        //Місце роботи, посада
        [XmlElement("workPlace")]
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string WorkPlace { get; set; }
        public bool ShouldSerializeWorkPlace()
        {
            return !string.IsNullOrEmpty(WorkPlace);
        }

        //Належнiсть до публiчних дiячiв
        [XmlElement("publp")]
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string Publp { get; set; }
        public bool ShouldSerializePublp()
        {
            return !string.IsNullOrEmpty(Publp);
        }

        //Статус зайнятості особи
        [XmlElement("cigpo")]
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string Cigpo { get; set; }
        public bool ShouldSerializeCigpo()
        {
            return !string.IsNullOrEmpty(Cigpo);
        }

        //Вiдмiтка про самозайнятiсть фiзособи
        [XmlElement("samz")]
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string Samz { get; set; }
        public bool ShouldSerializeSamz()
        {
            return !string.IsNullOrEmpty(Samz);
        }

        //Категорiя громадян, якi постраждали внаслiдок Чорноб.катастрофи
        [XmlElement("chorn")]
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string Chorn { get; set; }
        public bool ShouldSerializeChorn()
        {
            return !string.IsNullOrEmpty(Chorn);
        }

        //Код "Особливої Вiдмiтки" нестандартного клієнта ФО
        [XmlElement("spmrk")]
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string Spmrk { get; set; }
        public bool ShouldSerializeSpmrk()
        {
            return !string.IsNullOrEmpty(Spmrk);
        }

        //Ознака VIP-клієнта
        [XmlElement("vipK")]
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string VipK { get; set; }
        public bool ShouldSerializeVipK()
        {
            return !string.IsNullOrEmpty(VipK);
        }

        //Приналежнiсть до працiвникiв банку
        [XmlElement("workb")]
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string Workb { get; set; }
        public bool ShouldSerializeWorkb()
        {
            return !string.IsNullOrEmpty(Workb);
        }


        [XmlElement("codcagentDesc")]
        [DataMember]
        public string CodcagentDesc { get; set; }
        public bool ShouldSerializeCodcagentDesc()
        {
            return !string.IsNullOrEmpty(CodcagentDesc);
        }

        [XmlElement("k013Desc")]
        [DataMember]
        public string K013Desc { get; set; }
        public bool ShouldSerializeK013Desc()
        {
            return !string.IsNullOrEmpty(K013Desc);
        }

        [XmlElement("countryDesc")]
        [DataMember]
        public string CountryDesc { get; set; }
        public bool ShouldSerializeCountryDesc()
        {
            return !string.IsNullOrEmpty(CountryDesc);
        }

        [XmlElement("prinsiderDesc")]
        [DataMember]
        public string PrinsiderDesc { get; set; }
        public bool ShouldSerializePrinsiderDesc()
        {
            return !string.IsNullOrEmpty(PrinsiderDesc);
        }

        [XmlElement("tgrDesc")]
        [DataMember]
        public string TgrDesc { get; set; }
        public bool ShouldSerializeTgrDesc()
        {
            return !string.IsNullOrEmpty(TgrDesc);
        }

        [XmlElement("sexDesc")]
        [DataMember]
        public string SexDesc { get; set; }
        public bool ShouldSerializeSexDesc()
        {
            return !string.IsNullOrEmpty(SexDesc);
        }

        [XmlElement("iseDesc")]
        [DataMember]
        public string IseDesc { get; set; }
        public bool ShouldSerializeIseDesc()
        {
            return !string.IsNullOrEmpty(IseDesc);
        }

        [XmlElement("fsDesc")]
        [DataMember]
        public string FsDesc { get; set; }
        public bool ShouldSerializeFsDesc()
        {
            return !string.IsNullOrEmpty(FsDesc);
        }

        [XmlElement("vedDesc")]
        [DataMember]
        public string VedDesc { get; set; }
        public bool ShouldSerializeVedDesc()
        {
            return !string.IsNullOrEmpty(VedDesc);
        }

        [XmlElement("k050Desc")]
        [DataMember]
        public string K050Desc { get; set; }
        public bool ShouldSerializeK050Desc()
        {
            return !string.IsNullOrEmpty(K050Desc);
        }

        [XmlElement("gcif")]
        [DataMember]
        public string Gcif { get; set; }
        public bool ShouldSerializeGcif()
        {
            return !string.IsNullOrEmpty(K050Desc);
        }

        [XmlElement("okpoExclusion")]
        [DataMember]
        public decimal? OkpoExclusion { get; set; }
        public bool ShouldSerializeOkpoExclusion()
        {
            return OkpoExclusion != null;
        }

        [XmlElement("samzDesc")]
        [DataMember]
        public string SamzDesc { get; set; }
        public bool ShouldSerializeSamzDesc()
        {
            return !string.IsNullOrEmpty(SamzDesc);
        }

        [XmlElement("chornDesc")]
        [DataMember]
        public string ChornDesc { get; set; }
        public bool ShouldSerializeChornDesc()
        {
            return !string.IsNullOrEmpty(ChornDesc);
        }

        [XmlElement("spmrkDesc")]
        [DataMember]
        public string SpmrkDesc { get; set; }
        public bool ShouldSerializeSpmrkDesc()
        {
            return !string.IsNullOrEmpty(SpmrkDesc);
        }

        [XmlElement("workbDesc")]
        [DataMember]
        public string WorkbDesc { get; set; }
        public bool ShouldSerializeWorkbDesc()
        {
            return !string.IsNullOrEmpty(WorkbDesc);
        }

        [XmlElement("passpDesc")]
        [DataMember]
        public string PasspDesc { get; set; }
        public bool ShouldSerializePasspDesc()
        {
            return !string.IsNullOrEmpty(WorkbDesc);
        }

        [XmlElement("credit")]
        [DataMember]
        public decimal? Credit { get; set; }
        public bool ShouldSerializeCredit()
        {
            return Credit != null;
        }

        [XmlElement("deposit")]
        [DataMember]
        public decimal? Deposit { get; set; }
        public bool ShouldSerializeDeposit()
        {
            return Deposit != null;
        }

        [XmlElement("bankCard")]
        [DataMember]
        public decimal? BankCard { get; set; }
        public bool ShouldSerializeBankCard()
        {
            return BankCard != null;
        }

        [XmlElement("currentAccount")]
        [DataMember]
        public decimal? CurrentAccount { get; set; }
        public bool ShouldSerializeCurrentAccount()
        {
            return CurrentAccount != null;
        }

        [XmlElement("other")]
        [DataMember]
        public decimal? Other { get; set; }
        public bool ShouldSerializeOther()
        {
            return Other != null;
        }

        [XmlElement("lastChangeDt")]
        [DataMember]
        public DateTime? LastChangeDt { get; set; }
        public bool ShouldSerializeLastChangeDt()
        {
            return LastChangeDt != null;
        }

        [XmlElement("maker")]
        [DataMember]
        public string Maker { get; set; }
        public bool ShouldSerializeMaker()
        {
            return !string.IsNullOrEmpty(Maker);
        }

        [XmlElement("makerDtStamp")]
        [DataMember]
        public DateTime? MakerDtStamp { get; set; }
        public bool ShouldSerializeMakerDtStamp()
        {
            return MakerDtStamp != null;
        }
    }
}