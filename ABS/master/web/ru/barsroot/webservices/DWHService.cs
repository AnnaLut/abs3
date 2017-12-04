using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Net;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Xml;
using Bars.Classes;
using Bars.Configuration;
using BarsWeb.Core.Logger;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace Bars.DWH
{
    /// <summary>
    ///     дані від dwh
    /// </summary>
    [DataContract]
    public struct LogData
    {
        [DataMember] public Int32 PackageId;
        [DataMember] public int MFO;
        [DataMember] public byte PackageType;
        [DataMember] public string BankDate;
        [DataMember] public string PackageData;
        [DataMember] public string PackageStatus;

        public string OutFileName;

        public LogData(Int32 PackageId, int MFO, byte PackageType, string BankDate, string PackageData, ref DWHResponse response, OracleConnection con)
        {
            this.PackageId = PackageId;
            this.PackageData = "[" + PackageData + "]";
                //нормалізація XML, оскільки в пакеті від сховища некоректна структура
            PackageStatus = "DELIVERED";
            this.PackageType = PackageType;
            this.BankDate = BankDate;
            this.MFO = MFO;
            OutFileName = Path.GetTempFileName();
            Save(con, ref response);
        }

        public void Save(OracleConnection con, ref DWHResponse response)
        {
            var packageData = "{\"packagedata\":" + PackageData + "}";
            var packageDataBytes = Encoding.UTF8.GetBytes(packageData);
            using (var ss = new StreamWriter(OutFileName, false, Encoding.UTF8))
            {
                // чтение xml из массива байт "по элементам"
                using (
                    var reader = JsonReaderWriterFactory.CreateJsonReader(packageDataBytes,
                        XmlDictionaryReaderQuotas.Max))
                {
                    var ws = new XmlWriterSettings();
                    ws.Indent = false;
                    ws.OmitXmlDeclaration = true;
                    ws.CloseOutput = false;

                    using (var writer = XmlWriter.Create(ss, ws))
                    {
                        while (reader.Read())
                        {
                            if (reader.Name == "root")
                            {
                                continue;
                            }
                            switch (reader.NodeType)
                            {
                                case XmlNodeType.Element:
                                    if (reader.Name == "item")
                                    {
                                        writer.WriteStartElement("rw");
                                    }
                                    else
                                    {
                                        writer.WriteStartElement(reader.Name);
                                    }
                                    break;
                                case XmlNodeType.Text:
                                    writer.WriteString(reader.Value);
                                    break;
                                case XmlNodeType.XmlDeclaration:
                                case XmlNodeType.ProcessingInstruction:
                                    break;
                                case XmlNodeType.Comment:
                                    break;
                                case XmlNodeType.EndElement:
                                    writer.WriteFullEndElement();
                                    break;
                            }
                        }
                    }
                }
                ss.Flush();
            }

            try
            {
                var clob = new OracleClob(con, false, false);
                var bufferLength = 1024*512;
                var readLen = 0;
                var chars = new char[bufferLength];
                using (var fs = new StreamReader(OutFileName, Encoding.UTF8, false))
                {
                    while ((readLen = fs.Read(chars, 0, bufferLength)) != 0)
                    {
                        clob.Write(chars, 0, readLen);
                    }
                }
           
                var cmd = con.CreateCommand();
                cmd.CommandType = CommandType.Text;
                cmd.BindByName = true;
                cmd.CommandText = "begin segmentation_pack.InsertNewPackage (:p_ID, :p_DATA, :p_PACKAGETYPE, :p_BANKDATE, :p_KF); end;";
                cmd.Parameters.Add(new OracleParameter("p_ID", OracleDbType.Int32, PackageId, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_BANKDATE", OracleDbType.Varchar2, BankDate, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_DATA", OracleDbType.Clob, clob, ParameterDirection.Input));
                //cmd.Parameters.Add(new OracleParameter("p_STATUS", OracleDbType.Varchar2, PackageStatus, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_PACKAGETYPE", OracleDbType.Byte, PackageType, ParameterDirection.Input));
                //cmd.Parameters.Add(new OracleParameter("p_RECIEVED_DATE", OracleDbType.Date, DateTime.Now, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_KF", OracleDbType.Varchar2, MFO, ParameterDirection.Input));
                cmd.ExecuteNonQuery();
                clob.Close();
                clob.Dispose();
            }
            catch (System.Exception ex)
            {
                //switch (ex.Number)
                //{
                //    case 1:
                //        response.Description = "unique constraint exception: we have already package №" + PackageId;
                //        response.Result = "ERROR";
                //        break;
                //    default:
                        response.Description = "Database error: " + ex.Message;
                        response.Result = "ERROR";
                //        break;
                //}
            }
            //catch (System.Exception ex)
            //{
            //    response.Description = "something went wrong, sorry. Exception message: " + ex.Message + " " +
            //                           ex.InnerException + " " + ex.StackTrace;
            //    response.Result = "ERROR";
            //}
        }
    }


    public class CustomerSegments
    {
        public List<CustomerSegment> Customers { get; set; }
    }

    [DataContract]
    public struct DWHResponse
    {
        [DataMember] public string Result;
        [DataMember] public string Description;

        public DWHResponse(string Result, string Description)
        {
            this.Result = Result;
            this.Description = Description;
        }
    }

    /// <summary>
    ///     дані про сегмент клієнта
    /// </summary>
    [DataContract]
    public struct CustomerSegment
    {
        [DataMember] public decimal Rnk;

        [DataMember] public decimal Sg1;

        [DataMember] public decimal Sg2;

        [DataMember] public decimal Sg3;

        [DataMember] public decimal Sg4;

        [DataMember] public decimal Sg5;

        [DataMember] public decimal Sg6;

        public CustomerSegment(decimal Rnk, decimal Sg1, decimal Sg2, decimal Sg3, decimal Sg4, decimal Sg5, decimal Sg6)
        {
            this.Rnk = Rnk;
            this.Sg1 = Sg1;
            this.Sg2 = Sg2;
            this.Sg3 = Sg3;
            this.Sg4 = Sg4;
            this.Sg5 = Sg5;
            this.Sg6 = Sg6;
        }

        public CustomerSegment(string Rnk, string Sg1, string Sg2, string Sg3, string Sg4, string Sg5, string Sg6)
        {
            this.Rnk = Convert.ToDecimal(Rnk);
            this.Sg1 = Convert.ToDecimal(Sg1);
            this.Sg2 = Convert.ToDecimal(Sg2);
            this.Sg3 = Convert.ToDecimal(Sg3);
            this.Sg4 = Convert.ToDecimal(Sg4);
            this.Sg5 = Convert.ToDecimal(Sg5);
            this.Sg6 = Convert.ToDecimal(Sg6);
        }

        public void Save(OracleConnection con)
        {
            var cmd = con.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.BindByName = true;
            /* cmd.CommandText = "insert into PRVN_FV_REZ( ID_CALC_SET, ID_BRANCH, UNIQUE_BARS_IS, BARS_BRANCH_ID, RNK_CLIENT, ID_CURRENCY, PROV_BALANCE_CCY," +
                 "PROV_OFFBALANCE_CCY, ID_PROV_TYPE, ID_RISK_GROUP_PD, ID_COMMITMENT, ID_CONTRACT, ID_RISK_STATUS, IS_DEFAULT, ID_RISK_PORTF_PD, PD, LGD)" +
                " values (:p_ID_CALC_SET ,:p_ID_BRANCH ,:p_UNIQUE_BARS_IS,:p_BARS_BRANCH_ID ,:p_RNK_CLIENT ,:p_ID_CURRENCY ,:p_PROV_BALANCE_CCY ," +
         ":p_PROV_OFFBALANCE_CCY,:p_ID_PROV_TYPE,:p_ID_RISK_GROUP_PD,:p_ID_COMMITMENT,:p_ID_CONTRACT,:p_ID_RISK_STATUS,:p_IS_DEFAULT,:p_ID_RISK_PORTF_PD,:p_PD,:p_LGD )";

             cmd.Parameters.Add(new OracleParameter("p_ID_CALC_SET", OracleDbType.Decimal, this.ID_CALC_SET, ParameterDirection.Input));
             cmd.Parameters.Add(new OracleParameter("p_ID_BRANCH", OracleDbType.Varchar2, this.ID_BRANCH, ParameterDirection.Input));
             cmd.Parameters.Add(new OracleParameter("p_UNIQUE_BARS_IS", OracleDbType.Varchar2, this.UNIQUE_BARS_IS, ParameterDirection.Input));
             cmd.Parameters.Add(new OracleParameter("p_BARS_BRANCH_ID", OracleDbType.Varchar2, this.BARS_BRANCH_ID, ParameterDirection.Input));
             cmd.Parameters.Add(new OracleParameter("p_RNK_CLIENT", OracleDbType.Varchar2, this.RNK_CLIENT, ParameterDirection.Input));
             cmd.Parameters.Add(new OracleParameter("p_ID_CURRENCY", OracleDbType.Varchar2, this.ID_CURRENCY, ParameterDirection.Input));
             cmd.Parameters.Add(new OracleParameter("p_PROV_BALANCE_CCY", OracleDbType.Decimal, this.PROV_BALANCE_CCY, ParameterDirection.Input));
             cmd.Parameters.Add(new OracleParameter("p_PROV_OFFBALANCE_CCY", OracleDbType.Decimal, this.PROV_OFFBALANCE_CCY, ParameterDirection.Input));
             cmd.Parameters.Add(new OracleParameter("p_ID_PROV_TYPE", OracleDbType.Varchar2, this.ID_PROV_TYPE, ParameterDirection.Input));
             cmd.Parameters.Add(new OracleParameter("p_ID_RISK_GROUP_PD", OracleDbType.Varchar2, this.ID_RISK_GROUP_PD, ParameterDirection.Input));
             cmd.Parameters.Add(new OracleParameter("p_ID_COMMITMENT", OracleDbType.Varchar2, this.ID_COMMITMENT, ParameterDirection.Input));
             cmd.Parameters.Add(new OracleParameter("p_ID_CONTRACT", OracleDbType.Varchar2, this.ID_CONTRACT, ParameterDirection.Input));
             cmd.Parameters.Add(new OracleParameter("p_ID_RISK_STATUS", OracleDbType.Varchar2, this.ID_RISK_STATUS, ParameterDirection.Input));
             cmd.Parameters.Add(new OracleParameter("p_IS_DEFAULT", OracleDbType.Decimal, this.IS_DEFAULT, ParameterDirection.Input));
             cmd.Parameters.Add(new OracleParameter("p_ID_RISK_PORTF_PD", OracleDbType.Varchar2, this.ID_RISK_PORTF_PD, ParameterDirection.Input));
             cmd.Parameters.Add(new OracleParameter("p_PD", OracleDbType.Decimal, this.PD, ParameterDirection.Input));
             cmd.Parameters.Add(new OracleParameter("p_LGD", OracleDbType.Decimal, this.LGD, ParameterDirection.Input));
             cmd.ExecuteNonQuery();*/
        }
    }


    /// <summary>
    ///     Сервис для интеграции с DWH
    /// </summary>
    [WebService(Namespace = "http://segmentation")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class DWHService : BarsWebService
    {
        private readonly IDbLogger _dbLogger;

        # region Статические свойства

        public static string TechUser
        {
            get { return ConfigurationSettings.AppSettings["DWH.TechUserLogin"]; }
        }

        #endregion

        #region Веб-методы

        [WebMethod(EnableSession = true)]
        public DWHResponse FromDWH(int PacketNumber, int PreviousPacketNumber, DateTime PacketDateTime,
            string PacketType, int cstCount /*,
                            String DeliveryRegion*/, int MFO, string BankDate, string MD5, string Data)
        {
            string LoggerPrefix = "DWHServises";
            //_dbLogger.Info("On Begin. MFO = " + MFO, LoggerPrefix);
            if (string.IsNullOrEmpty(Data))
            {
                throw new HttpException((int) HttpStatusCode.BadRequest, "Empty DATA or invalid namespace!");
            }

            var response = new DWHResponse("OK", "Message was written to DB successfully.");
            // авторизация пользователя пішла в історію, тепер все перевіряє сертифікат
            var WSProxyUserName = TechUser;
            //String WSProxyPassword = "";
            if (!string.IsNullOrEmpty(WSProxyUserName)) //(isAuthenticated)
            {
                LoginUser(WSProxyUserName);
            }

            var con = OraConnector.Handler.IOraConnection.GetUserConnection();
            string tmpFileName;
            try
            {
                if (con.State != ConnectionState.Open)
                    con.Open();

                if (!string.IsNullOrEmpty(Data))
                {
                    var check = true;// CheckData(PacketNumber, PreviousPacketNumber, PacketType, MFO, ref response);
                    if (check)
                    {
                        //_dbLogger.Info("On Begin. MFO = " + MFO, LoggerPrefix);
                        var log = new LogData(PacketNumber, MFO, Convert.ToByte(PacketType), BankDate, Data, ref response, con);
                        tmpFileName = log.OutFileName;
                    }
                    else
                    {
                        return response;
                    }
                }
                else
                {
                    response.Description = "Empty DATA!";
                    response.Result = "ERROR";
                    throw new HttpException((int) HttpStatusCode.BadRequest, "Empty DATA!");
                }
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            try
            {
                File.Delete(tmpFileName);
            }
            catch (System.Exception)
            {
                //throw;
            }
            return response;
        }

        #endregion

        #region Приватные методы

        private string GetHostName()
        {
            var userHost = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            if (string.IsNullOrEmpty(userHost) || string.Compare(userHost, "unknown", true) == 0)
                userHost = HttpContext.Current.Request.UserHostAddress;

            if (string.Compare(userHost, HttpContext.Current.Request.UserHostName) != 0)
                userHost += " (" + HttpContext.Current.Request.UserHostName + ")";

            return userHost;
        }

        private bool CheckQueue(int PacketNumber, int PreviousPacketNumber, ref DWHResponse response)
        {
            var result = "N";
            try
            {
                InitOraConnection();
                // установка первичных параметров
                SetParameters("p_package_id", DB_TYPE.Decimal, PacketNumber, DIRECTION.Input);
                SetParameters("p_prev_package_id", DB_TYPE.Decimal, PreviousPacketNumber, DIRECTION.Input);
                SetParameters("p_real_package_id", DB_TYPE.Decimal, PreviousPacketNumber, DIRECTION.Output);
                SetParameters("p_result", DB_TYPE.Varchar2, 10, result, DIRECTION.Output);
                SQL_PROCEDURE("bars.SEGMENTATION_PACK.check_package_queue");
            }
            catch (System.Exception ex)
            {
                response.Result = "Error";
                response.Description = ex.Message;
                    // "Invalid PacketNumber " + PacketNumber.ToString()+ " and PreviousPacketNumber:" + PreviousPacketNumber.ToString();
                return false;
            }
            finally
            {
                DisposeOraConnection();
            }
            return true;
        }

        private bool CheckData(int PacketNumber, int PreviousPacketNumber, string PacketType, int MFO,
            ref DWHResponse response)
        {
            if (!CheckQueue(PacketNumber, PreviousPacketNumber, ref response))
            {
                return false;
            }

            //TODO: add checks
            //response.Result = "Error";
            //response.Description = "Invalid PacketNumber:" + PacketNumber.ToString();
            return true;
        }

        private void LoginUser(string userName)
        {
            // информация о текущем пользователе
            var userMap = ConfigurationSettings.GetUserInfo(userName);

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
            HttpContext.Current.Session["UserLoggedIn"] = true;
        }

        #endregion

        #region Статические методы

        #endregion
    }
}