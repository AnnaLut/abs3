using System.Collections.Generic;
using BarsWeb.Areas.OpenCloseDay.Models;

namespace BarsWeb.Areas.OpenCloseDay.Infrastructure.DI.Abstract
{
    public interface IFuncListOperation
    {
        ReturnModel GetList(string dateType);
        void ExecuteFunc(IList<FuncArray> model, string idGroup);
        void RunFailedGroup(int P_ID_GROUP_LOG);

        void StopFailGroup(int id);
        void RestoreGroup(int id);

        //List<History> GetHistory(string date, string dateType);
    }
}