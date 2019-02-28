using System.Collections.Generic;
using BarsWeb.Areas.Zay.Models;

namespace BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract
{
    /// <summary>
    /// Довідники перегляду додаткових реквізитів заявки купівлі/продажу валюти
    /// </summary>
    public interface ICurrencyDictionary
    {
        IEnumerable<ZAY_AIMS> ZayAimsDictionary(bool isBuying);
        IEnumerable<ZAY_BuyContract> ContractDictionary(decimal rnk);
        IEnumerable<F092Model> F092Dictionary();
        IEnumerable<Country> CountryDictionary();
        IEnumerable<v_rc_bnk> RcBankDictionary(); 
        IEnumerable<v_kod_70_2> Kod70_2Dictionary();
        IEnumerable<v_kod_70_4> Kod70_4Dictionary();
        IEnumerable<ZAY_BACK> ReasonDictionary();
        IEnumerable<v_kod_d3_1> AimDescriptionDictionary();
        IEnumerable<ZAY_PRIORITY> PrioritysDictionary();
        IEnumerable<ZAY_CLOSE_TYPES> CloseTypes();
        IEnumerable<V_P12_2C> OperMarkDictionary();
        IEnumerable<V_P_L_2C> CodeImportDictionary();
        IEnumerable<CurrencyPair> CurrencyPairsDictionary();
        IEnumerable<Kurs> KursDictionary();
        DilerIndCurrentRate DilerIndRate(decimal kv);
        DilerFactCurrentRate DilerFactRate(decimal kv);
        decimal? DilerConversionRate(decimal id, decimal kvF, decimal kvS);
        IEnumerable<VizaStatus> VizaStatusData(decimal id);
    }
}