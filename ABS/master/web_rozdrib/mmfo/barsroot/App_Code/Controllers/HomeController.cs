using System;
using System.Web.Mvc;
using BarsWeb.Infrastructure.Repository.DI.Abstract;
using Models;

namespace BarsWeb.Controllers
{
    [AuthorizeUser]
    public class HomeController : ApplicationController
    {

        EntitiesBars _entities;
        private IHomeRepository _repository;
        public HomeController(IHomeRepository repository)
        {
            _repository = repository;
        }

        /// <summary>
        /// переброс на страницу по умолчанию
        /// </summary>
        /// <returns></returns>
        [CompressFilter]
        public ActionResult Index()
        {
            return View();
        }
        [AllowAnonymous]
        public ActionResult Default()
        {
            return View();
        }

        public ActionResult Dashboard()
        {
            return View();
        }
        public ActionResult Applist()
        {
            if (HttpContext.Session["OperList"] == null)
            {
                HttpContext.Session["OperList"] = _repository.GetOperList();
            }
            return View(HttpContext.Session["OperList"]);
        }

        public ActionResult Head()
        {
            var userParam = _repository.GetUserParam();
            ViewBag.DbName = _repository.DbName();
            return View(userParam);
        }
        /// <summary>
        /// населення доступних бранчів
        /// </summary>
        /// <returns></returns>
        public ActionResult Branches(string selectedBranch,string selectedBranchName)
        {
            ViewBag.selectedBranch = selectedBranch;
            ViewBag.selectedBranchName = selectedBranchName;
            return View(_repository.GetBranches());
        }

        public ActionResult ChangeBranch(string branch)
        {
            _repository.ChangeBranch(branch);
            return Redirect("~/");
        }

        /*public ActionResult Error()
        {
            HttpContext.Response.StatusCode = 204;
            //string script = "<script>alert('test');document.execCommand('Stop','false',1);</script>";
            string script = "<script>window.open();</script>";
            return Content(script);
        }*/

        public ActionResult Error(string text)
        {
            return View("Error",model:new Exception(text));
        }

        public ActionResult Test()
        {
            return View();
        }
    }
}