using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.Configuration;
using System.Web.Mvc;
using barsroot;
using BarsWeb.Models;
using Models;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace BarsWeb.Controllers
{
    //[AuthorizeUser]
    // [CheckAccessPage]
    public class MessagesCtrlController : ApplicationController
    {
        EntitiesBars _entities;

        public ActionResult Index(decimal? userId = null, decimal pageNum = 1, decimal pageSize = 20)
        {
            //using (var conn = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            using (OracleConnection conn = GetIndependentConnection())
            using (var cmd = conn.CreateCommand())
            {
                var userMessages = new List<V_USER_MESSAGES>();
                //cmd.CommandText = "select MSG_ID,USER_ID,MSG_SENDER_ID,MSG_SUBJECT,MSG_TEXT,MSG_DATE,MSG_DONE,USER_COMMENT,DATE_TEXT,TODAY,MSG_DONE_TEXT from V_USER_MESSAGES order by msg_id desc";
                cmd.CommandText = "select MSG_ID,USER_ID,MSG_SENDER_ID,MSG_TEXT,MSG_DATE,MSG_DONE,USER_COMMENT,DATE_TEXT,TODAY,MSG_DONE_TEXT from BARS.V_USER_MESSAGES_GENERAL where USER_ID = :p_user_id order by msg_id desc";
                cmd.Parameters.Add("p_user_id", OracleDbType.Decimal, userId, System.Data.ParameterDirection.Input);
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        var userMessage = new V_USER_MESSAGES();
                        userMessage.MSG_ID = Convert.ToDecimal(reader["MSG_ID"]);
                        userMessage.USER_ID = Convert.ToDecimal(reader["USER_ID"]);
                        userMessage.MSG_SENDER_ID = Convert.ToDecimal(reader["MSG_SENDER_ID"]);
                        //userMessage.MSG_SUBJECT = Convert.ToString(reader["MSG_SUBJECT"]);
                        userMessage.MSG_TEXT = Convert.ToString(reader["MSG_TEXT"]);
                        userMessage.MSG_DATE = Convert.ToDateTime(reader["MSG_DATE"]);
                        userMessage.MSG_DONE = Convert.ToDecimal(reader["MSG_DONE"]);
                        userMessage.USER_COMMENT = Convert.ToString(reader["USER_COMMENT"]);
                        userMessage.DATE_TEXT = Convert.ToString(reader["DATE_TEXT"]);
                        userMessage.TODAY = Convert.ToDecimal(reader["TODAY"]);
                        userMessage.MSG_DONE_TEXT = Convert.ToString(reader["MSG_DONE_TEXT"]);
                        userMessages.Add(userMessage);
                    }
                }
                ViewBag.count = userMessages.Count;
                ViewBag.pageNum = pageNum;
                ViewBag.pageSize = pageSize;
                return View(userMessages);
            }
        }

        public ActionResult Count(decimal? userId)
        {
            try
            {
                //using (var conn = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                using (OracleConnection conn = GetIndependentConnection())
                using (OracleCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandText = "select count(*) from BARS.V_USER_MESSAGES_GENERAL V where V.USER_ID = :p_user_id";
                    cmd.Parameters.Add("p_user_id", OracleDbType.Decimal, userId, System.Data.ParameterDirection.Input);
                    return Content(Convert.ToString(cmd.ExecuteScalar()));
                }
            }
            catch (Exception ex)
            {
                return Content(ex.Message);
            }
        }

        public ActionResult Get(decimal id)
        {
            return View();
        }
        public ActionResult Get(decimal? userId)
        {
            using (var conn = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            using (var cmd = conn.CreateCommand())
            {
                var userMessages = new List<V_USER_MESSAGES>();
                //cmd.CommandText = "select MSG_SUBJECT,MSG_ID,USER_ID,MSG_SENDER_ID,MSG_TEXT,MSG_DATE,MSG_DONE,USER_COMMENT,DATE_TEXT,TODAY,MSG_DONE_TEXT from V_USER_MESSAGES order by msg_id desc";
                cmd.CommandText = "select MSG_ID,USER_ID,MSG_SENDER_ID,MSG_TEXT,MSG_DATE,MSG_DONE,USER_COMMENT,DATE_TEXT,TODAY,MSG_DONE_TEXT from BARS.V_USER_MESSAGES_GENERAL where USER_ID = :p_user_id order by msg_id desc";
                cmd.Parameters.Add("p_user_id", OracleDbType.Decimal, userId, System.Data.ParameterDirection.Input);
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        var userMessage = new V_USER_MESSAGES();
                        userMessage.MSG_ID = Convert.ToDecimal(reader["MSG_ID"]);
                        userMessage.USER_ID = Convert.ToDecimal(reader["USER_ID"]);
                        userMessage.MSG_SENDER_ID = Convert.ToDecimal(reader["MSG_SENDER_ID"]);
                        //userMessage.MSG_SUBJECT = Convert.ToString(reader["MSG_SUBJECT"]);
                        userMessage.MSG_TEXT = Convert.ToString(reader["MSG_TEXT"]);
                        userMessage.MSG_DATE = Convert.ToDateTime(reader["MSG_DATE"]);
                        userMessage.MSG_DONE = Convert.ToDecimal(reader["MSG_DONE"]);
                        userMessage.USER_COMMENT = Convert.ToString(reader["USER_COMMENT"]);
                        userMessage.DATE_TEXT = Convert.ToString(reader["DATE_TEXT"]);
                        userMessage.TODAY = Convert.ToDecimal(reader["TODAY"]);
                        userMessage.MSG_DONE_TEXT = Convert.ToString(reader["MSG_DONE_TEXT"]);
                        userMessages.Add(userMessage);
                    }
                }
                ViewBag.count = userMessages.Count;
                return View(userMessages);
            }
        }

        public JsonResult TellerMessages()
        {
            Int32 tellerMessageTypeId = 10;
            _entities = new EntitiesBarsCore().NewEntity();
            String message = String.Empty;

            Object[] parameters =
            {
                new OracleParameter("p_message_type_id",OracleDbType.Int32,tellerMessageTypeId, ParameterDirection.Input),
                new OracleParameter("p_message",OracleDbType.Varchar2, 4000, null, ParameterDirection.Output),
                new OracleParameter("p_sender_id",OracleDbType.Int32, ParameterDirection.Output),
                new OracleParameter("p_enqueue_time",OracleDbType.Date, ParameterDirection.Output)
            };

            var paramCollection = OracleRequest("bars.bms.receive_message", parameters);
            OracleString operDescRes = (OracleString)paramCollection["p_message"].Value;
            try
            {
                message = operDescRes.Value;
            }
            catch (OracleNullValueException)
            {
                message = String.Empty;
            }

            return Json(new { message = message });
        }

        private OracleParameterCollection OracleRequest(String functionName, Object[] parameters)
        {
            //IOraConnection conn = (IOraConnection)AppDomain.CurrentDomain.GetData("OracleConnectClass");
            OracleParameterCollection result;
            using (OracleConnection con = GetIndependentConnection())
            {
                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = functionName;
                    cmd.Parameters.Clear();
                    cmd.BindByName = true;
                    cmd.Parameters.AddRange(parameters);

                    using (var reader = cmd.ExecuteReader())
                    {
                        result = cmd.Parameters;
                    }
                }
            }

            return result;
        }


        public ActionResult CommentAdd(decimal[] id, string comment)
        {
            var status = "ok";
            var message = "Зміни збережено";
            decimal updCount = 0;
            _entities = new EntitiesBarsCore().NewEntity();
            if (id != null)
            {
                string stringUpdateId = "";
                foreach (var item in id)
                {
                    if (stringUpdateId != "") stringUpdateId += ",";
                    stringUpdateId += Convert.ToString(item);
                }
                try
                {
                    foreach (var item in id)
                    {
                        object[] parameters =
                        {
                            new OracleParameter("p_msg_id",OracleDbType.Decimal).Value=item,
                            new OracleParameter("p_comment",OracleDbType.Varchar2).Value=comment
                        };
                        _entities.ExecuteStoreCommand("begin bms.done_msg(:p_msg_id, :p_comment);end;", parameters);
                        _entities.SaveChanges();
                        updCount++;
                    }

                    /*updCount = _entities.ExecuteStoreCommand(
                        "update user_messages set user_comment = :p_comm , msg_done = 1 where msg_id in (" + stringUpdateId + ")",
                        parameters);
                    _entities.SaveChanges();*/
                    //message = Convert.ToString(id);
                }
                catch (Exception e)
                {
                    status = "error";
                    message = e.InnerException == null ? e.Message : e.InnerException.Message;
                }
            }

            return Json(new { status, message, count = updCount }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        [AllowAnonymous]
        public void PushMessage(/*string UserLogin, string Message, string TypeId*/ Mess pushMessage)
        {
            CometClientProcessor.PushData(pushMessage.UserLogin, pushMessage.Message);
        }

        public class Mess
        {
            public string UserLogin { get; set; }
            public string Message { get; set; }
            public string TypeId { get; set; }
        }

        private OracleConnection GetIndependentConnection()
        {
            string conStr = WebConfigurationManager.ConnectionStrings[Infrastructure.Constants.AppConnectionStringName].ConnectionString;
            OracleConnection conn = new OracleConnection(conStr);

            try { conn.Open(); }
            catch (OracleException ex)
            {
                if (ex.Message.StartsWith("Connection request timed out"))
                {
                    GC.Collect();
                    GC.WaitForPendingFinalizers();
                    GC.Collect();
                    conn.Open();
                }
                else if (ex.Message.StartsWith("ORA-604"))
                {
                    conn.Dispose();
                    throw ex;
                }
                else
                    throw ex;
            }
            return conn;
        }
    }
}