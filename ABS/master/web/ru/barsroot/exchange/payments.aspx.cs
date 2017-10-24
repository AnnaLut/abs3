using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Bars.Exception;
using Bars.Oracle;
using Bars.Classes;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

public partial class Payments : Bars.BarsPage
{
    private DataSet         _ds;
    private DateTime        _bankdate;

    private void LoadSessionParams()
    {
        // FileName
        object objFileName = Session["exchange.FileName"];
        if (objFileName != null) this.label_file.Text = objFileName.ToString();
        else throw new BarsException("Имя файла импорта не задано");

        // LineCount
        object objLineCount = Session["exchange.LineCount"];
        if (objLineCount != null) this.text_count.Text = objLineCount.ToString();
        else throw new BarsException("Количество платежей не задано");

        // ds
        object ds = Session["exchange.ds"];
        if (ds != null) this._ds = (DataSet)ds;
        else throw new BarsException("Массив платежей отсутсвует в сессии");

        // bankdate
        object obj_bankdate = Session["exchange.bankdate"];
        if (obj_bankdate != null) this.hd_bankdate.Value = obj_bankdate.ToString();
        else throw new BarsException("Параметр bankdate отсутсвует в сессии");

        // regncode
        object obj_regncode = Session["exchange.regncode"];
        if (obj_regncode != null) this.hd_regncode.Value = obj_regncode.ToString();
        else throw new BarsException("Параметр regncode отсутсвует в сессии");

        // key_id
        object obj_key_id = Session["exchange.key_id"];
        if (obj_key_id != null) this.hd_key_id.Value = obj_key_id.ToString();
        else throw new BarsException("Параметр key_id отсутсвует в сессии");

        // tt_int
        object obj_tt_int = Session["exchange.tt_int"];
        if (obj_tt_int != null) this.hd_tt_int.Value = obj_tt_int.ToString();
        else throw new BarsException("Параметр tt_int отсутсвует в сессии");

        // tt_ext
        object obj_tt_ext = Session["exchange.tt_ext"];
        if (obj_tt_ext != null) this.hd_tt_ext.Value = obj_tt_ext.ToString();
        else throw new BarsException("Параметр tt_ext отсутсвует в сессии");

        // int_flag
        object obj_int_flag = Session["exchange.int_flag"];
        if (obj_int_flag != null) this.hd_int_flag.Value = obj_int_flag.ToString();
        else throw new BarsException("Параметр int_flag отсутсвует в сессии");

        // ext_flag
        object obj_ext_flag = Session["exchange.ext_flag"];
        if (obj_ext_flag != null) this.hd_ext_flag.Value = obj_ext_flag.ToString();
        else throw new BarsException("Параметр ext_flag отсутсвует в сессии");

        // debug_bankdate
        object obj_debug_bankdate = Session["exchange.debug_bankdate"];
        if (obj_debug_bankdate != null) this.hd_debug_bankdate.Value = obj_debug_bankdate.ToString();
        else throw new BarsException("Параметр debug_bankdate отсутсвует в сессии");

        //RemoveSessionKeys();
    }

