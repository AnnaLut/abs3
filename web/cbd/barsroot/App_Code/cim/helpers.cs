using System;
using System.Text;
using System.Collections.Generic;
using System.Web;
using Oracle.DataAccess.Client;
using Bars.Logger;

namespace barsroot.cim
{
    public class ErrorHelper
    {
        public static string AnalyzeException(Exception ex, ref decimal? rec_id)
        {
            rec_id = -1;
            StringBuilder clientMessage = new StringBuilder();
            clientMessage.AppendLine("Помилка на сторінці.");

            // Исключение oracle пользовательское
            if (ex is OracleException)
            {
                string message = ex.Message;
                if (message.Split(new string[] { "ORA-" }, StringSplitOptions.None).Length > 1)
                {
                    message = message.Split(new string[] { "ORA-" }, StringSplitOptions.None)[1];
                    message = message.Substring(message.IndexOf(' ') + 1);
                }
                clientMessage.AppendLine(message);
            }
            // Наше исключение
            else if (ex is Bars.Exception.BarsException)
            {
                clientMessage.AppendLine(ex.Message);
            }
            else
            {
                clientMessage.AppendLine(ex.Message);
            }

            // Запись в журнал аудита
            try
            {
                rec_id = DBLogger.Exception(ex);
            }
            catch (Exception exept)
            {
                clientMessage.Append("Помилка запису в журнал аудиту");
                if (CimManager.IsDebug)
                    clientMessage.Append(" - " + exept.Message);
            }
            // для отладочной версии показываем полную ошибку
            if (CimManager.IsDebug)
            {
                clientMessage.AppendLine("Номер запису в журналі аудиту: " + rec_id);
                try
                {
                    for (Exception currEx = ex; currEx != null; currEx = currEx.InnerException)
                    {
                        clientMessage.AppendLine("Message: " + currEx.Message);
                        clientMessage.AppendLine("StackTrace: " + currEx.StackTrace);
                        clientMessage.AppendLine("");
                    }
                }
                catch { }
            }

            return clientMessage.ToString().Replace("\n", "<br>");
        }
    }

    /// <summary>
    /// Типовые константы для модуля
    /// </summary>
    public class Constants
    {
        // Сессионные ключи (Session[Constant.StateKeys...])
        public class StateKeys
        {
            public static readonly string LastError = "cim.LastError";
            public static readonly string LastErrorRecID = "cim.LastErrorRecId";
            public static readonly string Branch = "cim.Branch";
            public static readonly string BranchMask = "cim.BranchMask";
            public static readonly string BankDate = "cim.BankDate";
            public static readonly string VisaId = "cim.VisaId";
            public static readonly string BankId = "cim.BankId";
            public static readonly string UserId = "cim.UserId";
            public static readonly string SyncSide = "cim.SyncSide";
            public static readonly string CurrRef = "cim.CurrRef";
            public static readonly string ContrTaxCode = "cim.ContrTaxCode";
            public static readonly string ContrBenefName = "cim.ContrBenefName";
            public static readonly string ContrTypeId = "cim.ContrTypeId";
            public static readonly string ParamsPrintCorp2Doc = "cim.PrintCorp2Doc";
            public static readonly string ParamsAutoFillAllowDate = "cim.AutoFillAllowDate";
            public static readonly string ParamsContractOwnerFlag = "cim.ContractOwnerFlag";
            public static readonly string ParamsReqFilterCondition = "cim.ReqFilterCondition";
            
        }
    }
}