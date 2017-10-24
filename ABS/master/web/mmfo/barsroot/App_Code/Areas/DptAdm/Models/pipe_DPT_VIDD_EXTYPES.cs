using System;

namespace BarsWeb.Areas.DptAdm.Models
{
    public class pipe_DPT_VIDD_EXTYPES
    {
        public decimal ID { get; set; }	            //Код метода
        public string NAME { get; set; }	        //Описание метода
        public string BONUS_PROC { get; set; }	    //Процедура расчета и начисления бонуса
        public string BONUS_RATE { get; set; }	    //Выражение для расчета бонусной ставки + проверка допустимости получения бонуса
        public string EXT_CONDITION { get; set; }	//SQL-выражение для проверки допустимости переоформления
    }
}