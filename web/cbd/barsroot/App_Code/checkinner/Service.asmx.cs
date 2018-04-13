using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Web;
using System.Web.Services;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Xml;
using System.Web.Script.Services;
using System.Web.Script.Serialization;

namespace BarsWeb.CheckInner
{
    public class VisaResult
    {
        /// <summary>
        /// OK, ERROR
        /// </summary>
        private String _Code = "OK";

        public String Code
        {
            get
            {
                return _Code;
            }
            set
            {
                _Code = value;
            }
        }
        public String Text
        {
            get;
            set;
        }

        public VisaResult()
        {
        }
    }

    public class MakeData4VisaResult
    {
        /// <summary>
        /// OK, WARNING, ERROR
        /// </summary>
        private String _Code = "OK";

        public String Code
        {
            get
            {
                return _Code;
            }
            set
            {
                _Code = value;
            }
        }
        public String Text
        {
            get;
            set;
        }
        public String DataXml
        {
            get;
            set;
        }

        public MakeData4VisaResult()
        {
        }
    }

    [ScriptService]
    public class Service : Bars.BarsWebService
    {
        // размер куска для разбивки clob
        private const int CLOB_PIECE_SIZE = 2000;

        public Service()
        {
            InitializeComponent();
        }

        #region Component Designer generated code

