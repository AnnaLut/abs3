using BarsWeb.Areas.BpkW4.Models;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BarsWeb.Areas.BpkW4.Controllers;
using System.Collections;

namespace BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Abstract
{
    public interface ICheckdkboRepository
    {

        IEnumerable<W4_DKBO_WEB_Result> Get_W4_DKBO_WEB(DataSourceRequest request);
        IEnumerable<W4_DKBO_QUESTION_Result> Get_W4_DKBO_QUESTION(W4_DKBO_WEB_FilterParams fp);
        IEnumerable<V_LIST_ITEMS_Result> Get_V_LIST_ITEMS(W4_DKBO_WEB_FilterParams fp);
        CustomerFilter CreateDKBO(List<AddToDKBO> addToDKBO);
        object SetAnswers(Hashtable ht, string new_dkbo_id);
     }
}