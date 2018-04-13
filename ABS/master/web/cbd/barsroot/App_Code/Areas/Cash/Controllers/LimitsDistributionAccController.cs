using System.IO;
using System.Web;
using System.Web.Mvc;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center;
using BarsWeb.Controllers;

namespace BarsWeb.Areas.Cash.Controllers
{
    /// <summary>
    /// Розподіл лімітів
    /// </summary>
    [AuthorizeUser]
    public class LimitsDistributionAccController : ApplicationController
    {
        private readonly ILimitRepository _limitRepository;
        private readonly IMfoRepository _mfoRepository;

        public LimitsDistributionAccController(ILimitRepository limitRepository, IMfoRepository mfoRepository)
        {
            _limitRepository = limitRepository;
            _mfoRepository = mfoRepository;
        }

        /// <summary>
        /// Головна форма
        /// </summary>
        /// <returns></returns>
        public ViewResult Index()
        {
            return View();
        }
        [HttpGet]
        public ActionResult FileUpload(string date)
        {
            return View(model:date);
        }
        [HttpPost]
        public ActionResult FileUpload(HttpPostedFileBase file, string date)
        {
            if (file.InputStream != null)
            {
                /*var adversiting = _repository.GetAdvertising(id);
                if (adversiting != null)
                {
                    byte[] fileData;
                    using (var binaryReader = new BinaryReader(file.InputStream))
                    {
                        fileData = binaryReader.ReadBytes(file.ContentLength);
                    }
                    adversiting.DataBody = fileData;
                    adversiting.DataBodyHtml = null;
                    _repository.EditAdvertising(adversiting);
                }*/
            }
            return View();
        }
    }
}