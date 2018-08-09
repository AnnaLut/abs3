using System.Collections.Generic;
using System.Data;
using Areas.GL.Models;
using BarsWeb.Areas.GL.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;
using Oracle.DataAccess.Client;
using System;
using System.Linq;


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

        public SwiftInfo GetSwiftInfo(decimal refid)
        {
            object[] ref_obj = new object[] { new OracleParameter("refid", OracleDbType.Decimal, refid, ParameterDirection.Input) };

            SwiftInfo swift_data =_entities.ExecuteStoreQuery<SwiftInfo>(
                @"select j.sender,
                        j.receiver,
                        chr(10) || listagg(lpad(TAG || OPT || ': ', 6) ||
                                            replace(VALUE, chr(10), (chr(10) || '      ')),
                                            chr(10)) within group(ORDER BY N, TAG, SEQ) SWIFTDATA
                    FROM sw_operw s, sw_journal j, sw_oper g
                    where g.swref = s.swref
                    and j.swref = s.swref
                    and g.ref = :refid
                    GROUP BY j.sender, j.receiver", ref_obj).FirstOrDefault();

            if (swift_data != null)
                return swift_data;

            else
            {
                BISinfo data = _entities.ExecuteStoreQuery<BISinfo>(
                @"select nam_a as sender, nam_b as receiver from ARC_RRP where ref = :ref", ref_obj).FirstOrDefault();

                string bir_data = _entities.ExecuteStoreQuery<string>(
                    @"SELECT listagg ( b.NAZN || decode(b.NAZNS, 33, b.D_REC, ''), chr(10)) WITHIN GROUP (ORDER BY b.NAZN) SWIFTDATA
                    FROM ARC_RRP a, ARC_RRP b
                    WHERE a.REF = :ref and a.BIS = 1 and a.FN_A = b.FN_A and a.DAT_A = b.DAT_A and 
                        a.REC <> b.REC and a.REC_A-a.BIS = b.REC_A-b.BIS and b.BIS > 0
                    ORDER BY b.BIS", ref_obj).FirstOrDefault();

                if (bir_data != null)
                    return new SwiftInfo { SWIFTDATA = bir_data, RECEIVER = data.RECEIVER, SENDER = data.SENDER };
                else
                    return null;
            }
        }
    }
}