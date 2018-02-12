﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using barsroot;
using BarsWeb.Models;
using Models;
using Oracle.DataAccess.Client;

namespace BarsWeb.Controllers
{
    //[AuthorizeUser]
    // [CheckAccessPage]
    public class MessagesCtrlController : ApplicationController
    {
        EntitiesBars _entities;

        public ActionResult Index(decimal pageNum = 1, decimal pageSize = 20)
        {
            using (var conn = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            using (var cmd = conn.CreateCommand())
            {
                var userMessages = new List<V_USER_MESSAGES>();
                cmd.CommandText = "select MSG_ID,USER_ID,MSG_SENDER_ID,MSG_SUBJECT,MSG_TEXT,MSG_DATE,MSG_DONE,USER_COMMENT,DATE_TEXT,TODAY,MSG_DONE_TEXT from V_USER_MESSAGES order by msg_id desc";
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        var userMessage = new V_USER_MESSAGES();
                        userMessage.MSG_ID = Convert.ToDecimal(reader["MSG_ID"]);
                        userMessage.USER_ID = Convert.ToDecimal(reader["USER_ID"]);
                        userMessage.MSG_SENDER_ID = Convert.ToDecimal(reader["MSG_SENDER_ID"]);
                        userMessage.MSG_SUBJECT = Convert.ToString(reader["MSG_SUBJECT"]);
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

        public ActionResult Count()
        {
            using (var conn = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            using (var cmd = conn.CreateCommand())
            {
                cmd.CommandText = "select count(*) from V_USER_MESSAGES";
                return Content(Convert.ToString(cmd.ExecuteScalar()));
            }
        }

        public ActionResult Get(decimal id)
        {
            return View();
        }
        public ActionResult Get()
        {
            using (var conn = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            using (var cmd = conn.CreateCommand())
            {
                var userMessages = new List<V_USER_MESSAGES>();
                cmd.CommandText = "select MSG_ID,USER_ID,MSG_SENDER_ID,MSG_SUBJECT,MSG_TEXT,MSG_DATE,MSG_DONE,USER_COMMENT,DATE_TEXT,TODAY,MSG_DONE_TEXT from V_USER_MESSAGES order by msg_id desc";
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        var userMessage = new V_USER_MESSAGES();
                        userMessage.MSG_ID = Convert.ToDecimal(reader["MSG_ID"]);
                        userMessage.USER_ID = Convert.ToDecimal(reader["USER_ID"]);
                        userMessage.MSG_SENDER_ID = Convert.ToDecimal(reader["MSG_SENDER_ID"]);
                        userMessage.MSG_SUBJECT = Convert.ToString(reader["MSG_SUBJECT"]);
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
    }
}