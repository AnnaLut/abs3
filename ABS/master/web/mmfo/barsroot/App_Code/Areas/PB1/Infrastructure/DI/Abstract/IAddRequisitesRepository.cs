using BarsWeb.Areas.PB1.Models;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;


namespace BarsWeb.Areas.PB1.Infrastructure.Repository.DI.Abstract
{
    public interface IAddRequisitesRepository
    {
        string GetBankDate();
        List<RequisitesGrid> GetGridData(string dc, string date);
        object GetParams(string date);
        List<object> GetText(string name);
        void SaveData(List<RequisitesGrid> data);
        void SaveLoroData(List<LoroBank> data);
        List<LoroBank> GetLoroBanks();
        LoroBank GetLoroParams(decimal refer);
        void DeleteLoroData(string okpo);
        string V_OKPO(string okpo);
        void OK(LoroBank data, decimal refer);
    }
}