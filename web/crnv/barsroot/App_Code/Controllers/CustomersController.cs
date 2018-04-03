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

using System.Drawing;

namespace barsroot.Controllers
{

    //[Authorize]
    [AuthorizeSession]
    [IsPartinalRequest]
    public class CustomersController : Controller
    {
        EntitiesBars entities;

        /// <summary>
        /// початкова сторінка
        /// </summary>
        /// <returns></returns>
        public ActionResult Index(int? id, int? spd)
        {
            /*if (id == null) 
            {
                return this.JavaScript("removeLoader($('body'));barsUiAlert('Не задано обов`язковий параметр', 'Помилка!','error');");
            }*/
            id = id == null ? 0 : id;
            switch (id)
            {
                case 0: ViewBag.Type="(Всі)"; break;
                case 1: ViewBag.Type="(Банки)"; break;
                case 2: ViewBag.Type="(Юридичні особи)"; break;
                case 3: if (spd == 1)
                        { ViewBag.Type = "(Фізичні особи-СПД)"; }
                        else { ViewBag.Type = "(Фізичні особи)"; }; break;

                default:ViewBag.Type=""; break;
            }
            ViewBag.Id = id;
            ViewBag.Spd = spd;
            return View();
        }
        /// <summary>
        /// часткове представлення для наповнення таблиці перегляду контрагентів
        /// </summary>
        /// <param name="pageNum">номер сторінки в таблиці</param>
        /// <param name="pageSize">кількість рядків в таблиці</param>
        /// <param name="dStart">початкова дата пошуку</param>
        /// <param name="dEnd">кінцева дата пошуку</param>
        /// <param name="tipeDocumUserTobo">тип документів 0-відділення 1-користувача 2-клієнта</param>
        /// <param name="tipeDocumInOut">тип документів 1-всі 2-вхідні</param>
        /// <param name="tipeDocum">параметр сортування</param>
        /// <param name="tipeDocum">тип сортування (ASC/DESC)</param>
        /// <param name="viewClosedCustomer">показувати не показувати закритих клієнтів</param>
        /// <returns></returns>
        //[HttpPost]
        public ActionResult CustomersLoad(int? pageNum,
                                          int? pageSize,
                                          int id,
                                          int? spd,
                                          string sort,
                                          string sortDir,
                                          int? filterSysId,
                                          int? filterUserId,
                                          string filterStr,
                                          string filterTable,
                                          bool viewClosedCustomer)
        {
            int typeCustomer = id;
            sort = sort == "" ? "RNK" : sort.ToUpper();

            if (filterTable != "" && filterTable != null) filterTable = " , " + filterTable;

            pageNum = pageNum ?? 1;
            pageSize = pageSize ?? 10;
            ViewBag.RowNumber = pageSize;
            ViewBag.PageNum = pageNum;
            string where = "";
            if (id>0)
            {
                where=" a.CUSTTYPE="+Convert.ToString(id)+" ";
            }
            if (spd == 1)
            {
                where=where==""? " a.SED='91' " : where+" and a.SED='91' "  ;
            }
            if (!viewClosedCustomer)
            {
                where = where == "" ? " a.DATE_OFF is null " : where + " and a.DATE_OFF is null ";
            }
            string filterString = "";
            if (!String.IsNullOrWhiteSpace(filterStr))
            {
                where = where==""? filterStr : where+ " and " + filterStr;
            }
            filterString = where;
            List<V_TOBO_CUST> tobocust = new List<V_TOBO_CUST>();
            entities = new EntitiesBarsCore().GetEntitiesBars();
            string typeSeach = "V_TOBO_CUST";
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
            try
            {
                tobocust = entities.ExecuteStoreQuery<V_TOBO_CUST>(sqlText).ToList();
            }
            catch (Exception e)
            {
                var t = e;
                return this.Content("<div>" + t.Message + "</div>");
            }
            finally
            {
                entities.Dispose();
            }

            if (tobocust.Count == 0) return this.Content("NoData");
            return View(tobocust);
        }

