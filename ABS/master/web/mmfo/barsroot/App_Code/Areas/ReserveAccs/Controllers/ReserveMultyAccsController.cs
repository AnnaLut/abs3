using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BarsWeb.Controllers;

/// <summary>
/// Summary description for Class1
/// </summary>
/// 
namespace BarsWeb.Areas.ReserveAccs
{
	public class ReserveMultyAccsController : ApplicationController
	{
		[Authorize]
		public ActionResult Index(int rnk, decimal nls)
		{
			ViewBag.rnk = rnk;
			ViewBag.nls = nls;
			return View();
		}
	}
}