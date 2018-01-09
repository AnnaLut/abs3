using BarsWeb.Core.Logger;
using BarsWeb.Infrastructure.Repository.DI.Implementation;


namespace BarsWeb.Areas.WebSMS.Models
{
    /// <summary>
    /// Summary description for SMS
    /// </summary>
    public class WebSMS
    {
        public WebSMS(string body)
        {
            string UserName = Bars.Configuration.ConfigurationSettings.AppSettings["SMS.TECH_USER"]; ;
            var repository = new AccountRepository(new AppModel(), DbLoggerConstruct.NewDbLogger());
            repository.LoginUser(UserName);
            message msg = new message(body);
            //
            // TODO: Add constructor logic here
            //
        }
    }
}