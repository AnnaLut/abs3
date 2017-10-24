using System.Collections.Generic;
using System.Data;
using Areas.GL.Models;
using BarsWeb.Areas.GL.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.GL.Models
{
    public class NLRepository : INLRepository
    {
        private readonly GLModel _entities;
        public NLRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("GLModel", "GL");
            _entities = new GLModel(connectionStr);
        }

        public IEnumerable<File> FilesData(string tip)
        {
            const string query = @"
                select a.acc, a.kv, a.nls, a.nms, a.ostc/100 ost_fk, a.ostb/100 ost_pl, sum(o.s) sum_kar, count(*) kount_pl, lower(a.tip) as tip
                FROM v_gl a, v_per_nl_ o
                where a.acc = o.acc and a.tip = :tip
                group by a.acc, a.kv, a.nls, a.nms, a.ostc/100, a.ostb/100, a.tip
                order by a.nls, a.kv
            ";
            var param = new object[]
            {
                new OracleParameter("tip", OracleDbType.Varchar2, tip, ParameterDirection.Input)
            };
            return _entities.ExecuteStoreQuery<File>(query, param);
        }

        public IEnumerable<SubFile> SubFileData(decimal acc)
        {
            const string query = @"
                select v_per_nl_.*, (s*100)   s2
                from v_per_nl_
                where acc = :acc
            ";
            var param = new object[]
            {
                new OracleParameter("tip", OracleDbType.Decimal, acc, ParameterDirection.Input)
            };
            return _entities.ExecuteStoreQuery<SubFile>(query, param);
        }
        public void RemoveDocument(decimal id)
        {
            const string query = @"delete v_per_nl_ where ref = :ref";
            var param = new object[]
            {
                new OracleParameter("ref", OracleDbType.Decimal, id, ParameterDirection.Input)
            };
            _entities.ExecuteStoreCommand(query, param);
        }
        public IEnumerable<Operation> OperDictionary(string type)
        {
            const string query = @"select TT, NAME from V_NLK_TT where id = :id";
            var param = new object[]
            {
                new OracleParameter("id", OracleDbType.Varchar2, type, ParameterDirection.Input)
            };
            return _entities.ExecuteStoreQuery<Operation>(query, param);
        }
    }
}