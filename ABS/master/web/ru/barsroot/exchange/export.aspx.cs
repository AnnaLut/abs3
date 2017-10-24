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
using System.IO;
using System.Text;

public partial class Export : Bars.BarsPage
{
    /// <summary>
    /// Заполняет скрытые поля данными
    /// </summary>
    private void FillHiddenFields()
    {
        this.InitOraConnection();
        try
        {
            this.SetRole("WR_IMPEXP");
            this.hd_bankdate_start.Value = Convert.ToString(
                this.SQL_SELECT_scalar(
                "SELECT to_char(web_utl.get_bankdate,'DD.MM.YYYY') FROM dual"));
            this.hd_bankdate_finish.Value = this.hd_bankdate_start.Value;
        }
        finally
        {
            this.DisposeOraConnection();
        }

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            FillHiddenFields();
        }
    }
    protected void bt_export_Click(object sender, EventArgs e)
    {
        this.hd_bankdate_start.Value  = this.dt_start_TextBox.Value;
        this.hd_bankdate_finish.Value = this.dt_finish_TextBox.Value;
        DateTime date_start = new DateTime(
                        Convert.ToInt32(hd_bankdate_start.Value.Substring(6, 4)),
                        Convert.ToInt32(hd_bankdate_start.Value.Substring(3, 2)),
                        Convert.ToInt32(hd_bankdate_start.Value.Substring(0, 2)));
        DateTime date_finish = new DateTime(
                        Convert.ToInt32(hd_bankdate_finish.Value.Substring(6, 4)),
                        Convert.ToInt32(hd_bankdate_finish.Value.Substring(3, 2)),
                        Convert.ToInt32(hd_bankdate_finish.Value.Substring(0, 2)));
        this.InitOraConnection();
        bool fixTransaction = false;
        try
        {
            this.SetRole("WR_IMPEXP");
            this.BeginTransaction();
            // получаем имя файла
            string strFileName = (string)this.SQL_SELECT_scalar("select web_impexp.make_export_file_name from dual");
            // готовим данные с помощью процедуры
            this.ClearParameters();
            this.SetParameters("p_date_start", DB_TYPE.Date, date_start, DIRECTION.Input);
            this.SetParameters("p_date_finish", DB_TYPE.Date, date_finish, DIRECTION.Input);
            this.SQL_PROCEDURE("web_impexp.export_documents");

            DataSet ds = this.SQL_SELECT_dataset(
                "select "
                + " ref,stmt,mfoa,nlsa,mfob,nlsb,dk,s,vob,nd,kv,"
                + " to_char(datd,'YYMMDD') c_datd, to_char(datp,'YYMMDD') c_datp,nam_a,nam_b,nazn, "
                + " d_rec,nazns,id_a,id_b,ref_a,id_o,bis "
                + " from tmp_enr_export_docs order by ref,stmt,bis"
            );
            byte[] crlf = { 0x0D, 0x0A };
            Response.ContentType = "application/octet-stream";
            Response.AddHeader("Content-Disposition", "attachment; filename=" + strFileName);
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append(ds.Tables[0].Rows[i]["mfoa"].ToString().PadLeft(9));
                sb.Append(ds.Tables[0].Rows[i]["nlsa"].ToString().PadLeft(14));
                sb.Append(ds.Tables[0].Rows[i]["mfob"].ToString().PadLeft(9));
                sb.Append(ds.Tables[0].Rows[i]["nlsb"].ToString().PadLeft(14));
                sb.Append(ds.Tables[0].Rows[i]["dk"].ToString());
                sb.Append(ds.Tables[0].Rows[i]["s"].ToString().PadLeft(16));
                sb.Append(ds.Tables[0].Rows[i]["vob"].ToString().PadLeft(2));
                sb.Append(ds.Tables[0].Rows[i]["nd"].ToString().PadRight(10));
                sb.Append(ds.Tables[0].Rows[i]["kv"].ToString().PadLeft(3));                
                sb.Append(ds.Tables[0].Rows[i]["c_datd"].ToString());
                sb.Append(ds.Tables[0].Rows[i]["c_datp"].ToString());
                sb.Append(ds.Tables[0].Rows[i]["nam_a"].ToString().PadRight(38));
                sb.Append(ds.Tables[0].Rows[i]["nam_b"].ToString().PadRight(38));
                sb.Append(ds.Tables[0].Rows[i]["nazn"].ToString().PadRight(160));
                sb.Append(ds.Tables[0].Rows[i]["d_rec"].ToString().PadRight(60));
                sb.Append("   ");
                sb.Append(ds.Tables[0].Rows[i]["nazns"].ToString().PadRight(2));
                sb.Append(ds.Tables[0].Rows[i]["id_a"].ToString().PadLeft(14));
                sb.Append(ds.Tables[0].Rows[i]["id_b"].ToString().PadLeft(14));
                sb.Append(ds.Tables[0].Rows[i]["ref_a"].ToString().PadLeft(9));
                sb.Append(ds.Tables[0].Rows[i]["id_o"].ToString().PadRight(6));
                sb.Append(ds.Tables[0].Rows[i]["bis"].ToString().PadLeft(2));
                string doc = sb.ToString().PadRight(592);
                System.Text.Encoding enc1251 = System.Text.Encoding.GetEncoding(1251);
                byte[] bt = enc1251.GetBytes(doc.ToCharArray());
                Response.OutputStream.Write(bt, 0, bt.Length);
                Response.OutputStream.Write(crlf, 0, crlf.Length);
            }
            Response.Flush();
            Response.Close();

            this.commitTransaction();
            fixTransaction = true;
        }
        finally
        {
            if (!fixTransaction) this.RollbackTransaction();
            this.DisposeOraConnection();
        }
    }
}