        /// <summary>
        /// Перегляд одного контрагента
        /// </summary>
        /// <param name="id">рнк контрагента</param>
        /// <returns></returns>
        //[HttpPost]
        public ActionResult Customer(int? id, int? custtype, int? spd, int? rezid)
        {
            var dateStart=DateTime.Now;
            ViewBag.TimeStart = dateStart.ToString()+"."+dateStart.Millisecond.ToString();
            entities = new EntitiesBarsCore().GetEntitiesBars();
            //ViewBag.SysCont = entities.ExecuteStoreQuery<string>("select sys_context('bars_global', 'application_name') from dual").FirstOrDefault();
            CUSTOMER customer = new CUSTOMER();
            if (id != null && id>0)
            {
                customer = (from item in entities.CUSTOMERs where item.RNK == id select item).FirstOrDefault();
            }
            else
            {
                customer.CUSTTYPE = Convert.ToInt16(custtype);
                switch(custtype)
                {
                    case 1: if (rezid == 1) { customer.CODCAGENT = 1; }
                            else { customer.CODCAGENT = 2; }
                        break;
                    case 2: if (rezid == 1) { customer.CODCAGENT = 3; }
                            else { customer.CODCAGENT = 4; }
                        break;
                    case 3: if (rezid == 1) { customer.CODCAGENT = 5; }
                            else { customer.CODCAGENT = 6; }
                        break;
                    default: break;
                }
                customer.DATE_ON = DateTime.Now;
                customer.CODCAGENT1 = entities.CODCAGENTs.Where(i => i.CODCAGENT1 == customer.CODCAGENT).FirstOrDefault();
                //if (rezid == 1) customer.COUNTRY = 804;
                if (rezid == 1) customer.COUNTRY = Convert.ToInt16(entities.ExecuteStoreQuery<string>("select nvl(min(val), 804) from params where par = 'COUNTRY'").FirstOrDefault());
                customer.BRANCH = entities.V_TOBO_SUBTREE.FirstOrDefault().TOBO;
                customer.BRANCH1 = entities.BRANCHes.Where(i => i.BRANCH1 == customer.BRANCH).FirstOrDefault();

            }
            
            return View(customer); 
        }
        /// <summary>
        /// Пов"язані особи контрагента
        /// </summary>
        /// <param name="id">РНК контрагента</param>
        /// <returns></returns>
        public ActionResult CustomerRel(int id)
        {
            return View(id);
        }
        /// <summary>
        /// наповнення таблиці пов"язанихосіб
        /// </summary>
        /// <param name="id">РНК контрагента</param>
        /// <param name="pageNum">номер сторінки в таблиці</param>
        /// <param name="pageSize">к-ть рядків в таблиці</param>
        /// <returns></returns>
        public ActionResult CustomerRelLoad(int id,
                                            int pageNum=1,
                                            int pageSize=10)
        {
            entities = new EntitiesBarsCore().GetEntitiesBars();
            object[] Parameters = 
                    { 
                        new OracleParameter("p_rnk",OracleDbType.Decimal).Value=id
                    };
            var selectCust = @"select * from V_CUST_RELATIONS where rnk=:p_rnk";
            var rels=entities.ExecuteStoreQuery<Models.V_CUST_RELATIONS>(selectCust, Parameters).Skip((pageNum*pageSize)-pageSize).Take(pageSize+1).ToList();
            if (rels.Count() == 0)
            {
                return this.Content("");
            }
            else
            {
                return View(rels);
            }
        }
        /// <summary>
        /// редагування/заведення нової карточки пов"язаної особи
        /// </summary>
        /// <param name="id">РНК контрагента</param>
        /// <param name="relRnk">ИД/РНК пов"язаної особи</param>
        /// <param name="relIntext">тип пов"язаної особи(клієнт/НЕ клієнт банку)</param>
        /// <returns></returns>
        public ActionResult CustomerRelEdit(int id, int relRnk, int relIntext)
        {
            return View();
        }
        /// <summary>
        /// типи пов"язаності 
        /// </summary>
        /// <param name="id">РНК контрагента</param>
        /// <param name="relRnk">ИД/РНК пов"язаної особи</param>
        /// <param name="relIntext">тип пов"язаної особи(клієнт/НЕ клієнт банку)</param>
        /// <returns></returns>
        public ActionResult CustomerRelType(int id, int relRnk, int relIntext)
        {
            object[] Parameters = 
                    { 
                        new OracleParameter("p_rnk",OracleDbType.Decimal).Value=id,
                        new OracleParameter("p_rel_rnk",OracleDbType.Decimal).Value=relRnk,
                        new OracleParameter("p_rel_intext",OracleDbType.Decimal).Value=relIntext
                    };
            string selectCustType = @"select * from v_cust_rel_types 
                                        where id in (select rel_id from v_customer_rel 
                                                            where rnk=:p_rnk 
                                                                  and rel_rnk=:p_rel_rnk 
                                                                  and rel_intext=:p_rel_intext )";
            ViewBag.RNK = id;
            ViewBag.RELRNK = relRnk;
            ViewBag.RELINTEXT = relIntext;
            entities = new EntitiesBarsCore().GetEntitiesBars();
            var relType = entities.ExecuteStoreQuery<Models.V_CUST_REL_TYPES>(selectCustType, Parameters);
            return View(relType.ToList());
        }
        /// <summary>
        /// параметри зв"язку пов"язаної особи
        /// </summary>
        /// <param name="id">РНК контрагента</param>
        /// <param name="relRnk">ИД/РНК пов"язаної особи</param>
        /// <param name="relIntext">тип пов"язаної особи(клієнт/НЕ клієнт банку)</param>
        /// <param name="relId">ІД типу пов"язаності</param>
        /// <returns></returns>
        public ActionResult CustomerRelTypeOptions(int id, int relRnk, int relIntext, int relId)
        { 
            object[] Parameters = 
                    { 
                        new OracleParameter("p_rnk",OracleDbType.Decimal).Value=id,
                        new OracleParameter("p_rel_rnk",OracleDbType.Decimal).Value=relRnk,
                        new OracleParameter("p_rel_intext",OracleDbType.Decimal).Value=relIntext,
                        new OracleParameter("p_rel_id",OracleDbType.Decimal).Value=relId
                    };
            string selectCustType = @"select * from V_CUSTOMER_REL 
                                        where rnk=:p_rnk 
                                              and rel_rnk=:p_rel_rnk
                                              and rel_intext=:p_rel_intext
                                              and rel_id=:p_rel_id";
            entities = new EntitiesBarsCore().GetEntitiesBars();
            var relTypeOpt = entities.ExecuteStoreQuery<Models.V_CUSTOMER_REL>(selectCustType, Parameters);
            object[] Parameters2 = 
                    { 
                        new OracleParameter("p_id",OracleDbType.Decimal).Value=relId
                    };
            ViewBag.DataSetId = entities.ExecuteStoreQuery<string>("select dataset_id from v_cust_rel_types where id=:p_id",Parameters2).FirstOrDefault();
            return View(relTypeOpt.FirstOrDefault());
        }
        /// <summary>
        /// перегляд історії змін параметрів контрагента
        /// </summary>
        /// <param name="id">РНК контрагента</param>
        /// <returns></returns>
        public ActionResult CustomerUpdateHistory(int id)
        {
            return View(id);
        }
        /// <summary>
        /// наповнення табліці історії змін параметрів контрагента
        /// </summary>
        /// <param name="id">РНК контрагента</param>
        /// <param name="dStart">початкова дата виборки</param>
        /// <param name="dEnd">кінцева дата виборки</param>
        /// <param name="pageNum">номер сторінки в таблиці</param>
        /// <param name="pageSize">кількість рядків в табліці</param>
        /// <param name="sort">назва стовбця дл ясортування</param>
        /// <param name="sortDir">тип сортування (ASC/DESC)</param>
        /// <param name="filterStr">рядок фільтру</param>
        /// <returns></returns>
        public ActionResult CustomerUpdateHistoryLoad ( int id, 
                                                        string dStart = "",
                                                        string dEnd = "",
                                                        int pageNum=1,
                                                        int pageSize=10,
                                                        string sort="h.DAT",
                                                        string sortDir="DESC",
                                                        string filterStr="")
        {
            DateTime dS = new DateTime();
            DateTime dE = new DateTime();
            try
            {
                dS = string.IsNullOrWhiteSpace(dStart) ? DateTime.Now.AddMonths(-1) : Convert.ToDateTime(dStart);
                dE = string.IsNullOrWhiteSpace(dEnd) ? DateTime.Now : Convert.ToDateTime(dEnd);
            }
            catch (Exception e)
            {
                var t = e;
                //return this.Content("errDate"); 
                return this.JavaScript("removeLoader($('body'));barsUiAlert('Не вірно введено період', 'Помилка!','error');");
            }

            string select = @"SELECT c.semantic PAR,
                                upper(t.tabname) TABNAME,
                                h.valold OLD,
                                h.valnew NEW, 
                                TO_CHAR(h.dat,'DD/MM/YYYY') DAT,
                                h.isp USR, 
                                s.fio FIO 
                            FROM meta_tables t,
                                meta_columns c,
                                tmp_acchist h, 
                                staff s 
                            WHERE h.iduser=user_id 
                                AND h.acc=:rnk
                                AND h.tabid=t.tabid
                                AND t.tabid=c.tabid
                                AND h.colid=c.colid 
                                AND h.isp=s.logname 
                            ORDER BY h.dat desc,
                                t.tabid, 
                                h.idupd desc";
            object[] Parameters = 
                    { 
                        new OracleParameter("rnk",OracleDbType.Decimal).Value=id
                    };
            entities = new EntitiesBarsCore().GetEntitiesBars();
            var custUpdHist=new List<Models.CUSTOMER_UPDATE_HISTORY>();
            try
            {
                entities.Connection.Open();
                entities.P_ACCHIST(2, id, dS, dE);
                int skip = (pageNum * pageSize) - pageSize;
                custUpdHist = entities.ExecuteStoreQuery<Models.CUSTOMER_UPDATE_HISTORY>(select, Parameters)
                    .Skip(skip).Take(pageSize+1).ToList();
            }
            finally
            {
                entities.Connection.Close();
                entities.Dispose();
            }
            if (custUpdHist.Count() == 0)
            {
                return this.Content("");
            }
            return View(custUpdHist);
        }
        /// <summary>
        /// виклик довідника
        /// </summary>
        /// <param name="id">ім"я таблиці-довідника</param>
        /// <returns></returns>
        public ActionResult Katalog(string id)
        {
            return View();
        }
        /// <summary>
        /// наповнення таблиці довідника
        /// </summary>
        /// <returns></returns>
        public ActionResult KatalogLoad(string id,
                                        int pageNum = 1,
                                        int pageSize = 20,
                                        string sort = "1",
                                        string sortDir = "DESC",
                                        string filterStr = "")
        {
            return this.Content("");
        }
        /// <summary>
        /// метод для заповнення 'select' в HTML
        /// </summary>
        /// <param name="id">ІД запису який не повинен ввійти в результат</param>
        /// <param name="tableName">ім"я таблиці</param>
        /// <returns></returns>
        public ActionResult GetHandbookLoad(string id, string tableName)
        {
            string IdRow = "", ValueRow = "", whereString = "";
            switch (tableName.ToUpper())
            {
                case "SPR_REG":
                    IdRow = "c_dst";
                    ValueRow = "name_sti";
                    whereString="c_reg="+id;
                    break;
                case "ISE":
                    IdRow = "ise";
                    ValueRow = "name";
                    whereString="ise='"+id+"' and d_close is null";
                    break;
                case "FS":
                    IdRow = "fs";
                    ValueRow = "name";
                    whereString="fs='"+id+"' and d_close is null";
                    break;
                case "VED":
                    IdRow = "VED";
                    ValueRow = "name";
                    whereString="VED='"+id+"' and d_close is null";
                    break;
                case "OE":
                    IdRow = "OE";
                    ValueRow = "name";
                    whereString="OE='"+id+"' and d_close is null";
                    break;
                case "SP_K050":
                    IdRow = "K050";
                    ValueRow = "name";
                    whereString="K050='"+id+"' and d_close is null";
                    break;
                case "KL_K051":
                    IdRow = "K051";
                    ValueRow = "TXT";
                    whereString="K051=(select k051 from sp_k050 where k050='"+id+"') and d_close is null";
                    break;
                default: break;
            }

            List<Handbook> newHandbook = new List<Handbook>();
            using (entities = new EntitiesBarsCore().GetEntitiesBars())
            {
                newHandbook = ServicesClass.GetHandbookList(entities:entities,tableName:tableName,IdRow:IdRow,ValueRow:ValueRow,whereString:whereString).ToList();
            }
            if (newHandbook.Count == 0)
            {
                return this.Content("err");
            }

            return View(newHandbook);
        }

