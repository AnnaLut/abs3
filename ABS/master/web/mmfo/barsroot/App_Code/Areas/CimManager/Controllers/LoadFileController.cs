using System;
using System.IO;
using System.Web.Mvc;

namespace BarsWeb.Areas.CimManager.Controllers
{
	/// <summary>
	/// load frx file
	/// </summary>
	public class LoadFileController : Controller
	{
		public ActionResult ExportDoc(decimal? rf)
		{
			const string payTemplateName = "payment_message.frx";

			string templatePath = FrxDoc.GetTemplatePathByFileName(payTemplateName);
			FrxParameters pars = new FrxParameters
				{
					new FrxParameter("p_ref", TypeCode.Decimal, rf)
				};
			FrxDoc doc = new FrxDoc(templatePath, pars, null);
			using (var str = new MemoryStream())
			{
				var name = "payment_{0}_message.doc";
				doc.ExportToMemoryStream(FrxExportTypes.Word2007, str);
				return File(str.ToArray(), "application/msword", string.Format(name, rf));
			}
		}
	}
}