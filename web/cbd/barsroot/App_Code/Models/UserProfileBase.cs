using System;

namespace BarsWeb.Models
{
    /// <summary>
    /// Общий клас профиля пользователя 
    /// </summary>
    [Serializable]
    public class UserProfileBase 
    {
        //[Display(ResourceType = typeof(AccountRes), Name = "Language")]
        public string Language { get; set; }

        //[Display(ResourceType = typeof(AccountRes), Name = "Theme")]
        public string Theme { get; set; }

        //[Display(ResourceType = typeof(AccountRes), Name = "TimeZone")]
        public decimal TimeZone { get; set; }

        //[Display(ResourceType = typeof(AccountRes), Name = "GridPageSize")]
        public int GridPageSize { get; set; }

        //[Display(ResourceType = typeof(AccountRes), Name = "IsTechPassword")]
        public bool IsTechPassword { get; set; }
    }
}