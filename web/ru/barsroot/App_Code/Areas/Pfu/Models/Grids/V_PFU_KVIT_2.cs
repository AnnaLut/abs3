using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for V_PFU_KVIT_2
/// </summary>
public class V_PFU_KVIT_2
{
    public int ID { get; set; }
    public int? ENVELOPE_REQUEST_ID { get; set; }
    public decimal? CHECK_SUM { get; set; }
    public int? CHECK_LINES_COUNT { get; set; }
    public DateTime? PAYMENT_DATE { get; set; }
    public int? FILE_NUMBER { get; set; }
    public string FILE_NAME { get; set; }
    public byte[] FILE_DATA { get; set; }
    public string STATE_NAME { get; set; }
    public DateTime? CRT_DATE { get; set; }
    public byte[] DATA_SIGN { get; set; }
    public string USERNAME { get; set; }
}