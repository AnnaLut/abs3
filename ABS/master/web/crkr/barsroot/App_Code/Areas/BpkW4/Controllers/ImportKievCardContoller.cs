using System;
using System.Web.Mvc;
using BarsWeb.Models;
using BarsWeb.Controllers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System.Web;
using System.IO;
using BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.BpkW4.Models;
using System.Linq;
using System.Collections.Generic;
using System.Text;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using ICSharpCode.SharpZipLib.Core;
using ICSharpCode.SharpZipLib.Zip;


namespace BarsWeb.Areas.BpkW4.Controllers
{

    [AuthorizeUser]
    //[CheckAccessPage]
    public class ImportKievCardController : ApplicationController
    {
        private readonly IKievCardRepository _repository;
        private readonly IBranchesRepository _branches;
        private void ExtractZipFile(string archiveFilenameIn, string password, string outFolder)
        {
            ZipFile zf = null;
            ZipConstants.DefaultCodePage = 866;
            
            try
            {
                FileStream fs = System.IO.File.OpenRead(archiveFilenameIn);
                zf = new ZipFile(fs);
                if (!String.IsNullOrEmpty(password))
                {
                    zf.Password = password;     
                }
                foreach (ZipEntry zipEntry in zf)
                {
                    if (!zipEntry.IsFile)
                    {
                        continue;          
                    }
                    
                    String entryFileName = zipEntry.Name;
                   
                    byte[] buffer = new byte[4096];    
                    Stream zipStream = zf.GetInputStream(zipEntry);
                  
                    String fullZipToPath = Path.Combine(outFolder, entryFileName);
                    string directoryName = Path.GetDirectoryName(fullZipToPath);
                    if (directoryName.Length > 0)
                        Directory.CreateDirectory(directoryName);
                   
                    using (FileStream streamWriter = System.IO.File.Create(fullZipToPath))
                    {
                        StreamUtils.Copy(zipStream, streamWriter, buffer);
                    }
                }
            }
            finally
            {
                if (zf != null)
                {
                    zf.IsStreamOwner = true; // Makes close also shut the underlying stream
                    zf.Close(); // Ensure we release resources
                }
            }
        }
        public ImportKievCardController(IKievCardRepository repository, IBranchesRepository branches)
        {
            _repository = repository;
            _branches = branches;
        }
        public ActionResult Index()
        {
            return View();
        }


        [HttpPost]
        public ActionResult Upload(HttpPostedFileBase file)
        {
            if (file != null && file.ContentLength > 0) 
            {       
                string fileName = Path.GetFileName(file.FileName);
                string path = Path.Combine(Path.GetTempPath(), fileName);
                string extractPath = Path.Combine(Path.GetTempPath(), Path.GetRandomFileName());
                file.SaveAs(path);

                ExtractZipFile(path, "", extractPath);
                
                decimal id = _repository.ImportKievCardProjects(extractPath);
                List<KievCardImported> list = _repository.GetImportedProjects(id).ToList();
                ViewBag.FileId = id;
                return View(list);
            }
            else throw new Exception("Файл не вибрано");
        }

        [HttpPost]
        public ActionResult ProcessParameters(string branch, string executor, string projectGroup, string project, string cardType)
        {
            return View();
        }

        public ActionResult GetAllBranches([DataSourceRequest] DataSourceRequest request)
        {
            return Json(_branches.GetAllBranches().ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetStaff([DataSourceRequest] DataSourceRequest request, string branch)
        {
            return Json(_repository.GetStaff(branch).ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetGroups([DataSourceRequest] DataSourceRequest request, string branch)
        {
            return Json(_repository.GetGroups().ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetProducts([DataSourceRequest] DataSourceRequest request, string prodGrp)
        {
            if (prodGrp == "SALARY")
            {
                var result = _repository.GetSalaryProducts(prodGrp).Select(p => new
                {
                    CODE = p.PRODUCT_CODE,
                    NAME = p.NAME,
                    ID = p.ID,
                    OKPO = p.OKPO
                });
                return Json(result.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
            }
            else
            {
                var result = _repository.GetOtherProducts(prodGrp).Select(p => new
                {
                    CODE = p.CODE,
                    NAME = p.NAME
                });
                return Json(result.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult GetCards([DataSourceRequest] DataSourceRequest request, string product)
        {
            return Json(_repository.GetCards(product).ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        public ActionResult AcceptFile(PackageParams fileParams)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                var ticket = _repository.SaveFile(fileParams);
                result.data = ticket;
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet); 
        }

        public ActionResult GetSalaryData([DataSourceRequest] DataSourceRequest request, decimal fileId)
        {
            var result = _repository.GetSalaryData(fileId, request);
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult GetReceipt(string fileName, string body)
        {
            return File(Encoding.UTF8.GetBytes(body), "text/plain", fileName);
        } 
    }
}