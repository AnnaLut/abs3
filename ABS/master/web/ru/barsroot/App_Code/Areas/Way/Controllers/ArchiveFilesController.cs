using BarsWeb.Areas.Way.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Way.Models;
using BarsWeb.Controllers;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace BarsWeb.Areas.Way.Controllers
{
    public class ArchiveFilesController: ApplicationController
    {
        private readonly IWayRepository _repository;
        public ArchiveFilesController(IWayRepository repository)
        {
            _repository = repository;
        }
        public ActionResult ArchiveFiles()
        {
            return View();
        }
        public FileResult LoadFile(decimal? fileid)
        {
            TicketInfo ticketInfo = _repository.DoFormSalaryTicket(fileid);
            if (ticketInfo.Error != null)
            {
                throw new Exception(ticketInfo.Error);
            }
            string file_clob = _repository.GetFileData(ticketInfo.ID);
            var browserInformation = Request.Browser;
            var byteArray = Encoding.GetEncoding(1251).GetBytes(file_clob);
            var stream = new MemoryStream(byteArray);
            return File(stream, "application/octet-stream", ticketInfo.TicketName);
        }
    }
}