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
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Globalization;

public partial class ussr_deposit_Default2 : System.Web.UI.Page
{
    /// <summary>
    /// 
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetSignParams();

            CreateSignTable(prepare_input((ArrayList)Session["USSR_PAYOFF"]));
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="arr"></param>
    /// <returns></returns>
    private string prepare_input(ArrayList arr)
    {
        String result = String.Empty;
        String[] row_vals = new String[10];
        Decimal all_count = 0;

        foreach (ussr_payofftype p1 in arr)
        {
            Decimal row_length = 0;
            for (int i = 0; i < row_vals.Length; i++)
                row_vals[i] = String.Empty;

            row_vals[0] = p1.dpt_id.ToString().Length.ToString().PadRight(3) + p1.dpt_id;
            row_length += 3 + p1.dpt_id.ToString().Length;
            row_vals[1] = p1.type_id.ToString().Length.ToString().PadRight(3) + p1.type_id;
            row_length += 3 + p1.type_id.ToString().Length;

            foreach (ussr_payofftype_params p2 in p1.type_params_val)
            {               
                switch (p2.par_name.ToUpper())
                {
                    case "CUR": row_vals [2] = p2.par_val.Length.ToString().PadRight(3) + p2.par_val;
                        row_length += (3 + p2.par_val.Length); break;
                    case "SUM": row_vals [3] = p2.par_val.Length.ToString().PadRight(3) + p2.par_val;
                        row_length += (3 + p2.par_val.Length); break;
                    case "MFO": row_vals [4] = p2.par_val.Length.ToString().PadRight(3) + p2.par_val;
                        row_length += (3 + p2.par_val.Length); break;
                    case "ACC": row_vals [5] = p2.par_val.Length.ToString().PadRight(3) + p2.par_val;
                        row_length += (3 + p2.par_val.Length); break;
                    case "OKPO": row_vals [6] = p2.par_val.Length.ToString().PadRight(3) + p2.par_val;
                        row_length += (3 + p2.par_val.Length); break;
                    case "NAME": row_vals [7] = p2.par_val.Length.ToString().PadRight(3) + p2.par_val;
                        row_length += (3 + p2.par_val.Length); break;
                    case "DPTTYPE": row_vals [8] = p2.par_val.Length.ToString().PadRight(3) + p2.par_val;
                        row_length += (3 + p2.par_val.Length); break;
                    case "CARD": row_vals [9] = p2.par_val.Length.ToString().PadRight(3) + p2.par_val;
                        row_length += (3 + p2.par_val.Length); break;
                }
            }

            for (int i = 0; i < row_vals.Length; i++)
            {
                if (String.IsNullOrEmpty(row_vals[i]))
                {
                    row_vals[i] = "1   ";
                    row_length += 4;
                }
            }

            result += row_length.ToString().PadRight(4);

            for (int i = 0; i < row_vals.Length; i++)
                result += row_vals[i];
            
            all_count++;
        }

        return all_count.ToString().PadRight(2) + result;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="arr"></param>
    /// <returns></returns>
    private string prepare_input_signed(ArrayList arr)
    {
        String result = String.Empty;
        String[] row_vals = new String[13];
        Decimal all_count = 0;

        foreach (ussr_payofftype p1 in arr)
        {
            Decimal row_length = 0;
            for (int i = 0; i < row_vals.Length; i++)
                row_vals[i] = String.Empty;

            row_vals[0] = p1.dpt_id.ToString().Length.ToString().PadRight(3) + p1.dpt_id;
            row_length += 3 + p1.dpt_id.ToString().Length;
            row_vals[1] = p1.type_id.ToString().Length.ToString().PadRight(3) + p1.type_id;
            row_length += 3 + p1.type_id.ToString().Length;

            foreach (ussr_payofftype_params p2 in p1.type_params_val)
            {
                switch (p2.par_name.ToUpper())
                {
                    case "CUR": row_vals[2] = p2.par_val.Length.ToString().PadRight(3) + p2.par_val;
                        row_length += (3 + p2.par_val.Length); break;
                    case "SUM": row_vals[3] = p2.par_val.Length.ToString().PadRight(3) + p2.par_val;
                        row_length += (3 + p2.par_val.Length); break;
                    case "MFO": row_vals[4] = p2.par_val.Length.ToString().PadRight(3) + p2.par_val;
                        row_length += (3 + p2.par_val.Length); break;
                    case "ACC": row_vals[5] = p2.par_val.Length.ToString().PadRight(3) + p2.par_val;
                        row_length += (3 + p2.par_val.Length); break;
                    case "OKPO": row_vals[6] = p2.par_val.Length.ToString().PadRight(3) + p2.par_val;
                        row_length += (3 + p2.par_val.Length); break;
                    case "NAME": row_vals[7] = p2.par_val.Length.ToString().PadRight(3) + p2.par_val;
                        row_length += (3 + p2.par_val.Length); break;
                    case "DPTTYPE": row_vals[8] = p2.par_val.Length.ToString().PadRight(3) + p2.par_val;
                        row_length += (3 + p2.par_val.Length); break;
                    case "CARD": row_vals[9] = p2.par_val.Length.ToString().PadRight(3) + p2.par_val;
                        row_length += (3 + p2.par_val.Length); break;
                }
            }

            if (p1.ido != null)
            {
                row_vals[10] = p1.ido.Length.ToString().PadRight(3) + p1.ido;
                row_length += 3 + p1.ido.Length;
            }
            if (p1.sign != null)
            {
                row_vals[11] = p1.sign.Length.ToString().PadRight(3) + p1.sign;
                row_length += 3 + p1.sign.Length;
            }
            row_vals[12] = p1.pdoc.REF.Length.ToString().PadRight(3) + p1.pdoc.REF;
            row_length += 3 + p1.pdoc.REF.Length;

            for (int i = 0; i < row_vals.Length; i++)
            {
                if (String.IsNullOrEmpty(row_vals[i]))
                {
                    row_vals[i] = "1   ";
                    row_length += 4;
                }
            }

            result += row_length.ToString().PadRight(4);

            for (int i = 0; i < row_vals.Length; i++)
                result += row_vals[i];

            all_count++;
        }

        return all_count.ToString().PadRight(2) + result;
    }
    /// <summary>
    /// 
    /// </summary>
    private void CreateSignTable(string input4proc)
    {
        OracleConnection connect = new OracleConnection();

        DataSet dsDocs = new DataSet();
        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetParams = connect.CreateCommand();
            cmdGetParams.CommandText = "begin ussr_payoff.prepare_docs(ussr_payoff.deserialize(:INPUT),:OUTPUT); end;";
            cmdGetParams.Parameters.Add("INPUT", OracleDbType.Varchar2, input4proc, ParameterDirection.Input);
            cmdGetParams.Parameters.Add("OUTPUT", OracleDbType.RefCursor, ParameterDirection.Output);

            cmdGetParams.ExecuteNonQuery();

            OracleRefCursor refcur = (OracleRefCursor)cmdGetParams.Parameters["OUTPUT"].Value;

            OracleDataAdapter da = new OracleDataAdapter();
            da.Fill(dsDocs, refcur);
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

        /*  dpt_id  ref    nd      ref_a    vob     dk     datd   datp                                   
            mfoa    nlsa   nam_a            id_a    kv     s     
            mfob    nlsb   nam_b            id_b    kv2    s2   
            d_rec                           nazn                  */

        int i = -1;
        bool newrow;
        foreach (DataRow dr in dsDocs.Tables[0].Rows)
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";
            
            //i = -1;
            newrow = true;
            for (int j = 0; j < ((ArrayList)Session["USSR_PAYOFF"]).Count; j++)
            {
                if (((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[j]).type_id == Convert.ToDecimal(dr[1]))
                { i = j; newrow = false; break; }
            }

            // Новим рядком може бути лише конвертація,
            // яка може зустрітися ЛИШЕ РАЗ
            if (newrow)
            {
                ussr_payofftype pnew = new ussr_payofftype();
                pnew.dpt_id = Convert.ToDecimal(dr[0]);
                pnew.type_id = -1;
                i++;
                ((ArrayList)Session["USSR_PAYOFF"]).Insert(i, pnew);
            }
                //throw new Exception("Одержані документи не відповідають введеним!");

            ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc = 
                new ussr_payoffdoc(
                Convert.ToDecimal(dr[0]), Convert.ToDecimal(dr[1]),Convert.ToString(dr[2]),
                Convert.ToDecimal(dr[3]), Convert.ToString(dr[4]),Convert.ToDecimal(dr[5]),
                Convert.ToDecimal( (Convert.ToString(dr[6]) == String.Empty ? Decimal.MinValue : dr[6]) ),
                Convert.ToDecimal((Convert.ToString(dr[7]) == String.Empty ? Decimal.MinValue : dr[7])),
                Convert.ToDecimal(dr[8]), Convert.ToDecimal(dr[9]), Convert.ToString(dr[10]), Convert.ToDateTime(dr[11], cinfo),
                Convert.ToString(dr[12]),Convert.ToString(dr[13]),Convert.ToString(dr[14]),
                Convert.ToString(dr[15]),Convert.ToString(dr[16]),Convert.ToString(dr[17]),
                Convert.ToString(dr[18]),Convert.ToString(dr[19]),Convert.ToDateTime(dr[20], cinfo),
                Convert.ToString(dr[21]),Convert.ToString(dr[22]), 
                Convert.ToDecimal( (Convert.ToString(dr[23]) == String.Empty ? Decimal.MinValue : dr[23]) ),
                Convert.ToString(dr[24]),Convert.ToString(dr[25]));
            
            ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).GetSignTtsInfo();
            ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).sign_control_name = "SIGN" + Convert.ToDecimal(dr[1]);
            HtmlInputHidden h = new HtmlInputHidden();
            h.ID = ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).sign_control_name;
            tdDUMP.Controls.Add(h);
            ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).buffer_control = "BUFFER" + Convert.ToDecimal(dr[1]);
            h = new HtmlInputHidden();
            h.ID = ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).buffer_control;
            ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).ido = DOCKEY.Value;
            h.Value = ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).get_buffer();
            tdDUMP.Controls.Add(h);

            HtmlTable tblDoc = new HtmlTable();
            tblDoc.Attributes["class"] = "InnerTable";
            //---------------
            //-  FIRST ROW
            //---------------
            HtmlTableRow label1 = new HtmlTableRow();
            HtmlTableRow row1 = new HtmlTableRow();
            for (int k = 0; k < 8; k++)
            {
                label1.Cells.Add(new HtmlTableCell());
                row1.Cells.Add(new HtmlTableCell());
                label1.Cells[k].Style.Add(HtmlTextWriterStyle.TextAlign,"center");
                row1.Cells[k].Style.Add("WIDTH", "12.5%");
            }
            //---------------
            TextBox tb = new TextBox();
            tb.CssClass = "InfoText95"; tb.ReadOnly = true;
            tb.ID = "DPT_ID" + ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.type_id;
            tb.Text = Convert.ToString(((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.dpt_id);
            tb.ToolTip = "№ депозита";
            row1.Cells[0].Controls.Add(tb);
            Label lb = new Label();
            lb.ID = "lb" + tb.ID;
            lb.CssClass = "SmallLabel";
            lb.Text = "№ депозита";
            label1.Cells[0].Controls.Add(lb);
            //---------------
            tb = new TextBox();
            tb.CssClass = "InfoText95";tb.ReadOnly = true;
            tb.ID = "REF" + ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.type_id;
            tb.Text = ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.REF;
            tb.ToolTip = "Референс";
            row1.Cells[1].Controls.Add(tb);
            lb = new Label();
            lb.ID = "lb" + tb.ID;
            lb.CssClass = "SmallLabel";
            lb.Text = "Референс";
            label1.Cells[1].Controls.Add(lb);
            //---------------
            tb = new TextBox();
            tb.CssClass = "InfoText95";tb.ReadOnly = true;
            tb.ID = "ND" + ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.type_id;
            tb.Text = ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.nd;
            tb.ToolTip = "№ документа";
            row1.Cells[2].Controls.Add(tb);
            lb = new Label();
            lb.ID = "lb" + tb.ID;
            lb.CssClass = "SmallLabel";
            lb.Text = "№ документа";
            label1.Cells[2].Controls.Add(lb);
            //---------------
            tb = new TextBox();
            tb.CssClass = "InfoText95";tb.ReadOnly = true;
            tb.ID = "REF_A" + ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.type_id;
            tb.Text = ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.ref_a;
            tb.ToolTip = "Референс відправника";
            row1.Cells[3].Controls.Add(tb);
            lb = new Label();
            lb.ID = "lb" + tb.ID;
            lb.CssClass = "SmallLabel";
            lb.Text = "Реф. відпр.";
            label1.Cells[3].Controls.Add(lb);
            //---------------
            tb = new TextBox();
            tb.CssClass = "InfoText95";tb.ReadOnly = true;
            tb.ID = "VOB" + ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.type_id;
            tb.Text = Convert.ToString(((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.vob);
            tb.ToolTip = "Вид банківського документа";
            row1.Cells[4].Controls.Add(tb);
            lb = new Label();
            lb.ID = "lb" + tb.ID;
            lb.CssClass = "SmallLabel";
            lb.Text = "Вид банк. док.";
            label1.Cells[4].Controls.Add(lb);
            //---------------
            tb = new TextBox();
            tb.CssClass = "InfoText95";tb.ReadOnly = true;
            tb.ID = "DK" + ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.type_id;
            tb.Text = Convert.ToString(((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.dk);
            tb.ToolTip = "Дебет/кредит";
            row1.Cells[5].Controls.Add(tb);
            lb = new Label();
            lb.ID = "lb" + tb.ID;
            lb.CssClass = "SmallLabel";
            lb.Text = "Дб./Кр.";
            label1.Cells[5].Controls.Add(lb);
            //---------------
            tb = new TextBox();
            tb.CssClass = "InfoText95";tb.ReadOnly = true;
            tb.ID = "DATD" + ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.type_id;
            tb.Text = ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.datd.ToString("dd/MM/yyyy");
            tb.ToolTip = "Дата документа";
            row1.Cells[6].Controls.Add(tb);
            lb = new Label();
            lb.ID = "lb" + tb.ID;
            lb.CssClass = "SmallLabel";
            lb.Text = "Дата документа";
            label1.Cells[6].Controls.Add(lb);
            //---------------
            tb = new TextBox();
            tb.CssClass = "InfoText95"; tb.ReadOnly = true;
            tb.ID = "DATP" + ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.type_id;
            tb.Text = ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.datp.ToString("dd/MM/yyyy");
            tb.ToolTip = "Дата поступлення";
            row1.Cells[7].Controls.Add(tb);
            lb = new Label();
            lb.ID = "lb" + tb.ID;
            lb.CssClass = "SmallLabel";
            lb.Text = "Дата поступлення";
            label1.Cells[7].Controls.Add(lb);
            
            tblDoc.Rows.Add(label1);
            tblDoc.Rows.Add(row1);
            //---------------
            //-  SECOND ROW
            //---------------
            HtmlTableRow label2 = new HtmlTableRow();
            HtmlTableRow row2 = new HtmlTableRow();
            for (int k = 0; k < 7; k++)
            {
                row2.Cells.Add(new HtmlTableCell());
                label2.Cells.Add(new HtmlTableCell());
                label2.Cells[k].Style.Add(HtmlTextWriterStyle.TextAlign, "center");
            }
            row2.Cells[2].ColSpan = 2;
            label2.Cells[2].ColSpan = 2;
            //---------------
            tb = new TextBox();
            tb.CssClass = "InfoText95"; tb.ReadOnly = true;
            tb.ID = "MFOA" + ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.type_id;
            tb.Text = ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.mfoa;
            tb.ToolTip = "МФО відправника";
            row2.Cells[0].Controls.Add(tb);
            lb = new Label();
            lb.ID = "lb" + tb.ID;
            lb.CssClass = "SmallLabel";
            lb.Text = "МФО відправника";
            label2.Cells[0].Controls.Add(lb);
            //---------------
            tb = new TextBox();
            tb.CssClass = "InfoText95"; tb.ReadOnly = true;
            tb.ID = "NLSA" + ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.type_id;
            tb.Text = ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.nlsa;
            tb.ToolTip = "Рахунок відправника";
            row2.Cells[1].Controls.Add(tb);
            lb = new Label();
            lb.ID = "lb" + tb.ID;
            lb.CssClass = "SmallLabel";
            lb.Text = "Рахунок відправника";
            label2.Cells[1].Controls.Add(lb);
            //---------------
            tb = new TextBox();
            tb.CssClass = "InfoText95"; tb.ReadOnly = true;
            tb.ID = "NAM_A" + ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.type_id;
            tb.Text = ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.nam_a;
            tb.ToolTip = "Найменування відправника";
            row2.Cells[2].Controls.Add(tb);
            lb = new Label();
            lb.ID = "lb" + tb.ID;
            lb.CssClass = "SmallLabel";
            lb.Text = "Найменування відправника";
            label2.Cells[2].Controls.Add(lb);
            //---------------
            tb = new TextBox();
            tb.CssClass = "InfoText95"; tb.ReadOnly = true;
            tb.ID = "ID_A" + ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.type_id;
            tb.Text = ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.id_a;
            tb.ToolTip = "Код відправника";            
            row2.Cells[3].Controls.Add(tb);
            lb = new Label();
            lb.ID = "lb" + tb.ID;
            lb.CssClass = "SmallLabel";
            lb.Text = "Код відправника";
            label2.Cells[3].Controls.Add(lb);
            //---------------
            tb = new TextBox();
            tb.CssClass = "InfoText95"; tb.ReadOnly = true;
            tb.ID = "KV" + ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.type_id;
            tb.Text = Convert.ToString(((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.kv);
            tb.ToolTip = "Валюта";
            row2.Cells[4].Controls.Add(tb);
            lb = new Label();
            lb.ID = "lb" + tb.ID;
            lb.CssClass = "SmallLabel";
            lb.Text = "Валюта";
            label2.Cells[4].Controls.Add(lb);
            //---------------
            tb = new TextBox();
            tb.CssClass = "InfoText95"; tb.ReadOnly = true;
            tb.ID = "S" + ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.type_id;
            tb.Text = Convert.ToString(((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.s);
            tb.ToolTip = "Сума (коп.)";
            row2.Cells[5].Controls.Add(tb);
            lb = new Label();
            lb.ID = "lb" + tb.ID;
            lb.CssClass = "SmallLabel";
            lb.Text = "Сума (коп.)";
            label2.Cells[5].Controls.Add(lb);
            
            tblDoc.Rows.Add(label2);
            tblDoc.Rows.Add(row2);            
            //---------------
            //-  3rd ROW
            //---------------
            HtmlTableRow label3 = new HtmlTableRow();
            HtmlTableRow row3 = new HtmlTableRow();
            for (int k = 0; k < 7; k++)
            {
                row3.Cells.Add(new HtmlTableCell());
                label3.Cells.Add(new HtmlTableCell());
                label3.Cells[k].Style.Add(HtmlTextWriterStyle.TextAlign, "center");
            }
            row3.Cells[2].ColSpan = 2;
            label3.Cells[2].ColSpan = 2;
            //---------------
            tb = new TextBox();
            tb.CssClass = "InfoText95"; tb.ReadOnly = true;
            tb.ID = "MFOB" + ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.type_id;
            tb.Text = ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.mfob;
            tb.ToolTip = "МФО одержувача";
            row3.Cells[0].Controls.Add(tb);
            lb = new Label();
            lb.ID = "lb" + tb.ID;
            lb.CssClass = "SmallLabel";
            lb.Text = "МФО одержувача";
            label3.Cells[0].Controls.Add(lb);
            //---------------
            tb = new TextBox();
            tb.CssClass = "InfoText95"; tb.ReadOnly = true;
            tb.ID = "NLSB" + ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.type_id;
            tb.Text = ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.nlsb;
            tb.ToolTip = "Рахунок одержувача";
            row3.Cells[1].Controls.Add(tb);
            lb = new Label();
            lb.ID = "lb" + tb.ID;
            lb.CssClass = "SmallLabel";
            lb.Text = "Рахунок одержувача";
            label3.Cells[1].Controls.Add(lb);
            //---------------
            tb = new TextBox();
            tb.CssClass = "InfoText95"; tb.ReadOnly = true;
            tb.ID = "NAM_B" + ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.type_id;
            tb.Text = ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.nam_b;
            tb.ToolTip = "Найменування одержувача";
            row3.Cells[2].Controls.Add(tb);
            lb = new Label();
            lb.ID = "lb" + tb.ID;
            lb.CssClass = "SmallLabel";
            lb.Text = "Найменування одержувача";
            label3.Cells[2].Controls.Add(lb);
            //---------------
            tb = new TextBox();
            tb.CssClass = "InfoText95"; tb.ReadOnly = true;
            tb.ID = "ID_B" + ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.type_id;
            tb.Text = ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.id_b;
            tb.ToolTip = "Код одержувача";
            row3.Cells[3].Controls.Add(tb);
            lb = new Label();
            lb.ID = "lb" + tb.ID;
            lb.CssClass = "SmallLabel";
            lb.Text = "Код одержувача";
            label3.Cells[3].Controls.Add(lb);
            //---------------
            tb = new TextBox();
            tb.CssClass = "InfoText95"; tb.ReadOnly = true;
            tb.ID = "KVK" + ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.type_id;
            tb.Text = Convert.ToString(((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.kv2);
            tb.ToolTip = "Валюта 2";
            row3.Cells[4].Controls.Add(tb);
            lb = new Label();
            lb.ID = "lb" + tb.ID;
            lb.CssClass = "SmallLabel";
            lb.Text = "Валюта 2";
            label3.Cells[4].Controls.Add(lb);
            //---------------
            tb = new TextBox();
            tb.CssClass = "InfoText95"; tb.ReadOnly = true;
            tb.ID = "SB" + ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.type_id;
            tb.Text = Convert.ToString(((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.s2);
            tb.ToolTip = "Сума Б (коп.)";
            row3.Cells[5].Controls.Add(tb);
            lb = new Label();
            lb.ID = "lb" + tb.ID;
            lb.CssClass = "SmallLabel";
            lb.Text = "Сума Б (коп.)";
            label3.Cells[5].Controls.Add(lb);
            //---------------
            HtmlInputButton btSign = new HtmlInputButton();
            btSign.ID = "btSIGN" + ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.type_id;
            btSign.Value= "Підписати";
            btSign.Attributes["onclick"] = "if (GetSign('" +
                ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).buffer_control + "','" +
                ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).sign_control_name + "'," +
                ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).fli + "," +
                ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).inputsignflag + 
                ")) return;";
            row3.Cells[6].Controls.Add(btSign);

            tblDoc.Rows.Add(label3);
            tblDoc.Rows.Add(row3);
            //---------------
            //-  4th ROW
            //---------------
            HtmlTableRow label4 = new HtmlTableRow();
            HtmlTableRow row4 = new HtmlTableRow();
            row4.Cells.Add(new HtmlTableCell());
            row4.Cells[0].ColSpan = 4;
            row4.Cells.Add(new HtmlTableCell());
            row4.Cells[1].ColSpan = 4;
            label4.Cells.Add(new HtmlTableCell());
            label4.Cells[0].Style.Add(HtmlTextWriterStyle.TextAlign, "center");
            label4.Cells[0].ColSpan = 4;
            label4.Cells.Add(new HtmlTableCell());
            label4.Cells[1].Style.Add(HtmlTextWriterStyle.TextAlign, "center");
            label4.Cells[1].ColSpan = 4;
            //---------------
            tb = new TextBox();
            tb.CssClass = "InfoText95"; tb.ReadOnly = true;
            tb.ID = "DREC" + ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.type_id;
            tb.Text = ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.d_rec;
            tb.ToolTip = "Додаткові реквізити";
            row4.Cells[0].Controls.Add(tb);
            lb = new Label();
            lb.ID = "lb" + tb.ID;
            lb.CssClass = "SmallLabel";
            lb.Text = "Додаткові реквізити";
            label4.Cells[0].Controls.Add(lb);
            //---------------
            tb = new TextBox();
            tb.CssClass = "InfoText95"; tb.ReadOnly = true;
            tb.ID = "NAZN" + ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.type_id;
            tb.Text = ((ussr_payofftype)((ArrayList)Session["USSR_PAYOFF"])[i]).pdoc.nazn;
            tb.ToolTip = "Призначення";
            row4.Cells[1].Controls.Add(tb);
            lb = new Label();
            lb.ID = "lb" + tb.ID;
            lb.CssClass = "SmallLabel";
            lb.Text = "Призначення";
            label4.Cells[1].Controls.Add(lb);

            tblDoc.Rows.Add(label4);
            tblDoc.Rows.Add(row4);

            HtmlTableRow tr = new HtmlTableRow();
            tr.Cells.Add(new HtmlTableCell());
            tr.Cells[0].Controls.Add(tblDoc);
            tblAllDocs.Rows.Add(tr);            
        }
    }
    /// <summary>
    /// 
    /// </summary>
    private void GetSignParams()
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetParams = connect.CreateCommand();
            cmdGetParams.CommandText = @"SELECT chk.get_SignLng as SIGNLNG, 
             docsign.getIdOper as DOCKEY, 
             to_char(web_utl.get_bankdate, 'yyyy/MM/dd hh:mm:ss') as BDATE, 
             (SELECT NVL( min(to_number(VAL)), 1 ) FROM PARAMS WHERE PAR = 'SEPNUM') as SEPNUM, 
             (SELECT NVL( min(val), 'NBU' ) FROM PARAMS WHERE PAR = 'SIGNTYPE') as SIGNTYPE, 
             (SELECT NVL( min(to_number(VAL)), 1 ) FROM PARAMS WHERE PAR = 'VISASIGN') as VISASIGN, 
             (SELECT NVL( min(to_number(VAL)), 1 ) FROM PARAMS WHERE PAR = 'INTSIGN') as INTSIGN, 
             (SELECT NVL( min(to_number(VAL)), 1 ) FROM PARAMS WHERE PAR = 'REGNCODE') as REGNCODE
            FROM dual";

            OracleDataReader rdr = cmdGetParams.ExecuteReader();

            if (!rdr.Read()) throw new Exception("Не знайдені параметри підпису!");

            SIGNLNG.Value = Convert.ToString(rdr.GetOracleValue(0));
            DOCKEY.Value = Convert.ToString(rdr.GetOracleValue(1));
            BDATE.Value = Convert.ToString(rdr.GetOracleValue(2));
            SEPNUM.Value = Convert.ToString(rdr.GetOracleValue(3));
            SIGNTYPE.Value = Convert.ToString(rdr.GetOracleValue(4));
            VISASIGN.Value = Convert.ToString(rdr.GetOracleValue(5));
            INTSIGN.Value = Convert.ToString(rdr.GetOracleValue(6));
            REGNCODE.Value = Convert.ToString(rdr.GetOracleValue(7));

            if (!rdr.IsClosed) rdr.Close();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    protected void btPay_Click(object sender, EventArgs e)
    {
        String dpt_id = String.Empty;

        foreach (ussr_payofftype p1 in (ArrayList)Session["USSR_PAYOFF"])
        {
            dpt_id = Convert.ToString(p1.dpt_id);
            p1.ido = DOCKEY.Value;
            p1.sign = Convert.ToString(Request.Form[p1.sign_control_name]);
            if (p1.sign == String.Empty)
            {
                Response.Write("<script>alert('Документи не підписані!');</script>");
                CreateSignTable(prepare_input((ArrayList)Session["USSR_PAYOFF"]));
                return;
            }
        }

        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetParams = connect.CreateCommand();
            cmdGetParams.CommandText = "begin ussr_payoff.payment(ussr_payoff.deserialize(:INPUT)); end;";
            cmdGetParams.Parameters.Add("INPUT", OracleDbType.Varchar2, prepare_input_signed((ArrayList)Session["USSR_PAYOFF"]), ParameterDirection.Input);

            cmdGetParams.ExecuteNonQuery();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
        Response.Redirect("showdoc.aspx?dpt_id=" + dpt_id);
    }
}
