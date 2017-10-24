using Bars.Classes;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using BarsWeb.Areas.Sberutl.Infrastructure.Repository.DI.Abstract;
using System.Web;
using System.IO;
using System.Text;
using System.Collections;
using System.Globalization;
using Oracle.DataAccess.Client;
using BarsWeb.Areas.Sberutl.Models;

namespace BarsWeb.Areas.Sberutl.Infrastructure.Repository.DI.Implementation
{
    public class ArchiveRepository : IArchiveRepository
    {
        public ArchiveRepository()
        {
        }

        public List<OBPC_SALARY_IMPORT_LOG> GetGridData(Int32 param)
        {
            List<OBPC_SALARY_IMPORT_LOG> list = new List<OBPC_SALARY_IMPORT_LOG>();
            String sql_query = @"select 
                                    file_id FILE_ID,
                                    file_name FILE_NAME,
                                    crt_date CRT_DATE,
                                    ref REF,
                                    nls NLS,
                                    fio FIO,
                                    inn INN,
                                    summa SUMMA,
                                    status STATUS,
                                    error ERROR,
                                    link LINK
                                from OBPC_SALARY_IMPORT_LOG
                                where file_id=:p_file_id
                                order by link, error";
            DynamicParameters par = new DynamicParameters();
            par.Add("p_file_id", dbType: DbType.Int32, value: param, direction: ParameterDirection.Input);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                list = connection.Query<OBPC_SALARY_IMPORT_LOG>(sql_query, par).ToList();
            }
            return list;
        }
    }
}

