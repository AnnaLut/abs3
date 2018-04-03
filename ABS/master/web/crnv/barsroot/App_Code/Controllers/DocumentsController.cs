using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using System.IO;

using Models;
using barsroot.Models;

using System.Data;
using System.Data.Objects;
using System.Data.EntityClient;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

using Bars.Oracle;
using Bars.DocPrint;

namespace barsroot.Controllers
{

    //[Authorize]
    [AuthorizeSession]
    [IsPartinalRequest]
    public class DocumentsController : Controller
    {
        EntitiesBars entities;

        /// <summary>
        /// початкова сторінка
        /// </summary>
        /// <returns></returns>
        public ActionResult Index(int? id)
        {
            if (id == null) id = 1;//перегляд документів користувача
            switch (id)
            {
                case 0: ViewBag.Type="відділення"; break;
                case 1: ViewBag.Type="користувача"; break;
                case 2: ViewBag.Type="клієнта"; break;
                default:ViewBag.Type=""; break;
            }
            ViewBag.Id = id;
            return View();
        }
        /// <summary>
        /// часткове представлення для наповнення таблиці перегляду документів
        /// </summary>
        /// <param name="pageNum">номер сторінки в таблиці</param>
        /// <param name="pageSize">кількість рядків в таблиці</param>
        /// <param name="dStart">початкова дата пошуку</param>
        /// <param name="dEnd">кінцева дата пошуку</param>
        /// <param name="tipeDocumUserTobo">тип документів 0-відділення 1-користувача 2-клієнта</param>
        /// <param name="tipeDocumInOut">тип документів 1-всі 2-вхідні</param>
        /// <param name="tipeDocum">параметр сортування</param>
        /// <param name="tipeDocum">тип сортування (ASC/DESC)</param>
        /// <returns></returns>
        //[HttpPost]
        public ActionResult DocumentsLoad(int? pageNum,
                                          int? pageSize,
                                          string dStart,
                                          string dEnd,
                                          int id,/*int typeDocumUserTobo,*/
                                          int typeDocumInOut,
                                          string sort,
                                          string sortDir,
                                          int? filterSysId,
                                          int? filterUserId,
                                          string filterStr,
                                          string filterTable)
        {
            var test=Environment.Version.ToString();

            int typeDocumUserTobo = id;
            DateTime dS = new DateTime();
            DateTime dE = new DateTime();
            try
            {
                dS = Convert.ToDateTime(dStart);
                dE = Convert.ToDateTime(dEnd);
            }
            catch (Exception e) 
            {
                var t = e; 
                //return this.Content("errDate"); 
                return this.JavaScript("removeLoader($('body'));barsUiAlert('Не вірно введено період', 'Помилка!','error');");
            }
            finally { }
            sort = sort == "" ? "REF" : sort.ToUpper();

            if (filterTable != "" && filterTable!=null) filterTable = " , " + filterTable;

            int pNum = pageNum ?? 1;
            int pSize = pageSize ?? 10;
            ViewBag.RowNumber = pageSize;
            ViewBag.PageNum = pageNum;
            string filterString = " a.PDAT >= TRUNC (:ds) AND a.PDAT < (TRUNC (:de) + 1) ";

            if (!string.IsNullOrWhiteSpace(filterStr))
            {
                filterString += " and " + filterStr + " ";
            }

            List<V_DOCS_TOBO_OUT> tobodoc=new List<V_DOCS_TOBO_OUT>();
            entities = new EntitiesBarsCore().GetEntitiesBars();
            /*if (filterSysId != null)
            {
                var fs = entities.DYN_FILTER.Where(i => i.FILTER_ID == filterSysId).FirstOrDefault();
                if (fs != null)
                {
                    filterString+=" and "+fs.WHERE_CLAUSE+" ";
                    if(fs.FROM_CLAUSE!=null && fs.FROM_CLAUSE!="") filterTable+=" , "+fs.FROM_CLAUSE;
                }
            }
            if (filterUserId != null)
            {
                var fs = entities.DYN_FILTER.Where(i => i.FILTER_ID == filterUserId).FirstOrDefault();
                if (fs != null)
                { 
                    filterString+=" and "+fs.WHERE_CLAUSE+" ";
                    if(fs.FROM_CLAUSE!=null && fs.FROM_CLAUSE!="") filterTable+=" , "+fs.FROM_CLAUSE;                
                }
            }*/
            string typeSeach = "";
            switch (typeDocumUserTobo)
            {
                case 0: 
                    switch (typeDocumInOut)
                    {
                        case 1: typeSeach = "V_DOCS_TOBO_OUT"; break;
                        case 2: typeSeach = "V_DOCS_TOBO_IN"; break;
                    }
                    break;
                case 1:
                    switch (typeDocumInOut)
                    {
                        case 1: typeSeach = "V_DOCS_USER_OUT"; break;
                        case 2: typeSeach = "V_DOCS_USER_IN"; break;
                    }
                    break;
                default: break;
            }

            string sqlText = barsroot.ServicesClass.GetSelectStryng(entities: entities,
                                                        typeSeach: typeSeach,
                                                        filterSysId: filterSysId,
                                                        filterUserId: filterUserId,
                                                        filterTable: filterTable,
                                                        filterString: filterString,
                                                        sort: sort,
                                                        sortDir: sortDir,
                                                        pageNum: pageNum,
                                                        pageSize: pageSize);

            var text = @"SELECT * FROM 
                            (SELECT myquery.*, ROWNUM rnum
                                FROM (  SELECT a.*
                                        FROM " + typeSeach + " a " + filterTable + @"
                                        WHERE a.PDAT >= TRUNC (:ds)
                                          AND a.PDAT < (TRUNC (:de) + 1)
                                          " + filterString.Replace("$~~ALIAS~~$", "a") + @"
                                        ORDER BY a." + sort + @" " + sortDir + @") myquery
                                WHERE ROWNUM <=:rowon)
                            WHERE rnum >:rowwith" ;
           object[] Parameters = 
                    { 
                        new OracleParameter("ds",OracleDbType.Date).Value=dS, 
                        new OracleParameter("de",OracleDbType.Date ).Value=dE,
                        //new OracleParameter("rowon",OracleDbType.Decimal).Value=(pNum * pSize) + 1, 
                        //new OracleParameter("rowwith",OracleDbType.Decimal ).Value=(pNum * pSize) - pSize,
                    };
            try
            {
                tobodoc = entities.ExecuteStoreQuery<V_DOCS_TOBO_OUT>(sqlText, Parameters).ToList();
            }
            catch (Exception e) 
            {
                var t = e;
                return this.Content("<div>"+t.Message+"</div>");
            }
            finally
            {
                entities.Dispose();
            }

            if (tobodoc.Count == 0) return this.Content("NoData");
            return View(tobodoc);
        }

