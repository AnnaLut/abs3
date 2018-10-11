using System.Collections.Generic;
using BarsWeb.Areas.Zay.Models;

namespace BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract
{
	public interface ICurrencyOperations
	{
        IList<Nmk> GetCustomerNmk(decimal rnk);
        IList<Nmk> GetTabvalName(decimal dfKV);
        IList<Nmk> GetApplication(decimal dfID, decimal dfKV, decimal dfRNK, decimal nDk);
        void DeleteApplication(decimal dfID);
        void RestoreApplication(decimal dfID);
        IList<Nmk> GetNrefSos(decimal nRef);
        IList<ZAY_SPLITTING_AMOUNT> GetCurEarning();
        IList<V_ZAY_SPLIT_AMOUNT> GetSplitSum(_Spliter _data);
        void SaveSplitSettings(V_ZAY_SPLIT_AMOUNT _datam, decimal nREF);
        void DeleteSetting(decimal ID);
        string GetFNameKb(long id);
        GetFileFromClModel GetModelFileForCl(long id);

    }
}