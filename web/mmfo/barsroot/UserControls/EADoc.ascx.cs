using Bars.Classes;
using Bars.EAD;
using Bars.Exception;
using BarsWeb.Core.Logger;
using FastReport;
using FastReport.Data;
using FastReport.Export;
using FastReport.Export.Csv;
using FastReport.Export.Dbf;
using FastReport.Export.Html;
using FastReport.Export.Mht;
using FastReport.Export.Odf;
using FastReport.Export.OoXML;
using FastReport.Export.Pdf;
using FastReport.Export.RichText;
using FastReport.Export.Text;
using FastReport.Export.Xml;
using FastReport.Web;
using ibank.core;
using Oracle.DataAccess.Client;
using System;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;

namespace Bars.UserControls
{
    public class FrxDocLocal
    {
        #region Приватные свойства
        private String _templatePath;
        private FrxParameters _frxParameters;
        private Page _page;
        private Stream _stream;

        private readonly BarsWeb.Core.Logger.IDbLogger _dbLogger;

        #endregion

        #region Публичные свойства
        public String TemplatePath
        {
            get { return _templatePath; }
            set { _templatePath = value; }
        }
        #endregion

        #region Конструктор
        public FrxDocLocal(String templatePath, FrxParameters parameters, Page page)
        {
            ValidateTemplatePath(templatePath);

            _templatePath = templatePath;
            _frxParameters = parameters;
            _page = page;
            _dbLogger = DbLoggerConstruct.NewDbLogger();
            FastReport.Utils.RegisteredObjects.AddConnection(typeof(OracleDataConnection));
        }

        public FrxDocLocal(Stream stream, Page page)
        {
            ValidateStream(stream);
            _stream = stream;
            _page = page;
            _dbLogger = DbLoggerConstruct.NewDbLogger();
            FastReport.Utils.RegisteredObjects.AddConnection(typeof(OracleDataConnection));
        }
        #endregion

        #region Приватные методы
        public void ValidateTemplatePath(String templatePath)
        {
            if (!File.Exists(templatePath))
                throw new Bars.Exception.BarsException(String.Format("Файл шаблону {0} не знайдено", templatePath));
        }
        public void ValidateStream(Stream stream)
        {
            if (stream.Length == 0)
                throw new Bars.Exception.BarsException("Не можливо побудувати звіт з пустого файлу (параметр: stream)");
        }
        #endregion

        #region Статические методы
        public static String GetTemplatePathByFileName(String fileName)
        {
            return HttpContext.Current.Server.MapPath("/TEMPLATE.RPT/" + fileName);
        }
        public static String GetTemplateFileNameByID(String templateId)
        {
            String res;
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            try
            {
                OracleCommand cmd = new OracleCommand("select ds.file_name from doc_scheme ds where lower(ds.id) = :p_id", con);
                cmd.Parameters.Add("p_id", OracleDbType.Varchar2, templateId.ToLower(), ParameterDirection.Input);

                res = Convert.ToString(cmd.ExecuteScalar());
            }
            finally
            {
                con.Close();
                con.Dispose();
            }

            return res;
        }
        #endregion

        #region Публичные методы

        public WebReport GetWebReport()
        {
            WebReport webReport = new WebReport();
            Report rpt = new Report();
            webReport.Report = rpt;
            SetupReport(rpt);
            webReport.State = ReportState.Done;
            return webReport;
        }

