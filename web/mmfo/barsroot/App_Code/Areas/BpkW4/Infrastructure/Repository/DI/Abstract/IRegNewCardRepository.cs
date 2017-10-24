using BarsWeb.Areas.BpkW4.Models;
using BarsWeb.Areas.InsUi.Models.Transport;
using System.Linq;
using System.Collections.Generic;
using Kendo.Mvc.UI;
using Oracle.DataAccess.Client;


namespace BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Abstract 
{
    public interface IRegNewCardRepository
    {
        RegNewValue GetCardValue(decimal rnk, decimal proectId, string cardCode, bool isIns);
        RegExternal GetExternal(decimal rnk);
        RespOpenCard OpenCard(RegNewValue par);
        ParamsIns GetIsIns(string cardCode);
        void SetInsId(decimal nd, decimal ins_id, decimal tmp_id);
        ParamsBpkIns GetBpkInsParams(decimal nd, string deal_id, string table);
        ParamsEwa GetParamsEwa(decimal nd, decimal typeIns, OracleCommand cmd);
    }
}