        //Required by the Web Services Designer 
        private IContainer components = null;

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
        }

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        protected override void Dispose(bool disposing)
        {
            if (disposing && components != null)
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #endregion
        [WebMethod(EnableSession = true)]
        public object[] GetData(string[] data)
        {
            string filter = "";

            AppPars Params = new AppPars(data[10]);

            InitOraConnection(Context);

            try
            {
                ClearParameters();
                if (data[10] != "0")
                {
                    //-- если не самовиза
                    SetParameters("pgrpid", DB_TYPE.Decimal, decimal.Parse(data[9]), DIRECTION.Input);
                    String GrpidHex = Convert.ToString(SQL_SELECT_scalar("select idchk_hex from chklist where idchk = :pgrpid"));

                    ClearParameters();
                    SetParameters("p_grpid_hex", DB_TYPE.Varchar2, GrpidHex, DIRECTION.Input);
                    filter = " a.NEXTVISAGRP = :p_grpid_hex";
                }

                // Для модуля валютного контроля - понимаю плохо так делать, но сроки жмут ...
                // Если в сесии пришел документ - фильтруем по нему только 
                if (Session["cim.CurrRef"] != null)
                {
                    SetParameters("p_ref", DB_TYPE.Decimal, Session["cim.CurrRef"], DIRECTION.Input);
                    if (!string.IsNullOrEmpty(filter))
                        filter += " and ";
                    filter += " a.ref = :p_ref";
                }
                // ----------- закончился плохой блок 

                SetRole(Params.Role);

                object[] res = new object[5];
                object[] MainResult = BindTableWithNewFilter(@"a.COLOR1,	
																a.COLOR2,	
																to_char(a.VDAT,'dd.MM.yyyy') as VDAT, 
																a.REF, 
																a.TT, 
																a.NLSA,
                                                                a.MFOA,
                                                                a.ID_A,
                                                                a.NAM_A, 
																a.NLSB, 
																a.MFOB,
																a.NB_B,
                                                                a.ID_B,
                                                                a.NAM_B, 
																a.S, 
																a.S_, 
																a.DK, 
																a.SK, 
																a.LCV1, 
																a.DIG1, 
																a.USERID, 
																a.CHK, 
																a.NAZN, 
																a.LCV2, 
																a.DIG2, 
																a.S2, 
																a.S2_, 
																a.ND, 
																a.NEXTVISAGRP", Params.Table + " a", filter, data);

                res[0] = MainResult[0];
                res[1] = MainResult[1];

                // готовим данные по визам на вычитаных документах
                res[2] = PrepareDocVisasXmlData(MainResult[0], Params.Table);

                ClearParameters();
                if (data[10] != "0")
                {
                    //-- если не самовиза
                    SetParameters("pgrpid", DB_TYPE.Decimal, decimal.Parse(data[9]), DIRECTION.Input);
                    String GrpidHex = Convert.ToString(SQL_SELECT_scalar("select idchk_hex from chklist where idchk = :pgrpid"));

                    ClearParameters();
                    SetParameters("p_grpid_hex", DB_TYPE.Varchar2, GrpidHex, DIRECTION.Input);
                    filter = " a.NEXTVISAGRP = :p_grpid_hex";
                }
                // Для модуля валютного контроля - понимаю плохо так делать, но сроки жмут ...
                // Если в сесии пришел документ - фильтруем по нему только 
                if (Session["cim.CurrRef"] != null)
                {
                    SetParameters("p_ref", DB_TYPE.Decimal, Session["cim.CurrRef"], DIRECTION.Input);
                    if (!string.IsNullOrEmpty(filter))
                        filter += " and ";
                    filter += " a.ref = :p_ref";
                }
                // ----------- закончился плохой блок 

                DataSet dsAggs = GetFullDataSetForTable("count(1) as cnt, sum(a.s_) as s_", Params.Table + " a", filter, data);
                res[3] = Convert.ToDecimal(dsAggs.Tables[0].Rows[0]["CNT"]);
                res[4] = String.Format("{0:### ### ### ### ### ### ### ### ### ##0.00}", dsAggs.Tables[0].Rows[0]["S_"]);

                return res;
            }
            finally
            {
                DisposeOraConnection();
            }
        }
        [WebMethod(EnableSession = true)]
        public MakeData4VisaResult GetDataForVisa(string grpId, string[] refs, string type)
        {
            MakeData4VisaResult Result = new MakeData4VisaResult();
            String XmlDataDecoded = MakeInputXml(grpId, "", refs).InnerXml;

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            OracleTransaction trz = con.BeginTransaction();

            try
            {
                // записываем клоб по частям
                cmd.CommandText = "insert into tmp_lob (id, strdata) values (:p_id, :p_strdata)";
                for (Int32 i = 0; i <= XmlDataDecoded.Length / CLOB_PIECE_SIZE; i++)
                {
                    String StrData = XmlDataDecoded.Substring(i * CLOB_PIECE_SIZE, Math.Min(XmlDataDecoded.Length - i * CLOB_PIECE_SIZE, CLOB_PIECE_SIZE));

                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("p_id", OracleDbType.Int32, i, ParameterDirection.Input);
                    cmd.Parameters.Add("p_strdata", OracleDbType.Varchar2, StrData, ParameterDirection.Input);
                    cmd.ExecuteNonQuery();
                }

                // собираем клоб и передаем в процедуру, разбираем результат
                cmd.CommandText = "declare l_in_data  clob; l_out_data clob; begin bars_lob.import_clob(l_in_data); bars_lob.clear_temporary; chk.make_data4visa_xml(l_in_data, l_out_data); bars_lob.export_clob(l_out_data); end;";
                cmd.Parameters.Clear();
                cmd.ExecuteNonQuery();

                // собираем клоб по частям
                cmd.CommandText = "select l.id, l.strdata from tmp_lob l order by l.id";
                cmd.Parameters.Clear();

                String OutXmlData = String.Empty;
                OracleDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    OutXmlData += (String)rdr["strdata"];
                }
                rdr.Close();

                // закрываем транзакцию
                trz.Commit();

                // разбираем ответ
                XmlDocument DotNetXml = new XmlDocument();
                DotNetXml.InnerXml = OutXmlData;
                Result.DataXml = OutXmlData;
                XmlNodeList NdList = DotNetXml.GetElementsByTagName("doc");

                Int16 OkCnt = 0;
                for (int i = 0; i < NdList.Count; i++)
                {
                    if (NdList.Item(i).Attributes["err"].InnerText != "0")
                    {
                        Result.Code = "WARNING";
                        Result.Text += String.Format("<BR>№{0}: <code style='FONT-SIZE: 10pt; COLOR: red'>{1}</code>", NdList.Item(i).Attributes["ref"].InnerText, NdList.Item(i).Attributes["erm"].InnerText);
                    }
                    else OkCnt++;
                }

                // если нет ниодного хорошего документа, то статус ERROR
                if (OkCnt == 0) Result.Code = "ERROR";
            }
            catch (System.Exception e)
            {
                // откатываем транзакцию
                trz.Rollback();
                throw e;
            }
            finally
            {

                con.Close();
                con.Dispose();
            }

            return Result;
        }

        [WebMethod(EnableSession = true)]
        public VisaResult PutVisas(String XmlData, String Type)
        {
            VisaResult Result = new VisaResult();
            String XmlDataDecoded = HttpUtility.UrlDecode(XmlData);

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            OracleTransaction trz = con.BeginTransaction();
            try
            {
                // записываем клоб по частям
                cmd.CommandText = "insert into tmp_lob (id, strdata) values (:p_id, :p_strdata)";
                for (Int32 i = 0; i <= XmlDataDecoded.Length / CLOB_PIECE_SIZE; i++)
                {
                    String StrData = XmlDataDecoded.Substring(i * CLOB_PIECE_SIZE, Math.Min(XmlDataDecoded.Length - i * CLOB_PIECE_SIZE, CLOB_PIECE_SIZE));

                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("p_id", OracleDbType.Int32, i, ParameterDirection.Input);
                    cmd.Parameters.Add("p_strdata", OracleDbType.Varchar2, StrData, ParameterDirection.Input);
                    cmd.ExecuteNonQuery();
                }

                // собираем клоб и передаем в процедуру, разбираем результат
                cmd.CommandText = "declare l_in_data  clob; l_out_data clob; begin bars_lob.import_clob(l_in_data); bars_lob.clear_temporary; chk.put_visas_xml(l_in_data, l_out_data); bars_lob.export_clob(l_out_data); end;";
                cmd.Parameters.Clear();
                cmd.ExecuteNonQuery();

                // собираем клоб по частям
                cmd.CommandText = "select l.id, l.strdata from tmp_lob l order by l.id";
                cmd.Parameters.Clear();

                String OutXmlData = String.Empty;
                OracleDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    OutXmlData += (String)rdr["strdata"];
                }
                rdr.Close();

                // разбираем ответ
                System.Xml.XmlDocument DotNetXml = new System.Xml.XmlDocument();
                DotNetXml.InnerXml = OutXmlData;
                System.Xml.XmlNodeList NdList = DotNetXml.GetElementsByTagName("doc");

                // название выполняемой операции
                XmlNode docs4visa = DotNetXml.GetElementsByTagName("docs4visa")[0];
                String OperationName = String.Empty;
                switch (docs4visa.Attributes["par"].Value)
                {
                    case "-1": 
                        OperationName = "повернуто";
                        break;
                    case "0":
                        OperationName = "завізовано";
                        break;
                    default:
                        OperationName = "сторновано";
                        break;
                }

                // формируем результат визирования
                String ResultText = String.Empty;

                Int32 DocsCount = 0;
                Hashtable htDocsSum = new Hashtable();

                cmd.CommandText = @"select o.ref, o.s / power(10, t.dig) as s, t.lcv, t.name as lcv_name
                                      from oper o, tabval t
                                     where o.ref = :p_ref
                                       and o.kv = t.kv";

                cmd.Parameters.Clear();
                cmd.Parameters.Add("p_ref", OracleDbType.Int64, ParameterDirection.Input);

                for (int i = 0; i < NdList.Count; i++)
                {
                    // успешные документы отображаем общей суммой в разрезе валют
                    if (NdList.Item(i).Attributes["err"].InnerText == "0")
                    {
                        DocsCount++;

                        cmd.Parameters["p_ref"].Value = Convert.ToInt64(NdList.Item(i).Attributes["ref"].InnerText);

                        using (OracleDataReader rdr1 = cmd.ExecuteReader())
                        {
                            if (rdr1.Read())
                            {
                                if (!htDocsSum.Contains((String)rdr1["lcv"])) htDocsSum.Add((String)rdr1["lcv"], (Decimal)0);
                                htDocsSum[(String)rdr1["lcv"]] = (Decimal)htDocsSum[(String)rdr1["lcv"]] + Convert.ToDecimal(rdr1["s"]);
                            }
                            rdr1.Close();
                        }
                    }
                    else
                    {
                        ResultText += String.Format("<BR>№{0}: {1}", NdList.Item(i).Attributes["ref"].InnerText, NdList.Item(i).Attributes["erm"].InnerText);
                    }
                }

                // если были успешные документы, то отображаем из первыми
                if (DocsCount > 0)
                {
                    String DocsSumText = String.Empty;
                    foreach (String key in htDocsSum.Keys)
                        DocsSumText += (!String.IsNullOrEmpty(DocsSumText) ? "; " : "") + String.Format("{0} - {1:### ### ### ### ### ### ### ##0.00#}", key, htDocsSum[key]);

                    Result.Text = String.Format("Успішно {0} {1} док. на суму {2}<BR/>{3}", OperationName, DocsCount, DocsSumText, ResultText);
                }
                else
                {
                    Result.Text = ResultText;
                }

                // закрываем транзакцию
                trz.Commit();
            }
            catch (System.Exception e)
            {
                // откатываем транзакцию
                trz.Rollback();
                throw e;
            }
            finally
            {

                con.Close();
                con.Dispose();
            }

            return Result;
        }
        public System.Xml.XmlDocument MakeInputXml(string grpId, string key, string[] refs)
        {
            XmlDocument XmlDoc = new XmlDocument();

            // рут элемент
            XmlElement XmlRootElement = XmlDoc.CreateElement("docs4visa");
            XmlDoc.AppendChild(XmlRootElement);

            // основные параметры
            XmlAttribute XmlAttrGrpID = XmlDoc.CreateAttribute("grpid");
            XmlAttrGrpID.InnerText = grpId;
            XmlRootElement.Attributes.Append(XmlAttrGrpID);
            XmlAttribute XmlAttrKey = XmlDoc.CreateAttribute("key");
            XmlAttrKey.InnerText = key;
            XmlRootElement.Attributes.Append(XmlAttrKey);

            // создаем все референсы
            foreach (String Ref in refs)
            {
                XmlElement XmlDocElement = XmlDoc.CreateElement("doc");
                XmlRootElement.AppendChild(XmlDocElement);

                XmlAttribute XmlAttrRef = XmlDoc.CreateAttribute("ref");
                XmlAttrRef.InnerText = Ref;
                XmlDocElement.Attributes.Append(XmlAttrRef);
            }

            /* Структура XML
            <?xml version="1.0" encoding="utf-8" ?>
            <docs4visa grpid="grpId" key="key">
              <doc ref="ref" />
            </docs4visa>  
            */

            return XmlDoc;
        }
        private object PrepareDocVisasXmlData(object xml, string mainTable)
        {
            // будем парсить полученые данные
            XmlDocument DocsVisas = new XmlDocument();
            DocsVisas.LoadXml(Convert.ToString(xml));

