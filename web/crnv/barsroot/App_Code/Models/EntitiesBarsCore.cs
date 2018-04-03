using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.Objects;
using Models;
using barsroot.Models;


namespace barsroot.Models
{
    /// <summary>
    /// Сводное описание для EntitiesBarsCore
    /// </summary>
    public partial class EntitiesBarsCore 
    { 
        public EntitiesBars newentity;

        public EntitiesBarsCore(string connectioStr = "")
        {
            connectioStr = string.IsNullOrWhiteSpace(connectioStr) ? UserConnStr() : connectioStr;
            newentity = new EntitiesBars(connectioStr);
            newentity.Connection.StateChange += new System.Data.StateChangeEventHandler(OnStateChange);
        }

        /// <summary>
        /// обработка события открытия подключения
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="ev"></param>
        public void OnStateChange(object sender, StateChangeEventArgs ev)
        {
            if (ev.OriginalState != ConnectionState.Open && ev.CurrentState == ConnectionState.Open)
            {
                try
                {
                    newentity.ExecuteStoreCommand("begin bars.bars_login.set_user_session('" + System.Web.HttpContext.Current.Session.SessionID + "'); end;");
                }
                catch (Oracle.DataAccess.Client.OracleException ex)
                {
                    if (ex.Message.StartsWith("ORA-20984") /*Банковский день закрыт*/ ||
                            ex.Message.StartsWith("ORA-20982") /*Попытка представления сессией без ее регистрации с помощью LOGIN_USER*/ ||
                            ex.Message.StartsWith("ORA-20981") /*Не передан идентификатор сессии или он пустой*/
                           )
                    {
                        System.Web.HttpContext.Current.Session.Abandon();
                        if (ex.Message.StartsWith("ORA-20984"))
                        {
                            System.Web.HttpContext.Current.Response.Write("<script language=javascript>alert('Банківський день закрито. Спробуйте перезайти в систему.');parent.location.reload();</script>");
                            System.Web.HttpContext.Current.Response.Flush();
                        }
                    }
                    else
                        throw ex;
                }
                finally
                {

                }
            }
            else
            {
                //newentity.Dispose();
            }
        }
        /// <summary>
        /// строка подключения пользователя для EF
        /// </summary>
        /// <returns></returns>
        private string UserConnStr()
        {
            string connStr = "metadata=res://*/App_Code.Models.EntityBarsModel.csdl|res://*/App_Code.Models.EntityBarsModel.ssdl|res://*/App_Code.Models.EntityBarsModel.msl;provider=Oracle.DataAccess.Client;";
            connStr += "provider connection string=\"";
            string userConnStr = "";
            try
            { userConnStr = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString(); }
            catch (Exception e){ var t = e; }
            finally{ connStr += userConnStr + "\""; }
            return connStr;
        }
        /// <summary>
        /// создание контекста модели
        /// </summary>
        /// <param name="connectioStr">строка подключения к базе(если параметр не передавать то стороку вернет UserConnStr())</param>
        /// <returns>новый контекст EntitiesBars()</returns>
        public EntitiesBars GetEntitiesBars(string connectioStr="")
        {
            connectioStr = string.IsNullOrWhiteSpace(connectioStr) ? UserConnStr() : connectioStr;
            newentity = new EntitiesBars(connectioStr);
            newentity.Connection.StateChange += new System.Data.StateChangeEventHandler(OnStateChange);
            return newentity;
        }
    }

    public class V_VISALIST
    {
        public decimal? REF { get; set; }
        public decimal? COUNTER { get; set; }
        public decimal? SQNC { get; set; }
        public string MARK { get; set; }
        public decimal? MARKID { get; set; }
        public string CHECKGROUP { get; set; }
        public string USERNAME { get; set; }
        public DateTime? DAT { get; set; }
        public decimal? INCHARGE { get; set; }
        public decimal? SIGN_FLAG { get; set; }
        public string BUFINT { get; set; }
    }

