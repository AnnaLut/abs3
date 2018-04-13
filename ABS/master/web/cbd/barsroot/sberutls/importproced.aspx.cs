using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;
using ibank.core;
using Bars.Classes;
using Bars.DataComponents;
using UnityBars.WebControls;

public partial class sberutls_importproced : Bars.BarsPage
{
    private const string PARENT_PAGE = "importproc.aspx";
    private const string SESS_REF_NAME = "impref";
    private const string SESS_PARAMS_INVALID = "Invalid session parameters";
    private const string ROLE_NAME = "OPER000";
    private const string SESS_READONLY_TAG = "RO";
    private const string SESS_VIEWINDEX_TAG = "VI";

    private bool readOnly = false;

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        /*
         <asp:BoundField DataField="TAG" HeaderText="Реквiзит" />
         <asp:BoundField DataField="VALUE" HeaderText="Значення" />
        */
        BarsBoundFieldEx colTag = new BarsBoundFieldEx(gvW);
        BarsBoundFieldEx colTagName = new BarsBoundFieldEx(gvW);
        BarsBoundFieldEx colVal = new BarsBoundFieldEx(gvW);

        colTag.DataField = "TAG";
        colTag.HeaderText = "Реквiзит";
        colTag.SemanticField = colTagName;
        colTag.IsForeignKey = true;
        colTag.ModalDialogPath = "dialog.aspx?type=metatab&tail=''&tabname=V_XMLIMPDREC";

        colTagName.DataField = "NAME";
        colTagName.HeaderText = "Найменування";
        colTagName.IsForeignSemantic = true;
        colTagName.ReadOnly = true;

        colVal.DataField = "VALUE";
        colVal.HeaderText = "Значення";
        colVal.IsLast = true;