            // создаем подготовленый для отображения 
            XmlDocument PreraredDocsVisas = new XmlDocument();
            XmlNode xmlDeclar = PreraredDocsVisas.CreateNode(XmlNodeType.XmlDeclaration, "", "");
            PreraredDocsVisas.AppendChild(xmlDeclar);
            XmlNode xmlRoot = PreraredDocsVisas.CreateElement("", "ROOT", "");
            PreraredDocsVisas.AppendChild(xmlRoot);

            // вспомогательные списки
            ArrayList Refs = new ArrayList();
            XmlNodeList nodesRows = DocsVisas.GetElementsByTagName("Table");

            // получаем список референсов
            for (int i = 0; i < nodesRows.Count; i++)
            {
                decimal dREF = Convert.ToDecimal((nodesRows[i] as XmlElement).GetElementsByTagName("REF")[0].InnerText);

                ClearParameters();
                SetParameters("pref", DB_TYPE.Decimal, dREF, DIRECTION.Input);
                DataTable dt = SQL_SELECT_dataset("SELECT  NVL(v.CHECKGROUP, '--') as CHKGRP, NVL(v.MARKID, 0) as MARKID, NVL(v.USERNAME, '--') as USERNAME, a.FLAGS, v.INCHARGE FROM V_VISALIST v, " + mainTable + " a WHERE v.REF = a.REF and v.REF = :pref ORDER BY COUNTER, SQNC").Tables[0];

                for (int j = 0; j < dt.Rows.Count; j++)
                {
                    string REF = "nd_" + Convert.ToString(dREF);
                    string CHECKGROUP = Convert.ToString(dt.Rows[j]["CHKGRP"]);
                    string MARKID = Convert.ToString(dt.Rows[j]["MARKID"]);
                    string MARK = "";
                    string COLOR = "";
                    string USERNAME = Convert.ToString(dt.Rows[j]["USERNAME"]);
                    string FLAGS = Convert.ToString(dt.Rows[j]["FLAGS"]);
                    string INCHARGE = Convert.ToString(dt.Rows[j]["INCHARGE"]);

                    switch (MARKID)
                    {
                        case "0": { MARK = Resources.checkinner.LocalRes.text_VvelDokument; COLOR = "DarkBlue"; break; }
                        case "1": { MARK = Resources.checkinner.LocalRes.text_Viziroval; COLOR = "Black"; break; }
                        case "2": { MARK = Resources.checkinner.LocalRes.text_Oplatil; COLOR = "Black"; break; }
                        case "3": { MARK = Resources.checkinner.LocalRes.text_Storniroval; COLOR = "Red"; break; }
                        case "4": { MARK = Resources.checkinner.LocalRes.text_Ogidaet; COLOR = "Green"; break; }
                    }

                    // ищем такой референс
                    XmlNode xmlRef;
                    if (PreraredDocsVisas.GetElementsByTagName(REF).Count == 0)
                    {
                        xmlRef = PreraredDocsVisas.CreateElement(REF);
                        xmlRoot.AppendChild(xmlRef);
                    }
                    else
                    {
                        xmlRef = PreraredDocsVisas.GetElementsByTagName(REF).Item(0);
                    }

                    XmlElement xmlVisa = PreraredDocsVisas.CreateElement("VISA");
                    xmlRef.AppendChild(xmlVisa);

                    XmlElement xmlCHECKGROUP = PreraredDocsVisas.CreateElement("CHECKGROUP");
                    xmlCHECKGROUP.InnerText = CHECKGROUP;
                    xmlVisa.AppendChild(xmlCHECKGROUP);

                    XmlElement xmlMARK = PreraredDocsVisas.CreateElement("MARK");
                    xmlMARK.InnerText = MARK;
                    xmlVisa.AppendChild(xmlMARK);

                    XmlElement xmlMARKID = PreraredDocsVisas.CreateElement("MARKID");
                    xmlMARKID.InnerText = MARKID;
                    xmlVisa.AppendChild(xmlMARKID);

                    XmlElement xmlCOLOR = PreraredDocsVisas.CreateElement("COLOR");
                    xmlCOLOR.InnerText = COLOR;
                    xmlVisa.AppendChild(xmlCOLOR);

                    XmlElement xmlUSERNAME = PreraredDocsVisas.CreateElement("USERNAME");
                    xmlUSERNAME.InnerText = USERNAME;
                    xmlVisa.AppendChild(xmlUSERNAME);

                    XmlElement xmlINCHARGE = PreraredDocsVisas.CreateElement("INCHARGE");
                    xmlINCHARGE.InnerText = INCHARGE;
                    xmlVisa.AppendChild(xmlINCHARGE);

                    XmlElement xmlFLAGS = PreraredDocsVisas.CreateElement("FLAGS");
                    xmlFLAGS.InnerText = FLAGS;
                    if (GetChildNodeByName(xmlRef, "FLAGS") != null)
                        xmlRef.RemoveChild(GetChildNodeByName(xmlRef, "FLAGS"));
                    xmlRef.AppendChild(xmlFLAGS);
                }
            }

