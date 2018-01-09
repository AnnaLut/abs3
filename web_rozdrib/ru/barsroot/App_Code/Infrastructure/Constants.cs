using System.Collections.Generic;
using System.Web.Mvc;

namespace BarsWeb.Infrastructure
{
    public static class Constants
    {
        public static string UserId = "skUserID";
        /// <summary>
        /// Сторінка авторизації 
        /// </summary>
        public static string LoginPageUrl = "~/account/login/";
        /// <summary>
        /// Ім"я строки коннекта
        /// </summary>
        public static string AppConnectionStringName = "IBankCoreConnectionString";
        /// <summary>
        /// Доступні мови
        /// </summary>
        public static string RouteLang = "uk|ru|en";
        /// <summary>
        /// Список доступних тем інтерфейсу
        /// </summary>
        public static List<Theme> ThemesList = new List<Theme>
        {
             new Theme("Kendo","default",false),
             new Theme("Kendo","black",true),
             new Theme("Kendo","blueopal",false),
             new Theme("Kendo","bootstrap",false),
             new Theme("Kendo","flat",true),
             new Theme("Kendo","highcontrast",true),
             new Theme("Kendo","metro",false),
             new Theme("Kendo","metroblack",true),
             new Theme("Kendo","moonlight",true),
             new Theme("Kendo","silver",false),
             new Theme("Kendo","uniform",false)
        };

        public static DefaultRoute DefaultRoute = new DefaultRoute();


    }
    public class Theme
    {
        public Theme(string patern, string name, bool isBlack)
        {
            Pattern = patern;
            Name = name;
            IsBlack = isBlack;
        }

        public string Pattern { get; set; }
        public string Name { get; set; }
        public bool IsBlack { get; set; }
    }

    public class DefaultRoute
    {
        public string controller
        {
            get { return "Home"; }
        }

        public string action
        {
            get { return "Index"; }
        }

        public UrlParameter id
        {
            get { return UrlParameter.Optional; }
        }
    }

}