namespace clientregister
{
    /// <summary>
    /// заява на зміну реквізитів клієнта
    /// </summary>
    public class ChangeCustTags
    {
        /// <summary>
        /// Повна адреса проживання
        /// </summary>
        public string ADDRESS_F { get; set; }
        /// <summary>
        /// Повна назва клієнта
        /// </summary>
        public string NAME_FULL { get; set; }
        /// <summary>
        /// Дата народження клієнта
        /// </summary>
        public string BIRTH_DATE { get; set; }
        /// <summary>
        /// ІПН клієнта
        /// </summary>
        public string CUST_CODE { get; set; }
        /// <summary>
        /// Країна клієнта
        /// </summary>
        public string COUNTRY { get; set; }
        /// <summary>
        /// Назва ідентифікаційного документу
        /// </summary>
        public string DOC_TYPE { get; set; }
        /// <summary>
        /// Серія ідентифікаційного документу
        /// </summary>
        public string DOC_SERIAL { get; set; }
        /// <summary>
        /// Номер ідентифікаційного документу
        /// </summary>
        public string DOC_NUMBER { get; set; }
        /// <summary>
        /// Організація яка видала ідентифікаційний документ
        /// </summary>
        public string DOC_ORGAN { get; set; }
        /// <summary>
        /// Дата видачі ідентифікаційного документу
        /// </summary>
        public string DOC_DATE { get; set; }
        /// <summary>
        /// Дата вклеювання фото в паспорт
        /// </summary>
        public string PHOTO_DATE { get; set; }
        /// <summary>
        /// Повна адреса реєстрації
        /// </summary>
        public string ADDRESS_U { get; set; }
        /// <summary>
        /// Домашній телефон
        /// </summary>
        public string HOME_PHONE { get; set; }
        /// <summary>
        /// Робочий телефон
        /// </summary>
        public string WORK_PHONE { get; set; }
        /// <summary>
        /// Мобільний телефон
        /// </summary>
        public string CELL_PHONE { get; set; }
    }

}