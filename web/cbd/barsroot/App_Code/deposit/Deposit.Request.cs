using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;
using Bars.Logger;
using Bars.Oracle;
using Oracle.DataAccess.Client;

namespace Bars.Requests
{
    /// <summary>
    /// Запити на доступ (депозитний модуль)
    /// </summary>
    public class DepositRequest
    {
        /// <summary>
        /// Ідентифікатор запиту
        /// </summary>
        private Int32? REQ_ID;
        public Int32 ID
        {
            get
            {
                return this.REQ_ID.Value;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private List<AccessInfo> ACCESS_INFO;
        
        /// <summary>
        /// 
        /// </summary>
        public DepositRequest()
        {
            this.REQ_ID = null;
            this.ACCESS_INFO = new List<AccessInfo>();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="ReqAccessInfo"></param>
        public DepositRequest(List<AccessInfo> ReqAccessInfo)
        {
            this.REQ_ID = null;
            this.ACCESS_INFO = ReqAccessInfo;
        }

        /// <summary>
        /// 
        /// </summary>
        public DepositRequest(Int32 RequestID, List<AccessInfo> ReqAccessInfo)
        {
            this.REQ_ID = RequestID;
            this.ACCESS_INFO = ReqAccessInfo;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        private XmlDocument GetXML()
        {
            XmlDocument XmlDoc = new XmlDocument();

            XmlNode p_root = XmlDoc.CreateElement("AccessInfo");
            XmlDoc.AppendChild(p_root);
            
            for (int i = 0; i < this.ACCESS_INFO.Count; i++)
            {
                XmlNode p_row = XmlDoc.CreateElement("row");
                p_root.AppendChild(p_row);

                XmlNode ContractID = XmlDoc.CreateElement("ContractID");
                ContractID.InnerText = this.ACCESS_INFO[i].DPT_ID.ToString();
                p_row.AppendChild(ContractID);

                XmlNode Amount = XmlDoc.CreateElement("Amount");
                Amount.InnerText = this.ACCESS_INFO[i].AMOUNT.ToString("########0.00##");
                p_row.AppendChild(Amount);

                XmlNode Flags = XmlDoc.CreateElement("Flags");
                Flags.InnerText = ((this.ACCESS_INFO[i].FL_REPORT ? "1" : "0") + (this.ACCESS_INFO[i].FL_MONEY ? "1" : "0") +
                    (this.ACCESS_INFO[i].FL_EARLY ? "1" : "0") + (this.ACCESS_INFO[i].FL_AGREEMENTS ? "1" : "0"));
                p_row.AppendChild(Flags);
            }
            
            // DBLogger.Info("XmlDoc = " + Convert.ToString(XmlDoc.InnerXml), "deposit");
            
            return XmlDoc;
        }

        /// <summary>
        /// Збереження запиту в БД
        /// </summary>
        /// <param name="RequestType">Тип запиту (картка/депозити)</param>
        /// <param name="TrusteeType">Тип третьої особи</param>
        /// <param name="CustomerID">РНК</param>
        /// <param name="CertifNumber">Номер документу</param>
        /// <param name="CertifDate">Дата документу</param>
        /// <param name="StartDate"></param>
        /// <param name="FinishDate"></param>
        public void Save(Decimal RequestType, String TrusteeType, Decimal CustomerID, 
            String CertifNumber, DateTime CertifDate, DateTime StartDate, DateTime? FinishDate)
        {
            OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

            try
            {
                OracleCommand cmd = connect.CreateCommand();

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "ebp.create_access_request";
                cmd.BindByName = true;

                cmd.Parameters.Add("p_type", OracleDbType.Decimal, RequestType, ParameterDirection.Input);
                cmd.Parameters.Add("p_trustee", OracleDbType.Varchar2, TrusteeType, ParameterDirection.Input);
                cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, CustomerID, ParameterDirection.Input);
                cmd.Parameters.Add("p_cert_num", OracleDbType.Varchar2, CertifNumber, ParameterDirection.Input);
                cmd.Parameters.Add("p_cert_date", OracleDbType.Date, CertifDate, ParameterDirection.Input);
                cmd.Parameters.Add("p_date_start", OracleDbType.Date, StartDate, ParameterDirection.Input);
                cmd.Parameters.Add("p_date_finish", OracleDbType.Date, FinishDate, ParameterDirection.Input);
                cmd.Parameters.Add("p_access_info", OracleDbType.XmlType, this.GetXML().InnerXml, ParameterDirection.Input);

                cmd.Parameters.Add("p_reqid", OracleDbType.Decimal, this.REQ_ID, ParameterDirection.Output);

                cmd.ExecuteNonQuery();

                this.REQ_ID = Convert.ToInt32(Convert.ToString(cmd.Parameters["p_reqid"].Value));

                DBLogger.Info("Користувач створив макет запиту на доступ №" + this.REQ_ID.ToString() + " (для друку).", "deposit");
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                {
                    connect.Close();
                    connect.Dispose();
                }
            }

        }

        /// <summary>
        /// Зміна параметрів запиту на доступ
        /// </summary>
        /// <param name="RequestID">ІД запиту</param>
        /// <param name="CertifNumber">Номер свідоцтва</param>
        /// <param name="CertifDate">Дата свідоцтва</param>
        /// <param name="StartDate">Дата початку дії довіреності / вступу в права</param>
        /// <param name="FinishDate">Дата закінчення дії довіреності</param>
        public void Modify(String CertifNumber, DateTime CertifDate, DateTime StartDate, DateTime? FinishDate)
        {
            OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

            try
            {
                OracleCommand cmd = connect.CreateCommand();

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "ebp.modify_access_request";
                cmd.BindByName = true;

                cmd.Parameters.Add("p_reqid", OracleDbType.Decimal, this.REQ_ID, ParameterDirection.Input);
                cmd.Parameters.Add("p_cert_num", OracleDbType.Varchar2, CertifNumber, ParameterDirection.Input);
                cmd.Parameters.Add("p_cert_date", OracleDbType.Date, CertifDate, ParameterDirection.Input);
                cmd.Parameters.Add("p_date_start", OracleDbType.Date, StartDate, ParameterDirection.Input);
                cmd.Parameters.Add("p_date_finish", OracleDbType.Date, FinishDate, ParameterDirection.Input);
                cmd.Parameters.Add("p_access_info", OracleDbType.XmlType, this.GetXML().InnerXml, ParameterDirection.Input);

                cmd.ExecuteNonQuery();
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                {
                    connect.Close();
                    connect.Dispose();
                }
            }
        }

        /// <summary>
        /// обробка запиту (відмова / надання доступу до депозиту)
        /// </summary>
        public static void Process(Decimal Request_ID, Decimal Request_State, String Request_Comment)
        {
            OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

            try
            {
                OracleCommand cmd = connect.CreateCommand();

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "ebp.process_access_request";
                cmd.BindByName = true;

                cmd.Parameters.Add("p_reqid", OracleDbType.Decimal, Request_ID, ParameterDirection.Input);
                cmd.Parameters.Add("p_reqstate", OracleDbType.Decimal, Request_State, ParameterDirection.Input);
                cmd.Parameters.Add("p_comment", OracleDbType.Varchar2, Request_Comment, ParameterDirection.Input);

                cmd.ExecuteNonQuery();
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                {
                    connect.Close();
                    connect.Dispose();
                }
            }
        }

        
        /// <summary>
        /// закриття активного запиту на БЕК в поточному ТВБВ при завершенні роботи з клієнтом
        /// </summary>
        public static void Close(Decimal CustomerID, Decimal RequestType)
        {
            OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

            try
            {
                OracleCommand cmd = connect.CreateCommand();

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "ebp.close_access_request";
                cmd.BindByName = true;

                cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, CustomerID, ParameterDirection.Input);
                cmd.Parameters.Add("p_type", OracleDbType.Decimal, RequestType, ParameterDirection.Input);

                cmd.ExecuteNonQuery();
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                {
                    connect.Close();
                    connect.Dispose();
                }
            }
        }

        /// <summary>
        /// Ініціалізація нового запиту
        /// </summary>
        /// <param name="RequestID">ІД запиту</param>
        public static void InitRequest(Decimal RequestID)
        {
            OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

            try
            {
                OracleCommand cmd = connect.CreateCommand();

                cmd.CommandText = "begin ebp.set_request_state( :p_reqid, 0 ); end;";

                cmd.Parameters.Add("p_reqid", OracleDbType.Decimal, RequestID, ParameterDirection.Input);

                cmd.ExecuteNonQuery();
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                {
                    connect.Close();
                    connect.Dispose();
                }
            }
        }

        /// <summary>
        /// Сповіщення бек-офісу щодо нового запиту
        /// </summary>
        /// <param name="RequestURL">посилання на запит</param>
        public static void SendMessageToBackOffice(String RequestURL)
        {
            OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

            try
            {
                OracleCommand cmd = connect.CreateCommand();

                cmd.CommandText = "begin ebp.send_message_to_back_office( :p_pass_to_request); end;";

                cmd.Parameters.Add("p_pass_to_request", OracleDbType.Varchar2, RequestURL, ParameterDirection.Input);

                cmd.ExecuteNonQuery();
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                {
                    connect.Close();
                    connect.Dispose();
                }
            }
        }

        /// <summary>
        /// обробка запиту (відмова / надання доступу до депозиту)
        /// </summary>
        /// <param name="Request_ID">ID повідомлення в черзі cust_requests</param>
        /// <param name="Request_Comment">коментар до запиту</param>
      
        public static void SendMessageToBOR(Decimal Request_ID, String Request_Comment)
        {
            Decimal msg_id =0;
            OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            //шукаємо повідомлення з відповідним запитом в черзі

            DBLogger.Info("Користувач обробив запит на доступ №" + Request_ID.ToString(), "deposit");
           
            try
            {
                OracleCommand cmd = connect.CreateCommand();

                cmd.CommandText = @"select max(msg_id) from bars.user_messages where msg_text like '%req_id=" + Request_ID.ToString() + "%' and msg_done =0";

                //cmd.Parameters.Add("p_req_id", OracleDbType.Decimal, Request_ID, ParameterDirection.Input);
                DBLogger.Info("cmd.CommandText  " + cmd.CommandText, "deposit");
                OracleDataReader rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    if (!rdr.IsDBNull(0))
                    {
                        if (rdr.GetOracleDecimal(0).Value > 0)
                            msg_id = rdr.GetOracleDecimal(0).Value;
                        DBLogger.Info("msg_id №" + msg_id.ToString(), "deposit");
                    }
                            if (msg_id > 0)//якщо повідомлення знайшли - всі повідомлення обробляємо.
                            {
                                DBLogger.Info("Користувач відправив ок повідомлення №" + msg_id.ToString(), "deposit");

                                try
                                {
                             
                                    cmd.CommandType = CommandType.StoredProcedure;
                                    cmd.CommandText = "bms.done_msg";
                                    cmd.BindByName = true;

                                    cmd.Parameters.Add("p_msg_id", OracleDbType.Decimal, msg_id, ParameterDirection.Input);
                                    cmd.Parameters.Add("p_comment", OracleDbType.Varchar2, Request_Comment, ParameterDirection.Input);

                                    cmd.ExecuteNonQuery();
                                }
                                finally
                                {
                                    if (connect.State != ConnectionState.Closed)
                                    {
                                        connect.Close();
                                        connect.Dispose();
                                    }
                                }
                            }

                }
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                {
                    connect.Close();
                    connect.Dispose();
                }
            }
            
        }

        /// <summary>
        /// Перевірка наявності активного запиту
        /// </summary>
        /// <param name="CustomerID">РНК</param>
        public static Boolean HasActive(Decimal CustomerID, Decimal? ContractID)
        {
            Boolean res = false;

            OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

            try
            {
                OracleCommand cmd = connect.CreateCommand();

                cmd.CommandText = @"SELECT ebp.get_active_request(:p_rnk, :p_dptid) FROM dual";

                cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, CustomerID, ParameterDirection.Input);
                cmd.Parameters.Add("p_dptid", OracleDbType.Decimal, ContractID, ParameterDirection.Input);
                
                OracleDataReader rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    if (!rdr.IsDBNull(0))
                    {
                        if (rdr.GetOracleDecimal(0).Value > 0)
                            res = true;
                    }
                }
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                {
                    connect.Close();
                    connect.Dispose();
                }
            }

