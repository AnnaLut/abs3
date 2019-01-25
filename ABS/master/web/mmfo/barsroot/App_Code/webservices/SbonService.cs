using Bars;
using Bars.Application;
using Bars.Classes;
using Bars.WebServices;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;

/// <summary>
/// Summary description for SbonLimit
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class SbonService : BarsWebService
{
    private String p_errtxt { get; set; }

    [WebMethod(EnableSession = true)]
    public SbonResultModel RegisterTransaction(SbonCheckModel data)
    {
        return GetResponse(data, "RegisterTransaction");
    }

    [WebMethod(EnableSession = true)]
    public SbonResultModel IsTeller(SbonCheckModel data) {
        return GetResponse(data, "IsTeller");
    }

    [WebMethod(EnableSession = true)]
    public SbonResultModel UpdateTransaction(SbonCheckModel data)
    {
        return GetResponse(data, "UpdateTransaction");
    }

    private SbonResultModel GetResponse(SbonCheckModel data, String action)
    {
        SbonResultModel req = new SbonResultModel();
        req.code = "0";
        if (!ValidateData(data, action))
            req.message = "структура повідомлення не відповідає загальній схемі";
        else
        {
            req.message = "Помилка при запиті";
            if (action == "IsTeller")
                req.message = "Немає прав для доступу";
            try
            {
                if (IsAsbUser(data.login))
                {
                    using (OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                    {
                        if (action == "RegisterTransaction")
                        {
                            Int32 result = String.IsNullOrEmpty(data.code) ? OperationRequest(con, data.sum, data.login, data.user_ip) : OperationRequest(con, data.sum, p_user: data.login, user_ip: data.user_ip, code: data.code);
                            if (result == -1)
                                req.message = "Немає доступу до проведення операції";
                            else if (result == 0)
                                req.message = p_errtxt;
                            else if (result > 0)
                            {
                                req.code = result.ToString();
                                req.message = "OK";
                            }
                        }
                        else if (action == "IsTeller")
                        {
                            Int32 hasRole = IsTellerUser(con, data.login);
                            if (hasRole == 1)
                            {
                                req.code = "1";
                                req.message = "Ok";
                            }
                            else
                                req.message = "Немає прав для доступу";
                        }
                        else if (action == "UpdateTransaction")
                        {
                            Int32 status = UpdateOperation(con, data.id, data.operation.ToUpper(), data.user_ip);
                            if (status == 1)
                            {
                                req.code = "1";
                                req.message = "OK";
                            }
                            else if (status == 0)
                                req.message = p_errtxt;
                        }
                    }
                }
            }
            catch (Exception e) { req.message = e.Message; }
            finally
            {
                DisposeOraConnection();
            }
        }
        return req;
    }

    private Boolean ValidateData(SbonCheckModel data, String action)
    {
        Boolean isValid = false;
        switch(action)
        {
            case "RegisterTransaction":
                if (data != null || !String.IsNullOrEmpty(data.login))
                    isValid = true;
                break;
            case "IsTeller":
                if (data != null || !String.IsNullOrEmpty(data.login))
                    isValid = true;
                break;
            case "UpdateTransaction":
                if (data != null || !String.IsNullOrEmpty(data.login) && !String.IsNullOrEmpty(data.operation) && !String.IsNullOrEmpty(data.id))
                    isValid = true;
                break;
        }
        return isValid;
    }

    private Boolean IsAsbUser(String login)
    {
        try
        {
            LoginUserInt(login);
        }
        catch (Exception) { return false; }
        return true;
    }

    private Int32 OperationRequest(OracleConnection con, Decimal sum, String p_user, String user_ip, String code = "SBN")
    {
        Int32 result = -2;
        
        using (OracleCommand cmd = con.CreateCommand())
        {
            cmd.Parameters.Clear();
            cmd.CommandText = "bars.teller_tools.registry_sbon_operation";
            cmd.BindByName = true;
            cmd.CommandType = CommandType.StoredProcedure;
            var resultObject = new OracleParameter("result", OracleDbType.Int32, ParameterDirection.ReturnValue);
            cmd.Parameters.Add(resultObject);
            cmd.Parameters.Add("p_user", OracleDbType.Varchar2, p_user, ParameterDirection.Input);
            cmd.Parameters.Add("p_user_ip", OracleDbType.Varchar2, user_ip, ParameterDirection.Input);
            cmd.Parameters.Add("p_op_code", OracleDbType.Varchar2, code, ParameterDirection.Input);
            Int32 s = Convert.ToInt32(sum);            
            cmd.Parameters.Add("p_op_amount", OracleDbType.Int32, s, ParameterDirection.Input);
            OracleParameter retV = new OracleParameter("p_errtxt", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
            cmd.Parameters.Add(retV);
            cmd.ExecuteNonQuery();
            if (retV.Value.ToString() != "null" && retV.Value.ToString() != "")
                p_errtxt = ((OracleString)retV.Value).Value;
            try { result = Convert.ToInt32(resultObject.Value.ToString()); }
            catch (InvalidCastException) { result = 0; }
            
        }
        return result;
    }

    private Int32 UpdateOperation(OracleConnection con, String transactionCode, String operation, String user_ip)
    {
        Int32 result = -2;

        using (OracleCommand cmd = con.CreateCommand())
        {
            cmd.Parameters.Clear();
            cmd.CommandText = "bars.teller_tools.update_oper";
            cmd.BindByName = true;
            cmd.CommandType = CommandType.StoredProcedure;
            var resultObject = new OracleParameter("number", OracleDbType.Int32, ParameterDirection.ReturnValue);
            cmd.Parameters.Add(resultObject);
            cmd.Parameters.Add("p_id", OracleDbType.Varchar2, transactionCode, ParameterDirection.Input);
            cmd.Parameters.Add("p_user_ip", OracleDbType.Varchar2, user_ip, ParameterDirection.Input);
            cmd.Parameters.Add("p_action", OracleDbType.Varchar2, operation, ParameterDirection.Input);
            OracleParameter retV = new OracleParameter("p_errtxt", OracleDbType.Varchar2, ParameterDirection.Output);
            cmd.Parameters.Add(retV);
            cmd.ExecuteNonQuery();
            if (retV.Value.ToString() != "null")
                p_errtxt = ((OracleString)retV.Value).Value;
            result = Convert.ToInt32(resultObject.Value.ToString());

        }
        return result;
    }

    private Int32 IsTellerUser(OracleConnection con, String p_user)
    {
        Int32 result = -1;
        using (OracleCommand cmd = con.CreateCommand())
        {
            cmd.Parameters.Clear();
            cmd.CommandText = "bars.teller_tools.is_teller";
            cmd.BindByName = true;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("p_user", OracleDbType.Varchar2, p_user, ParameterDirection.Input);
            cmd.Parameters.Add("p_sbonflag", OracleDbType.Int32, 1, ParameterDirection.Input);
            var resultObject = new OracleParameter("HasTellerRole", OracleDbType.Int32, ParameterDirection.ReturnValue);
            cmd.Parameters.Add(resultObject);
            cmd.ExecuteNonQuery();
            result = Convert.ToInt32(resultObject.Value.ToString());

        }
        return result;
    }
}
