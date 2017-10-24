using System;
namespace BarsWeb.Areas.OpenCloseDay.Infrastructure.DI.Abstract
{
    public interface IDateOperation
    {
        string GetCurrentDate();
        void CloseBankDay();
        bool CheckPass(string pass);
        void CreateDay(DateTime p_next_bank_date);
        string GetNetDate();
    }
}