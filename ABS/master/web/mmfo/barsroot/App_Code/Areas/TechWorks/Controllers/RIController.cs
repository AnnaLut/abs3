using System.Web.Mvc;
using BarsWeb.Controllers;
using System.Web;
using System.IO;
using Oracle.DataAccess.Client;
using System;
using Bars.Classes;
using System.Text;
using System.Data;
using BarsWeb.Areas.TechWorks.Infrastructure;
using BarsWeb.Areas.TechWorks.Models;

namespace BarsWeb.Areas.TechWorks.Controllers
{
    [Authorize]
    [CheckAccessPage]
    public class RiController : ApplicationController
    {        
        public ActionResult Index(string result, string fileName)
        {
            if (!string.IsNullOrEmpty(result))
            {
                ViewBag.Result = result;                
            }
            if (!string.IsNullOrEmpty(fileName))
            {
                ViewBag.FileName = fileName;
            }
            return View();
        }
        public ActionResult RecieveInsidersRegFile(HttpPostedFileBase upload)
        {
            if (upload == null || upload.InputStream == null)
            {
                return RedirectToAction("Index");
            }
            try
            {                
                var fileInfo = new FileManager().FileProcess(upload.FileName, upload.InputStream);                
                return RedirectToAction("Index", new { result = "Результат обробки файлу: "+fileInfo.FileMessage, fileName = fileInfo.FileName});                
            }
            catch (Exception ex)
            {
                return RedirectToAction("Index", new { result = ex.Message });
            }
        }

        public ActionResult GetReceiptFile(string fileName)
        {
            try
            {
                var fileManager = new FileManager();
                Stream stream = new MemoryStream(Encoding.GetEncoding("windows-1251").GetBytes(fileManager.GetReceiptFile()));
                return File(stream, Path.GetExtension(fileName), fileName);
            }
            catch (Exception ex)
            {
                return RedirectToAction("Index", new { result ="Не вдалося отримати файл квитанцію " + ex.Message });
            }
        }
    }
}