using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BarsWeb.Areas.Doc.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Doc.Controllers
{
    [CheckAccessPage]
    [Authorize]
    public class AdditionalReqvController : ApplicationController
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}