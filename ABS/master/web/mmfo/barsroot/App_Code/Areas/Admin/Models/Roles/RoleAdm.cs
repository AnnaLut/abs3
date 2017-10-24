namespace BarsWeb.Areas.Admin.Models.Roles
{
    /// <summary>
    /// Модель адміністрування ролей: V_STAFF_ROLE_ADM
    /// </summary>
    public class RoleAdm
    {
        public string STATE_NAME { get; set; }
        public string ROLE_NAME { get; set; }
        public string ROLE_CODE { get; set; }
        public decimal? ID { get; set; }
    }
}