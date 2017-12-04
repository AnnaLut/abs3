using System;
using System.Linq;
using Bars.Classes;
using Bars.Web.Session;
using Dapper;

namespace BarsWeb.Areas.Crkr.Infrastructure.Helper
{
    public static class UserBranch
    {
        public static string Branch(out string mfo)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var branch = connection.Query<string>("select branch_usr.get_branch BR from dual").SingleOrDefault();
                if(string.IsNullOrEmpty(branch))
                    throw new NullReferenceException("Відділення не знайдено!");
                mfo = branch.Substring(1, 6);
                return branch;
            }
        }
    }
}
