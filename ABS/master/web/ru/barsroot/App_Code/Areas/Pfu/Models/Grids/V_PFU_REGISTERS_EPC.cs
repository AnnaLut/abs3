using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for V_PFU_REGISTERS_EPC
/// </summary>
public class V_PFU_REGISTERS_EPC
{
    public decimal ID { get; set; }
    public decimal NAME { get; set; }
    public DateTime BATCH_DATE { get; set; }//	Дата створення
    public decimal BATCH_LINES_COUNT { get; set; } //Кількість рядків
    public decimal? COUNT_GOOD { get; set; } //Кількість рядків до сплати
    public string STATE { get; set; } //Статус реєстру    
}