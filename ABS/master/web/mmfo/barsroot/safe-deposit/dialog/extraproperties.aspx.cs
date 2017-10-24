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
using Bars.Exception;

public partial class safe_deposit_dialog_ExtraProperties : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["SAFE_ID"] == null || Request["deal_ref"] == null)
            throw new SafeDepositException("Страница вызвана с неверными параметрами!");

        if (!IsPostBack)
        {
            SAFE_ID.Value = Convert.ToString(Request["SAFE_ID"]);
            ND.Value = Convert.ToString(Request["deal_ref"]);
            lbTitle.Text = lbTitle.Text.Replace("%s", Convert.ToString(Request["deal_ref"]));
            GetFields();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    private void GetFields()
    {
        fields.Value = String.Empty;

        safe_deposit sdpt = new safe_deposit();
        sdpt.ReadExtraFields(Convert.ToDecimal(SAFE_ID.Value),
            Convert.ToDecimal(ND.Value));

        if (sdpt.EXTRA_PROPS.Count < 1)
        {
            PROP_TABLE.Visible = false;
            btSave.Enabled = false;
            return;
        }
        else
        {
            HtmlTableRow row;

            for (int i = 0; i < sdpt.EXTRA_PROPS.Count; i++)
            {
                safe_deposit_extra_field ef = (safe_deposit_extra_field)sdpt.EXTRA_PROPS[i];

                row = new HtmlTableRow();
                row.Cells.Add(new HtmlTableCell());
                row.Cells.Add(new HtmlTableCell());
                row.Cells.Add(new HtmlTableCell());

                PROP_TABLE.Rows.Add(row);

                String control_name = ef.tag;

                fields.Value += control_name + ",";

                PROP_TABLE.Rows[i + 1].Cells[0].Style.Add("WIDTH", "40%");
                PROP_TABLE.Rows[i + 1].Cells[1].Style.Add("WIDTH", "45%");
                PROP_TABLE.Rows[i + 1].Cells[2].Style.Add("WIDTH", "15%");

                PROP_TABLE.Rows[i + 1].Cells[0].InnerText = ef.name;
                PROP_TABLE.Rows[i + 1].Cells[0].Style.Add("FONT-FAMILY", "Arial");
                PROP_TABLE.Rows[i + 1].Cells[0].Style.Add("FONT-SIZE", "10pt");

                int tab_index = (10 + i);

                PROP_TABLE.Rows[i + 1].Cells[1].NoWrap = true;
                PROP_TABLE.Rows[i + 1].Cells[1].InnerHtml = "<input name=\"" + control_name
                    + "\" type=\"text\" runat=\"server\" TabIndex=\"" + tab_index + "\" value=\"" + ef.val + "\"";
                PROP_TABLE.Rows[i + 1].Cells[1].InnerHtml += "class=\"InfoText95\"";
                PROP_TABLE.Rows[i + 1].Cells[1].InnerHtml += " />";
            }
            if (fields.Value.Length > 0)
                fields.Value = fields.Value.Remove(fields.Value.Length - 1, 1);
        }    
    }
    /// <summary>
    /// 
    /// </summary>
    protected void btSave_Click(object sender, EventArgs e)
    {
        safe_deposit sdpt = new safe_deposit();
        sdpt.ReadExtraFields(Convert.ToDecimal(SAFE_ID.Value),
            Convert.ToDecimal(ND.Value));

        String[] sdpt_fields = fields.Value.Split(',');
        foreach (String name in sdpt_fields)
        {
            for (int i = 0; i < sdpt.EXTRA_PROPS.Count; i++)
            {
                safe_deposit_extra_field ef = (safe_deposit_extra_field)sdpt.EXTRA_PROPS[i];
                if (ef.tag != name)
                    continue;
                ef.val = Request.Form[name].ToString();
                break;
            }
        }

        sdpt.WriteExtraFields(Convert.ToDecimal(ND.Value));

        GetFields();

        Response.Write("<script>alert('Доп. реквизиты были успешно обновлены.');</script>");
        Response.Flush();
    }
}
