using Bars.WebServices.MSP.Models;
using System;

namespace Bars.WebServices.MSP
{
    public class McpResultHolder : IResultHolder
    {
        public string HeaderError()
        {
            return Models.Utils.Serialize(new PaymentDataAns
            {
                rq_st = "D",
                rq_st_detail = "Неправильний 'Action - Type' в хедері запиту"
            });
        }

        public string SaveDataError(string error)
        {
            return Models.Utils.Serialize(new PaymentDataAns
            {
                rq_st = "D",
                rq_st_detail = "Помилка запису в БД. Повторіть через деякий час. " + error
            });
        }
    }
}