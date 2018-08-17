using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System;

namespace Bars.EAD.Models
{
    public class SyncQueueRow : IOracleCustomType
    {
        [OracleObjectMapping("ID")]
        public long Id { get; set; }

        [OracleObjectMapping("CRT_DATE")]
        public DateTime? CreateDate { get; set; }

        [OracleObjectMapping("OBJ_ID")]
        public string ObjId { get; set; }

        [OracleObjectMapping("STATUS_ID")]
        public string StatusId { get; set; }

        [OracleObjectMapping("ERR_COUNT")]
        public int ErrorCount { get; set; }

        [OracleObjectMapping("TYPE_ID")]
        public string TypeId { get; set; }

        public string ErrorText { get; set; }

        #region Message
        /// <summary>
        /// MESSAGE_ID
        /// </summary>
        public string MessageId { get; set; }
        /// <summary>
        /// MESSAGE_DATE
        /// </summary>
        public DateTime? MessageDate { get; set; }
        /// <summary>
        /// MESSAGE
        /// </summary>
        public string Message { get; set; }
        #endregion

        #region response
        /// <summary>
        /// RESPONSE_ID
        /// </summary>
        public string ResponseId { get; set; }
        /// <summary>
        /// RESPONSE_DATE
        /// </summary>
        public DateTime? ResponseDate { get; set; }
        /// <summary>
        /// RESPONSE
        /// </summary>
        public string Response { get; set; }
        #endregion

        public void SetError(string msg)
        {
            this.StatusId = Status.ERROR.ToString();
            this.ErrorText = msg;
            this.ErrorCount++;
        }

        public void FromCustomObject(OracleConnection con, IntPtr pUdt)
        {
            OracleUdt.SetValue(con, pUdt, "ID", Id);
            OracleUdt.SetValue(con, pUdt, "CRT_DATE", CreateDate);
            OracleUdt.SetValue(con, pUdt, "OBJ_ID", ObjId);
            OracleUdt.SetValue(con, pUdt, "STATUS_ID", StatusId);
            OracleUdt.SetValue(con, pUdt, "ERR_COUNT", ErrorCount);
            OracleUdt.SetValue(con, pUdt, "TYPE_ID", TypeId);
        }

        public void ToCustomObject(OracleConnection con, IntPtr pUdt)
        {
            Id = (long)OracleUdt.GetValue(con, pUdt, "ID");
            CreateDate = (DateTime)OracleUdt.GetValue(con, pUdt, "CRT_DATE");
            ObjId = (string)OracleUdt.GetValue(con, pUdt, "OBJ_ID");
            StatusId = (string)OracleUdt.GetValue(con, pUdt, "STATUS_ID");
            ErrorCount = (int)OracleUdt.GetValue(con, pUdt, "ERR_COUNT");
            TypeId = (string)OracleUdt.GetValue(con, pUdt, "TYPE_ID");
        }
    }

    [OracleCustomTypeMapping("BARS.T_EAD_SYNC_QUE_LINE")]
    public class SignArrayItemFactory : IOracleCustomTypeFactory
    {
        public IOracleCustomType CreateObject()
        {
            return new SyncQueueRow();
        }
    }

    [OracleCustomTypeMapping("BARS.T_EAD_SYNC_QUE_LIST")]
    public class FilterInfoListFactory : IOracleArrayTypeFactory
    {
        public Array CreateArray(int numElems)
        {
            return new SyncQueueRow[numElems];
        }

        public Array CreateStatusArray(int numElems)
        {
            return new OracleUdtStatus[numElems];
        }
    }
}