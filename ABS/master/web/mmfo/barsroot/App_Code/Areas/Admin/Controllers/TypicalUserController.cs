using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using Areas.Admin.Models;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Controllers;
using Kendo.Mvc.UI;
using BarsWeb.Areas.Admin.Models;
using System;
using Newtonsoft.Json;

namespace BarsWeb.Areas.Admin.Controllers
{
    public class TypicalUserController : ApplicationController
    {
        private readonly ITypicalUserRepository _typicalRepo;
        private readonly IADMURepository _admuRepo;
        public TypicalUserController(ITypicalUserRepository typicalRepo, IADMURepository admuRepo)
        {
            _typicalRepo = typicalRepo;
            _admuRepo = admuRepo;
        }
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetTypicalUsersData([DataSourceRequest] DataSourceRequest request)
        {
            IEnumerable<STAFF_TIPS> data = _typicalRepo.TypicalUser(request);
            var dataCount = _typicalRepo.CountTypicalUser(request);
            return Json(new { Data = data, Total = dataCount}, JsonRequestBehavior.AllowGet);
        }

        public ActionResult BranchData(decimal? branchId)
        {
            IEnumerable<Branch> result;
            List<Branch> bList = new List<Branch>();
            bList.Add(new Branch() { BranchId = 1, BranchName = "/", HasSubBranch = true });
            bList.Add(new Branch() { BranchId = 2, BranchName = "302076", HasSubBranch = true, SubBranchId = 1 });
            bList.Add(new Branch() { BranchId = 3, BranchName = "/302076/302003", HasSubBranch = false, SubBranchId = 2 });
            bList.Add(new Branch() { BranchId = 4, BranchName = "/302076/302004", HasSubBranch = false, SubBranchId = 2 });
            bList.Add(new Branch() { BranchId = 5, BranchName = "/302076/302005", HasSubBranch = false, SubBranchId = 2 });
            bList.Add(new Branch() { BranchId = 6, BranchName = "/302076/302006", HasSubBranch = false, SubBranchId = 2 });

            bList.Add(new Branch() { BranchId = 10, BranchName = "302076/10", HasSubBranch = true, SubBranchId = 1 });
            bList.Add(new Branch() { BranchId = 11, BranchName = "/302076/10/302011", HasSubBranch = false, SubBranchId = 10 });
            bList.Add(new Branch() { BranchId = 12, BranchName = "/302076/10/302012", HasSubBranch = false, SubBranchId = 10 });
            bList.Add(new Branch() { BranchId = 13, BranchName = "/302076/10/302013", HasSubBranch = false, SubBranchId = 10 });

            bList.Add(new Branch() { BranchId = 20, BranchName = "302076/20", HasSubBranch = true, SubBranchId = 1 });
            bList.Add(new Branch() { BranchId = 21, BranchName = "302076/20/302021", HasSubBranch = false, SubBranchId = 20 });
            bList.Add(new Branch() { BranchId = 22, BranchName = "302076/20/302022", HasSubBranch = false, SubBranchId = 20 });
            bList.Add(new Branch() { BranchId = 23, BranchName = "302076/20/302023", HasSubBranch = false, SubBranchId = 20 });
            bList.Add(new Branch() { BranchId = 24, BranchName = "302076/20/302024", HasSubBranch = false, SubBranchId = 20 });
            bList.Add(new Branch() { BranchId = 25, BranchName = "302076/20/302025", HasSubBranch = false, SubBranchId = 20 });

            bList.Add(new Branch() { BranchId = 30, BranchName = "302076/20", HasSubBranch = true, SubBranchId = 1 }); 
            bList.Add(new Branch() { BranchId = 31, BranchName = "302076/20/302031", HasSubBranch = false, SubBranchId = 30 });
            bList.Add(new Branch() { BranchId = 32, BranchName = "302076/20/302032", HasSubBranch = false, SubBranchId = 30 });
            bList.Add(new Branch() { BranchId = 33, BranchName = "302076/20/302033", HasSubBranch = false, SubBranchId = 30 });
            bList.Add(new Branch() { BranchId = 34, BranchName = "302076/20/302034", HasSubBranch = false, SubBranchId = 30 });
            bList.Add(new Branch() { BranchId = 35, BranchName = "302076/20/302035", HasSubBranch = false, SubBranchId = 30 });
            bList.Add(new Branch() { BranchId = 36, BranchName = "302076/20/302036", HasSubBranch = false, SubBranchId = 30 });
            bList.Add(new Branch() { BranchId = 37, BranchName = "302076/20/302037", HasSubBranch = false, SubBranchId = 30 });

            if (branchId == null)
            {
                result = bList.Where(e => e.SubBranchId == null);
            }
            else
            {
                result = bList.Where(e => e.SubBranchId == branchId);
            }

            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult CheckedList(string chkList)
        {
            decimal[] chkArray = JsonConvert.DeserializeObject<decimal[]>(chkList);
            throw new NotImplementedException();
        }
    }
    
}