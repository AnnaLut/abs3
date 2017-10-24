using System;


namespace BarsWeb.Areas.Sep.Models
{
    public class SepTechAccountsFilterParams
    {
        public bool postFlag { get; set; }
        /// <summary>
        /// Строка варианта отображения грида 
        /// </summary>
        public string PartialVariantString { get; set; }

        /// <summary>
        /// Вариант вызова грид - GetSEPTECHACCOUNT_V2 или GetSEPTECHACCOUNT_V1
        /// </summary>
        public string GridVariantString { get; set; }
        /// <summary>
        /// Сортировать счета без учета КР
        /// </summary>
        public bool? SortWithoutKR { get; set; }
        /// <summary>
        /// Обороты за период Дат с
        /// </summary>
        public DateTime? DateCashFlowPeriod1 { get; set; }
        /// <summary>
        /// Обороты за период Дат по
        /// </summary>
        public DateTime? DateCashFlowPeriod2 { get; set; } 
        /// <summary>
        /// Номер счета
        /// </summary>
        public int? NACC { get; set; }
        /// <summary>
        /// Банковский день
        /// </summary>
        public string bankdate { get; set; }
        /// <summary>
        /// Номер лицевого счета
        /// </summary>
        public string NLS { get; set; }
        public DateTime? dat11 { get; set; }
        public DateTime? dat22 { get; set; }
        /// <summary>
        /// Отобраюать версчию View №2
        /// </summary>
        public bool SepTechAccountFlag_v2 { get; set; }         
        /// <summary>
        /// Показывать связанные счета
        /// </summary>
        public bool LinkedAccFlag { get; set; }

        /// <summary>
        /// Показывать эквиваленты
        /// </summary>
        public string ShowEquivalents { get ; set; }

        /// <summary>
        /// Показывать закрытые счета
        /// </summary>
        public string ShowClosedAcc { get; set; }

        /// <summary>
        /// Показывать финсновые атрибуты
        /// </summary>
        public string ShowFinAtrib { get; set; }

        public string dat1 { get; set; }
        public string dat2 { get; set; }

        public int TABID { get; set; }
        public int COLID { get; set; }

        public string DF { get; set; }
         
    }
}