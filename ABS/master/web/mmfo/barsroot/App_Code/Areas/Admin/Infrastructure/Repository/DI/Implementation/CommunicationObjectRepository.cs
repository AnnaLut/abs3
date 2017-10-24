using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Admin.Models.CommunicationObject;
using BarsWeb.Areas.Kernel.Models;
using Areas.Admin.Models;
using System.Linq;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using Kendo.Mvc.UI;
using System.Collections.Generic;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Implementation
{
    public class CommunicationObjectRepository : ICommunicationObjectRepository
    {

        private readonly BarsSql _baseSql;
        private readonly Entities _entities;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;

        public CommunicationObjectRepository(IAdminModel model, IKendoSqlTransformer sqlTransformer, IKendoSqlCounter sqlCounter)
        {
            _entities = model.Entities;
            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = sqlCounter;
            _baseSql = new BarsSql() { };
        }

        public List<CommObjDropDown> GetDropDownCommObj()
        {
            _baseSql.SqlText = "SELECT * FROM V_REL_ADMN_OBJS";
            _baseSql.SqlParams = new object[] { };
            var result = _entities.ExecuteStoreQuery<CommObjDropDown>(_baseSql.SqlText, _baseSql.SqlParams).ToList();
            return result;
        }


        public List<CommObj> GetCommObjGrid([DataSourceRequest]DataSourceRequest request, int id)
        {
            InitSQLGetCommObj(id);
            var sql = _sqlTransformer.TransformSql(_baseSql, request);
            var result = _entities.ExecuteStoreQuery<CommObj>(sql.SqlText, sql.SqlParams).ToList();
            return result;
        }

        public decimal GetCommObjDataCount([DataSourceRequest]DataSourceRequest request, int id)
        {
            InitSQLGetCommObj(id);
            var sql = _kendoSqlCounter.TransformSql(_baseSql, request);
            var result = _entities.ExecuteStoreQuery<decimal>(sql.SqlText, sql.SqlParams).Single();
            return result;
        }

        private void InitSQLGetCommObj(int id)
        {
            _baseSql.SqlParams = new object[] { };

            switch (id)
            {
                case 0:
                    _baseSql.SqlText = "SELECT TO_CHAR(s.id) as idWhom, s.fio as objNameWhom, a.codeapp as idWhat, a.name as objNameWhat FROM staff s, applist a, APPLIST_STAFF sa WHERE sa.id=s.id and sa.codeapp=a.codeapp";
                    break;

                case 1:
                    _baseSql.SqlText = "SELECT TO_CHAR(s.id) as idWhom, s.fio as objNameWhom, t.tt as idWhat , t.name  as objNameWhat FROM staff s, tts t, STAFF_TTS st WHERE st.id=s.id and st.tt=t.tt";
                    break;

                case 2:
                    _baseSql.SqlText = "SELECT TO_CHAR(s.id) as idWhom, s.fio as objNameWhom, TO_CHAR(c.IDCHK) as idWhat, c.name as objNameWhat FROM staff s, CHKLIST c, STAFF_CHK sc WHERE sc.id=s.id and sc.CHKID=c.IDCHK";
                    break;

                case 3:
                    _baseSql.SqlText = "SELECT TO_CHAR(s.id) as idWhom, s.fio as objNameWhom, k.KODF as idWhat, k.SEMANTIC as objNameWhat FROM staff s, KL_F00 k, STAFF_KLF00 sk WHERE sk.id=s.id  and sk.KODF=k.KODF";
                    break;

                case 4:
                    _baseSql.SqlText = "SELECT TO_CHAR(s.id) as idWhom, s.fio as objNameWhom, TO_CHAR(o.CODEOPER) as idWhat, o.name as objNameWhat  FROM staff s, OPERLIST o, APPLIST_STAFF sa, OPERAPP oa WHERE sa.id=s.id and sa.CODEAPP=oa.CODEAPP and oa.CODEOPER=o.CODEOPER";
                    break;

                case 5:
                    _baseSql.SqlText = "SELECT TO_CHAR(s.id) as idWhom, s.fio as objNameWhom, m.tabname as idWhat, m.SEMANTIC as objNameWhat FROM staff s, REFERENCES r, APPLIST_STAFF sa, REFAPP ra, META_TABLES m WHERE sa.id=s.id and sa.CODEAPP=ra.CODEAPP and ra.tabid=r.tabid and r.tabid=m.tabid";
                    break;

                case 6:
                    _baseSql.SqlText = "SELECT TO_CHAR(s.id) as idWhom, s.fio as objNameWhom, TO_CHAR(p.id) as idWhat, p.DESCRIPTION as objNameWhat FROM staff s, REPORTS p, APPLIST_STAFF sa, APP_REP pa WHERE sa.id=s.id and sa.CODEAPP=pa.CODEAPP and pa.CODEREP=p.id";
                    break;

                case 7:
                    _baseSql.SqlText = "SELECT TO_CHAR(s.id) as idWhom, s.fio as objNameWhom, TO_CHAR(d.id) as idWhat, d.name as objNameWhat FROM staff s, OTDEL d, OTD_USER sd WHERE sd.USERID=s.id and sd.OTD=d.id";
                    break;

                case 8:
                    _baseSql.SqlText = "SELECT a.codeapp as idWhom, a.name as objNameWhom, TO_CHAR(o.codeoper) as idWhat, o.name as objNameWhat FROM applist a, operlist o, OPERAPP oa WHERE a.codeapp=oa.codeapp and oa.codeoper=o.codeoper";
                    break;

                case 9:
                    _baseSql.SqlText = "SELECT a.codeapp as idWhom, a.name as objNameWhom, m.tabname as idWhat, m.SEMANTIC as objNameWhat FROM applist a, REFAPP ra, META_TABLES m, REFERENCES r WHERE r.tabid=m.tabid and a.codeapp=ra.codeapp and ra.tabid=m.tabid";
                    break;

                case 10:
                    _baseSql.SqlText = "SELECT a.codeapp as idWhom, a.name as objNameWhom, TO_CHAR(p.id) as idWhat, p.DESCRIPTION as objNameWhat FROM applist a, APP_REP pa, REPORTS p WHERE a.codeapp=pa.codeapp and pa.CODEREP=p.id";
                    break;
            }
        }
    }
}
