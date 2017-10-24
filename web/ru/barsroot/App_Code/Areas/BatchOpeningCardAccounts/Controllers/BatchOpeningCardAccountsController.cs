using BarsWeb.Areas.BatchOpeningCardAccounts.Infrastructure.DI.Abstract;
using BarsWeb.Areas.BatchOpeningCardAccounts.Infrastructure.DI.Implementation;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Controllers;
using System;
using System.Web.Mvc;

namespace BarsWeb.Areas.BatchOpeningCardAccounts.Controllers
{
    [AuthorizeUser]
    public class BatchOpeningCardAccountsController : ApplicationController
    {
        readonly IBatchOpeningCardAccountsRepository _repo;

        public BatchOpeningCardAccountsController(IBatchOpeningCardAccountsRepository repo)
        {
            _repo = repo;
        }

        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult UploadPublicFiguresFile(System.Web.HttpPostedFileBase upload)
        {
            if (upload == null || upload.InputStream == null)
            {
                ViewBag.LoadFileStatus = "Файл пустий";
                return View("Index");
            }

            byte[] p_filebody;
            try
            {
                p_filebody = new byte[upload.InputStream.Length];
                long data = upload.InputStream.Read(p_filebody, 0, (int)upload.InputStream.Length);
                upload.InputStream.Close();

                int p_filetype = int.Parse(Request.Form.Get("filetype"));
                string p_filename = System.IO.Path.GetFileName(upload.FileName);
                BarsSql sql = SqlCreator.LoadFile(p_filename, p_filebody, p_filetype);
                _repo.ExecuteStoreCommand(sql.SqlText, sql.SqlParams);
            }
            catch (Exception ex)
            {
                ViewBag.LoadFileStatus = ex.Message;
                return View("Index");
            }
            finally
            {
                p_filebody = null;
            }
            ViewBag.LoadFileStatus = "OK";
            return View("Index");
        }
    }
}
