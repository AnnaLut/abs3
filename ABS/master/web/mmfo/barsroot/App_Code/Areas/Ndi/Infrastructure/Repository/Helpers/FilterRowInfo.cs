using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

/// <summary>
/// Summary description for FilterDbInfo
/// </summary>
/* FunctionInfo Class
**   An instance of a FunctionInfo class represents an FunctionInfo object
**   A custom type must implement INullable and IOracleCustomType interfaces
*/
namespace BarsWeb.Areas.Ndi.Infrastructure.Repository.Helpers
{
    public class FilterRowInfo : INullable, IOracleCustomType
    {

        [OracleObjectMapping("LOGICAL_OP")]
        public string LogicalOp { get; set; }

        [OracleObjectMapping("COLNAME")]
        public string Colname { get; set; }

        [OracleObjectMapping("RELATIONAL_OP")]
        public string ReletionalOp { get; set; }

        [OracleObjectMapping("VALUE")]
        public string Value { get; set; }

        public bool IsNull
        {
            get
            {
                return false;
            }
        }

        public void FromCustomObject(OracleConnection con, IntPtr pUdt)
        {
            // Convert from the Custom Type to Oracle Object
            OracleUdt.SetValue(con, pUdt, "LOGICAL_OP", LogicalOp);
            OracleUdt.SetValue(con, pUdt, "COLNAME", Colname);
            OracleUdt.SetValue(con, pUdt, "RELATIONAL_OP", ReletionalOp);
            OracleUdt.SetValue(con, pUdt, "VALUE", Value);
        }

        public void ToCustomObject(OracleConnection con, IntPtr pUdt)
        {
            LogicalOp = (string)OracleUdt.GetValue(con, pUdt, "LOGICAL_OP");
            Colname = (string)OracleUdt.GetValue(con, pUdt, "COLNAME");
            ReletionalOp = (string)OracleUdt.GetValue(con, pUdt, "RELATIONAL_OP");
            Value = (string)OracleUdt.GetValue(con, pUdt, "VALUE");
        }
    }

    [OracleCustomTypeMapping("BARS.T_DYN_FILTER_COND_LINE")]
    public class FunctionInfoFactory : IOracleCustomTypeFactory
    {
        public IOracleCustomType CreateObject()
        {
            return new FilterRowInfo();
        }
    }

    /* FunctionInfoList Class
    **   An instance of a FunctionInfoList class represents an FunctionInfoList object
    **   A custom type must implement INullable and IOracleCustomType interfaces
    */
    //public class FilterInfoList : INullable, IOracleCustomType
    //{
    //    [OracleArrayMapping()]
    //    public FilterRowInfo[] FilterInfoArray;

    //    private bool objectIsNull;

    //    #region INullable Members

    //    public bool IsNull
    //    {
    //        get 
    //        { 
    //            return false; 
    //        }
    //    }

    //    //public static FilterInfoList Null
    //    //{
    //    //    get
    //    //    {
    //    //        FilterInfoList obj = new FilterInfoList();
    //    //        obj.objectIsNull = true;
    //    //        return obj;
    //    //    }
    //    //}

    //    #endregion

    //    #region IOracleCustomType Members

    //    public void FromCustomObject(OracleConnection con, IntPtr pUdt)
    //     {
    //         OracleUdt.SetValue(con, pUdt, "", FilterInfoArray);        
    //    }

    //    public void ToCustomObject(OracleConnection con, IntPtr pUdt)
    //    {
    //        FilterInfoArray = (FilterRowInfo[])OracleUdt.GetValue(con, pUdt, 0);
    //    }

    //    #endregion
    //}

    [OracleCustomTypeMapping("BARS.T_DYN_FILTER_COND_LIST")]
    public class FilterInfoListFactory : IOracleArrayTypeFactory
    {
        public Array CreateArray(int numElems)
        {
            return new FilterRowInfo[numElems];

        }

        public Array CreateStatusArray(int numElems)
        {
            return new OracleUdtStatus[numElems];
        }
    }
}