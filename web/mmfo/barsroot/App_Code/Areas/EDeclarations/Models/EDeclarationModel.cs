using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Areas.EDeclarations.Models
{
    /// <summary>
    /// Модель Е-Декларации на основе BD View v_eds_clt_log
    /// </summary>
    public class EDeclarationModel
    {
        public String ID { get; set; }
        public String TRANSPORT_ID { get; set; }
        public String OKPO { get; set; }
        public DateTime? BIRTH_DATE { get; set; }
        public Int32? DOC_TYPE { get; set; }
        public String DOC_SERIAL { get; set; }
        public String DOC_NUMBER { get; set; }
        public DateTime DATE_FROM { get; set; }
        public DateTime DATE_TO { get; set; }
        public String CUST_NAME { get; set; }
        public Int16 STATE { get; set; }
        public String C_STATE { get; set; }
        public Int64? DECL_ID { get; set; }
        public DateTime? CRT_DATE { get; set; }
        public String DONEBY_FIO { get; set; }
        public String BRANCH { get; set; }
        public String COMM { get; set; }
        public DateTime ADD_DATE { get; set; }
        public Int32 ADD_FIO { get; set; }
    }
}