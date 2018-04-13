using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Objects;
using System.IO;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using System.Web.UI;
using Bars.DocPrint;
using Bars.Oracle;
using BarsWeb.Models;
using BarsWeb.Infrastructure.Repository.DI.Implementation;
using Models;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Infrastructure.Extensions;

namespace BarsWeb.Controllers
{
    [AuthorizeUser]
    //[CheckAccessPage]
    public class DocumentsController : ApplicationController
    {
        EntitiesBars _entities;
        private DocumentsRepository _repository;
        public DocumentsController()
        {
            _repository = new DocumentsRepository();
        }

        /// <summary>
        /// початкова сторінка
        /// </summary>
        /// <returns></returns>
        public ActionResult Index(AccessDocType? id)
        {
            if (id == null) id = AccessDocType.User;//перегляд документів користувача
            switch (id)
            {
                case AccessDocType.Tobo: ViewBag.Type="відділення"; break;
                case AccessDocType.User: ViewBag.Type="користувача"; break;
                case AccessDocType.Client: ViewBag.Type="клієнта"; break;
                default:ViewBag.Type=""; break;
            }
            ViewBag.Id = id;
            return View();
        }
        /// <summary>
        /// наповнення таблиці
        /// </summary>
        /// <param name="id">тип пошуку документів(tobo, user, client)</param>
        /// <param name="dStart">початкова дата</param>
        /// <param name="dEnd">кінцева дата</param>
        /// <param name="dirType">тип документів(in - вхідні; out - всі)</param>
        /// <returns></returns>
        public ActionResult Grid(AccessDocType id, string dStart,string dEnd,DirectionDocType dirType)
        {
            DateTime dS = Convert.ToDateTime(dStart);
            DateTime dE = Convert.ToDateTime(dEnd);
            if (string.IsNullOrWhiteSpace(dStart))
            {
                dS = DateTime.Now;
            }
            if (string.IsNullOrWhiteSpace(dEnd))
            {
                dE = DateTime.Now.AddDays(1);
            }

            var documents = _repository.GetDocuments(id, dS, dE, dirType);
            return PartialView(new GridMvc<Documents>(documents));
        }
        /// <summary>
        /// отримати друковану форму в HTML
        /// </summary>
        /// <param name="id">рефоренс документа</param>
        /// <param name="printModel">признак чи потрібно друкувати бух.модель</param>
        /// <returns></returns>
        public ActionResult GetTicketHtml(int id, bool printModel = true)
        {
            return View(model:_repository.GetByteArrayTicket(id,printModel));
        }
        /// <summary>
        ///отримати ім"я згенерованого файла для друку
        /// </summary>
        /// <param name="id">масив рефференсів</param>
        /// <param name="printModel">признак чи потрібно друкувати бух.модель</param>
        /// <returns></returns>
        public string GetTicketFileName(int[] id, bool printModel = true)
        {
            var ticket = _repository.CreateTicket(id, printModel);
            return ticket.GetTicketFileName();
        }
        /// <summary>
        /// отримати файл друкованої форми документа
        /// </summary>
        /// <param name="id">рефоренс документа</param>
        /// <param name="printModel">признак чи потрібно друкувати бух.модель</param>
        /// <returns></returns>
        //[DeleteTmpFile]
        public ActionResult GetTicketFile(int[] id, bool printModel = true)
        {
            var ticket = _repository.CreateTicket(id, printModel);
            ViewBag.TmpFileName = ticket.GetTicketFileName();
            return File(ticket.GetTicketFileName(), "text/html", id.Length > 1 ? "tickets.txt" : string.Format("ticket_{0}.txt", id[0]));
        }
        /// <summary>
        /// Перегляд одного документу
        /// </summary>
        /// <param name="id">референс документу</param>
        /// <returns></returns>
        //[HttpPost]
        public ActionResult Item(decimal? id)
        {
            if (id == null)
            {
                return Content("<span id=\"notFound\" style=\"color:red\">Документ не знайдено!</span>");
            }
            _entities = new EntitiesBarsCore().NewEntity();
            var docum = (from item in _entities.OPERs where item.REF == id select item).FirstOrDefault();
            if (docum == null)
            {
                return Content("<span id=\"notFound\" style=\"color:red\">Документ не знайдено!</span>");
            }
            object[] parameters =         
            { 
                new OracleParameter("nSum",OracleDbType.Decimal).Value=docum.S,
                new OracleParameter("nKodVal",OracleDbType.Decimal).Value=docum.TABVAL_GLOBAL.KV,
                new OracleParameter("strGender",OracleDbType.Varchar2).Value="F",
                new OracleParameter("nDefDig",OracleDbType.Decimal).Value=2
            };
            try
            {
                ViewBag.Sumpr = Convert.ToString(_entities.ExecuteStoreQuery<string>("select F_SUMPR(:nSum,:nKodVal,:strGender,:nDefDig) from dual", parameters).FirstOrDefault());
            }
            catch (Exception e) { var t = e; }
            List<object[]> dopRecwList =new List<object[]>();
            if (docum.D_REC != "" && docum.D_REC!=null )
            {
                //разбераем d_rec на под реквизиты
                //структура поля D_REC:
                //{'#'<один символ - код реквизита><его значение>#}
                string[] RekvArr = docum.D_REC.Split('#');
                for (int i = 1; i < RekvArr.Length - 1; i++)
                {
                    string TagParam = RekvArr[i].Substring(0, 1);
                    string ValueParam = RekvArr[i].Substring(1);
                    //берем строковое представление тега из OP_FIELD  
                    var Tag = _entities.OP_FIELD.Where(it => it.TAG == TagParam+"    ").FirstOrDefault();
                    //если в таблице не было найдено соответствия, то определяем 
                    //реквизит как СЕП
                    string name = (Tag == null) ? ("Вспомогательный реквизит СЭП " + TagParam) : (Tag.NAME);
                    object[] row = { name, ValueParam, TagParam };
                    dopRecwList.Add(row);
                }            
            }
            ViewBag.DopRecv=dopRecwList;
            ViewBag.PDAT = docum.PDAT;
            ViewBag.FN_A = null; 
            ViewBag.DAT_A = null;
            ViewBag.DATK_A = null;
            ViewBag.DAT_2_A = null;
            ViewBag.FN_B = null; 
            ViewBag.DAT_B = null;
            ViewBag.DATK_B = null;
            var arcRRP=docum.ARC_RRP.FirstOrDefault();
            if (arcRRP != null)
            {
                ViewBag.PDAT = arcRRP.DAT_B;
                var zagA = (from item in _entities.ZAG_A where item.FN == arcRRP.FN_A && item.DAT==arcRRP.DAT_A select item).FirstOrDefault();
                if (zagA == null)
                {
                    var zagB = (from item in _entities.ZAG_B where item.FN == arcRRP.FN_B && item.DAT==arcRRP.DAT_B select item).FirstOrDefault();
                    if (zagB != null)
                    {
                        ViewBag.FN_B =zagB.FN ;
                        ViewBag.DAT_B =zagB.DAT;
                        ViewBag.DATK_B = zagB.DATK;
                    }
                }
                else
                {
                    ViewBag.FN_A = zagA.FN;
                    ViewBag.DAT_A = zagA.DAT; 
                    ViewBag.DATK_A = zagA.DATK; 
                    ViewBag.DAT_2_A = zagA.DAT_2;
                }
            }
            var visa = new List<V_VISALIST>();
            try
            {
                visa = _entities.ExecuteStoreQuery<V_VISALIST>(@"SELECT REF, COUNTER, SQNC, MARK, MARKID, CHECKGROUP, USERNAME, DAT, INCHARGE 
												    FROM V_VISALIST 
												    WHERE REF = :pref 
												    ORDER by Counter, Sqnc", new OracleParameter("pref", OracleDbType.Decimal).Value = docum.REF).ToList();

            }
            catch (Exception e) { var t = e; }
            decimal pLevId=0;
            foreach (var item in visa)
            {
                if (item.MARKID != 4)
                {
                    decimal pRef = docum.REF; decimal pLev = pLevId;
                    var FSign = new ObjectParameter("FSign", typeof(decimal));
                    var IntBuff = new ObjectParameter("IntBuff", typeof(string));
                    var ExtBuff = new ObjectParameter("ExtBuff", typeof(string));
                    try
                    {
                        _entities.CHK_GETVISABUFFERSFORCHECK(pRef, pLev, FSign, IntBuff, ExtBuff);
                        var t = ExtBuff.Value;
                    }
                    catch (Exception e)
                    {
                        var t = e;
                    }
                    item.SIGN_FLAG=Convert.ToDecimal(FSign.Value);
                    item.BUFINT = Convert.ToString(IntBuff.Value);
                }
                pLevId++;
            }
            var dtSystemSignParams = new DtSystemSignParams();
            try
            {
                dtSystemSignParams = _entities.ExecuteStoreQuery<DtSystemSignParams>(@"SELECT chk.get_SignLng as SIGNLNG, 
                                                                 docsign.getIdOper as DOCKEY, 
                                                                 to_char(web_utl.get_bankdate, 'yyyy/MM/dd hh:mm:ss') as BDATE, 
                                                                 (SELECT NVL( min(to_number(VAL)), 1 ) FROM PARAMS WHERE PAR = 'SEPNUM') as SEPNUM, 
                                                                 docsign.GetSignType as SIGNTYPE, 
                                                                 (SELECT NVL( min(to_number(VAL)), 1 ) FROM PARAMS WHERE PAR = 'VISASIGN') as VISASIGN, 
                                                                 (SELECT NVL( min(to_number(VAL)), 1 ) FROM PARAMS WHERE PAR = 'INTSIGN') as INTSIGN, 
                                                                 (select nvl(val,'00') from params where par='REGNCODE') as REGNCODE,
                                                                 null as EXTSIGNBUFF
                                                          FROM dual").FirstOrDefault();
            }
            catch (Exception e) { var t = e; } 

            decimal pRefSep = docum.REF; decimal pLevSep = 0;
            var FSignSep = new ObjectParameter("FSign", typeof(decimal));
            var IntBuffSep = new ObjectParameter("IntBuff", typeof(string));
            var ExtBuffSep = new ObjectParameter("ExtBuff", typeof(string));
            try
            {
                _entities.CHK_GETVISABUFFERSFORCHECK(pRefSep, pLevSep, FSignSep, IntBuffSep, ExtBuffSep);
            }
            catch (Exception e) { var t = e; } 
            dtSystemSignParams.EXTSIGNBUFF = (Convert.ToString(ExtBuffSep.Value) == string.Empty || Convert.ToString(ExtBuffSep.Value) == "") ? "0" : Convert.ToString(ExtBuffSep.Value);

            ViewBag.Visa = visa;
            ViewBag.DtSystemSignParams = dtSystemSignParams;

            return View(docum);
        }

        public void LoadTXT(int[] id, bool printModel = true)
        {
            var icon = (IOraConnection)AppDomain.CurrentDomain.GetData("OracleConnectClass");
            OracleConnection con = icon.GetUserConnection(System.Web.HttpContext.Current);
            if (id != null)
            {
                try
                {
                    OracleCommand cmd = con.CreateCommand();
                    cmd.CommandText = icon.GetSetRoleCommand(Resources.documentview.Global.AppRole);
                    cmd.ExecuteNonQuery();

                    Response.ClearContent();
                    Response.ClearHeaders();
                    Response.Charset = "windows-1251";
                    Response.ContentEncoding = Encoding.GetEncoding("windows-1251");
                    Response.AppendHeader("content-disposition", "attachment;filename=ticket_" + id[0].ToString() + ".txt");
                    Response.ContentType = "text/html";
                    foreach (var item in id)
                    {
                        var ticCon = icon.GetUserConnection(System.Web.HttpContext.Current);
                        try
                        {
                            var ourTick = new cDocPrint(ticCon, item, Server.MapPath("/TEMPLATE.RPT/"), printModel);
                            Response.WriteFile(ourTick.GetTicketFileName(), true);
                            ourTick.DeleteTempFiles();
                        }
                        catch (Exception e) { var t = e; }
                        finally
                        {
                            if (System.Data.ConnectionState.Open == ticCon.State) ticCon.Close();
                            ticCon.Dispose();
                        }
                    }
                    Response.Flush();
                    Response.End();

                }
                finally
                {
                    if (System.Data.ConnectionState.Open == con.State) con.Close();
                    con.Dispose();
                }
            }
        }
        public void LoadHtml(int id, bool printModel = true)
        {
            var icon = (IOraConnection)AppDomain.CurrentDomain.GetData("OracleConnectClass");
            OracleConnection con = icon.GetUserConnection(System.Web.HttpContext.Current);

            var ourTick = new cDocPrint(con, id, Server.MapPath("/TEMPLATE.RPT/"), printModel);

            try
            {
                Response.ClearContent();
                Response.ClearHeaders();
                Response.Charset = "windows-1251";
                Response.ContentEncoding = Encoding.GetEncoding("windows-1251");
                Response.ContentType = "text/html";

                Response.AppendHeader("content-disposition", "inline;filename=ticket_" + id + ".htm");
                Response.Write("<STYLE>@media Screen{.print_action{DISPLAY: none}} @media print{body *:not(PRE){display: none} PRE{width:100%;heigth:100%;border:0} }</STYLE>");
                Response.Write(@"<div style=""margin:0;"" class=""buttons tiptip"">
                                    <a href=""#"" id=""btSubmitFilter"" onclick=""window.print();return false;"" title=""Друк"" class=""button hover""><span class=""icon icon153""></span><span class=""label"">Друк</span></a>
                                </div>");
                Response.Write("<PRE class=\"print\" style=\"MARGIN-LEFT: 0; FONT-SIZE: 8pt; COLOR: black; FONT-FAMILY: 'Courier New';  BACKGROUND-COLOR: gainsboro\">");
                Response.WriteFile(ourTick.GetTicketFileName(), true);
                Response.Write("</PRE>");

                Response.Flush();
                Response.End();
            }
            finally
            {
                ourTick.DeleteTempFiles();
            }
        }
        
        public string GetFileForPrint(int[] id, bool printModel = true)
        { 
            var conn = (IOraConnection)AppDomain.CurrentDomain.GetData("OracleConnectClass");
            OracleConnection con = conn.GetUserConnection(System.Web.HttpContext.Current);
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();
                var outTicket = new cDocPrint(con, id[0], Server.MapPath("/TEMPLATE.RPT/"), printModel);
                if (id.Length > 1)
                {
                    var sw = new StreamWriter(outTicket.GetTicketFileName(),true);

                    for (int i = 1; i < id.Length; i++)
                    {
                        var ticCon = conn.GetUserConnection(System.Web.HttpContext.Current);
                        try
                        {
                            var ourTick = new cDocPrint(ticCon, id[i], Server.MapPath("/TEMPLATE.RPT/"), printModel);
                            string text = System.IO.File.ReadAllText(ourTick.GetTicketFileName(),Encoding.ASCII);
                            sw.WriteLine(text);

                            ourTick.DeleteTempFiles();
                        }
                        catch (Exception e) { var t = e; }
                        finally
                        {
                            if (System.Data.ConnectionState.Open == ticCon.State) ticCon.Close();
                            ticCon.Dispose();
                        }
                    }

                    sw.Close();

                }
                return outTicket.GetTicketFileName();
            }
            finally
            {
                con.Close();
                cmd.Dispose();
                con.Dispose();
            }
        }

        public void ExportToExcel(FormCollection cont)
        {
            //Export
            const string contentType = "vnd.ms-excel";
            var lc = new LiteralControl();

            const string attachment = "attachment; filename=test.xls"; 
            Response.ClearContent();
            Response.BufferOutput = true;
            Response.AddHeader("content-disposition", attachment);
            Response.Charset = "utf-8";
            Response.ContentEncoding = Encoding.UTF8;
            Response.ContentType = "application/" + contentType;
            Response.Write("<meta http-equiv=Content-Type content=\"text/html; charset=utf-8\">");

            var swrt = new StringWriter();
            var htw = new HtmlTextWriter(swrt);
            lc.RenderControl(htw);
            Response.Write("<HEAD><STYLE>");
            Response.Write(".nobot {border-bottom: 1px solid red;}");
            Response.Write("td {border: 1px solid black;}");
            Response.Write("</STYLE></HEAD>");
            Response.Write(swrt.ToString());
            Response.Flush();
            Response.End();
        }

        public ActionResult Storno(decimal? id)
        {
            _entities = new EntitiesBarsCore().NewEntity();
            var res = _entities.ExecuteStoreQuery<BP_REASON>("select * from bp_reason order by id").ToList();
            return View(res);
        }
        [HttpPost]
        public ActionResult Storno(decimal? id,decimal reason)
        {
            string status = "ok";
            string message = "";

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.CommandText = "begin p_back_web(:p_ref,:p_reason,:res_code,:res_text);end;";
                cmd.Parameters.Add("p_ref", OracleDbType.Decimal, id, ParameterDirection.Input);
                cmd.Parameters.Add("p_reason", OracleDbType.Decimal, reason, ParameterDirection.Input);
                cmd.Parameters.Add("res_code", OracleDbType.Decimal, 0, ParameterDirection.Output);
                cmd.Parameters.Add("res_text", OracleDbType.Varchar2, 200,null,ParameterDirection.Output);
                if (con.State != ConnectionState.Open) con.Open();
                cmd.ExecuteNonQuery();

                if (Convert.ToDecimal(((OracleDecimal)cmd.Parameters["res_code"].Value).Value) != 0)
                {
                    status = "error";
                }

                message = Convert.ToString(cmd.Parameters["res_text"].Value);
            }
            catch (Exception e)
            {
                status = "error";
                message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            finally
            {
                con.Close();
                cmd.Dispose();
                con.Dispose();
            }

            return Json(new { status, message }, JsonRequestBehavior.AllowGet); 
        }        
    }
}