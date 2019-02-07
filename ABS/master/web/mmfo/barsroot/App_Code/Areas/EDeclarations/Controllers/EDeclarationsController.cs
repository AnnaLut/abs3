using Areas.EDeclarations.Models;
using BarsWeb.Areas.EDeclarations.Infrastructure.DI.Abstract;
using BarsWeb.Areas.EDeclarations.Infrastructure.DI.Implementation;
using BarsWeb.Areas.FastReport.Helpers;
using BarsWeb.Areas.FastReport.Models;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Controllers;
using Newtonsoft.Json;
using System;
using System.Linq;
using System.Web.Mvc;

namespace BarsWeb.Areas.EDeclarations.Controllers
{
    [AuthorizeUser]
    public class EDeclarationsController : ApplicationController
    {
        readonly IEDeclarationsRepository _repo;
        public EDeclarationsController(IEDeclarationsRepository repo)
        {
            this._repo = repo;
        }
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Create()
        {
            return View();
        }

        public ActionResult Clients(string req)
        {
            EDeclViewModel model = JsonConvert.DeserializeObject<EDeclViewModel>(req);

            if (model.Inn != null && model.Inn.Length > 0)
            {
                BarsSql sql = SqlCreator.GetClientsByInn(model.Inn);
                var data = _repo.ExecuteStoreQuery<ClientViewModel>(sql);
                ClientSearchResultModel result = new ClientSearchResultModel
                {
                    Clients = data.ToList(),
                    DateFrom = model.DateFrom,
                    DateTo = model.DateTo,
                };
                return View(result);
            }
            else
            {
                BarsSql sql = SqlCreator.GetClientsByData(model);
                var data = _repo.ExecuteStoreQuery<ClientViewModel>(sql);
                ClientSearchResultModel result = new ClientSearchResultModel
                {
                    Clients = data.ToList(),
                    DateFrom = model.DateFrom,
                    DateTo = model.DateTo,
                };
                return View(result);
            }
        }

        //[HttpPost]
        public ActionResult DownloadDeclaration(String id)
        {
            FrxDocHelper helper = new FrxDocHelper(new FastReportModel
            {
                ResponseFileType = FrxExportTypes.Pdf,
                FileName = "EDECL_FR_OSHAD.frx",
                Parameters = new FrxParameters
                {
                    new FrxParameter("p_decl_id", TypeCode.Int32, id)
                }
            });
            //BarsSql sql = SqlCreator.GetPdfInBase64Sql(id);
            //Byte[] bytes = _repo.GetDeclarationFile(sql);
            Byte[] bytes = helper.GetFileInByteArray();
            if (bytes.Length == 0)
                return File(bytes, System.Net.Mime.MediaTypeNames.Application.Octet, "empty.pdf");
            return File(bytes, System.Net.Mime.MediaTypeNames.Application.Octet, String.Format("declaration_{0}.pdf",id));
        }
    }
}
