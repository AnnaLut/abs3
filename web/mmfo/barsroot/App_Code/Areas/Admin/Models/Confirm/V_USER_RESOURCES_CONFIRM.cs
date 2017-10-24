namespace BarsWeb.Areas.Admin.Models.Confirm
{
    /// <summary>
    /// V_USER_RESOURCES_CONFIRM. Підтвердження виконання дій адміністрування користувачів
    /// </summary>
    public class V_USER_RESOURCES_CONFIRM
    {
        public string STATUS { get; set; }
        public string OBJ { get; set; }
        public string NAME { get; set; }
        public string LOGNAME { get; set; }
        public string ID_RES { get; set; }
        public decimal? ID { get; set; }
        public string FIO { get; set; }
    }
}
