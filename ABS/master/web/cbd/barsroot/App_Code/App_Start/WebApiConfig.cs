using System.Globalization;
using System.Net.Http.Formatting;
using System.Net.Http.Headers;
using System.Threading;
using System.Web.Http;
using AttributeRouting.Web.Http.WebHost;
using BarsWeb.Infrastructure.Handlers;

namespace BarsWeb
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {

            config.Routes.MapHttpAttributeRoutes();
            config.MessageHandlers.Add(new LanguageMessageHandler());

            var route = config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );
            
            // See http://github.com/mccalltd/AttributeRouting/wiki for more options.
            // To debug routes locally using the built in ASP.NET development server, go to /routes.axd

            // Формат ответа от WebApi можно запросить добавлением к URL "?type=json"
            config.Formatters.JsonFormatter.MediaTypeMappings.Add(
                new QueryStringMapping("type", "json", new MediaTypeHeaderValue("application/json")));

            // Формат ответа от WebApi можно запросить добавлением к URL "?type=xml"
             config.Formatters.XmlFormatter.MediaTypeMappings.Add(
                new QueryStringMapping("type", "xml", new MediaTypeHeaderValue("application/xml")));

            // установить по умолчанию JSON как результат ответа от WebApi
            config.Formatters.JsonFormatter.SupportedMediaTypes.Add(new MediaTypeHeaderValue("text/html"));
            config.Formatters.XmlFormatter.UseXmlSerializer = true;

            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture("uk");
            Thread.CurrentThread.CurrentUICulture = CultureInfo.CreateSpecificCulture("uk");


            var json = config.Formatters.JsonFormatter;
            json.SerializerSettings.Formatting = Newtonsoft.Json.Formatting.Indented;
            json.SerializerSettings.DateFormatHandling = Newtonsoft.Json.DateFormatHandling.MicrosoftDateFormat;
            json.SerializerSettings.DateTimeZoneHandling = Newtonsoft.Json.DateTimeZoneHandling.Local;


        }
    }
}
