using System;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Areas.Finp.Infrastructure.Repository.DI.Abstract;
using Areas.Finp.Models;
using BarsWeb.Areas.Finp.Models;
using BarsWeb.Controllers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Finp.Controllers
{
    [AuthorizeUser]
    public class SessionsController : ApplicationController
    {
        private readonly IFinpRepository _finpRepository;

        public SessionsController(IFinpRepository finpRepository)
        {
            _finpRepository = finpRepository;
        }

        [HttpGet]
        public ViewResult SessionList()
        {
            var sesMeth = new FinpSessionModel();
            sesMeth.Sessions = _finpRepository.GetSessions();
            sesMeth.Metods = _finpRepository.GetMethods();
            sesMeth.ObjectTypes = _finpRepository.GetObjectTypes();
            sesMeth.QuestionListItems = _finpRepository.GetQuestionListItems();
                        
            //var session = _finpRepository.GetSessions();
            return View(sesMeth);
        }
        public ViewResult SessionObjList(string typeId, decimal srcObjId)
        {
            var session = _finpRepository.GetSessionObjectSrc(typeId, srcObjId);
            return View("SessionList", session);
        }
        public ActionResult GridData([DataSourceRequest] DataSourceRequest request)
        {
            IQueryable<V_FINP_SESSIONS> session;
            session = _finpRepository.GetSessions();
            return Json(session.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        public ActionResult GridDataFiltered([DataSourceRequest] DataSourceRequest request, string typeId, string methodId)
        {
            IQueryable<V_FINP_SESSIONS> session;
            /*if (String.IsNullOrEmpty(typeId))
            {
                session = _finpRepository.GetSessions();
            }
            else
            {*/
            session = _finpRepository.GetSessionFiltered(typeId, methodId);
            //}
            return Json(session.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        
        public String CreateSession(string objType, int objId, string methId, int countGuarantor)
        {
            var session = _finpRepository.CreateSession(objType, objId, methId, countGuarantor);
            var surveyId = _finpRepository.GetSurveyId(methId);
            return "/Finp/QuestionNaire/GroupList/?surveyId=" + surveyId + "&sessionId=" + session;
        }
    }
}