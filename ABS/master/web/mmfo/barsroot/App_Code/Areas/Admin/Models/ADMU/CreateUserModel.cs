namespace BarsWeb.Areas.Admin.Models.ADMU
{
    /// <summary>
    /// Модель створення нового користувача
    /// </summary>
    public class CreateUserModel
    {
        public string Login { get; set; }
        public string Name { get; set; }
        public string DefaultBranch { get; set; }

        public bool CanSelectBranch { get; set; }
        public bool ExtendedAccess { get; set; }
        public string Token { get; set; }

        public bool AbsAuth { get; set; }
        public string AbsPass { get; set; }

        public bool OraAuth { get; set; }
        public string OraPass { get; set; }
        public string OraRoles { get; set; }

        public bool AdAuth { get; set; }
        public string AdLogin { get; set; }

        //public string Branches { get; set; }
        public string WebRoles { get; set; }
    }
}