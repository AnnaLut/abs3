﻿using System.Web.Mvc;
using BarsWeb.Areas.AccpReport.Infrastructure.DI.Abstract;
using BarsWeb.Areas.AccpReport.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.AccpReport.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Areas.AccpReport.Infrastucture.DI.Implementation;

using BarsWeb.Infrastructure;
using BarsWeb.Infrastructure.Repository;

namespace BarsWeb.Areas.AccpReport
{
    public class AccpReportAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "AccpReport";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {         
            context.MapRoute(
                name: AreaName + "_lang",
                url: "{lang}/"+AreaName+"/{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                constraints: new { lang = Constants.RouteLang }
            );
            context.MapRoute(
                AreaName + "_default",
                AreaName+"/{controller}/{action}/{id}",
                new {controller = "Home", action = "Index", id = UrlParameter.Optional }
            );

            //все несистемные привязки
            BindAreaDI();
        }

        private void BindAreaDI()
        {
            var controllerFactory = ((NinjectControllerFactory)ControllerBuilder.Current.GetControllerFactory());
            var ninjectKernel = controllerFactory.NinjectKernel;
            ninjectKernel.Bind<IAccpReportModel>().To<AccpReportModel>();
            ninjectKernel.Bind<IAccpReportRepository>().To<AccpReportRepository>();
        }
    }
}