    private void RemoveSessionKeys()
    {
        Session.Remove("exchange.FileName");
        Session.Remove("exchange.LineCount");
        Session.Remove("exchange.ds");
        Session.Remove("exchange.bankdate");
        Session.Remove("exchange.regncode");
        Session.Remove("exchange.key_id");
        Session.Remove("exchange.tt_int");
        Session.Remove("exchange.tt_ext");
        Session.Remove("exchange.int_flag");
        Session.Remove("exchange.ext_flag");
        Session.Remove("exchange.debug_bankdate");
        Session.Remove("exchange.Template");
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadSessionParams();
            LoadDS();
        }
    }


    private void LoadDS()
    {
        gv.DataSource = _ds;        
        gv.DataBind();        
    }

    private void LoadDBParams()
    {
        this.InitOraConnection();
        try
        {
            this.SetRole("WR_IMPEXP");
            _bankdate = Convert.ToDateTime(this.SQL_SELECT_scalar("SELECT web_utl.get_bankdate FROM dual"));
            /*
            cmd.Parameters.Clear();
            cmd.Parameters.Add("psum", OracleDbType.Varchar2, this.CheckSum, ParameterDirection.Input);
            cmd.CommandText = "SELECT count(*) FROM MOPER_ACCERTED_FILES WHERE FSUM = :psum";
            isOldCheckSum = Convert.ToInt32(cmd.ExecuteScalar());
            if (0 != isOldCheckSum) Errors.AddError("Данный файл '" + this.FirstFileName + "' уже загружался!!!");
            */
            // читаем PARAMS
            //cmd.CommandText = "select par,val from params where par in "
            //    + "('INTSIGN','VISASIGN','ABE_KI','ABE_KE','REGNCODE','SEPNUM','SIGNTYPE','SIGNLNG')";
            
        }
        finally
        {
            this.DisposeOraConnection();
        }
    }
    protected void HiddenField3_ValueChanged(object sender, EventArgs e)
    {

    }
    protected void bt_pay_Click(object sender, EventArgs e)
    {   // читаем данные из http-запроса
        string signatures = this.hd_signatures.Value;
        string key_id = this.hd_key_id.Value;
        // читаем данные из сессии
        LoadSessionParams();

        // разберем строку подписи и сохраним в полях _ds
        int pay_count = Convert.ToInt32(this.text_count.Text);
        int nStartPos = 0;
        int nSemicolonPos = 0;
        int nCommaPos = 0;
        for (int i = 0; i < pay_count; i++)
        {
            nSemicolonPos = signatures.IndexOf(";", nStartPos);
            if (nSemicolonPos == -1) nSemicolonPos = signatures.Length;
            nCommaPos = signatures.IndexOf(",", nStartPos);
            _ds.Tables[0].Rows[i]["INTSIGN"] = signatures.Substring(nStartPos, nCommaPos - nStartPos);
            _ds.Tables[0].Rows[i]["SEPSIGN"] = signatures.Substring(nCommaPos+1, nSemicolonPos - nCommaPos-1);
            nStartPos = nSemicolonPos+1;
        }
        bool fCommit = false;
        OracleTransaction tx;
        OracleConnection con = OraConnector.Handler.UserConnection;
        OracleCommand cmd = new OracleCommand();
        cmd.Connection = con;
        tx = con.BeginTransaction();
        try
        {
            cmd.CommandText = "SET ROLE WR_IMPEXP";
            cmd.ExecuteNonQuery();
            // сохраняем заголовок файла
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_fn", OracleDbType.Varchar2, this.label_file.Text, ParameterDirection.Input);
            cmd.CommandText = "begin web_impexp.store_file_header(:p_fn); end;";
            cmd.ExecuteNonQuery();
            
            for (int i = 0; i < pay_count; i++)
            {
                long Ref = Convert.ToInt64((decimal)_ds.Tables[0].Rows[i]["REF"]);
                string BankA = (string)_ds.Tables[0].Rows[i]["MFOA"];
                string BankB = (string)_ds.Tables[0].Rows[i]["MFOB"];
                string TT = this.hd_tt_int.Value;
                if (BankA != BankB) TT = this.hd_tt_ext.Value;
                byte Dk = Convert.ToByte((decimal)_ds.Tables[0].Rows[i]["DK"]);
                short Vob = Convert.ToInt16((decimal)_ds.Tables[0].Rows[i]["VOB"]);
                string Nd = (string)_ds.Tables[0].Rows[i]["ND"];                
                DateTime DatD = (DateTime)_ds.Tables[0].Rows[i]["DATD"];                
                DateTime DatP = (DateTime)_ds.Tables[0].Rows[i]["DATP"];
                DateTime DatV1 = DatP;
                DateTime DatV2 = DatP;
                string NlsA = (string)_ds.Tables[0].Rows[i]["NLSA"];
                string NlsB = (string)_ds.Tables[0].Rows[i]["NLSB"];
                string NamA = (string)_ds.Tables[0].Rows[i]["NAM_A"];
                string NamB = (string)_ds.Tables[0].Rows[i]["NAM_B"];
                short KvA = Convert.ToInt16((decimal)(_ds.Tables[0].Rows[i]["KV"]));
                short KvB = KvA;
                decimal SA = (decimal)(_ds.Tables[0].Rows[i]["S"]);
                decimal SB = SA;
                string OkpoA = (string)_ds.Tables[0].Rows[i]["ID_A"];
                string OkpoB = (string)_ds.Tables[0].Rows[i]["ID_B"];
                string Nazn = (string)_ds.Tables[0].Rows[i]["NAZN"];
                string OperId = key_id;
                string ExtSignHex = (string)_ds.Tables[0].Rows[i]["SEPSIGN"];
                string IntSignHex = (string)_ds.Tables[0].Rows[i]["INTSIGN"];
                try
                {
                    Bars.Doc.cDoc ourDoc = new Bars.Doc.cDoc(con,
                        Ref, TT, Dk, Vob, Nd, DatD, DatP, DatV1, DatV2,
                        NlsA, NamA, BankA, "", KvA, SA, OkpoA,
                        NlsB, NamB, BankB, "", KvB, SB, OkpoB,
                        Nazn, "", OperId, /*Sign*/null, 0/*Sk*/, 0, 0, ExtSignHex, IntSignHex,"","");
                    Bars.Doc.cDoc.Tags tag_fn = new Bars.Doc.cDoc.Tags("ENRFN", this.label_file.Text);
                    ourDoc.DrecS.Add(tag_fn);
                    Bars.Doc.cDoc.Tags tag_fl = new Bars.Doc.cDoc.Tags("ENRFL", Convert.ToString(i + 1));
                    ourDoc.DrecS.Add(tag_fl);
                    if (!ourDoc.oDocument()) throw new BarsException("Помилка при оплаті документа. Стрічка " + i + 1);
                }                
                finally
                {
                    
                }
            }

            fCommit = true;
        }
        finally
        {
            if (fCommit) tx.Commit(); else tx.Rollback();
            con.Close();
            con.Dispose();
            RemoveSessionKeys();
        }
        Response.Redirect("success.aspx?fn=" + this.label_file.Text 
            + "&burl=" + Server.HtmlEncode("default.aspx"));
    }
}
