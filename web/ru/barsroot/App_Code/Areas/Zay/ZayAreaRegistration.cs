using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;

namespace BarsWeb.Areas.Zay
{
    public class ZayAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "Zay";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.Routes.MapHttpRoute(
               name: AreaName + "_api",
               routeTemplate: "api/" + AreaName + "/{controller}/{action}/{id}",
               defaults: new { id = RouteParameter.Optional }
            );

            context.Routes.MapHttpRoute(
                name: AreaName + "_api_zayBuy",
                routeTemplate: "api/zayBuy/" + AreaName + "/{controller}/{action}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            context.Routes.MapHttpRoute(
                name: AreaName + "_api_zaySale",
                routeTemplate: "api/zaySale/" + AreaName + "/{controller}/{action}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            context.Routes.MapHttpRoute(
                name: AreaName + "_api_zay_birja",
                routeTemplate: "api/birja/" + AreaName + "/{controller}/{action}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            context.MapRoute(
                name: AreaName + "_lang",
                url: "{lang}/" + AreaName + "/{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                constraints: new { lang = Constants.RouteLang }
            );
            context.MapRoute(
                AreaName + "_default",
                AreaName + "/{controller}/{action}/{id}",
                new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );

            //все несистемные привязки
            BindAreaDI();
            RegisterBundles(BundleTable.Bundles);
        }

        private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<IZayParams>().To<ZayParams>();
            ninjectKernel.Bind<IMandatorySaleRepository>().To<MandatorySaleRepository>();
            ninjectKernel.Bind<ICurrencySightRepository>().To<CurrencySightRepository>();
            ninjectKernel.Bind<ICurrencyDictionary>().To<CurrencyDictionary>();
            ninjectKernel.Bind<ICurrencyOperations>().To<CurrencyOperations>();
        }

        private void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/" + AreaName + "/currencyBuy")
                .Include("~/Areas/" + AreaName + "/Scripts/CurrencyBuySighting/currencyBuySightCtrl.js")
                .Include("~/Areas/" + AreaName + "/Scripts/Utils/helper.js")
                .Include("~/Areas/" + AreaName + "/Scripts/Utils/visaCtrl.js")
            );

            bundles.Add(new ScriptBundle("~/bundles/" + AreaName + "/currencySale")
                .Include("~/Areas/" + AreaName + "/Scripts/CurrencySaleSighting/currencySaleSightCtrl.js")
                .Include("~/Areas/" + AreaName + "/Scripts/Utils/helper.js")
                .Include("~/Areas/" + AreaName + "/Scripts/Utils/visaCtrl.js")
            );

            bundles.Add(new ScriptBundle("~/bundles/" + AreaName + "/confirmZay")
                .Include("~/Areas/" + AreaName + "/Scripts/ConfirmPrimaryZay/confirmPrimaryZayCtrl.js")
                .Include("~/Areas/" + AreaName + "/Scripts/Utils/helper.js")
                .Include("~/Areas/" + AreaName + "/Scripts/Utils/visaCtrl.js")
            );

            bundles.Add(new StyleBundle("~/bundles/" + AreaName + "/styles")
                .Include("~/Areas/" + AreaName + "/Css/styles.css"));
        }
    }
}