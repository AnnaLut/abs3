using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using BarsWeb.Areas.Teller.Model;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Teller.Patterns.TellerWindowStatus
{
    /// <summary>
    /// выполнение запроса GetWindowStatus
    /// </summary>
    public class GetWindowStatusExecute: AbstractExecute<ATMModel, TellerWindowStatusModel>
    {        
        public GetWindowStatusExecute()
        {
            sql = "bars.teller_tools.get_window_status";
            model = new TellerWindowStatusModel();
        }
        public override TellerWindowStatusModel Implement(AbstractOracleParameters<ATMModel> abstractParameters, OracleCommand command)
        {
            Execute(abstractParameters, command);
            model.Amount = GetValueFromOracleDecimal(       list.FirstOrDefault(x =>    x.ParameterName == "p_amount"));
            model.Status = GetValueFromOracleString(        list.FirstOrDefault(x =>    x.ParameterName == "result"));
            model.OperDesc = GetValueFromOracleString(      list.FirstOrDefault(x =>    x.ParameterName == "p_oper_desc"));
            model.Currency = GetValueFromOracleString(      list.FirstOrDefault(x =>    x.ParameterName == "p_currency"));
            model.StatusText = GetValueFromOracleString(    list.FirstOrDefault(x =>    x.ParameterName == "p_atm"));

            if(abstractParameters.Model.Ref == "0" && abstractParameters.Model.SbonFlag == 1)
                model.Ref = GetIntValueFromOracleDecimal(   list.FirstOrDefault(x =>    x.ParameterName == "p_doc_ref")).ToString();
            model.RejectFlag = GetIntValueFromOracleDecimal(list.FirstOrDefault(x =>    x.ParameterName == "p_reject_flag"));

            model.Message = "OK";
            if (abstractParameters.Model.RJ && model.Status == "RJ")
                model.Status = "Done";
            if (model.Status == "ER" || model.Status == "RJ")
            {
                model.Message = model.OperDesc;
                model.Status = "ERR";
            }
            else if (String.IsNullOrEmpty(model.OperDesc) && String.IsNullOrEmpty(model.Currency) && model.Amount == 0 && model.Status != "OK")
                model.Status = "ERR";
            else if (model.StatusText.StartsWith("Неможливо встановити з&apos;єднання"))
            {
                model.Status = "ERR";
                model.Message = HttpUtility.HtmlDecode(model.StatusText) + " з АТМ";
            }
            return model;
        }
    }
}