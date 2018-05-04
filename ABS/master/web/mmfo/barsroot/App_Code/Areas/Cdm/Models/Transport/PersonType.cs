namespace BarsWeb.Areas.Cdm.Models.Transport
{
    /// <summary>
    /// Тип особи (0 - individual (ФО), 1 - legal (ЮО), 2 - privateEntrepreneur (ФОП)
    /// </summary>
    public enum PersonType
    {
        /// <summary>
        /// Фізична особа (ФО)
        /// </summary>
        I = 0,
        /// <summary>
        /// Юридична особа (ЮО)
        /// </summary>
        L = 1,
        /// <summary>
        /// Фізична особа - підприємець (ФОП)
        /// </summary>
        P = 2
    }
}