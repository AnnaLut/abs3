using System.Collections.Generic;
using System.Linq;
using Bars.Classes;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Admin.Models.EditRecords;
using Dapper;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Implementation
{
    public class RecordsRepository : IRecordsRepository
    {
        public List<ListOtch> GetListId()
        {
            List<ListOtch> list; ;

            const string sql = @"select otchgrp id, substr(otchgrp||'-'||name,1,20) name
                               from rep_otchgrp
                               ORDER BY name";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                list = connection.Query<ListOtch>(sql).ToList();
            }
            return list;
        }

        public List<LeftGrid> GetLeftGrid(decimal nGrp)
        {
            List<LeftGrid> list;
            const string sql = @"SELECT a.accgrp, a.name, a.filemask, a.grpdir
                                 FROM rep_otchgrp o, rep_accgrp a, rep_accg_otchg t
                                 WHERE o.otchgrp=t.otchgrp 
                                 AND a.accgrp=t.accgrp
                                 AND o.otchgrp=:nGrp
                                 ORDER BY o.otchgrp, a.accgrp";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                list = connection.Query<LeftGrid>(sql, new {nGrp}).ToList();
            }
            return list;
        } 
    }
}