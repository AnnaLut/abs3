using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;
using System.Data;

namespace BarsWeb.Areas.DynamicLayoutLegalEntities.Infrastructure.DI.Implementation {
    public class SqlCreator
    {
        public static BarsSql SearchMain()
        {
            return new BarsSql()
            {
                SqlText = @"SELECT ID, DK, NAME, NLS , BS, OB, NAZN, DATP, ALG , GRP FROM V_STATIC_LAYOUT",
                SqlParams = new object[] { }
            };

        }
        /// <summary>
        /// filter - строка типу "1,2,3,4" , де через кому ідуть номера груп, які будуть виводитись
        /// </summary>
        /// <param name="filter"></param>
        /// <returns></returns>
        public static BarsSql SearchMainWithFilter(string filter)
        {
            BarsSql result = SearchMain();
            result.SqlText += " WHERE GRP IN(" + filter + ")";

            return result;
        }
        // WHERE GRP IN (20,21,22,23,24,25,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,59)

        public static BarsSql SearchMainFiltered()
        {
            BarsSql result = SearchMain();
            result.SqlText += " WHERE GRP IN (20,21,22,23,24,25,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,59)";

            return result;
        }

        public static BarsSql SearchStaticLayoutData()
        {
            return new BarsSql()
            {
                SqlText = @"SELECT ID, ND, KV, BRANCH, BRANCH_NAME, NLS_A, NAMA, OKPOA, MFOB, MFOB_NAME, NLS_B, NAMB, OKPOB, PERCENT, SUMM_A, SUMM_B, DELTA, TT, VOB, NAZN, REF, NLS_COUNT, ORD, USERID FROM V_TMP_STATIC_LAYOUT_DETAIL_A",
                SqlParams = new object[] { }
            };
        }

        public static BarsSql SearchTmpDynamicLayout()
        {
            return new BarsSql()
            {
                SqlText = @"select null,  t.ND, t.DATD, t.DK, t.SUMM, t.KV_A, t.NLS_A, t.OSTC, t.NMS, t.NAZN, t.DATE_FROM, t.DATE_TO, t.DATES_TO_NAZN, t.CORRECTION, t.REF, t.TYPED_PERCENT, t.TYPED_SUMM, t.BRANCH_COUNT, t.USERID from V_TMP_DYNAMIC_LAYOUT t",
                SqlParams = new object[] { }
            };
        }


        public static BarsSql KvAutoComplete()
        {
            return new BarsSql()
            {
                SqlParams = new object[] { },
                SqlText = "SELECT KV, NAME FROM TABVAL WHERE D_CLOSE IS NULL ORDER BY KV DESC"
            };
        }
    }
}
