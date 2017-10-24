using System;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.OpenCloseDay.Helpers
{
    /* FunctionInfo Class
    **   An instance of a FunctionInfo class represents an FunctionInfo object
    **   A custom type must implement INullable and IOracleCustomType interfaces
    */
    public class FunctionInfo : INullable, IOracleCustomType
    {
        private bool objectIsNull;

        [OracleObjectMapping("TASK_ID")]
        public int TaskId { get; set; }

        [OracleObjectMapping("TASK_ACTIVE")]
        public string TaskActive { get; set; }
        public static FunctionInfo Null
        {
            get
            {
                FunctionInfo function = new FunctionInfo();
                function.objectIsNull = true;
                return function;
            }
        }

        #region INullable Members

        public bool IsNull
        {
            get { return objectIsNull; }
        }

        #endregion

        #region IOracleCustomType Members

        public void FromCustomObject(OracleConnection con, IntPtr pUdt)
        {
            // Convert from the Custom Type to Oracle Object
            if (TaskId!=0)
            {
                OracleUdt.SetValue(con, pUdt, "TASK_ID", TaskId);
            }
            if (!string.IsNullOrEmpty(TaskActive))
            {
                OracleUdt.SetValue(con, pUdt, "TASK_ACTIVE", TaskActive);
            }

        }

        public void ToCustomObject(OracleConnection con, IntPtr pUdt)
        {
            TaskId = (int)OracleUdt.GetValue(con, pUdt, "TASK_ID");
            TaskActive = (string)OracleUdt.GetValue(con, pUdt, "TASK_ACTIVE");
            
        }

        #endregion

    }

    [OracleCustomTypeMapping("BARS.T_TASK_LIST_INFO")]
    public class FunctionInfoFactory : IOracleCustomTypeFactory
    {
        #region IOracleCustomTypeFactory Members

        public IOracleCustomType CreateObject()
        {
            return new FunctionInfo();
        }

        #endregion
    }

    /* FunctionInfoList Class
    **   An instance of a FunctionInfoList class represents an FunctionInfoList object
    **   A custom type must implement INullable and IOracleCustomType interfaces
    */
    public class FunctionInfoList : INullable, IOracleCustomType
    {
        [OracleArrayMapping()]
        public FunctionInfo[] FunctionInfoArray;

        private bool objectIsNull;

        #region INullable Members

        public bool IsNull
        {
            get { return objectIsNull; }
        }

        public static FunctionInfoList Null
        {
            get
            {
                FunctionInfoList obj = new FunctionInfoList();
                obj.objectIsNull = true;
                return obj;
            }
        }

        #endregion

        #region IOracleCustomType Members

        public void FromCustomObject(OracleConnection con, IntPtr pUdt)
        {
            OracleUdt.SetValue(con, pUdt, 0, FunctionInfoArray);
        }

        public void ToCustomObject(OracleConnection con, IntPtr pUdt)
        {
            FunctionInfoArray = (FunctionInfo[])OracleUdt.GetValue(con, pUdt, 0);
        }

        #endregion
    }

    [OracleCustomTypeMapping("BARS.TMS_TAB_LIST_INFO")]
    public class FunctionInfoListFactory : IOracleCustomTypeFactory, IOracleArrayTypeFactory
    {
        #region IOracleCustomTypeFactory Members
        public IOracleCustomType CreateObject()
        {
            return new FunctionInfoList();
        }

        #endregion

        #region IOracleArrayTypeFactory Members
        public Array CreateArray(int numElems)
        {
            return new FunctionInfo[numElems];
        }

        public Array CreateStatusArray(int numElems)
        {
            return null;
        }

        #endregion
    }
}
