using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Areas.NbuIntegration.Models
{
    public class OperationRow
    {
        [JsonProperty("ACT_DATE")]
        public DateTime? OperationDate { get; set; }
        [JsonProperty("D_DOC")]
        public DateTime? PermissionDate { get; set; }
        [JsonProperty("TOTAL_AMOUNT")]
        public long? TotalSum { get; set; }
        [JsonProperty("ACT_TYPE")]
        public int? OperationType { get; set; }
        [JsonProperty("REG_ID")]
        public int? RegionId { get; set; }
        [JsonProperty("REF")]
        public long? RefSago { get; set; }
        [JsonProperty("F_STATE")]
        public long? OperationState { get; set; }
        [JsonProperty("N_DOC")]
        public string PermissionNumber { get; set; }
        [JsonProperty("ACT")]
        public string OperationCode { get; set; }
        [JsonProperty("FIO_REG")]
        public string PibReg { get; set; }
        [JsonProperty("USER_ID")]
        public string UserId { get; set; }
    }

    public class OperationRowExtended
    {
        /// <summary>
        /// REF_OUR
        /// </summary>
        public string Ref { get; set; }
        /// <summary>
        /// ACT_DATE
        /// </summary>
        public DateTime? OperationDate { get; set; }
        /// <summary>
        /// D_DOC
        /// </summary>
        public DateTime? PermissionDate { get; set; }
        /// <summary>
        /// TOTAL_AMOUNT
        /// </summary>
        public long? TotalSum { get; set; }
        /// <summary>
        /// ACT_TYPE
        /// </summary>
        public int? OperationType { get; set; }
        /// <summary>
        /// REG_ID
        /// </summary>
        public int? RegionId { get; set; }
        /// <summary>
        /// REF_SAGO
        /// </summary>
        public long? RefSago { get; set; }
        /// <summary>
        /// F_STATE
        /// </summary>
        public string OperationState { get; set; }
        /// <summary>
        /// N_DOC
        /// </summary>
        public string PermissionNumber { get; set; }
        /// <summary>
        /// ACT
        /// </summary>
        public string OperationCode { get; set; }
        /// <summary>
        /// FIO_REG
        /// </summary>
        public string PibReg { get; set; }
        /// <summary>
        /// USER_ID
        /// </summary>
        public string UserId { get; set; }
    }

    public class Operations
    {
        [JsonProperty("ROWDATA")]
        public List<OperationRow> Rows { get; set; }

        [JsonIgnore]
        public long TotalSum
        {
            get
            {
                if (null == Rows || Rows.Count <= 0) return 0;
                long tmp = Rows.Sum(x => x.TotalSum == null ? 0 : (long)x.TotalSum);
                return Convert.ToInt64(tmp);
            }
        }
    }

    public class Data
    {
        [JsonProperty("OPERS")]
        public Operations Operations { get; set; }
    }

    public class NbuServiceResponse
    {
        [JsonProperty("data")]
        public Data Data { get; set; }
        [JsonProperty("user")]
        public string User { get; set; }
        [JsonProperty("sign")]
        public string Sign { get; set; }
        [JsonProperty("errcode")]
        public int ErrorCode { get; set; }
        [JsonProperty("errmsg")]
        public string ErrorMessage { get; set; }

        /// <summary>
        /// overrided method, returns json
        /// </summary>
        /// <returns></returns>
        public override string ToString()
        {
            return JsonConvert.SerializeObject(this);
        }
    }
}