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
    /// <summary>
    /// Advertising on tickets
    /// </summary>
    [AuthorizeUser]
    [CompressFilter]
    //[Authorize]
    //[CheckAccessPage]
    public class AdvertisingController : ApplicationController
    {
        private readonly IAdvertisingRepository _repository;
        public AdvertisingController(IAdvertisingRepository repository)
        {
            _repository = repository;
        }
        /// <summary>
        /// перегляд рахунків
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            return View();
        }
        /// <summary>
        /// view Advertising list 
        /// </summary>
        /// <param name="request">параметри запроса гріда</param>
        /// <returns>JSON</returns>
        public ActionResult GridData([DataSourceRequest] DataSourceRequest request)
        {
            var accounts = _repository.GetAllAdvertising();
            return Json(accounts.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// детальна інформація
        /// </summary>
        /// <param name="id">acc рахунку</param>
        /// <returns></returns>
        public ActionResult Detail(int id)
        {
            return View();
        }

        public ActionResult Edit(int id)
        {
            return View();
        }

        public ActionResult ImageEditor()
        {
            return View();
        }
        /*public ActionResult GetBankDate()
        {
            var date = _repository.GetBankDate();
            return Json(new{Data = date},JsonRequestBehavior.AllowGet);
        }*/
        public ActionResult Image(int id)
        {
            var adversiting = _repository.GetAdvertising(id);
            if (adversiting != null && adversiting.DataBody != null)
            {
                return File(adversiting.DataBody.ToArray(), "image/png");
            }

            var image = new Bitmap(1, 1);
            MemoryStream ms = new MemoryStream();
            image.Save(ms,ImageFormat.Png);
            return File(ms.ToArray(), "image/png");
        }
        public ActionResult FileUpload(int id)
        {
            return View(model:id);
        }
        [HttpPost]
        public ActionResult FileUpload(HttpPostedFileBase file, int id)
        {
            if (file.InputStream != null)
            {
                var adversiting = _repository.GetAdvertising(id);
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
                }
            }
            return View(model:id);
        }

        /*private string CreateBase64Image(MemoryStream fileStream)
        {
            Image streamImage = System.Drawing.Image.FromStream(fileStream);
            using (MemoryStream ms = new MemoryStream())
            {
                // Convert this image back to a base64 string 
                streamImage.Save(ms, ImageFormat.Png);
                return Convert.ToBase64String(ms.ToArray());
            }
        }*/
    }
}