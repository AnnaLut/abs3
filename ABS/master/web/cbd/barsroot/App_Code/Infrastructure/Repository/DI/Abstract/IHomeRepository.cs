using System.Collections.Generic;
using BarsWeb.Models;

namespace BarsWeb.Infrastructure.Repository.DI.Abstract
{
    public interface IHomeRepository
    {
        List<V_OPERAPP_UI> GetOperList();
        USER_PARAM GetUserParam();
        string DbName();
        List<BRANCHES> GetBranches();
        void ChangeBranch(string branch);
    }
}
