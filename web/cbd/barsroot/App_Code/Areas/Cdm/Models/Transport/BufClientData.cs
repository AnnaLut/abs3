using System;
using System.ComponentModel.DataAnnotations;
using System.Runtime.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    [DataContract]
    public class BufClientData
    {
        //Код Філії - МФО
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 12, MinimumLength = 6)]
        public string Kf { get; set; }

        //Реєстраційний номер клієнта
        [DataMember(IsRequired = true)]
        public string Rnk { get; set; }

        //Дата реєстрації
        [DataMember(IsRequired = true)]
        public DateTime? DateOn { get; set; }

        //Дата закриття
        [DataMember]
        public DateTime? DateOff { get; set; }

        //Найменування кліента
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 70)]
        public string Nmk { get; set; }

        //Прізвище клієнта
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 500)]
        public string SnLn { get; set; }

        //Ім'я
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 500)]
        public string SnFn { get; set; }

        //По-батькові
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string SnMn { get; set; }

        //Найменування кліента (міжнародне)
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 70)]
        public string Nmkv { get; set; }

        //Найменування кліента в родовому відмінку
        [DataMember]
        [StringLength(maximumLength: 70)]
        public string SnGc { get; set; }

        //Характеристика клієнта (К010)
        [DataMember(IsRequired = true)]
        [Range(typeof (int), "0", "9")] 
        public int? Codcagent { get; set; }

        //Код виду клієнта (K013)
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string K013 { get; set; }

        //країна клієнта (К040)
        [DataMember(IsRequired = true)]
        [Range(typeof (int), "0", "999")] 
        public int? Country { get; set; }

        //ознака інсайдера (К060)
        [DataMember(IsRequired = true)]
        public decimal? Prinsider { get; set; }

        //тип держ. реєстру
        [DataMember(IsRequired = true)]
        [Range(typeof (string), "0", "9")] 
        public string Tgr { get; set; }

        //Ідентифікаційний код
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 14)]
        public string Okpo { get; set; }

        [DataMember(IsRequired=true)]  //вид документу 
        public decimal? Passp { get; set; }

        //Серія документу
        [DataMember]
        [StringLength(maximumLength: 10)]
        public string Ser { get; set; }

        //Номер документу
        [DataMember]
        [StringLength(maximumLength: 20)]
        public string Numdoc { get; set; }

        //Орган що видав документ
        [DataMember]
        [StringLength(maximumLength: 70)]
        public string Organ { get; set; }

        //Дата видачі документу
        [DataMember]
        public DateTime? Pdate { get; set; }

        //Дата вклеювання фото в паспорт
        [DataMember]
        public DateTime? DatePhoto { get; set; }

        //Дата народження 
        [DataMember]
        public DateTime? Bday { get; set; }

        //місце народження
        [DataMember]
        [StringLength(maximumLength: 70)]
        public string Bplace { get; set; }

        //Стать
        [DataMember]
        [StringLength(maximumLength: 1)]
        public string Sex { get; set; }

        //код. безбалансового відділення
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 30)]
        public string Branch { get; set; }

        //Адреса (єдине поле)
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 70)]
        public string Adr { get; set; }

        //Юридична адреса: Індекс
        [DataMember]
        [StringLength(maximumLength: 30)]
        public string UrZip { get; set; }

        //Юридична адреса: Область
        [DataMember]
        [StringLength(maximumLength: 30)]
        public string UrDomain { get; set; }

        //Юридична адреса: Регіон
        [DataMember]
        [StringLength(maximumLength: 30)]
        public string UrRegion { get; set; }

        //Юридична адреса: Населений пукт
        [DataMember]
        [StringLength(maximumLength: 30)]
        public string UrLocality { get; set; }

        //Юридична адреса: Адреса(вулиця, будинок, квартира)
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 100)]
        public string UrAddress { get; set; }

        //Юридична адреса: Код адреси
        [DataMember]
        [StringLength(maximumLength: 22)]
        public string UrTerritoryId { get; set; }

        //Юридична адреса: Тип населеного пункта
        [DataMember]
        [StringLength(maximumLength: 22)]
        public string UrLocalityType { get; set; }

        //Юридична адреса: Тип вулиці
        [DataMember]
        [StringLength(maximumLength: 22)]
        public string UrStreetType { get; set; }

        //Юридична адреса: Вулиця
        [DataMember]
        [StringLength(maximumLength: 100)]
        public string UrStreet { get; set; }

        //Юридична адреса: Тип будинку
        [DataMember]
        [StringLength(maximumLength: 22)]
        public string UrHomeType { get; set; }

        //Юридична адреса: № будинку
        [DataMember]
        [StringLength(maximumLength: 100)]
        public string UrHome { get; set; }

        //Юридична адреса: Тип частини будинку
        [DataMember]
        [StringLength(maximumLength: 22)]
        public string UrHomepartType { get; set; }

        //Юридична адреса: № частини будинку
        [DataMember]
        [StringLength(maximumLength: 100)]
        public string UrHomepart { get; set; }

        //Юридична адреса: Тип житлового приміщення
        [DataMember]
        [StringLength(maximumLength: 22)]
        public string UrRoomType { get; set; }

        //Юридична адреса: № житлового приміщення
        [DataMember]
        [StringLength(maximumLength: 100)]
        public string UrRoom { get; set; }

        //Адр:вулиця,буд.,кв.
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string Fgadr { get; set; }

        //Адреса: район
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string Fgdst { get; set; }

        //Адреса: область
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string Fgobl { get; set; }

        //Адреса: населений пункт
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string Fgtwn { get; set; }

        //Мобільний телефон
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string Mpno { get; set; }

        //мобіьний тел.
        [DataMember]
        [StringLength(maximumLength: 20)]
        public string Cellphone { get; set; }

        //домашній тел.
        [DataMember]
        [StringLength(maximumLength: 20)]
        public string Teld { get; set; }

        //робочий тел.
        [DataMember]
        [StringLength(maximumLength: 20)]
        public string Telw { get; set; }

        //Адреса електронної пошти
        [DataMember]
        [DataType(DataType.EmailAddress)] 
        [StringLength(maximumLength: 500)]
        public string Email { get; set; }


        //інст.сектор.економіки (К070)
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 5)]
        public string Ise { get; set; }

        //форма власності (К080)
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 2)]
        public string Fs { get; set; }

        //вид ек. діяльності (К110)
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 5)]
        public string Ved { get; set; }

        //форма господарювання (К050)
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 3)]
        public string K050 { get; set; }

        //БПК. Закордонний паспорт. Номер
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string PcZ2 { get; set; }

        //БПК. Закордонний паспорт. Серія
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string PcZ1 { get; set; }

        //БПК. Закордонний паспорт. Коли виданий
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string PcZ5 { get; set; }

        //БПК. Закордонний паспорт. Ким виданий
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string PcZ3 { get; set; }

        //БПК. Закордонний паспорт. Дійсний до
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string PcZ4 { get; set; }

        //Місце роботи, посада
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string WorkPlace { get; set; }

        //Належнiсть до публiчних дiячiв
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string Publp { get; set; }

        //Статус зайнятості особи
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string Cigpo { get; set; }

        //Вiдмiтка про самозайнятiсть фiзособи
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string Samz { get; set; }

        //Категорiя громадян, якi постраждали внаслiдок Чорноб.катастрофи
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string Chorn { get; set; }

        //Код "Особливої Вiдмiтки" нестандартного клієнта ФО
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string Spmrk { get; set; }

        //Ознака VIP-клієнта
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string VipK { get; set; }

        //Приналежнiсть до працiвникiв банку
        [DataMember]
        [StringLength(maximumLength: 500)]
        public string Workb { get; set; }

        [DataMember]
        public string CodcagentDesc { get; set; }

        [DataMember]
        public string K013Desc { get; set; }

        [DataMember]
        public string CountryDesc { get; set; }

        [DataMember]
        public string PrinsiderDesc { get; set; }

        [DataMember]
        public string TgrDesc { get; set; }

        [DataMember]
        public string SexDesc { get; set; }

        [DataMember]
        public string IseDesc { get; set; }

        [DataMember]
        public string FsDesc { get; set; }

        [DataMember]
        public string VedDesc { get; set; }

        [DataMember]
        public string K050Desc { get; set; }

        [DataMember]
        public string Gcif { get; set; }

        [DataMember]
        public string OkpoExclusion { get; set; }

        [DataMember]
        public string SamzDesc { get; set; }

        [DataMember]
        public string ChornDesc { get; set; }

        [DataMember]
        public string SpmrkDesc { get; set; }

        [DataMember]
        public string WorkbDesc { get; set; }

        [DataMember]
        public string PasspDesc { get; set; }

        [DataMember]
        public string Credit { get; set; }

        [DataMember]
        public string Deposit { get; set; }

        [DataMember]
        public string BankCard { get; set; }

        [DataMember]
        public string CurrentAccount { get; set; }

        [DataMember]
        public string Other { get; set; }

        //Пов'язані особи
        [DataMember]
        public BufRelData[] RelatedPerson { get; set; }

        [DataMember]
        public string Maker { get; set; }

        [DataMember]
        public DateTime? MakerDtStamp { get; set; }
    }
}