        /// <summary>
        /// Перегляд одного документу
        /// </summary>
        /// <param name="id">референс документу</param>
        /// <returns></returns>
        //[HttpPost]
        public ActionResult Document(int id)
        { 
            entities = new EntitiesBarsCore().GetEntitiesBars();
            var docum = (from item in entities.OPERs where item.REF == id select item).FirstOrDefault();
            object[] Parameters =         
            { 
                new OracleParameter("nSum",OracleDbType.Decimal).Value=docum.S,
                new OracleParameter("nKodVal",OracleDbType.Decimal).Value=docum.TABVAL_GLOBAL.KV,
                new OracleParameter("strGender",OracleDbType.Varchar2).Value="F",
                new OracleParameter("nDefDig",OracleDbType.Decimal).Value=2
            };
            try
            {
                ViewBag.Sumpr = Convert.ToString(entities.ExecuteStoreQuery<string>("select F_SUMPR(:nSum,:nKodVal,:strGender,:nDefDig) from dual", Parameters).FirstOrDefault());
            }
            catch (Exception e) { var t = e; } finally { }
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
                    var Tag = entities.OP_FIELD.Where(it => it.TAG == TagParam+"    ").FirstOrDefault();
                    //если в таблице не было найдено соответствия, то определяем 
                    //реквизит как СЕП
                    string name = (Tag == null) ? ("Вспомогательный реквизит СЭП " + TagParam) : (Tag.NAME);
                    object[] row = { Tag.NAME, ValueParam, TagParam };
                    dopRecwList.Add(row);
                }            
            }
            ViewBag.DopRecv=dopRecwList;
            ViewBag.FN_A = null; ViewBag.DAT_A = null;ViewBag.DATK_A = null;ViewBag.DAT_2_A = null;
            ViewBag.FN_B = null; ViewBag.DAT_B = null;ViewBag.DATK_B = null;
            var arcRRP=docum.ARC_RRP.FirstOrDefault();
            if (arcRRP != null)
            {
                var zagA = (from item in entities.ZAG_A where item.FN == arcRRP.FN_A && item.DAT==arcRRP.DAT_A select item).FirstOrDefault();
                if (zagA == null)
                {
                    var zagB = (from item in entities.ZAG_B where item.FN == arcRRP.FN_B && item.DAT==arcRRP.DAT_B select item).FirstOrDefault();
                    if (zagB != null)
                    {
                        ViewBag.FN_B =zagB.FN ; ViewBag.DAT_B =zagB.DAT; ViewBag.DATK_B = zagB.DATK;
                    }
                }
                else
                {
                    ViewBag.FN_A = zagA.FN; ViewBag.DAT_A = zagA.DAT; ViewBag.DATK_A = zagA.DATK; ViewBag.DAT_2_A = zagA.DAT_2;
                }
            }
            List<V_VISALIST> visa = new List<V_VISALIST>();
            try
            {
                visa = entities.ExecuteStoreQuery<V_VISALIST>(@"SELECT REF, COUNTER, SQNC, MARK, MARKID, CHECKGROUP, USERNAME, DAT, INCHARGE 
												    FROM V_VISALIST 
												    WHERE REF = :pref 
												    ORDER by Counter, Sqnc", new OracleParameter("pref", OracleDbType.Decimal).Value = docum.REF).ToList();

            }
            catch (Exception e) { var t = e; } finally { }
            decimal pLevId=0;
            foreach (var item in visa)
            {
                if (item.MARKID != 4)
                {
                    decimal pRef = docum.REF; decimal pLev = pLevId;
                    ObjectParameter FSign = new ObjectParameter("FSign", typeof(decimal));
                    ObjectParameter IntBuff = new ObjectParameter("IntBuff", typeof(string));
                    ObjectParameter ExtBuff = new ObjectParameter("ExtBuff", typeof(string));
                    try
                    {
                        entities.CHK_GETVISABUFFERSFORCHECK(pRef, pLev, FSign, IntBuff, ExtBuff);
                        var t = ExtBuff.Value;
                    }
                    catch (Exception e) { var t = e; }
                    finally { }
                    item.SIGN_FLAG=Convert.ToDecimal(FSign.Value);
                    item.BUFINT = Convert.ToString(IntBuff.Value);
                }
                pLevId++;
            }
            DtSystemSignParams dtSystemSignParams = new DtSystemSignParams();
            try
            {
                dtSystemSignParams = entities.ExecuteStoreQuery<DtSystemSignParams>(@"SELECT chk.get_SignLng as SIGNLNG, 
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
            catch (Exception e) { var t = e; } finally { }

            decimal pRefSep = docum.REF; decimal pLevSep = 0;
            ObjectParameter FSignSep = new ObjectParameter("FSign", typeof(decimal));
            ObjectParameter IntBuffSep = new ObjectParameter("IntBuff", typeof(string));
            ObjectParameter ExtBuffSep = new ObjectParameter("ExtBuff", typeof(string));
            try
            {
                entities.CHK_GETVISABUFFERSFORCHECK(pRefSep, pLevSep, FSignSep, IntBuffSep, ExtBuffSep);
                var t = ExtBuffSep.Value;
            }
            catch (Exception e) { var t = e; } finally { }
            dtSystemSignParams.EXTSIGNBUFF = (Convert.ToString(ExtBuffSep.Value) == string.Empty || Convert.ToString(ExtBuffSep.Value) == "") ? "0" : Convert.ToString(ExtBuffSep.Value);

            ViewBag.Visa = visa;
            ViewBag.DtSystemSignParams = dtSystemSignParams;

            return View(docum);
        }

        public void LoadTXT(int[] id, bool printModel = true)
        {
            IOraConnection icon = (IOraConnection)AppDomain.CurrentDomain.GetData("OracleConnectClass");
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
                            cDocPrint ourTick = new cDocPrint(ticCon, item, Server.MapPath("/TEMPLATE.RPT/"), printModel);
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
        public void LoadHTML(int id, bool printModel = true)
        {
            IOraConnection icon = (IOraConnection)AppDomain.CurrentDomain.GetData("OracleConnectClass");
            OracleConnection con = icon.GetUserConnection(System.Web.HttpContext.Current);

            cDocPrint ourTick = new cDocPrint(con, id, Server.MapPath("/TEMPLATE.RPT/"), printModel);

            try
            {
                Response.ClearContent();
                Response.ClearHeaders();
                Response.Charset = "windows-1251";
                Response.ContentEncoding = Encoding.GetEncoding("windows-1251");
                Response.ContentType = "text/html";

                Response.AppendHeader("content-disposition", "inline;filename=ticket_" + id + ".htm");
                Response.Write("<STYLE>@media Screen{.print_action{DISPLAY: none}} @media print{body *:not(PRE){display: none} }</STYLE>");
                Response.Write("<DIV align=center class=screen_action>");
                Response.Write("<INPUT id=btPrint type=\"button\" value=\"" + Resources.documentview.GlobalResource.printBtn + "\" style=\"FONT-SIZE:14px;WIDTH:100px;font-weight:bold\" onclick=\"window.print()\"><BR>");
                Response.Write("</DIV>");
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
            IOraConnection conn = (IOraConnection)AppDomain.CurrentDomain.GetData("OracleConnectClass");
            OracleConnection con = conn.GetUserConnection(System.Web.HttpContext.Current);
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();
                cDocPrint outTicket = new cDocPrint(con, id[0], Server.MapPath("/TEMPLATE.RPT/"), printModel);
                if (id.Length > 1)
                {
                    StreamWriter sw = new StreamWriter(outTicket.GetTicketFileName(),true);

                    for (int i = 1; i < id.Length; i++)
                    {
                        var ticCon = conn.GetUserConnection(System.Web.HttpContext.Current);
                        try
                        {
                            cDocPrint ourTick = new cDocPrint(ticCon, id[i], Server.MapPath("/TEMPLATE.RPT/"), printModel);
                            string text = System.IO.File.ReadAllText(ourTick.GetTicketFileName(),Encoding.ASCII);
                            var encoding = sw.Encoding;
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
            var table=cont.Get(0);
            string contentType = "vnd.ms-excel";
            LiteralControl lc = new LiteralControl();

            string attachment = "attachment; filename=test.xls"; 
            Response.ClearContent();
            Response.BufferOutput = true;
            Response.AddHeader("content-disposition", attachment);
            Response.Charset = "utf-8";
            Response.ContentEncoding = System.Text.Encoding.UTF8;
            Response.ContentType = "application/" + contentType;
            Response.Write("<meta http-equiv=Content-Type content=\"text/html; charset=utf-8\">");

            StringWriter swrt = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(swrt);
            lc.RenderControl(htw);
            Response.Write("<HEAD><STYLE>");
            Response.Write(".nobot {border-bottom: 1px solid red;}");
            Response.Write("td {border: 1px solid black;}");
            Response.Write("</STYLE></HEAD>");
            Response.Write(swrt.ToString());
            Response.Flush();
            Response.End();
        }
        
    }
}