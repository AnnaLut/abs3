using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Collections.Generic;
using AttributeRouting.Web.Http;
using BarsWeb.Areas.WayKlb.Infrastructure.DI.Abstract;
using BarsWeb.Areas.WayKlb.Infrastructure.DI.Implementation;
using BarsWeb.Areas.WayKlb.Models;
using Newtonsoft.Json.Linq;

namespace BarsWeb.Areas.WayKlb.Controllers.Api
{
    public class IntgKlbController : ApiController
    {
        private readonly IIntgKlbRepository _repo;
        
        public IntgKlbController()
        {
            _repo = new IntgKlbRepository();
        }

        [HttpGet]
        [GET("/api/WayKlb/IntgKlb/deposits")]
        public HttpResponseMessage deposits(string abs_id, decimal? id)
        {
            List<Product> product = new List<Product>();
            Product p = new Product();
            if (id == null)
            {
                product = _repo.GetProductList();
            }
            else
            {
                p = _repo.GetProductById((decimal)id);
                //product.Add(p);
            }
            

            if (product.Count > 0)
            {
                JArray arrJson = new JArray();
                for (var i = 0; i < product.Count; i++)
                {
                    JObject json = JObject.Parse(product[i].JSON);
                    arrJson.Add(json);
                }
                return Request.CreateResponse(HttpStatusCode.OK, arrJson);
            }
            else if (!String.IsNullOrEmpty(p.JSON))
            {
                JObject json = JObject.Parse(p.JSON);
                return Request.CreateResponse(HttpStatusCode.OK, json);
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.NotFound);
            }
        }
    }
}