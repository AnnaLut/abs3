using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ModelBinding;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using BarsWeb.Infrastructure.Repository.DI.Abstract;
using AttributeRouting.Web.Http;
using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.Kernel.Controllers.Api
{
    [AuthorizeApi]
    public class HeaderBranchesController : ApiController
    {
        private IHomeRepository _homeRpository;
        public HeaderBranchesController(IHomeRepository homeRpository)
        {
            _homeRpository = homeRpository;
        }

        [HttpGet]
        [GET("api/kernel/headerbranches/get")]
        public HttpResponseMessage Get()
        {
            try
            {
                var data = _homeRpository.CurrentBranch();
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data);
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpGet]
        [GET("api/kernel/headerbranches/get")]
        public HttpResponseMessage Get(string id)
        {
            try
            {
                //We should get branch tree, showing Regional names only for "/XXXXXX/" level 
                // only if user works in "/" or "/XXXXXX/" level
                var currentUserBranch = _homeRpository.CurrentBranch();
                // for branches of "/" and of "/XXXXXX/" level:
                int currentBranchSegmentsLength = currentUserBranch.BRANCH.Split('/').Length;
                bool showRegionalNames = (currentBranchSegmentsLength == 2 || currentBranchSegmentsLength == 3);

                var data = _homeRpository.UsersBranches(id);
                foreach (var branch in data)
                {

                    int branchSegmentsLength = branch.BRANCH.Split('/').Length;
                    if (branchSegmentsLength == 3 && showRegionalNames)
                    {
                        branch.SHOW_REGIONAL_NAME = true;
                    }
                    else
                        branch.SHOW_REGIONAL_NAME = false;
                }

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK, data);
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public HttpResponseMessage Post(BranchPostRequest item)
        {
            try
            {
                _homeRpository.ChangeBranch(item.branch);
                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.OK);
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
    }
}

public class BranchPostRequest
{
    public string branch { get; set; }
}