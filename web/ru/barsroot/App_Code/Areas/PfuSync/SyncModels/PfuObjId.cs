using Newtonsoft.Json;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System;

namespace BarsWeb.Areas.PfuSync.SyncModels
{
    public class PfuObjId : INullable, IOracleCustomType
    {
        [OracleObjectMappingAttribute("OBJ_ID")]
        public decimal obj_id { get; set; }
        /// <summary>
        /// 0 - не сихронізовано, 1 - в процесі - 2 сихронізовано
        /// </summary>
        [OracleObjectMappingAttribute("RES")]
        public Int32 res { get; set; }
        [JsonIgnore]
        public bool IsNull
        {
            get
            {
                return false;
            }
        }
        public void FromCustomObject(OracleConnection con, IntPtr pUdt)
        {
            OracleUdt.SetValue(con, pUdt, "OBJ_ID", obj_id);
            OracleUdt.SetValue(con, pUdt, "RES", res);
        }

        public void ToCustomObject(OracleConnection con, IntPtr pUdt)
        {
            obj_id = (decimal)OracleUdt.GetValue(con, pUdt, "OBJ_ID");
            res = (Int32)OracleUdt.GetValue(con, pUdt, "RES");
        }
    }

    //Oracle type mapping class
    //single obj
    [OracleCustomTypeMappingAttribute("BARS.R_PFU_OBJ_ID")]
    public class PfuObjIdFactory : IOracleCustomTypeFactory
    {
        public IOracleCustomType CreateObject()
        {
            return new PfuObjId();
        }
    }

    //array of obj's
    [OracleCustomTypeMappingAttribute("BARS.T_PFU_OBJ_ID")]
    public class PfuObjIdArrayFactory : IOracleArrayTypeFactory
    {
        public Array CreateArray(int numElems)
        {
            return new PfuObjId[numElems];
        }

        public Array CreateStatusArray(int numElems)
        {
            return new OracleUdtStatus[numElems];
        }

    }
}