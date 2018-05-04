using System;
using System.ComponentModel.DataAnnotations;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.Individual
{
    public class IndividualPersonV2 : PersonV2
    {
        //Найменування кліента
        [XmlElement("nmk")]
        [StringLength(maximumLength: 70)]
        public string Nmk { get; set; }
        public bool ShouldSerializeNmk()
        {
            return !string.IsNullOrWhiteSpace(Nmk);
        }

        // Прізвище клієнта
        [XmlElement("snLn")]
        [StringLength(maximumLength: 500)]
        public string SnLn { get; set; }
        public bool ShouldSerializeSnLn()
        {
            return !string.IsNullOrWhiteSpace(SnLn);
        }

        // Ім'я
        [XmlElement("snFn")]
        [StringLength(maximumLength: 500)]
        public string SnFn { get; set; }
        public bool ShouldSerializeSnFn()
        {
            return !string.IsNullOrWhiteSpace(SnFn);
        }

        // По-батькові
        [XmlElement("snMn")]
        [StringLength(maximumLength: 500)]
        public string SnMn { get; set; }
        public bool ShouldSerializeSnMn()
        {
            return !string.IsNullOrWhiteSpace(SnMn);
        }

        // Найменування кліента (міжнародне)
        [XmlElement("nmkv")]
        [StringLength(maximumLength: 70)]
        public string Nmkv { get; set; }
        public bool ShouldSerializeNmkv()
        {
            return !string.IsNullOrWhiteSpace(Nmkv);
        }

        // Найменування кліента в родовому відмінку
        [XmlElement("snGc")]
        [StringLength(maximumLength: 500)]
        public string SnGc { get; set; }
        public bool ShouldSerializeSnGc()
        {
            return !string.IsNullOrWhiteSpace(SnGc);
        }

        // Характеристика клієнта (К010)
        [XmlElement("codcagent")]
        [Range(typeof(decimal), "0", "9")]
        public decimal? Codcagent { get; set; }
        public bool ShouldSerializeCodcagent()
        {
            return Codcagent != null;
        }

        // Код виду клієнта (K013)
        [XmlElement("k013")]
        [StringLength(maximumLength: 500)]
        public string K013 { get; set; }
        public bool ShouldSerializeK013()
        {
            return !string.IsNullOrWhiteSpace(K013);
        }

        // країна клієнта (К040)
        [XmlElement("country")]
        public decimal? Country { get; set; }
        public bool ShouldSerializeCountry()
        {
            return Country != null;
        }

        // ознака інсайдера (К060)
        [XmlElement("prinsider")]
        public decimal? Prinsider { get; set; }
        public bool ShouldSerializePrinsider()
        {
            return Prinsider != null;
        }

        // тип держ. реєстру
        [XmlElement("tgr")]
        public decimal? Tgr { get; set; }
        public bool ShouldSerializeTgr()
        {
            return Tgr != null;
        }

        // Дата народження
        [XmlElement("bday")]
        public DateTime? Bday { get; set; }
        public bool ShouldSerializeBday()
        {
            return Bday != null;
        }

        // місце народження
        [XmlElement("bplace")]
        [StringLength(maximumLength: 70)]
        public string Bplace { get; set; }
        public bool ShouldSerializeBplace()
        {
            return !string.IsNullOrWhiteSpace(Bplace);
        }

        // Стать
        [XmlElement("sex")]
        [StringLength(maximumLength: 1)]
        public string Sex { get; set; }
        public bool ShouldSerializeSex()
        {
            return null != Sex;
        }

        // код. безбалансового відділення
        [XmlElement("branch")]
        [StringLength(maximumLength: 30)]
        public string Branch { get; set; }
        public bool ShouldSerializeBranch()
        {
            return !string.IsNullOrWhiteSpace(Branch);
        }

        // інст.сектор.економіки (К070)
        [XmlElement("ise")]
        [StringLength(maximumLength: 5)]
        public string Ise { get; set; }
        public bool ShouldSerializeIse()
        {
            return !string.IsNullOrWhiteSpace(Ise);
        }

        // форма власності (К080)
        [XmlElement("fs")]
        [StringLength(maximumLength: 2)]
        public string Fs { get; set; }
        public bool ShouldSerializeFs()
        {
            return !string.IsNullOrWhiteSpace(Fs);
        }

        // вид ек. діяльності (К110)
        [XmlElement("ved")]
        [StringLength(maximumLength: 5)]
        public string Ved { get; set; }
        public bool ShouldSerializeVed()
        {
            return !string.IsNullOrWhiteSpace(Ved);
        }

        // форма господарювання (К050)
        [XmlElement("k050")]
        [StringLength(maximumLength: 3)]
        public string K050 { get; set; }
        public bool ShouldSerializeK050()
        {
            return !string.IsNullOrWhiteSpace(K050);
        }

        // Додаткова інформація
        [XmlElement("addInfo")]
        public IndividualPersonAddInfoV2 AddInfo { get; set; }
        public bool ShouldSerializeAddInfo()
        {
            return AddInfo != null;
        }

        // Адреса 
        [XmlElement("address")]
        public IndividualPersonAddressV2 Address { get; set; }
        public bool ShouldSerializeAddress()
        {
            return null != Address;
        }

        // Контактна інформація
        [XmlElement("contact")]
        public IndividualPersonContactV2 Contact { get; set; }
        public bool ShouldSerializeContact()
        {
            return null != Contact;
        }

        // Документи
        [XmlElement("document")]
        public IndividualPersonDocumentV2 Document { get; set; }
        public bool ShouldSerializeDocument()
        {
            return null != Document;
        }

        // Продукти
        [XmlElement("product")]
        public IndividualPersonProductV2 Product { get; set; }
        public bool ShouldSerializeProduct()
        {
            return null != Product;
        }
    }

    public class IndividualPersonAddInfoV2
    {
        // Належнiсть до публiчних дiячiв
        [XmlElement("publp")]
        public string Publp { get; set; }
        public bool ShouldSerializePublp()
        {
            return !string.IsNullOrWhiteSpace(Publp);
        }

        // Статус зайнятості особи
        [XmlElement("cigpo")]
        public string Cigpo { get; set; }
        public bool ShouldSerializeCigpo()
        {
            return !string.IsNullOrWhiteSpace(Cigpo);
        }

        // Вiдмiтка про самозайнятiсть фiзособи
        [XmlElement("samz")]
        public string Samz { get; set; }
        public bool ShouldSerializeSamz()
        {
            return !string.IsNullOrWhiteSpace(Samz);
        }

        // Категорiя громадян, якi постраждали внаслiдок Чорноб.катастрофи
        [XmlElement("chorn")]
        public string Chorn { get; set; }
        public bool ShouldSerializeChorn()
        {
            return !string.IsNullOrWhiteSpace(Chorn);
        }

        // Код "Особливої Вiдмiтки" нестандартного клієнта ФО
        [XmlElement("spmrk")]
        public string Spmrk { get; set; }
        public bool ShouldSerializeSpmrk()
        {
            return !string.IsNullOrWhiteSpace(Spmrk);
        }

        // Ознака VIP-клієнта
        [XmlElement("vipK")]
        public string VipK { get; set; }
        public bool ShouldSerializeVipK()
        {
            return !string.IsNullOrWhiteSpace(VipK);
        }

        // Приналежнiсть до працiвникiв банку
        [XmlElement("workb")]
        public string Workb { get; set; }
        public bool ShouldSerializeWorkb()
        {
            return !string.IsNullOrWhiteSpace(Workb);
        }

        // Місце роботи, посада
        [XmlElement("workPlace")]
        public string WorkPlace { get; set; }
        public bool ShouldSerializeWorkPlace()
        {
            return !string.IsNullOrWhiteSpace(WorkPlace);
        }
    }

    public class IndividualPersonAddressV2
    {
        // Адреса (єдине поле)
        [XmlElement("adr")]
        [StringLength(maximumLength: 70)]
        public string Adr { get; set; }

        // Юридична адреса: Індекс
        [XmlElement("urZip")]
        [StringLength(maximumLength: 20)]
        public string UrZip { get; set; }
        public bool ShouldSerializeUrZip()
        {
            return !string.IsNullOrWhiteSpace(UrZip);
        }

        // Юридична адреса: Область
        [XmlElement("urDomain")]
        [StringLength(maximumLength: 30)]
        public string UrDomain { get; set; }
        public bool ShouldSerializeUrDomain()
        {
            return !string.IsNullOrWhiteSpace(UrDomain);
        }

        //Юридична адреса: Регіон
        [XmlElement("urRegion")]
        [StringLength(maximumLength: 30)]
        public string UrRegion { get; set; }
        public bool ShouldSerializeUrRegion()
        {
            return !string.IsNullOrWhiteSpace(UrRegion);
        }

        // Юридична адреса: Населений пукт
        [XmlElement("urLocality")]
        [StringLength(maximumLength: 30)]
        public string UrLocality { get; set; }
        public bool ShouldSerializeUrLocality()
        {
            return !string.IsNullOrWhiteSpace(UrLocality);
        }

        // Юридична адреса: Адреса(вулиця, будинок, квартира)
        [XmlElement("urAddress")]
        [StringLength(maximumLength: 100)]
        public string UrAddress { get; set; }
        public bool ShouldSerializeUrAddress()
        {
            return !string.IsNullOrWhiteSpace(UrAddress);
        }

        //Юридична адреса: Код адреси
        [XmlElement("urTerritoryId")]
        public decimal? UrTerritoryId { get; set; }
        public bool ShouldSerializeUrTerritoryId()
        {
            return UrTerritoryId != null;
        }

        // Юридична адреса: Тип населеного пункта
        [XmlElement("urLocalityType")]
        public decimal? UrLocalityType { get; set; }
        public bool ShouldSerializeUrLocalityType()
        {
            return UrLocalityType != null;
        }

        // Юридична адреса: Тип вулиці
        [XmlElement("urStreetType")]
        public decimal? UrStreetType { get; set; }
        public bool ShouldSerializeUrStreetType()
        {
            return UrStreetType != null;
        }

        // Юридична адреса: Вулиця
        [XmlElement("urStreet")]
        [StringLength(maximumLength: 100)]
        public string UrStreet { get; set; }
        public bool ShouldSerializeUrStreet()
        {
            return !string.IsNullOrWhiteSpace(UrStreet);
        }

        // Юридична адреса: Тип будинку
        [XmlElement("urHomeType")]
        public decimal? UrHomeType { get; set; }
        public bool ShouldSerializeUrHomeType()
        {
            return UrHomeType != null;
        }

        // Юридична адреса: № будинку
        [XmlElement("urHome")]
        [StringLength(maximumLength: 100)]
        public string UrHome { get; set; }
        public bool ShouldSerializeUrHome()
        {
            return !string.IsNullOrWhiteSpace(UrHome);
        }

        // Юридична адреса: Тип частини будинку
        [XmlElement("urHomepartType")]
        public decimal? UrHomepartType { get; set; }
        public bool ShouldSerializeUrHomepartType()
        {
            return UrHomepartType != null;
        }

        // Юридична адреса: № частини будинку
        [XmlElement("urHomepart")]
        [StringLength(maximumLength: 100)]
        public string UrHomepart { get; set; }
        public bool ShouldSerializeUrHomepart()
        {
            return !string.IsNullOrWhiteSpace(UrHomepart);
        }

        // Юридична адреса: Тип житлового приміщення
        [XmlElement("urRoomType")]
        public decimal? UrRoomType { get; set; }
        public bool ShouldSerializeUrRoomType()
        {
            return UrRoomType != null;
        }

        // Юридична адреса: № житлового приміщення
        [XmlElement("urRoom")]
        [StringLength(maximumLength: 100)]
        public string UrRoom { get; set; }
        public bool ShouldSerializeUrRoom()
        {
            return !string.IsNullOrWhiteSpace(UrRoom);
        }

        // Адр:вулиця,буд.,кв.
        [XmlElement("fgadr")]
        [StringLength(maximumLength: 500)]
        public string Fgadr { get; set; }
        public bool ShouldSerializeFgadr()
        {
            return !string.IsNullOrWhiteSpace(Fgadr);
        }

        // Адреса: район
        [XmlElement("fgdst")]
        [StringLength(maximumLength: 500)]
        public string Fgdst { get; set; }
        public bool ShouldSerializeFgdst()
        {
            return !string.IsNullOrWhiteSpace(Fgdst);
        }

        // Адреса: область
        [XmlElement("fgobl")]
        [StringLength(maximumLength: 500)]
        public string Fgobl { get; set; }
        public bool ShouldSerializeFgobl()
        {
            return !string.IsNullOrWhiteSpace(Fgobl);
        }

        //Адреса: населений пункт
        [XmlElement("fgtwn")]
        [StringLength(maximumLength: 500)]
        public string Fgtwn { get; set; }
        public bool ShouldSerializeFgtwn()
        {
            return !string.IsNullOrWhiteSpace(Fgtwn);
        }
    }

    public class IndividualPersonContactV2
    {
        // Мобільний телефон
        [XmlElement("mpno")]
        [StringLength(maximumLength: 500)]
        public string Mpno { get; set; }
        public bool ShouldSerializeMpno()
        {
            return !string.IsNullOrWhiteSpace(Mpno);
        }

        // Моб. картка клієнта
        [XmlElement("cellphone")]
        [StringLength(maximumLength: 20)]
        public string Cellphone { get; set; }
        public bool ShouldSerializeCellphone()
        {
            return !string.IsNullOrWhiteSpace(Cellphone);
        }

        // домашній тел.
        [XmlElement("teld")]
        [StringLength(maximumLength: 20)]
        public string Teld { get; set; }
        public bool ShouldSerializeTeld()
        {
            return !string.IsNullOrWhiteSpace(Teld);
        }

        // робочий тел.
        [XmlElement("telw")]
        [StringLength(maximumLength: 20)]
        public string Telw { get; set; }
        public bool ShouldSerializeTelw()
        {
            return !string.IsNullOrWhiteSpace(Telw);
        }

        // Адреса електронної пошти
        [XmlElement("email")]
        [DataType(DataType.EmailAddress)]
        [StringLength(maximumLength: 500)]
        public string Email { get; set; }
        public bool ShouldSerializeEmail()
        {
            return !string.IsNullOrWhiteSpace(Email);
        }
    }

    public class IndividualPersonDocumentV2
    {
        // Вид документу 
        [XmlElement("passp")]
        public decimal? Passp { get; set; }
        public bool ShouldSerializePassp()
        {
            return Passp != null;
        }

        // Серія (якщо не ID Card)
        [XmlElement("ser")]
        [StringLength(maximumLength: 22)]
        public string Ser { get; set; }
        public bool ShouldSerializeSer()
        {
            return !string.IsNullOrWhiteSpace(Ser);
        }

        // Номер документу
        [XmlElement("numdoc")]
        [StringLength(maximumLength: 30)]
        public string Numdoc { get; set; }
        public bool ShouldSerializeNumdoc()
        {
            return !string.IsNullOrWhiteSpace(Numdoc);
        }

        // Орган що видав документ
        [XmlElement("organ")]
        [StringLength(maximumLength: 70)]
        public string Organ { get; set; }
        public bool ShouldSerializeOrgan()
        {
            return !string.IsNullOrWhiteSpace(Organ);
        }

        // Дата видачі документу
        [XmlElement("pdate")]
        public DateTime? Pdate { get; set; }
        public bool ShouldSerializePdate()
        {
            return Pdate != null;
        }

        // Дата вклеювання фото в паспорт
        [XmlElement("datePhoto")]
        public DateTime? DatePhoto { get; set; }
        public bool ShouldSerializeDatePhoto()
        {
            return DatePhoto != null;
        }

        // Дійсний до(для ID Card)
        [XmlElement("actualDate")]
        public DateTime? ActualDate { get; set; }
        public bool ShouldSerializeActualDate()
        {
            return ActualDate != null;
        }

        // Унікальний номер запису ЄДДР
        [XmlElement("eddrId")]
        [StringLength(maximumLength:20)]
        public string EddrId { get; set; }
        public bool ShouldSerializeEddrId()
        {
            return !string.IsNullOrWhiteSpace(EddrId);
        }

        // БПК. Закордонний паспорт. Номер
        [XmlElement("pcZ2")]
        [StringLength(maximumLength: 500)]
        public string PcZ2 { get; set; }
        public bool ShouldSerializePcZ2()
        {
            return !string.IsNullOrWhiteSpace(PcZ2);
        }

        // БПК. Закордонний паспорт. Серія
        [XmlElement("pcZ1")]
        [StringLength(maximumLength: 500)]
        public string PcZ1 { get; set; }
        public bool ShouldSerializePcZ1()
        {
            return !string.IsNullOrWhiteSpace(PcZ1);
        }

        // БПК. Закордонний паспорт. Коли виданий
        [XmlElement("pcZ5")]
        [StringLength(maximumLength: 500)]
        public string PcZ5 { get; set; }
        public bool ShouldSerializePcZ5()
        {
            return !string.IsNullOrWhiteSpace(PcZ5);
        }

        // БПК. Закордонний паспорт. Ким виданий
        [XmlElement("pcZ3")]
        [StringLength(maximumLength: 500)]
        public string PcZ3 { get; set; }
        public bool ShouldSerializePcZ3()
        {
            return !string.IsNullOrWhiteSpace(PcZ3);
        }

        //БПК. Закордонний паспорт. Дійсний до
        [XmlElement("pcZ4")]
        [StringLength(maximumLength: 500)]
        public string PcZ4 { get; set; }
        public bool ShouldSerializePcZ4()
        {
            return !string.IsNullOrWhiteSpace(PcZ4);
        }
    }

    public class IndividualPersonProductV2
    {
        // Наявність кредитного продукту
        // Кредит (1 – присутній, інше - відсутній) CHAR(1)
        [XmlElement("credit")]
        [Range(typeof(decimal), "0", "9")]
        public decimal? Credit { get; set; }
        public bool ShouldSerializeCredit()
        {
            return Credit != null;
        }

        // Наявність депозитного продукту
        // Депозит (1 – присутній, інше - відсутній)
        [XmlElement("deposit")]
        [Range(typeof(decimal), "0", "9")]
        public decimal? Deposit { get; set; }
        public bool ShouldSerializeDeposit()
        {
            return Deposit != null;
        }

        // Наявність банківської карти
        // Банківська  картка (1 – присутній, інше - відсутній)
        [XmlElement("bankCard")]
        [Range(typeof(decimal), "0", "9")]
        public decimal? BankCard { get; set; }
        public bool ShouldSerializeBankCard()
        {
            return BankCard != null;
        }

        // Наявність поточного рахунку
        // Поточний рахунок (1 – присутній, інше - відсутній)
        [XmlElement("currentAccount")]
        [Range(typeof(decimal), "0", "9")]
        public decimal? CurrentAccount { get; set; }
        public bool ShouldSerializeCurrentAccount()
        {
            return CurrentAccount != null;
        }

        // Наявність іншого продукту
        // Інший продукт (1 – присутній, інше - відсутній)
        [XmlElement("other")]
        [Range(typeof(decimal), "0", "9")]
        public decimal? Other { get; set; }
        public bool ShouldSerializeOther()
        {
            return Other != null;
        }

    }
}