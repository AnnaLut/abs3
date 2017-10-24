using BarsWeb.Areas.Way.Infrastructure.DI.Abstract;
using BarsWeb.Controllers;
using System.Web.Mvc;

/// <summary>
/// Summary description for InstantCardsController
/// </summary>
/// 
namespace BarsWeb.Areas.Way.Controllers
{
    public class InstantCardsController : ApplicationController
    {
        private readonly IInstantCardsRepository _repository;

        public InstantCardsController(IInstantCardsRepository repository)
        {
            _repository = repository;
        }

        public ActionResult InstantCards()
        {
            return View();
        }
        
    }
}