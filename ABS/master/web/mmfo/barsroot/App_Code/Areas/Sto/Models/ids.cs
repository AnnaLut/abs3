using System;
namespace BarsWeb.Areas.Sto
{
    /// <summary>
    /// Договор на регулярные платежи
    /// </summary>
    public class ids
    {
        public ids() { }

        public ids(decimal RNK, decimal IDG, string NAME)
        {
            this.RNK = RNK;
            this.IDG = IDG;
            this.NAME = NAME;
        }

        /// <summary>
        /// РНК, регистрационный номер клиента
        /// </summary>
        public decimal RNK { get; set; }
        
        /// <summary>
        /// Имя / детали договора
        /// </summary>
        public string NAME { get; set; }
        
        /// <summary>
        /// Дата начала действия
        /// </summary>
        public DateTime SDAT { get; set; }
        
        /// <summary>
        /// Группа регулярных платежей
        /// </summary>
        public decimal IDG { get; set; }
        
        /// <summary>
        /// ИД договора
        /// </summary>
        public decimal IDS { get; set; }

    }
}