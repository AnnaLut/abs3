using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for V_PFU_REGISTERS_LINES_EPC
/// </summary>
public class V_PFU_REGISTERS_LINES_EPC
{
    public string EPP_NUMBER { get; set; }
    public string FIO { get; set; }
    public string TAX_REGISTRATION_NUMBER { get; set; }
    public string PHONE_NUMBERS { get; set; }
    public string DOCUMENT_ID { get; set; }
    public string TYPE { get; set; }
    public string BANK_NUM { get; set; }
    //public string error_code { get; set; }
    public string ERR_TAG { get; set; }     //OracleClob
    public int? STATE_ID { get; set; }
    public string ACCOUNT_NUMBER { get; set; }
}