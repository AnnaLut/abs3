using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;
using System.Data;

namespace BarsWeb.Areas.SyncTablesEditor.Infrastructure.DI.Implementation
{
    public class SqlCreator
    {
        public static BarsSql SearchMain()
        {
            return new BarsSql()
            {
                SqlText = @"SELECT st.TABID, mt.SEMANTIC, mt.TABNAME, st.FILE_NAME, st.S_SELECT, st.S_INSERT, st.S_UPDATE, st.S_DELETE, st.FILE_DATE, st.SYNC_FLAG, st.SYNC_DATE, st.ENCODE, st.BRANCH from DBF_SYNC_TABS st join META_TABLES mt on ( mt.TABID = st.TABID ) order by st.TABID",
                SqlParams = new object[] { }
            };

        }
    }
}