    public class DtSystemSignParams
    {
        public decimal SIGNLNG { get; set; }
        public string DOCKEY { get; set; }
        public string BDATE { get; set; }
        public decimal SEPNUM { get; set; }
        public string SIGNTYPE { get; set; }
        public decimal VISASIGN { get; set; }
        public decimal INTSIGN { get; set; }
        public string REGNCODE { get; set; }
        public string EXTSIGNBUFF { get; set; }
    }
    /// <summary>
    /// клас справочника (valueID,valueNAME)
    /// </summary>
    public class Handbook
    {
        public string ID { get; set; }
        public string NAME { get; set; }
        public string DATA { get; set; }
    }

    public class V_CUST_RELATIONS
    {
        public decimal RNK { get; set; }
        public decimal? REL_INTEXT { get; set; }
        public decimal? RELEXT_ID { get; set; }
        public decimal? RELCUST_RNK { get; set; }
        public string NAME { get; set; }
        public decimal? DOC_TYPE { get; set; }
        public string DOC_NAME { get; set; }
        public string DOC_SERIAL { get; set; }
        public string DOC_NUMBER { get; set; }
        public DateTime? DOC_DATE { get; set; }
        public string DOC_ISSUER { get; set; }
        public DateTime? BIRTHDAY { get; set; }
        public string BIRTHPLACE { get; set; }
        public string SEX { get; set; }
        public string SEX_NAME { get; set; }
        public string ADR { get; set; }
        public string TEL { get; set; }
        public string EMAIL { get; set; }
        public decimal? CUSTTYPE { get; set; }
        public string OKPO { get; set; }
        public decimal? COUNTRY { get; set; }
        public string COUNTRY_NAME { get; set; }
        public string REGION { get; set; }
        public string FS { get; set; }
        public string FS_NAME { get; set; }
        public string VED { get; set; }
        public string VED_NAME { get; set; }
        public string SED { get; set; }
        public string SED_NAME { get; set; }
        public string ISE { get; set; }
        public string ISE_NAME { get; set; }
        public string NOTES { get; set; }
    }

    public class V_CUST_REL_TYPES
    {
        public decimal? ID { get; set; }
        public string NAME { get; set; } 
        public string DATASET_ID { get; set; } 
    }

    public class V_CUSTOMER_REL
    {
        public decimal? RNK { get; set; }
        public decimal? REL_ID { get; set; }
        public decimal? REL_RNK { get; set; }
        public decimal? REL_INTEXT { get; set; }
        public string NAME { get; set; }
        public decimal? DOC_TYPE { get; set; }
        public string DOC_SERIAL { get; set; }
        public string DOC_NUMBER { get; set; }
        public DateTime? DOC_DATE { get; set; }
        public string DOC_ISSUER { get; set; }
        public DateTime? BIRTHDAY { get; set; }
        public string BIRTHPLACE { get; set; }
        public string SEX { get; set; }
        public string ADR { get; set; }
        public string TEL { get; set; }
        public string EMAIL { get; set; }
        public decimal? CUSTTYPE { get; set; }
        public string OKPO { get; set; }
        public decimal? COUNTRY { get; set; }
        public string REGION { get; set; }
        public string FS { get; set; }
        public string VED { get; set; }
        public string SED { get; set; }
        public string ISE { get; set; }
        public string NOTES { get; set; }
        public decimal? VAGA1 { get; set; }
        public decimal? VAGA2 { get; set; }
        public decimal? TYPE_ID { get; set; }
        public string POSITION { get; set; }
        public string FIRST_NAME { get; set; }
        public string MIDDLE_NAME { get; set; }
        public string LAST_NAME { get; set; }
        public decimal? DOCUMENT_TYPE_ID { get; set; }
        public string DOCUMENT { get; set; }
        public string TRUST_REGNUM { get; set; }
        public DateTime? TRUST_REGDAT { get; set; }
        public DateTime? BDATE { get; set; }
        public DateTime? EDATE { get; set; }
        public string NOTARY_NAME { get; set; }
        public string NOTARY_REGION { get; set; }
        public decimal? SIGN_PRIVS { get; set; }
        public decimal? SIGN_ID { get; set; }
        public string NAME_R { get; set; }
    }

    public class CUSTOMER_UPDATE_HISTORY
    {
        public string PAR { get; set; }
        public string TABNAME { get; set; }
        public string OLD { get; set; }
        public string NEW { get; set; }
        public string DAT { get; set; }
        public string USR { get; set; }
        public string FIO { get; set; }
    }
}