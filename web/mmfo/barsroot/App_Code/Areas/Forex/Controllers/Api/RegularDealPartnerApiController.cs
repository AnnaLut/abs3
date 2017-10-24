using BarsWeb.Areas.Forex.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Forex.Models;
using System;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web.Http;

/// <summary>
/// Summary description for RegularDealPartnerApiController
/// </summary>
public class RegularDealPartnerApiController : ApiController
{

    private readonly IRegularDealsRepository _repo;

    public RegularDealPartnerApiController(IRegularDealsRepository repo)
    {
        _repo = repo;
    }

    public HttpResponseMessage Post(FOREX_ALIEN partner)
    {
        try
        {
            _repo.SaveGhangesPartners(partner);

            return new HttpResponseMessage()
            {                
                StatusCode = HttpStatusCode.OK
            };
            
        }
        catch (Exception ex)
        {
            return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
        }
    }

    
}