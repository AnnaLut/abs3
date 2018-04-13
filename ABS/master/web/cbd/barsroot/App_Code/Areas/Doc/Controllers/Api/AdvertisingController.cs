using System;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using BarsWeb.Areas.Doc.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Doc.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.Doc.Controllers.Api
{
    /// <summary>
    /// Summary description for Advertising
    /// </summary>
    [AuthorizeApi]
    public class AdvertisingController : ApiController
    {
        private readonly IAdvertisingRepository _repository;
        private readonly IBankDatesRepository _bankDatesRepository;

        /*public AdvertisingController()
        {
            _repository = new AdvertisingRepository(new DocModel());
            _bankDatesRepository = new BankDatesRepository(new KernelModel());
        }*/
        public AdvertisingController(IAdvertisingRepository repository, IBankDatesRepository bankDatesRepository)
        {
            _repository = repository;
            _bankDatesRepository = bankDatesRepository;
        }
        public DataSourceResult Get(
                    [ModelBinder(typeof(WebApiDataSourceRequestModelBinder))]DataSourceRequest request,
                    bool showNotActive = false)
        {
            IQueryable<TicketsAdvertising> accounts = _repository.GetAllAdvertising()
                .Select(i=>new TicketsAdvertising
            {
                Id = i.Id,
                Name = i.Name,
                DateBegin = i.DateBegin,
                DateEnd = i.DateEnd,
                IsActive = i.IsActive,
                DataBodyHtml = null,
                DataBody = null,
                Description = i.Description,
                //UserId = i.UserId,
                //Branch = i.Branch,
                BranchList = i.BranchList,
                TransactionCodeList = i.TransactionCodeList,
                IsDefault = i.IsDefault,
                Kf = i.Kf,
                Width = i.Width,
                Height = i.Height
            });
            if (!showNotActive)
                accounts = accounts.Where(i => i.IsActive == "Y");
            return accounts.ToDataSourceResult(request);
        }

        public HttpResponseMessage Get(int id)
        {
            var advertising = _repository.GetAdvertising(id);
            if (advertising != null)
            {
                advertising.DataBody = null;
            }
            return Request.CreateResponse(HttpStatusCode.OK, advertising);
        }
        public HttpResponseMessage Put(TicketsAdvertising advertising)
        {
            if (advertising.Id == null)
            {
                return  Request.CreateResponse(HttpStatusCode.BadRequest, new { Message = "Параметр Id не може бути пустим" });
            }
            var baseAdv = _repository.GetAdvertising(Convert.ToInt32(advertising.Id));
            if (baseAdv == null)
            {
                return  Request.CreateResponse(HttpStatusCode.BadRequest, 
                    new { Message = String.Format("Не знайдено оголошення з порядковим номером {0}",advertising.Id) });
            }
            if (advertising.DateBegin >= advertising.DateEnd)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest,
                    new
                    {
                        Message = "Дата початку дії оголошення не може бути однаковою або більшою від дати закінчення."
                    });
            }
            if (advertising.IsActive != "N")
            {
                if (!string.IsNullOrEmpty(advertising.TransactionCodeList))
                {
                    var array = advertising.TransactionCodeList.Replace(" ", "").Split(',');
                    Array.Sort(array);
                    advertising.TransactionCodeList = string.Join(",", array);
                }

                var branchList = "";
                foreach (var item in advertising.BranchList)
                {
                    var valid = _repository.ValidateIsExistAdvertising(
                        advertising.Id,
                        advertising.DateBegin,
                        advertising.DateEnd,
                        item,
                        advertising.TransactionCodeList);
                    if (valid != null)
                    {
                        branchList += (string.IsNullOrEmpty(branchList) ? "" : ", ");
                        branchList += item + "(id: " + valid + ")";
                    }
                }

                if (!string.IsNullOrEmpty(branchList))
                {
                    const string text = @"Неможливо зберегти зміни, так як для відділеннь {0} 
                                            вже зареєстровано рекламне оголошення для операцій ""{1}"" на перод з {2} по {3}";

                    return Request.CreateResponse(HttpStatusCode.BadRequest,
                        new { Message = string.Format(
                                                        text, 
                                                        branchList,
                                                        advertising.TransactionCodeList,
                                                        advertising.DateBegin, 
                                                        advertising.DateEnd) 
                        });
                }

            }

            if (!String.IsNullOrEmpty(advertising.DataBodyHtml))
            {
                advertising.DataBodyHtml = HttpUtility.HtmlDecode(advertising.DataBodyHtml);
                advertising.DataBody = ConvertHtmlToImage(advertising.DataBodyHtml);
            }
            else
            {
                advertising.DataBody = baseAdv.DataBody;
            }

            _repository.EditAdvertising(advertising);

            return Request.CreateResponse(HttpStatusCode.OK, new { Message = "" });
        }

        public HttpResponseMessage Post(TicketsAdvertising advertising)
        {
            if (!string.IsNullOrEmpty(advertising.TransactionCodeList))
            {
                var array = advertising.TransactionCodeList.Replace(" ", "").Split(',');
                Array.Sort(array);
                advertising.TransactionCodeList = string.Join(",", array);
            }

            var bDate = _bankDatesRepository.GetBankDate();
            if (advertising.DateBegin < bDate)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest,
                    new
                    {
                        Message = string.Format("Дата початку дії оголошення менше банківської {0}.",
                                                bDate.ToShortTimeString())
                    });
            }
            if (advertising.DateBegin >= advertising.DateEnd)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest,
                    new
                    {
                        Message = "Дата початку дії оголошення не може бути однаковою або більшою від дати закінчення."
                    });
            }
            var branchList = "";
            foreach (var item in advertising.BranchList)
            {
                var valid = _repository.ValidateIsExistAdvertising(
                    advertising.Id,
                    advertising.DateBegin,
                    advertising.DateEnd,
                    item,
                    advertising.TransactionCodeList);
                if (valid != null)
                {
                    branchList += (string.IsNullOrEmpty(branchList) ? "" : ", ");
                    branchList += item + "(id: " + valid + ")";
                }
            }

            if (!string.IsNullOrEmpty(branchList))
            {
                const string text = @"Неможливо зберегти зміни, так як для відділеннь {0} 
                                            вже зареєстровано рекламне оголошення для операцій ""{1}"" на перод з {2} по {3}";

                return Request.CreateResponse(HttpStatusCode.BadRequest,
                    new
                    {
                        Message = string.Format(
                                                  text,
                                                  branchList,
                                                  advertising.TransactionCodeList,
                                                  advertising.DateBegin,
                                                  advertising.DateEnd)
                    });
            }


            /*var baseAdvt = _repository.GetAllAdvertising().Where(i => /*i.Branch == advertising.Branch 
                                                                      &&* / i.DateBegin >= advertising.DateBegin
                                                                      && i.DateEnd <= advertising.DateEnd
                                                                      && i.IsActive == "Y"
                                                                      && i.TransactionCodeList == advertising.TransactionCodeList);
            if (baseAdvt.Count() != 0)
            {
                const string text = @"Для відділення {0} вже зареєстровано 
                                        реклемне оголошення для операцій ""{1}"" на перод з {2} по {3} ({4})";
                string baseAdvtIdList = "";
                var count = 0;
                foreach (var item in baseAdvt)
                {
                    if (count != 0)
                    {
                        baseAdvtIdList += ", ";
                    }
                    baseAdvtIdList += item.Id;
                    count++;
                }
                return Request.CreateResponse(HttpStatusCode.BadRequest, 
                    new { Message = string.Format(
                                                    text,
                                                    "", //advertising.Branch,
                                                    advertising.TransactionCodeList,
                                                    advertising.DateBegin,
                                                    advertising.DateEnd,
                                                    baseAdvtIdList)
                    });
            }*/

            if (!String.IsNullOrEmpty(advertising.DataBodyHtml))
            {
                advertising.DataBodyHtml = HttpUtility.HtmlDecode(advertising.DataBodyHtml);
                advertising.DataBody = ConvertHtmlToImage(advertising.DataBodyHtml);                
            }

            var id = _repository.AddAdvertising(advertising);
            return Request.CreateResponse(HttpStatusCode.OK, new { Message = "", Id=id});
        }
        public HttpResponseMessage Delete(int id)
        {
            _repository.DeleteAdvertising(id);
            return Request.CreateResponse(HttpStatusCode.OK);
        }

        private byte[] ConvertHtmlToImage(string html)
        {
           byte[] result;
            /* var obj = new WebsitesScreenshot.WebsitesScreenshot();
            var imgResult = obj.CaptureHTML(html);//.CaptureWebpage("www.google.com");
            if (imgResult == WebsitesScreenshot.WebsitesScreenshot.Result.Captured)
            {
                try
                {
                    //obj.ImageWidth = 200;
                    //obj.ImageHeight = 300;
                    obj.ImageFormat = WebsitesScreenshot.WebsitesScreenshot.ImageFormats.PNG;
                    var img = obj.GetImage();

                    var converter = new ImageConverter();
                    result = (byte[]) converter.ConvertTo(img, typeof (byte[]));
                }
                finally 
                {
                    obj.Dispose();
                }
                //_Obj.SaveImage("d:\\Amazon.png");
            }*/


            using (var ms = new MemoryStream())
            {
                using (Image image = TheArtOfDev.HtmlRenderer.WinForms.HtmlRender.RenderToImage(html))
                {
                    image.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                    result = ms.ToArray();
                }
            }
            
            return result;
        }

    }
}