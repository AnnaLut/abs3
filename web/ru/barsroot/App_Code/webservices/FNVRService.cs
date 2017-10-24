using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Data;


using Bars.Application;
using Bars.Classes;
using barsroot.core;

using Oracle.DataAccess.Client;
using System.Runtime.Serialization;


namespace Bars.FNVR
{


    /// <summary>
    /// рядок для запису в таблицю
    /// </summary>
    [DataContract]
    public struct FNVRDataRow
    {
        [DataMember]
        public Decimal ID_CALC_SET;
        [DataMember]
        public String ID_BRANCH;
        [DataMember]
        public String UBARS;
        [DataMember]
        public String BRANCHID;
        [DataMember]
        public String RNKC;
        [DataMember]
        public String CURR;
        [DataMember]
        public Decimal PBALANCE;
        [DataMember]
        public Decimal POFFBALANCE;
        [DataMember]
        public String PROVT;
        [DataMember]
        public String RISKG;
        [DataMember]
        public String COMM;
        [DataMember]
        public String CONTR;
        [DataMember]
        public String RISKST;
        [DataMember]
        public Decimal ISDEF;
        [DataMember]
        public String RISKP;
        [DataMember]
        public Decimal PD;
        [DataMember]
        public Decimal LGD;
        [DataMember]
        public Decimal AIRC;
        [DataMember]
        public Decimal IRC;


        public FNVRDataRow(Decimal ID_CALC_SET, String ID_BRANCH, String UBARS,
                            String BRANCHID, String RNKC, String CURR,
                            Decimal PBALANCE, Decimal POFFBALANCE, String PROVT,
                            String RISKG, String COMM, String CONTR, String RISKST,
                            Decimal ISDEF, String RISKP, Decimal PD, Decimal LGD, Decimal AIRC, Decimal IRC)
        {
            this.ID_CALC_SET = ID_CALC_SET;
            this.ID_BRANCH = ID_BRANCH;
            this.UBARS = UBARS;
            this.BRANCHID = BRANCHID;
            this.RNKC = RNKC;
            this.CURR = CURR;
            this.PBALANCE = PBALANCE;
            this.POFFBALANCE = POFFBALANCE;
            this.PROVT = PROVT;
            this.RISKG = RISKG;
            this.COMM = COMM;
            this.CONTR = CONTR;
            this.RISKST = RISKST;
            this.ISDEF = ISDEF;
            this.RISKP = RISKP;
            this.PD = PD;
            this.LGD = LGD;
            this.AIRC = AIRC;
            this.IRC = IRC;
        }

        public void DeleteRows(OracleConnection con, decimal id)
        {
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "delete from PRVN_FV_REZ where ID_CALC_SET=:p_ID_CALC_SET";
            cmd.Parameters.Add(new OracleParameter("p_ID_CALC_SET", OracleDbType.Decimal, id, ParameterDirection.Input));
            cmd.ExecuteNonQuery();
        }