        public ActionResult PictureFile(int? id)
        {
            if (id == null)
            {
                //-- формируем файл
                Bitmap bmp = new Bitmap(150, 150);
                Graphics g = Graphics.FromImage(bmp);

                g.DrawLine(new Pen(Color.Black, 2), new Point(0, 0), new Point(150, 150));
                g.DrawLine(new Pen(Color.Black, 2), new Point(0, 150), new Point(150, 0));
                MemoryStream memoryStream = new MemoryStream();
                bmp.Save(memoryStream, System.Drawing.Imaging.ImageFormat.Bmp);
                return File(memoryStream, "image/bmp");

            }
            else
            {
                entities = new EntitiesBarsCore().GetEntitiesBars();
                var photo = entities.CUSTOMER_BIN_DATA.Where(i => i.ID == id).FirstOrDefault();
                return File(photo.BIN_DATA,"image/gif");
            }

            //return File(pr.LargePhoto, "image/gif");
        }
        /// <summary>
        /// Перереєстрація клієнта
        /// </summary>
        /// <param name="id">РНК клієнта</param>
        /// <returns>ok - якщо клієнт успішно перереєстрований,
        /// текст помилки - якщо виникли помилки</returns>
        public ActionResult ResurectCustomer(int id)
        {
            using (entities = new EntitiesBarsCore().GetEntitiesBars())
            {
                var cust = entities.CUSTOMERs.Where(i => i.RNK == id).FirstOrDefault();
                if (cust != null)
                {
                    if (cust.DATE_OFF == null)
                    {
                        return this.Content("Клиент не закритий!");
                    }
                    else
                    {
                        DateTime bdate = entities.ExecuteStoreQuery<DateTime>("SELECT bankdate FROM dual").FirstOrDefault();
                        if (bdate < cust.DATE_OFF)
                        {
                            return this.Content("Клієнт не може бути перереєстрований датою (" + bdate.ToShortDateString() + "), яка менша дати відкриття (" + Convert.ToDateTime(cust.DATE_OFF).ToShortDateString() + ").");
                        }
                        else
                        {
                            cust.DATE_OFF = null;
                            entities.SaveChanges();
                            return this.Content("ok");
                        }
                    }
                }
                else
                {
                    return this.Content("Клієнт з РНК " + id + " не існує!");
                }
            }
        }
        /// <summary>
        /// Закрити клієнта
        /// </summary>
        /// <param name="id">РНК клієнта</param>
        /// <returns>ok - якщо клієнт успішно закритий,
        /// текст помилки - якщо виникли помилки</returns>
        public ActionResult CloseCustomer(int id)
        {
            using (entities = new EntitiesBarsCore().GetEntitiesBars())
            {
                var cust = entities.CUSTOMERs.Where(i=>i.RNK==id).FirstOrDefault();
                if (cust != null)
                {
                    var custAcc = cust.ACCOUNTS.Where(i=>i.DAZS==null);
                    if (custAcc.Count() != 0)
                    {
                        return this.Content("У клієнта (РНК: "+id+") " + custAcc.Count() + " незакритих рахунків!");
                    }
                    else 
                    {
                        DateTime bdate = entities.ExecuteStoreQuery<DateTime>("SELECT bankdate FROM dual").FirstOrDefault();
                        if (bdate < cust.DATE_ON)
                        {
                            return this.Content(@"Клієнт (РНК: "+id+") не може бути закритий датою (" + bdate.ToShortDateString() + @"),
                                                  меншою дати відкриття (" + cust.DATE_ON + @")");
                        }
                        else 
                        {
                            cust.DATE_OFF = bdate;
                            entities.SaveChanges();
                            return this.Content("ok");
                        }
                    }
                }
                else
                {
                    return this.Content("Клієнт з РНК " + id + " не існує!");
                }
            }
        }
        /// <summary>
        /// Транслитерация наименования клиента
        /// </summary>
        /// <param name="nmk">ФИО клиента кирилицей</param>
        public string TransleteNMK(string nmk) 
        {
            string newNMK="";
            object[] Parameters = 
                    { 
                        new OracleParameter("p_txt",OracleDbType.Varchar2).Value=nmk
                    };
            using (entities = new EntitiesBarsCore().GetEntitiesBars())
            {
                newNMK = entities.ExecuteStoreQuery<string>("select f_translate_kmu(:p_txt) from dual",Parameters).FirstOrDefault();
            }
            return newNMK; 
        }





        public void LoadTXT(int[] id, bool printModel = true)
        {
            IOraConnection icon = (IOraConnection)AppDomain.CurrentDomain.GetData("OracleConnectClass");
            //OracleConnection con = icon.GetUserConnection(System.Web.HttpContext.Current);
            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
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
            //IOraConnection icon = (IOraConnection)AppDomain.CurrentDomain.GetData("OracleConnectClass");
            //OracleConnection con = icon.GetUserConnection(System.Web.HttpContext.Current);

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

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