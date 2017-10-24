using System;
using System.Web;
using BarsWeb.Areas.Crkr.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Crkr.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using Bars.Classes;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.Ndi.Infrastructure;
using Dapper;

namespace BarsWeb.Areas.Crkr.Controllers.Api
{
    
    [AuthorizeApi]
    public class GetProfileController : ApiController
    {
        private readonly IDoposProfileRepository _repository;
        private readonly IKendoRequestTransformer _requestTransformer;
        private readonly ICrkrProfileRepository _crkrProfile;
        public GetProfileController(IDoposProfileRepository repository, IKendoRequestTransformer requestTransformer, ICrkrProfileRepository crkrProfile)
        {
            _repository = repository;
            _requestTransformer = requestTransformer;
            _crkrProfile = crkrProfile;
        }

        [HttpPost]
        [POST("api/crkr/getprofile/gethistory")]
        public HttpResponseMessage GetHistory(decimal Id)
        {
            var history = _repository.GetHistories(Id);
            return Request.CreateResponse(HttpStatusCode.OK, new { Data = history, Total = history.Count });
        }

        [HttpPost]
        [POST("api/crkr/getprofile/gettrustedperson")]
        public HttpResponseMessage GetTrustedPerson(decimal Id)
        {
            var persons = _repository.GetTrustedPersons(Id);
            return Request.CreateResponse(HttpStatusCode.OK, new { Data = persons, Total = persons.Count });
            //return Request.CreateResponse(HttpStatusCode.OK, persons);
        }

        [HttpPost]
        [POST("api/crkr/getprofile/getheirsperson")]
        public HttpResponseMessage GetHeirsPerson(decimal Id)
        {
            var persons = _repository.GetHeirsPersons(Id);
            return Request.CreateResponse(HttpStatusCode.OK, new { Data = persons, Total = persons.Count });
            //return Request.CreateResponse(HttpStatusCode.OK, persons);
        }

        [HttpGet]
        public HttpResponseMessage GetData(string rnk)
        {
            if(!string.IsNullOrEmpty(rnk))
                return Request.CreateResponse(HttpStatusCode.OK, _repository.ClientInfo(rnk));
            return Request.CreateResponse(HttpStatusCode.NotFound, "RNK = null");
        }

        [HttpPost]
        public HttpResponseMessage GetCrkrBag([ModelBinder(typeof(WebApiDataSourceRequestModelBinder))] DataSourceRequest request, CrkrBag model)
        {
            try
            {
                var requestTrans = _requestTransformer.MultiplyFilterValue(request, new[] {"s"});
                var profiles = _crkrProfile.GetProfiles(model, requestTrans);
                if (profiles == null)
                    return Request.CreateResponse(HttpStatusCode.OK);
                var result = profiles.ToDataSourceResult(request);
                return Request.CreateResponse(HttpStatusCode.OK, result);
            }
            catch (HttpException ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, ex.Message);
            }
        }
    }
}