        public void WriteRow(OracleConnection con)
        {
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.BindByName = true;
            cmd.CommandText = "insert into PRVN_FV_REZ( ID_CALC_SET, ID_BRANCH, UNIQUE_BARS_IS, BARS_BRANCH_ID, RNK_CLIENT, ID_CURRENCY, PROV_BALANCE_CCY," +
                "PROV_OFFBALANCE_CCY, ID_PROV_TYPE, ID_RISK_GROUP_PD, ID_COMMITMENT, ID_CONTRACT, ID_RISK_STATUS, IS_DEFAULT, ID_RISK_PORTF_PD, PD, LGD, AIRC_CCY, IRC_CCY)" +
               " values (:p_ID_CALC_SET ,:p_ID_BRANCH ,:p_UNIQUE_BARS_IS,:p_BARS_BRANCH_ID ,:p_RNK_CLIENT ,:p_ID_CURRENCY ,:p_PROV_BALANCE_CCY ," +
        ":p_PROV_OFFBALANCE_CCY,:p_ID_PROV_TYPE,:p_ID_RISK_GROUP_PD,:p_ID_COMMITMENT,:p_ID_CONTRACT,:p_ID_RISK_STATUS,:p_IS_DEFAULT,:p_ID_RISK_PORTF_PD,:p_PD,:p_LGD, :p_AIRC_CCY, :p_IRC_CCY)";

            cmd.Parameters.Add(new OracleParameter("p_ID_CALC_SET", OracleDbType.Decimal, this.ID_CALC_SET, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_ID_BRANCH", OracleDbType.Varchar2, this.ID_BRANCH, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_UNIQUE_BARS_IS", OracleDbType.Varchar2, this.UBARS, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_BARS_BRANCH_ID", OracleDbType.Varchar2, this.BRANCHID, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_RNK_CLIENT", OracleDbType.Varchar2, this.RNKC, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_ID_CURRENCY", OracleDbType.Varchar2, this.CURR, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_PROV_BALANCE_CCY", OracleDbType.Decimal, this.PBALANCE, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_PROV_OFFBALANCE_CCY", OracleDbType.Decimal, this.POFFBALANCE, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_ID_PROV_TYPE", OracleDbType.Varchar2, this.PROVT, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_ID_RISK_GROUP_PD", OracleDbType.Varchar2, this.RISKG, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_ID_COMMITMENT", OracleDbType.Varchar2, this.COMM, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_ID_CONTRACT", OracleDbType.Varchar2, this.CONTR, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_ID_RISK_STATUS", OracleDbType.Varchar2, this.RISKST, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_IS_DEFAULT", OracleDbType.Decimal, this.ISDEF, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_ID_RISK_PORTF_PD", OracleDbType.Varchar2, this.RISKP, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_PD", OracleDbType.Decimal, this.PD, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_LGD", OracleDbType.Decimal, this.LGD, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_AIRC_CCY", OracleDbType.Decimal, this.AIRC, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_IRC_CCY", OracleDbType.Decimal, this.IRC, ParameterDirection.Input));
            cmd.ExecuteNonQuery();


        }

    }


    /// <summary>
    /// Сервис для интеграции с FNVR
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class FNVRService : Bars.BarsWebService
    {
        # region Константы
        # endregion

        # region Конструкторы
        public FNVRService()
        {
        }
        # endregion

        # region Статические свойства
        # endregion

        # region Приватные методы
        private string GetHostName()
        {
            string userHost = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            if (String.IsNullOrEmpty(userHost) || String.Compare(userHost, "unknown", true) == 0)
                userHost = HttpContext.Current.Request.UserHostAddress;

            if (String.Compare(userHost, HttpContext.Current.Request.UserHostName) != 0)
                userHost += " (" + HttpContext.Current.Request.UserHostName + ")";

            return userHost;
        }
        private void LoginUser(String userName)
        {
            // информация о текущем пользователе
            UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);

            try
            { 
                InitOraConnection();
                // установка первичных параметров
                SetParameters("p_session_id", DB_TYPE.Varchar2, Session.SessionID, DIRECTION.Input);
                SetParameters("p_user_id", DB_TYPE.Varchar2, userMap.user_id, DIRECTION.Input);
                SetParameters("p_hostname", DB_TYPE.Varchar2, GetHostName(), DIRECTION.Input);
                SetParameters("p_appname", DB_TYPE.Varchar2, "barsroot", DIRECTION.Input);
                SQL_PROCEDURE("bars.bars_login.login_user");
            }
            finally
            {
                DisposeOraConnection();
            }

            // Если выполнили установку параметров
            Session["UserLoggedIn"] = true;
        }
        #endregion

        #region Веб-методы

        [WebMethod(EnableSession = true)]
        public void GetFNVRData(String WSProxyUserName, String WSProxyPassword, List<FNVRDataRow> FNVRData)
        {
            // авторизация пользователя, в случае ошибки она полетит к вызывающей стороне
            Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(WSProxyUserName, WSProxyPassword, true);
            if (isAuthenticated)
            {
                LoginUser(WSProxyUserName);
                // Bars.Logger.DBLogger.Info("FNVRService.WSProxyUserName= " + WSProxyUserName);
            }
            /*else
            {
                Bars.Logger.DBLogger.Info("WSProxyUserName= Noname" + WSProxyUserName);
            }*/
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();

            try
            {
                if (con.State != ConnectionState.Open)
                    con.Open();

                decimal idForDel = -1;
                // Начинаем сессию взаимодействия и вычитываем сообщение і пишемо в таблицю
                foreach (FNVRDataRow inputData in FNVRData)
                {
                    if (idForDel != inputData.ID_CALC_SET)
                    {
                        idForDel = inputData.ID_CALC_SET;
                        inputData.DeleteRows(con, idForDel);
                    }
                    inputData.WriteRow(con);
                }
            }
            finally
            {
                con.Close();
            }


        }
        #endregion


        #region Статические методы

        #endregion
    }
}