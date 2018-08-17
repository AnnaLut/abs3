using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;

namespace Bars.EAD.Structs.Params
{
    /// <summary>
    /// Параметри - Довідник
    /// </summary>
    public struct Dictionary
    {
        public static Object[] GetData(String ObjID, OracleConnection con)
        {
            Object[] res = null;
            switch (ObjID)
            {
                case "EA-UB":
                    List<Dicts.DictDataBranch> list = Dicts.DictDataBranch.GetInstanceList(con);
                    res = list.ConvertAll(item => (Object)item).ToArray();
                    break;
            }

            return res;
        }
    }
}