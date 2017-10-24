using System;
using System.Globalization;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Areas.BaseRates.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;
using clientregister;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System.Web;
using System.IO;
using Oracle.DataAccess.Client;
using System.Data;
using Oracle.DataAccess.Types;
using Bars.Classes;
using System.Text;
using System.Net.Http;
using System.Net;
using Dapper;
using System.Xml;

namespace BarsWeb.Areas.BaseRates.Controllers
{
    [AuthorizeUser]
    [CheckAccessPage]
    public class BaseRatesController : ApplicationController
    {
		IBaseRatesRepository _repository;
		public BaseRatesController(IBaseRatesRepository repository)
		{
			_repository = repository;
		}
		public ActionResult Index()
        {
            return View();
        }

        public ActionResult InterestRate()
        {
            return View();
        }
    }
}