        gvW.Columns.Add(colTag);
        gvW.Columns.Add(colTagName);
        gvW.Columns.Add(colVal);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (null == Session[SESS_REF_NAME])
            throw new ArgumentException(SESS_PARAMS_INVALID);
        if (Session[SESS_READONLY_TAG]!=null)
            readOnly = Session[SESS_READONLY_TAG].ToString() == "1";
        fv.DefaultMode = FormViewMode.Edit;
        mv.ActiveViewIndex = 0;
        dsW.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsW.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand(ROLE_NAME);
        dsC.ConnectionString = dsW.ConnectionString;
        dsC.PreliminaryStatement = dsW.PreliminaryStatement;
        if (IsPostBack && Session[SESS_VIEWINDEX_TAG] != null)
            mv.ActiveViewIndex = Convert.ToInt32(Session[SESS_VIEWINDEX_TAG]);
        if (!IsPostBack)
            Session[SESS_VIEWINDEX_TAG] = 0;
    }
    protected void btnOk_Click(object sender, EventArgs e)
    {
        Response.Redirect(PARENT_PAGE);
    }
    protected void ods_Updating(object sender, ObjectDataSourceMethodEventArgs e)
    {

    }
    protected void fv_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {

    }
    protected void btnDoc_Click(object sender, EventArgs e)
    {
        mv.ActiveViewIndex = 0;
        Session[SESS_VIEWINDEX_TAG] = mv.ActiveViewIndex;
    }
    protected void btnW_Click(object sender, EventArgs e)
    {
        mv.ActiveViewIndex = 1;
        Session[SESS_VIEWINDEX_TAG] = mv.ActiveViewIndex;
    }
    protected void btnC_Click(object sender, EventArgs e)
    {
        mv.ActiveViewIndex = 2;
        Session[SESS_VIEWINDEX_TAG] = mv.ActiveViewIndex;
    }
    protected override void OnPreRender(EventArgs e)
    {
        if (Session[SESS_VIEWINDEX_TAG] != null)
            mv.ActiveViewIndex = Convert.ToInt32(Session[SESS_VIEWINDEX_TAG]);

        btnC.Enabled = mv.ActiveViewIndex != 2;
        btnW.Enabled = mv.ActiveViewIndex != 1;
        btnDoc.Enabled = mv.ActiveViewIndex != 0;

        if (readOnly)
            fv.DefaultMode = FormViewMode.ReadOnly;


        base.OnPreRender(e);
    }
    protected void dsW_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        OracleParameter par = new OracleParameter("impref", OracleDbType.Decimal, Session[SESS_REF_NAME], System.Data.ParameterDirection.Input);
        e.Command.Parameters.Add(par);
    }
    protected void dsC_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        OracleParameter par = new OracleParameter("impref", OracleDbType.Decimal, Session[SESS_REF_NAME], System.Data.ParameterDirection.Input);
        e.Command.Parameters.Add(par);
    }
    protected void fv_DataBound(object sender, EventArgs e)
    {
        TextBox NLSATextBox = ((sender as FormView).FindControl("NLSATextBox") as TextBox);
        TextBox NLSBTextBox = ((sender as FormView).FindControl("NLSBTextBox") as TextBox);
        TextBox NAM_ATextBox = ((sender as FormView).FindControl("NAM_ATextBox") as TextBox);
        TextBox NAM_BTextBox = ((sender as FormView).FindControl("NAM_BTextBox") as TextBox);
        TextBox ID_ATextBox = ((sender as FormView).FindControl("ID_ATextBox") as TextBox);
        TextBox ID_BTextBox = ((sender as FormView).FindControl("ID_BTextBox") as TextBox);
        TextBox DKTextBox = ((sender as FormView).FindControl("DKTextBox") as TextBox);
        TextBox TTTextBox = ((sender as FormView).FindControl("TTTextBox") as TextBox);
        TextBox MFOATextBox = ((sender as FormView).FindControl("MFOATextBox") as TextBox);
        TextBox MFOBTextBox = ((sender as FormView).FindControl("MFOBTextBox") as TextBox);
        TextBox KVTextBox = ((sender as FormView).FindControl("KVTextBox") as TextBox);
        BarsNumericTextBox SKTextBox = ((sender as FormView).FindControl("SKTextBox") as BarsNumericTextBox);
        if (NLSATextBox != null && NLSBTextBox != null && NAM_ATextBox != null &&
            NAM_BTextBox != null && ID_ATextBox != null && ID_BTextBox != null &&
            DKTextBox != null && TTTextBox != null && MFOATextBox != null &&
            MFOBTextBox != null && KVTextBox != null && SKTextBox != null)
        {
            string attr = DKTextBox.ClientID + "','" + TTTextBox.ClientID + "','" + MFOATextBox.ClientID + "','" + MFOBTextBox.ClientID + "','" + KVTextBox.ClientID + "')";
            NLSATextBox.Attributes.Add("onkeydown", "nlsSelect(this, 1, '" + ID_ATextBox.ClientID + "', '" + NAM_ATextBox.ClientID + "','" + attr);
            NLSBTextBox.Attributes.Add("onkeydown", "nlsSelect(this, 2, '" + ID_BTextBox.ClientID + "', '" + NAM_BTextBox.ClientID + "','" + attr);
            SKTextBox.Attributes.Add("onkeydown", String.Format("skSelect(this,'{0}','{1}','{2}')", DKTextBox.ClientID, NLSATextBox.ClientID, NLSBTextBox.ClientID));
            MFOATextBox.Attributes.Add("onkeydown", String.Format("mfoSelect(this,'{0}')", NLSATextBox.ClientID));
            MFOBTextBox.Attributes.Add("onkeydown", String.Format("mfoSelect(this,'{0}');setNamBMode('{1}','{2}','{3}');", NLSBTextBox.ClientID, MFOATextBox.ClientID, MFOBTextBox.ClientID, NAM_BTextBox.ClientID));
            //
            NLSBTextBox.Attributes.Add("onblur", String.Format("chkNls(this,2,'{0}','{1}','{2}','{3}','{4}','{5}','{6}')", KVTextBox.ClientID, DKTextBox.ClientID, TTTextBox.ClientID, ID_BTextBox.ClientID, NAM_BTextBox.ClientID, MFOATextBox.ClientID, MFOBTextBox.ClientID));
            NLSATextBox.Attributes.Add("onblur", String.Format("chkNls(this,1,'{0}','{1}','{2}','{3}','{4}','{5}','{6}')", KVTextBox.ClientID, DKTextBox.ClientID, TTTextBox.ClientID, ID_ATextBox.ClientID, NAM_ATextBox.ClientID, MFOATextBox.ClientID, MFOBTextBox.ClientID));
            SKTextBox.Attributes.Add("onblur", String.Format("chkSk(this,'{0}','{1}','{2}')", DKTextBox.ClientID, NLSATextBox.ClientID, NLSBTextBox.ClientID));
            MFOBTextBox.Attributes.Add("onblur", String.Format("chkMfo(this,'{0}','{1}','{2}')", MFOATextBox.ClientID, MFOBTextBox.ClientID, NAM_BTextBox.ClientID));
            MFOATextBox.Attributes.Add("onblur", String.Format("chkMfo(this,'{0}','{1}','{2}')", MFOATextBox.ClientID, MFOBTextBox.ClientID, NAM_BTextBox.ClientID));
            //
            NAM_ATextBox.Attributes.Add("onkeypress", "return false;");
        }
        if (!readOnly)
            ClientScript.RegisterStartupScript(this.GetType(), "controls", String.Format("<script type=\"text/javascript\">setNamBMode('{0}','{1}','{2}');</script>", MFOATextBox.ClientID, MFOBTextBox.ClientID, NAM_BTextBox.ClientID));
    }
    protected void mv_ActiveViewChanged(object sender, EventArgs e)
    {
    }
    protected void dsW_Updating(object sender, SqlDataSourceCommandEventArgs e)
    {
        /*
                    <UpdateParameters>
                        <asp:Parameter Name="p_impref" DbType="Decimal"  />
                        <asp:Parameter Name="p_tag"  DbType="String" Size="5"/>
                        <asp:Parameter Name="p_val" DbType="String" Size="200" />
                        <asp:Parameter Name="p_action" DbType="Decimal"  DefaultValue="1"/>
                    </UpdateParameters>
        */
        /*
        ((OracleCommand)e.Command).Parameters.Add("p_impref", OracleDbType.Decimal, Session["impref"], System.Data.ParameterDirection.Input);
        ((OracleCommand)e.Command).Parameters.Add("p_tag", OracleDbType.Varchar2, 5,Session["p_tag"], System.Data.ParameterDirection.Input);
        ((OracleCommand)e.Command).Parameters.Add("p_val", OracleDbType.Varchar2, 200, Session["p_val"], System.Data.ParameterDirection.Input);
        ((OracleCommand)e.Command).Parameters.Add("p_action", OracleDbType.Decimal, 1, System.Data.ParameterDirection.Input);
         */
    }
    protected void dsW_Deleting(object sender, SqlDataSourceCommandEventArgs e)
    {

    }
    protected void dsW_Inserting(object sender, SqlDataSourceCommandEventArgs e)
    {
        ((OracleCommand)e.Command).Parameters.Add("IMPREF", OracleDbType.Decimal, Session["IMPREF"], System.Data.ParameterDirection.Input);
    }
    private TextBox findFirstTextBox(ControlCollection controls)
    {
        TextBox found = null;
        foreach (Control control in controls)
        {

            if (control is TextBox)
            {
                found = (TextBox)control;
                break;
            }
            if (control.HasControls())
            {
                found = findFirstTextBox(control.Controls);
                if (found != null)
                {
                    break;
                }
            }
        }
        return found;
    }
    protected void gvW_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowState == (DataControlRowState.Edit | DataControlRowState.Alternate) || e.Row.RowState == DataControlRowState.Edit)
        {
            TextBox tb = findFirstTextBox(e.Row.Cells[1].Controls);
            tb.Attributes.Remove("style");
            tb.Attributes.Add("style", "width:80%");
            TextBox tbs = findFirstTextBox(e.Row.Cells[2].Controls);
            if (tbs != null)
                tbs.Enabled = false;
        }
    }
    protected void gvW_RowEditing(object sender, GridViewEditEventArgs e)
    {
    }
    protected void UpdateCancelButton_Click(object sender, EventArgs e)
    {
        Response.Redirect("importproced.aspx");
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("importproced.aspx");
    }
}
