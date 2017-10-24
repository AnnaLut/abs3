using BarsWeb.Areas.DptAdm.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.DptAdm.Models;
using BarsWeb.Controllers;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Formatters.Binary;
using System.Web;
using System.Web.Mvc;

/// <summary>
/// Summary description for EditFinesDFOController
/// </summary>
/// 

namespace BarsWeb.Areas.DptAdm.Controllers
{
    public class grid
    {
        public string data { get; set; }
    }

    [AuthorizeUser]
    public class EditFinesDFOController : ApplicationController
    {
        private readonly IEditFinesDFORepository _repository;

        public EditFinesDFOController(IEditFinesDFORepository repository)
        {
            _repository = repository;
        }

        public ActionResult EditFinesDFO(int read_only, string mod_cod) {
            ViewBag.read_only =read_only;
            ViewBag.mod_cod = mod_cod;
            return View();
        }

        [HttpPost]
        public FileResult ExcelExport(string contentType, string base64, string fileName)
        {
            /*var listGrid = grid.data;

            return File(GetBytes(listGrid), "application/vnd.ms-excel", "ex.xls");*/
            var fileContents = Convert.FromBase64String(base64);

            return File(fileContents, contentType, fileName);
        }

        static byte[] GetBytes(string str)
        {
            byte[] bytes = new byte[str.Length * sizeof(char)];
            System.Buffer.BlockCopy(str.ToCharArray(), 0, bytes, 0, bytes.Length);
            return bytes;
        }
    }
}