            return res;
        }
    }
    
    /// <summary>
    /// Параметри запиту
    /// </summary>
    [Serializable]
    public class AccessInfo
    {
        /// <summary>
        /// Ідентифікатор договору до якого оформлюється доступ
        /// </summary>
        private Int32 _DPT_ID;
        public Int32 DPT_ID
        {
            get { return _DPT_ID; }
            set { _DPT_ID = value; }
        }

        /// <summary>
        /// Сума зняття по дорученню / частка спадку
        /// </summary>
        private Decimal _AMOUNT;
        public Decimal AMOUNT
        {
            get { return _AMOUNT; }
            set { _AMOUNT = value; }
        }

        /// <summary>
        /// Дозволено отримувати виписки по депозиту
        /// </summary>
        private Boolean _FL_REPORT;
        public Boolean FL_REPORT
        {
            get { return _FL_REPORT; }
            set { _FL_REPORT = value; }
        }

        private Boolean _FL_MONEY;
        /// <summary>
        /// Дозволено отримати суму депозиту по завершенні дії договору",
        /// </summary>
        public Boolean FL_MONEY
        {
            get { return _FL_MONEY; }
            set { _FL_MONEY = value; }
        }

        private Boolean _FL_EARLY;
        /// <summary>
        /// Дозволено дострокове повернення депозиту
        /// </summary>
        public Boolean FL_EARLY
        {
            get { return _FL_EARLY; }
            set { _FL_EARLY = value; }
        }

        private Boolean _FL_AGREEMENTS;
        /// <summary>
        /// Дозволено укладання додаткових угод
        /// </summary>
        public Boolean FL_AGREEMENTS
        {
            get { return _FL_AGREEMENTS; }
            set { _FL_AGREEMENTS = value; }
        }

        public AccessInfo() {}

        public AccessInfo(Int32 ContractID, Decimal Amount, Boolean Flag1, Boolean Flag2, Boolean Flag3, Boolean Flag4)
        {            
            this.DPT_ID = ContractID;
            this.AMOUNT = Amount;
            this.FL_REPORT = Flag1;
            this.FL_MONEY = Flag2;
            this.FL_EARLY = Flag3;
            this.FL_AGREEMENTS = Flag4;
        }
    }
}