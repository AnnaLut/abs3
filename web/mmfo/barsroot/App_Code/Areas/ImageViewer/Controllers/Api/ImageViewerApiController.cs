using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.ImageViewer.Infrastructure.DI.Abstract;
using BarsWeb.Areas.ImageViewer.Infrastructure.DI.Implementation;
using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Binders.Api;
using System.Collections.Generic;
using Areas.ImageViewer.Models;

namespace BarsWeb.Areas.ImageViewer.Controllers.Api
{
    public class ImageViewerController: ApiController
    {
        readonly IImageViewerRepository _repo;
        public ImageViewerController(IImageViewerRepository repo) { _repo = repo; }

	    [HttpGet]
        public HttpResponseMessage SearchMain([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, string type_img, string date_img_start, string date_img_end)
        {
            try
            {
                ImageViewerRequest obj = new ImageViewerRequest { DATE_IMG_START = date_img_start, DATE_IMG_END = date_img_end, TYPE_IMG = type_img };
                BarsSql sql = SqlCreator.SearchMain(obj);

                var data = _repo.SearchGlobal<ImageViewerResponse>(request, sql);
                decimal dataCount = _repo.CountGlobal(request, sql);

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = data, Total = dataCount });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpPost]
        public HttpResponseMessage GetPhoto(ImageViewerPhotoRequest obj)
        {
            try
            {
                if (string.IsNullOrEmpty(obj.rnk) || string.IsNullOrEmpty(obj.image_type))
                {
                    return Request.CreateResponse(HttpStatusCode.InternalServerError, "РНК клієнта, або тип фото пусте.");
                }
                decimal rnk = decimal.Parse(obj.rnk);
                string data = GetPhotoFromDb(rnk, obj.image_type);
                return Request.CreateResponse(HttpStatusCode.OK, new { Data = data });
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        [HttpGet]
        public HttpResponseMessage ImageViewerTypes()
        {
            try
            {
                BarsSql sql = SqlCreator.GetImagesTypes();
                IEnumerable<CUSTOMER_IMAGE_TYPES> data = _repo.ExecuteStoreQuery<CUSTOMER_IMAGE_TYPES>(sql);

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, new { Data = data });
                return response;
            }
            catch (Exception ex)
            {
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
                return response;
            }
        }

        string GetPhotoFromDb(decimal rnk, string image_type)
        {
            var currentPhoto = Tools.get_cliet_picture(rnk, image_type);
            if (currentPhoto != null && currentPhoto.Length > 0)
            {
                return "data:image/jpg;base64," + Convert.ToBase64String(currentPhoto);
            }
            return "";
        }
    }
}
