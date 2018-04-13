using System.Web;
using barsroot.core;
using BarsWeb.Infrastructure;

namespace BarsWeb.Models
{
    public static class EntitiesConnection
    {
        public static string ConnectionString(string modelName = "EntityBarsModel", string areaName="")
        {
            string connStr = string.Format("metadata=res://*/App_Code{0}.Models.{1}.csdl|res://*/App_Code{0}.Models.{1}.ssdl|res://*/App_Code{0}.Models.{1}.msl;provider=BarsWeb.DbProvider.Oracle;",
                string.IsNullOrWhiteSpace(areaName)? "" : ".Areas." + areaName,
                modelName);//barsroot.core;
            connStr += "provider connection string=\"";
            string userConnStr = "";
            try
            {
                userConnStr = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
            }
            catch (BarsCoreException)
            {
                var response = HttpContext.Current.Response;
                response.Redirect(Constants.LoginPageUrl);
                response.End();
                response.Flush();
            }
            connStr += userConnStr + "\"";
            return connStr;
        }
    }
}
