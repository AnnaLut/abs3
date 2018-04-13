using System;
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
            _entities = new EntitiesBarsCore().NewEntity();
            decimal count = _entities.ExecuteStoreQuery<decimal>("select count(*) from V_USER_MESSAGES").FirstOrDefault();
            ViewBag.count = count;
            ViewBag.pageNum = pageNum;
            ViewBag.pageSize = pageSize;

            //const string sql = "select a.*, f_get_userfio(a.MSG_SENDER_ID) as MSG_SENDER_FIO from V_USER_MESSAGES a order by msg_id desc";

            string sqlText = ServicesClass.GetSelectStryng(
                                                        typeSeach: "V_USER_MESSAGES",
                                                        filterString: "",
                                                        sort: "msg_id",
                                                        sortDir: "desc",
                                                        pageNum: Convert.ToInt32(pageNum),
                                                        pageSize: Convert.ToInt32(pageSize),
                                                        rowName: "a.*, f_get_userfio(a.MSG_SENDER_ID) as MSG_SENDER_FIO");
            
            var mess = _entities.ExecuteStoreQuery<V_USER_MESSAGES>(sqlText).ToList();

            return View(mess);
        }

        public ActionResult Count()
        {
            return Content(Convert.ToString(GetCountUserMessage()));            
        }

        private int GetCountUserMessage()
        {
            _entities = new EntitiesBarsCore().NewEntity();

            const string sql = "select to_char(count(*)) from V_USER_MESSAGES";
            var count = _entities.ExecuteStoreQuery<string>(sql).FirstOrDefault();
            return Convert.ToInt32(count);
        }
        public ActionResult Get(decimal id)
        {
            return View();
        }
        public ActionResult Get()
        {
            _entities = new EntitiesBarsCore().NewEntity();
            decimal count = _entities.ExecuteStoreQuery<decimal>("select count(*) from V_USER_MESSAGES").FirstOrDefault();
            ViewBag.count = count;
            const string sql = "select um.*, f_get_userfio(um.MSG_SENDER_ID) as MSG_SENDER_FIO from V_USER_MESSAGES um order by msg_id desc";
            var mess = _entities.ExecuteStoreQuery<V_USER_MESSAGES>(sql).ToList();

            return View(mess);
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
                        _entities.ExecuteStoreCommand("begin bms.done_msg(:p_msg_id, :p_comment);end;",parameters);
                        _entities.SaveChanges();
                        updCount ++;
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
            var r = HttpContext.Request;
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