            return PreraredDocsVisas.InnerXml;
        }
        private string GetChildNodeValue(XmlNode parent, string childName)
        {
            for (int i = 0; i < parent.ChildNodes.Count; i++)
                if (parent.ChildNodes.Item(i).Name.ToUpper().Trim() == childName.ToUpper().Trim())
                    return parent.ChildNodes.Item(i).InnerText;

            return "--";
        }
        private XmlNode GetChildNodeByName(XmlNode parent, string childName)
        {
            for (int i = 0; i < parent.ChildNodes.Count; i++)
                if (parent.ChildNodes.Item(i).Name.ToUpper().Trim() == childName.ToUpper().Trim())
                    return parent.ChildNodes.Item(i);

            return null;
        }

        [WebMethod(EnableSession = true)]
        public void CheckVerifAbility()
        {
            try
            {
                InitOraConnection();
                string self_grp = GetGlobalParam("SELFVISA", "basic_info");
                SetRole("wr_verifdoc");
                string strQuery = "SELECT count(*)  FROM staff_chk WHERE ";
                if (!string.IsNullOrEmpty(self_grp))
                    strQuery += "chkid <> " + self_grp + " and ";
                strQuery += " id=user_id";
                string res = Convert.ToString(SQL_SELECT_scalar(strQuery));
                if (string.IsNullOrEmpty(res) || res == "0")
                    throw new Bars.Exception.BarsException("Пользователь не обладает правами Контролера платежей");
            }
            finally
            {
                DisposeOraConnection();
            }
        }

        [WebMethod(EnableSession = true)]
        public object[] GetVerifDocData(string[] data)
        {
            InitOraConnection();
            string filter = string.Empty;
            try
            {
                SetRole("wr_verifdoc");

                object[] res = new object[3];
                SetParameters("grpid", DB_TYPE.Decimal, decimal.Parse(data[10]), DIRECTION.Input);
                object[] MainResult = BindTableWithNewFilter("a.chk,a.ref, a.nd, a.userid, a.nlsa, a.mfob, a.nlsb, a.sum, a.nazn, a.id_b",
                                                             "v_user_verif_docs a", "decode(substr(a.NEXTVISAGRP,0,1), '0', substr(a.NEXTVISAGRP,2), a.NEXTVISAGRP)=chk.TO_HEX(:grpid)", data);

                res[0] = MainResult[0];
                res[1] = MainResult[1];

                return MainResult;
            }
            finally
            {
                DisposeOraConnection();
            }
        }

    }
}
