using System;

namespace BarsWeb.Areas.DptAdm.Models
{
    public class pipe_BRATES
    {
        public decimal BR_ID { get; set; }	    //Код базовой ставки
        public string NAME { get; set; }        //Наименование
        public decimal BR_TYPE { get; set; }    //Тип базовой процентной ставки       
        public string COMM { get; set; }        //опис
	    public string FORMULA { get; set; }     //SQL-формула для типа ставки =4
        public int INUSE { get; set; }	        //1 - діюча, 0 - недіюча
    }
}