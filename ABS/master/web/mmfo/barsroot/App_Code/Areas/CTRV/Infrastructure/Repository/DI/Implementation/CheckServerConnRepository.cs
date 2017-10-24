using BarsWeb.Areas.CTRV.Infrastructure.Repository.DI.Abstract;
using System.Collections.Generic;
using Dapper;
using Bars.Classes;
using System.Linq;
using System.IO;
using System;
using System.Data;
using System.Globalization;
using System.Text;
using System.Collections;
using Bars.Doc;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.CTRV.Infrastructure.Repository.DI.Implementation
{
    public class CheckServerConnRepository : ICheckServerConnRepository
    {
        public CheckServerConnRepository()
        {
        }

        public string GetStatus()
        {
            string sql_query = @"SELECT substr(check_vo,1,200)
                                 FROM   dual";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<string>(sql_query).SingleOrDefault();
            }
        }
    }
}