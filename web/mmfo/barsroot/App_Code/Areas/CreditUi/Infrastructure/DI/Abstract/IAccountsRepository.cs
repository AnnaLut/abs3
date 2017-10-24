using System.Linq;
using BarsWeb.Areas.CreditUi.Models;
using System;
using System.Collections.Generic;


namespace BarsWeb.Areas.CreditUi.Infrastructure.DI.Abstract
{
    public interface IAccountsRepository
    {
        IQueryable<Account> GetAccounts(decimal refID);
        AccountStaticData GetStaticData(decimal nd);
        void CloseKD(decimal nd);
        void Lim9129(decimal nd);
        void DelAccountWithoutClose(decimal nd, decimal acc, string tip);
        void ConnectAccountWithKD(decimal nd, string nls, int kv);
        void UpdateAccount(UpdateAccount data);
        void Remain8999(decimal nd);
        void AutoSG(decimal nd);
        List<KVList> GetKV();
        void setMasIni(decimal nd);
    }
}