        public void Print(FrxExportTypes exportType)
        {
            WebReport wrpt = new WebReport();

            //на страницу данный объект добавить нужно обязательно 
            HtmlGenericControl div = new HtmlGenericControl("div");
            div.Visible = false;
            div.Style.Add("visibility", "hidden");
            div.Controls.Add(wrpt);
            if (_page != null)
            {
                _page.Controls.Add(div);
            }
            wrpt.Visible = false;

            //шаблон отчета
            Report rpt = new Report();
            wrpt.Report = rpt;

            try
            {
                //настройка шаблона
                SetupReport(rpt);
                //wrpt.ReportDone = true;
                //это или баг или фича, если стейт не установить - работать не будет
                wrpt.State = ReportState.Done;
                
                // экспорт в нужный формат
                switch (exportType)
                {
                    case FrxExportTypes.Csv:
                        wrpt.ExportCsv(HttpContext.Current);
                        break;
                    case FrxExportTypes.Dbf:
                        wrpt.ExportDbf(HttpContext.Current);
                        break;
                    case FrxExportTypes.Excel2007:
                        wrpt.ExportExcel2007(HttpContext.Current);
                        break;
                    case FrxExportTypes.Html:
                        wrpt.ExportHtml(HttpContext.Current, false);
                        break;
                    case FrxExportTypes.Mht:
                        wrpt.ExportMht(HttpContext.Current);
                        break;
                    case FrxExportTypes.Ods:
                        wrpt.ExportOds(HttpContext.Current);
                        break;
                    case FrxExportTypes.Odt:
                        wrpt.ExportOdt(HttpContext.Current);
                        break;
                    case FrxExportTypes.Pdf:
                        wrpt.ExportPdf(HttpContext.Current);
                        break;
                    case FrxExportTypes.PowerPoint2007:
                        wrpt.ExportPowerPoint2007(HttpContext.Current);
                        break;
                    case FrxExportTypes.Rtf:
                        wrpt.ExportRtf(HttpContext.Current);
                        break;
                    case FrxExportTypes.Text:
                        wrpt.ExportText(HttpContext.Current);
                        break;
                    case FrxExportTypes.Word2007:
                        wrpt.ExportWord2007(HttpContext.Current);
                        break;
                    case FrxExportTypes.XmlExcel:
                        wrpt.ExportXmlExcel(HttpContext.Current);
                        break;
                    case FrxExportTypes.Xps:
                        wrpt.ExportXps(HttpContext.Current);
                        break;
                }

            }

            catch (System.Exception e)
            {
                string m = e.InnerException != null ? e.InnerException.Message : e.Message;
                _dbLogger.Error(string.Format("FrxDocLocal:Print Message={0}, TemplatePath={1}, StackTrace={2}, ", m, TemplatePath,  e.StackTrace), "FrxDocLocal");
                throw e;
                //HttpContext.Current.Response.Write(e.Message); :-)
            }
            finally
            {
                wrpt.Dispose();
                rpt.Dispose();
            }
        }
        public String Export(FrxExportTypes exportType)
        {
            String res = Path.GetTempPath() + Path.GetFileNameWithoutExtension(Path.GetTempFileName());
            string ext = ".tmp";

            ExportBase export = null;

            // объект отчета
            Report rpt = new Report();

            try
            {
                SetupReport(rpt);

                // выгрузка на диск
                switch (exportType)
                {
                    case FrxExportTypes.Csv:
                        export = new CSVExport();
                        ext = ".csv";
                        break;
                    case FrxExportTypes.Dbf:
                        export = new DBFExport();
                        break;
                    case FrxExportTypes.Excel2007:
                        export = new Excel2007Export();
                        ext = ".xls";
                        break;
                    case FrxExportTypes.Html:
                        export = new HTMLExport();
                        ext = ".html";
                        break;
                    case FrxExportTypes.Mht:
                        export = new MHTExport();
                        break;
                    case FrxExportTypes.Ods:
                        export = new ODSExport();
                        break;
                    case FrxExportTypes.Odt:
                        export = new ODTExport();
                        break;
                    case FrxExportTypes.Pdf:
                        export = new PDFExport();
                        ext = ".pdf";
                        break;
                    case FrxExportTypes.PowerPoint2007:
                        export = new PowerPoint2007Export();
                        ext = ".pptx";
                        break;
                    case FrxExportTypes.Rtf:
                        export = new RTFExport();
                        ext = ".rtf";
                        break;
                    case FrxExportTypes.Text:
                        export = new TextExport();
                        ext = ".txt";
                        break;
                    case FrxExportTypes.Word2007:
                        export = new Word2007Export();
                        ext = ".doc";
                        break;
                    case FrxExportTypes.XmlExcel:
                        export = new XMLExport();
                        break;
                    case FrxExportTypes.Xps:
                        export = new XPSExport();
                        break;
                    default:
                        throw new System.Exception(String.Format("Формат экспорту {0} не підтримується", exportType.ToString()));
                }

                res = res + ext;
                rpt.Export(export, res);
            }
            finally
            {
                rpt.Dispose();
                if (export != null) export.Dispose();
            }

            return res;
        }
        /// <summary>
        /// єкспорт в поток в пам"яті
        /// </summary>
        /// <param name="exportType">тип файлу експорту</param>
        /// <param name="stream">поток в який буде проведено експорт</param>
        public void ExportToMemoryStream(FrxExportTypes exportType, MemoryStream stream)
        {
            ExportBase export = null;
            Report rpt = new Report();
            try
            {
                SetupReport(rpt);
                switch (exportType)
                {
                    case FrxExportTypes.Csv:
                        export = new CSVExport();
                        break;
                    case FrxExportTypes.Dbf:
                        export = new DBFExport();
                        break;
                    case FrxExportTypes.Excel2007:
                        export = new Excel2007Export();
                        break;
                    case FrxExportTypes.Html:
                        export = new HTMLExport();
                        break;
                    case FrxExportTypes.Mht:
                        export = new MHTExport();
                        break;
                    case FrxExportTypes.Ods:
                        export = new ODSExport();
                        break;
                    case FrxExportTypes.Odt:
                        export = new ODTExport();
                        break;
                    case FrxExportTypes.Pdf:
                        export = new PDFExport();
                        break;
                    case FrxExportTypes.PowerPoint2007:
                        export = new PowerPoint2007Export();
                        break;
                    case FrxExportTypes.Rtf:
                        export = new RTFExport();
                        break;
                    case FrxExportTypes.Text:
                        export = new TextExport();
                        break;
                    case FrxExportTypes.Word2007:
                        export = new Word2007Export();
                        break;
                    case FrxExportTypes.XmlExcel:
                        export = new XMLExport();
                        break;
                    case FrxExportTypes.Xps:
                        export = new XPSExport();
                        break;
                    default:
                        throw new System.Exception(String.Format("Формат экспорту {0} не підтримується", exportType));
                }

                rpt.Export(export, stream);
            }
            finally
            {
                rpt.Dispose();
                if (export != null) export.Dispose();
            }
        }
        private void SetupReport(Report rpt)
        {
            if (_stream != null)
            {
                _stream.Position = 0;
                //завантаження готового збереженого шаблону
                rpt.LoadPrepared(_stream);
            }
            else
            {
                // загрузка шаблона
                rpt.Load(_templatePath);
                // соединение
                rpt.Report.Dictionary.Connections[0].ConnectionString =
                    OraConnector.Handler.IOraConnection.GetUserConnectionString();

                // параметры
                if (null != _frxParameters)
                {
                    foreach (FrxParameter p in _frxParameters)
                    {
                        rpt.Report.SetParameterValue(p.Name, p.Value);
                    }
                }
                rpt.Prepare();
            }

        }
        #endregion

