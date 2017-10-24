using System;
using System.Web.UI;
using System.Data;
using Bars.EAD;
using ibank.core;
using Bars.Exception;
using BarsWeb.Core.Logger;
using Oracle.DataAccess.Client;

namespace Bars.UserControls
{
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
                _dbLogger.Info("TemplateID = "+ TemplateID, "deposit");
                _dbLogger.Info("EAStructID = "+ EAStructID.ToString(), "deposit" );

                if ( EAStructID.HasValue)
                    this._DocID = ep.DOC_CREATE("DOC", TemplateID, null, EAStructID, RNK, AgrID);
                

                // печатаем документ
                FrxParameters pars = new FrxParameters();
                if (DocID.HasValue)
                {
                    pars.Add(new FrxParameter("p_doc_id", TypeCode.Int64, Convert.ToInt64(DocID.Value)));
                    _dbLogger.Info("p_doc_id = " + DocID.Value.ToString(), "deposit");
                }

                if (RNK.HasValue)
                {
                    pars.Add(new FrxParameter("p_rnk", TypeCode.Decimal, RNK));
                    _dbLogger.Info("p_rnk = " + RNK.ToString(), "deposit");
                }
                if (AgrID.HasValue)
                {
                    pars.Add(new FrxParameter("p_agr_id", TypeCode.Int64, AgrID));
                    _dbLogger.Info("p_agr_id = " + AgrID.ToString(), "deposit");
                }
                if (AgrUID.HasValue)
                {
                    pars.Add(new FrxParameter("p_agrmnt_id", TypeCode.Int32, AgrUID));
                    _dbLogger.Info("p_agrmnt_id = " + AgrUID.ToString(), "deposit");
                }


                // дополнительные параметры
                foreach (FrxParameter par in this.AddParams)
                    pars.Add(par);

                FrxDoc doc = new FrxDoc(
                    FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(TemplateID)),
                    pars,
                    this.Page);

                _dbLogger.Info("doc.TemplatePath = " + doc.TemplatePath, "deposit");

                // открываем контрол подписи
                cbSigned.Checked = false;
                cbSigned.Enabled = true;
                // выбрасываем в поток в формате PDF

                doc.Print(FrxExportTypes.Pdf);

                //// открываем контрол подписи
                //cbSigned.Checked = false;
                //cbSigned.Enabled = true;
            }
            catch (DepositException ex)
            {
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