        #region Приватные события

        #endregion
    }

    public class DOCSchemeRecord
    {
        public String TemplateID
        {
            get;
            set;
        }
        public String Name
        {
            get;
            set;
        }

        public DOCSchemeRecord(String TemplateID, OracleConnection con)
            : this()
        {
            OracleCommand cmd = con.CreateCommand();

            cmd.CommandText = "select ds.id, ds.name from doc_scheme ds where ds.id = :p_id and ds.fr = 1";
            cmd.Parameters.Add("p_id", OracleDbType.Varchar2, TemplateID, ParameterDirection.Input);

            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.Read())
                {
                    this.TemplateID = Convert.ToString(rdr["id"]);
                    this.Name = Convert.ToString(rdr["name"]);
                }
                else
                {
                    throw new System.Exception(String.Format("Не знайдено шаблон {0} у таблиці doc_scheme, або шаблон не описано як FastReport", TemplateID));
                }
            }
        }
        public DOCSchemeRecord()
        {
            this.TemplateID = String.Empty;
            this.Name = String.Empty;
        }
    }
    public class StructCodeRecord
    {
        public Int16? ID
        {
            get;
            set;
        }
        public String Name
        {
            get;
            set;
        }

        public StructCodeRecord(Int16 ID, OracleConnection con)
            : this()
        {
            OracleCommand cmd = con.CreateCommand();

            cmd.CommandText = "select sc.id, sc.name from ead_struct_codes sc where sc.id = :p_id";
            cmd.Parameters.Add("p_id", OracleDbType.Int64, ID, ParameterDirection.Input);

            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.Read())
                {
                    this.ID = Convert.ToInt16(rdr["id"]);
                    this.Name = Convert.ToString(rdr["name"]);
                }
                rdr.Close();
            }
        }
        public StructCodeRecord()
        {
            this.ID = (Int16?)null;
            this.Name = String.Empty;
        }
    }
    public class CustomerRecord
    {
        public Decimal RNK
        {
            get;
            set;
        }
        public String NMK
        {
            get;
            set;
        }
        public String OKPO
        {
            get;
            set;
        }

        public CustomerRecord(Decimal RNK, OracleConnection con)
        {
            OracleCommand cmd = con.CreateCommand();

            cmd.CommandText = "select c.rnk, c.nmk, c.okpo from customer c where c.rnk = :p_rnk";
            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, RNK, ParameterDirection.Input);

            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.Read())
                {
                    this.RNK = Convert.ToDecimal(rdr["rnk"]);
                    this.NMK = Convert.ToString(rdr["nmk"]);
                    this.OKPO = Convert.ToString(rdr["okpo"]);
                }
                rdr.Close();
            }
        }
    }

    [ParseChildren(true)]
    public partial class EADoc : System.Web.UI.UserControl
    {
        # region Приватные свойства
        private Decimal? _DocID
        {
            get
            {
                if (String.IsNullOrEmpty(hDocID.Value)) return (Decimal?)null;
                return Convert.ToDecimal(hDocID.Value);
            }
            set
            {
                hDocID.Value = Convert.ToString(value);
            }
        }
        private Boolean _IsSigned
        {
            get
            {
                if (ViewState["_IsSigned"] == null) ViewState["_IsSigned"] = false;
                return (Boolean)ViewState["_IsSigned"];
            }
            set
            {
                ViewState["_IsSigned"] = value;
            }
        }

        private DOCSchemeRecord _TemplateRecord;
        private StructCodeRecord _EAStructRecord;

        private DOCSchemeRecord TemplateRecord
        {
            get
            {
                if (String.IsNullOrEmpty(TemplateID)) return new DOCSchemeRecord();

                if (_TemplateRecord == null || _TemplateRecord.TemplateID != TemplateID)
                {
                    OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
                    try
                    {
                        _TemplateRecord = new DOCSchemeRecord(TemplateID, con);
                    }
                    finally
                    {
                        con.Close();
                        con.Dispose();
                    }
                }

                return _TemplateRecord;
            }
        }
        private StructCodeRecord EAStructRecord
        {
            get
            {
                if (!EAStructID.HasValue) return new StructCodeRecord();

                if (_EAStructRecord == null || _EAStructRecord.ID != EAStructID)
                {
                    OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
                    try
                    {
                        _EAStructRecord = new StructCodeRecord(EAStructID.Value, con);
                    }
                    finally
                    {
                        con.Close();
                        con.Dispose();
                    }
                }

                return _EAStructRecord;
            }
        }
        private readonly IDbLogger _dbLogger;

        # endregion
        public EADoc()
        {
            _dbLogger = DbLoggerConstruct.NewDbLogger();
        }


        # region Публичные свойства
        /// <summary>
        /// Ид. отпечатка
        /// </summary>
        public Decimal? DocID
        {
            get
            {
                return this._DocID;
            }
        }
        public Boolean IsSigned
        {
            get
            {
                return this._IsSigned;
            }

        }
        public Boolean Signed()
        {
            cbSigned.Checked = true;
            cbSigned.Enabled = false;
            return true;

        }
        public Boolean UnSigned()
        {
            cbSigned.Checked = false;
            cbSigned.Enabled = true;
            return true;

        }
        public void EnableBigFont()
        {
            cbBigFont.Visible = true;
        }
        public void EnableEnglish()
        {
            cbEnglish.Visible = true;
        }
        public void HideCheckBoxes()
        {
            cbBigFont.Visible = false;
            cbSigned.Visible = false;
            cbEnglish.Visible = false;
        }
        /// <summary>
        /// Ид. шаблона из DOC_SCHEME
        /// </summary>
        public String TemplateID
        {
            get
            {
                return (String)ViewState["TemplateID"];
            }
            set
            {
                ViewState["TemplateID"] = value;
            }
        }
        /// <summary>
        /// Текст заголовка
        /// </summary>
        public String TitleText
        {
            get
            {
                return (String)ViewState["TitleText"];
            }
            set
            {
                ViewState["TitleText"] = value;
            }
        }
        /// <summary>
        /// Текст контрола подписи
        /// </summary>
        public String SignText
        {
            get
            {
                return (String)ViewState["SignText"];
            }
            set
            {
                ViewState["SignText"] = value;
            }
        }
        /// <summary>
        /// Код структуры документа
        /// </summary>
        public Int16? EAStructID
        {
            get
            {
                return (Int16?)ViewState["EAStructID"];
            }
            set
            {
                ViewState["EAStructID"] = value;
            }
        }
        /// <summary>
        /// РНК клиента
        /// </summary>
        public Decimal? RNK
        {
            get
            {
                return (Decimal?)ViewState["RNK"];
            }
            set
            {
                ViewState["RNK"] = value;
            }
        }
        /// <summary>
        /// Ид. сделки
        /// </summary>
        public Int64? AgrID
        {
            get
            {
                return (Int64?)ViewState["AgrID"];
            }
            set
            {
                ViewState["AgrID"] = value;
            }
        }
        /// <summary>
        /// Ид. ДУ
        /// </summary>
        public Int32? AgrUID
        {
            get
            {
                return (Int32?)ViewState["AgrUID"];
            }
            set
            {
                ViewState["AgrUID"] = value;
            }
        }


        public Boolean Enabled
        {
            get { return ibPrint.Enabled; }
            set { ibPrint.Enabled = value; }
        }


        public Boolean Send2EA
        {
            get
            {
                if (ViewState["Send2EA"] == null) ViewState["Send2EA"] = true;
                return (Boolean)ViewState["Send2EA"];
            }
            set
            {
                ViewState["Send2EA"] = value;
            }
        }

        // Дополнительные параметры печати
        public FrxParameters AddParams
        {
            get
            {
                if (ViewState["AddParams"] == null) ViewState["AddParams"] = new FrxParameters();
                return (FrxParameters)ViewState["AddParams"];
            }
            set
            {
                ViewState["AddParams"] = value;
            }
        }
        # endregion

        # region События
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // cbSigned.Checked = false;
                cbSigned.Enabled = false;
            }
        }
        protected void ibPrint_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                // если есть подписка на событие то запускаем его
                if (this.BeforePrint != null)
                {
                    this.BeforePrint(this, new EventArgs());
                }

                //якщо друкуємо великими літерами/*найдибільніше доопрацювання всіх часів та народів*/
                if (cbBigFont.Checked)
                    this.TemplateID += "_BIGFONT";

                //якщо друкуємо на англійській мові
                if (cbEnglish.Checked)
                    this.TemplateID += "_ENG";

                // делаем запись об отпечатке
                EadPack ep = new EadPack(new BbConnection());
                _dbLogger.Info("FrxDocLocal:  TemplateID = " + TemplateID, "deposit");

                if (EAStructID.HasValue)
                    this._DocID = ep.DOC_CREATE("DOC", TemplateID, null, EAStructID, RNK, AgrID,null);

                // печатаем документ
                FrxParameters pars = new FrxParameters();
                if (DocID.HasValue)
                {
                    pars.Add(new FrxParameter("p_doc_id", TypeCode.Int64, Convert.ToInt64(DocID.Value)));
                    //_dbLogger.Info("p_doc_id = " + DocID.Value.ToString(), "deposit");
                }

                if (RNK.HasValue)
                {
                    pars.Add(new FrxParameter("p_rnk", TypeCode.Decimal, RNK));
                    //_dbLogger.Info("p_rnk = " + RNK.ToString(), "deposit");
                }
                if (AgrID.HasValue)
                {
                    pars.Add(new FrxParameter("p_agr_id", TypeCode.Int64, AgrID));
                    //_dbLogger.Info("p_agr_id = " + AgrID.ToString(), "deposit");
                }
                if (AgrUID.HasValue)
                {
                    pars.Add(new FrxParameter("p_agrmnt_id", TypeCode.Int32, AgrUID));
                    //_dbLogger.Info("p_agrmnt_id = " + AgrUID.ToString(), "deposit");
                }

                // дополнительные параметры
                foreach (FrxParameter par in this.AddParams)
                    pars.Add(par);

                FrxDocLocal doc = new FrxDocLocal(
                    FrxDocLocal.GetTemplatePathByFileName(FrxDocLocal.GetTemplateFileNameByID(TemplateID)),
                    pars,
                    this.Page);

                // открываем контрол подписи
                cbSigned.Checked = false;
                cbSigned.Enabled = true;
                // выбрасываем в поток в формате PDF
                try
                {
                    doc.Print(FrxExportTypes.Pdf);
                }
                catch (System.Exception ex) {
                    _dbLogger.Info(String.Format("FrxDocLocal:try alt template; FrxDocLocal_1: {0} , {1}", ex.Message, ex.StackTrace));
                    doc = new FrxDocLocal(
                    FrxDocLocal.GetTemplatePathByFileName(FrxDocLocal.GetTemplateFileNameByID(TemplateID).Replace(".frx", "_alt.frx")),
                    pars,
                    this.Page);
                    try
                    {
                        doc.Print(FrxExportTypes.Pdf);
                    }
                    catch(System.Exception ex2) {
                        _dbLogger.Info(String.Format("FrxDocLocal_2: {0} , {1}", ex.Message, ex.StackTrace));
                        HttpContext.Current.Response.Write(ex2.Message);
                    }
                }
                //// открываем контрол подписи
                //cbSigned.Checked = false;
                //cbSigned.Enabled = true;
            }
            catch (DepositException ex)
            {
                _dbLogger.Info(String.Format("FrxDocLocal_3: {0} , {1}", ex.Message, ex.StackTrace));
                throw new DepositException(ex.Message, ex.InnerException);
            }


        }
        protected void cbSigned_CheckedChanged(object sender, EventArgs e)
        {
            // проверяем отпечатал ли документ
            if (!this._DocID.HasValue)
            {
                cbSigned.Checked = false;
                cbSigned.Enabled = true;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert_not_printed", "alert('Документ не надруковано'); ", true);
            }
            else
            {
                cbSigned.Checked = true;
                cbSigned.Enabled = false;

                EadPack ep = new EadPack(new BbConnection());
                ep.DOC_SIGN(DocID);
                this._IsSigned = true;

                if (this.DocSigned != null)
                {
                    this.DocSigned(this, new EventArgs());
                }
            }
        }
        protected override void OnPreRender(EventArgs e)
        {
            // Текст заголовка
            lbTitle.Text = !String.IsNullOrEmpty(this.TitleText) ? this.TitleText : TemplateRecord.Name;
            lbTitle.ToolTip = String.Format("{0}: {1}", EAStructRecord.Name, TemplateRecord.Name);

            // Текст контрола подписи
            if (!String.IsNullOrEmpty(this.SignText))
                cbSigned.Text = this.SignText;

            base.OnPreRender(e);
        }

        public event EventHandler BeforePrint;
        public event EventHandler DocSigned;
        # endregion
    }
}