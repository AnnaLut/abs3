using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Bars.UserControls;
using Bars.Classes;
using clientregister;

public partial class clientregister_tab_linked_custs : System.Web.UI.Page
{
    # region Приватные свойства
    private Decimal RNK
    {
        get
        {
            return Convert.ToDecimal(Request.Params.Get("rnk"));
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        String ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        sdsREL_INTEXT.ConnectionString = ConnectionString;
        sdsCUSTTYPE.ConnectionString = ConnectionString;
        sdsPassp.ConnectionString = ConnectionString;
        sdsSEX.ConnectionString = ConnectionString;
        sdsTYPE.ConnectionString = ConnectionString;
        sdsDOCUMENT_TYPE.ConnectionString = ConnectionString;

        // если это регистрация нового клиента, то дизейблим все
        if (!IsPostBack)
        {
            Boolean IsNew = String.IsNullOrEmpty(Request.Params.Get("rnk")) || (Request.Params.Get("readonly") == "1");

            gvCustRelations.Enabled = !IsNew;
            gvCustRelationTypes.Enabled = !IsNew;
            fv.Enabled = !IsNew;
            fvCustRelationData.Enabled = !IsNew;

            ClientScript.RegisterStartupScript(this.GetType(), "enchCheck", "if(parent.flagEnhCheck) parent.Check_RekvLinkCusts(); if(parent.obj_Parameters['EditType'] == 'Reg') parent.getEl('bTab6').style.visibility = 'hidden';", true);
        }
        string editFlag = (Convert.ToString(Session["ClientRegister.RO"]) == "1").ToString().ToLower();

        ClientScript.RegisterStartupScript(this.GetType(), "disableLC", "DisableAllImg(document, '" + editFlag + "');", true); 
        var type = "b";
        var rezId = Request.Params.Get("rezid");
        var nSPD = Request.Params.Get("spd");
        var client = Request.Params.Get("client");
        if (client == "bank") type = "b";
        if (client == "corp" && rezId == "1") type = "u";
        if (client == "corp" && rezId == "2") type = "u_nrez";
        if (client == "person" && rezId == "1" && nSPD == "0") type = "f";
        if (client == "person" && rezId == "1" && nSPD == "1") type = "f_spd";
        if (client == "person" && rezId == "2") type = "f_nrez";

        sel_custrel.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        sel_custrel.SelectParameters.Clear();
        sel_custrel.SelectCommand = "select vt.* from v_cust_rel v, v_cust_rel_types vt where v.id=vt.id and v." + type + "=1 order by vt.id ";
        //sel_custrel.SelectCommand = "select vt.* from v_cust_rel v, v_cust_rel_types vt where v.id=vt.id order by vt.id ";
    }
    protected void fv_DataBound(object sender, EventArgs e)
    {
        if (fv.CurrentMode == FormViewMode.Edit || fv.CurrentMode == FormViewMode.Insert)
        {
            DDLList REL_INTEXT = fv.FindControl("REL_INTEXT") as DDLList;
            if (REL_INTEXT.Value == (Decimal?)null)
                REL_INTEXT.Value = 0;

            REL_INTEXT_ValueChanged(fv.FindControl("REL_INTEXT"), null);

            if (fv.FindControl("IS_NEW") != null)
            {
                IS_NEW_ValueChanged(fv.FindControl("IS_NEW"), null);
            }
        }
    }
    protected void fv_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gvCustRelations.DataBind();
    }
    protected void fv_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        e.Values["RNK"] = RNK;
    }
    protected void fv_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gvCustRelations.DataBind();
    }
    protected void fv_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        gvCustRelations.DataBind();
    }

    public void REL_INTEXT_ValueChanged(object sender, EventArgs e)
    {
        DDLList REL_INTEXT = sender as DDLList;

        if (fv.CurrentMode == FormViewMode.Edit || fv.CurrentMode == FormViewMode.Insert)
        {
            MultiView mv = fv.FindControl("mv") as MultiView;
            mv.ActiveViewIndex = Convert.ToInt32(REL_INTEXT.Value);
        }
    }
    public void IS_NEW_ValueChanged(object sender, EventArgs e)
    {
        RBLFlag IS_NEW = sender as RBLFlag;

        if (fv.CurrentMode == FormViewMode.Edit || fv.CurrentMode == FormViewMode.Insert)
        {
            TextBoxRefer RELEXT_ID = fv.FindControl("RELEXT_ID") as TextBoxRefer;

            if (!IS_NEW.Value.HasValue || IS_NEW.Value.Value == 1)
            {
                RELEXT_ID.IsRequired = false;
                RELEXT_ID.ReadOnly = true;
            }
            else
            {
                RELEXT_ID.IsRequired = true;
                RELEXT_ID.ReadOnly = false;
            }
        }
    }
    public void RELEXT_ID_ValueChanged(object sender, EventArgs e)
    {
        TextBoxRefer RELEXT_ID = sender as TextBoxRefer;

        if (fv.CurrentMode == FormViewMode.Edit || fv.CurrentMode == FormViewMode.Insert)
        {
            DDLList CUSTTYPE = fv.FindControl("CUSTTYPE") as DDLList;
            TextBoxString NAME = fv.FindControl("NAME") as TextBoxString;
            DDLList DOC_TYPE = fv.FindControl("DOC_TYPE") as DDLList;
            TextBoxString DOC_SERIAL = fv.FindControl("DOC_SERIAL") as TextBoxString;
            TextBoxString DOC_NUMBER = fv.FindControl("DOC_NUMBER") as TextBoxString;
            TextBoxDate DOC_DATE = fv.FindControl("DOC_DATE") as TextBoxDate;
            TextBoxString DOC_ISSUER = fv.FindControl("DOC_ISSUER") as TextBoxString;
            TextBoxDate BIRTHDAY = fv.FindControl("BIRTHDAY") as TextBoxDate;
            TextBoxString BIRTHPLACE = fv.FindControl("BIRTHPLACE") as TextBoxString;
            DDLList SEX = fv.FindControl("SEX") as DDLList;
            TextBoxString ADR = fv.FindControl("ADR") as TextBoxString;
            TextBoxString TEL = fv.FindControl("TEL") as TextBoxString;
            TextBoxString EMAIL = fv.FindControl("EMAIL") as TextBoxString;
            TextBoxString OKPO = fv.FindControl("OKPO") as TextBoxString;
            TextBoxRefer COUNTRY = fv.FindControl("COUNTRY") as TextBoxRefer;
            TextBoxRefer REGION = fv.FindControl("REGION") as TextBoxRefer;
            TextBoxRefer FS = fv.FindControl("FS") as TextBoxRefer;
            TextBoxRefer VED = fv.FindControl("VED") as TextBoxRefer;
            TextBoxRefer SED = fv.FindControl("SED") as TextBoxRefer;
            TextBoxRefer ISE = fv.FindControl("ISE") as TextBoxRefer;
            TextBoxString NOTES = fv.FindControl("NOTES") as TextBoxString;

            // обнуляем значения
            CUSTTYPE.Value = (Decimal?)null;
            NAME.Value = (String)null;
            DOC_TYPE.Value = (Decimal?)null;
            DOC_SERIAL.Value = (String)null;
            DOC_NUMBER.Value = (String)null;
            DOC_DATE.Value = (DateTime?)null;
            DOC_ISSUER.Value = (String)null;
            BIRTHDAY.Value = (DateTime?)null;
            BIRTHPLACE.Value = (String)null;
            SEX.Value = (Decimal?)null;
            ADR.Value = (String)null;
            TEL.Value = (String)null;
            EMAIL.Value = (String)null;
            OKPO.Value = (String)null;
            COUNTRY.Value = (String)null;
            REGION.Value = (String)null;
            FS.Value = (String)null;
            VED.Value = (String)null;
            SED.Value = (String)null;
            ISE.Value = (String)null;
            NOTES.Value = (String)null;

            if (!String.IsNullOrEmpty(RELEXT_ID.Value))
            {
                // если выбрали значение то заполняем контролы
                VCustExternRecord rec = (new VCustExtern()).SelectCustExtern(Convert.ToDecimal(RELEXT_ID.Value))[0];

                CUSTTYPE.Value = rec.CUSTTYPE;
                NAME.Value = rec.NAME;
                DOC_TYPE.Value = rec.DOC_TYPE;
                DOC_SERIAL.Value = rec.DOC_SERIAL;
                DOC_NUMBER.Value = rec.DOC_NUMBER;
                DOC_DATE.Value = rec.DOC_DATE;
                DOC_ISSUER.Value = rec.DOC_ISSUER;
                BIRTHDAY.Value = rec.BIRTHDAY;
                BIRTHPLACE.Value = rec.BIRTHPLACE;
                SEX.Value = Convert.ToDecimal(rec.SEX);
                ADR.Value = rec.ADR;
                TEL.Value = rec.TEL;
                EMAIL.Value = rec.EMAIL;
                OKPO.Value = rec.OKPO;
                COUNTRY.Value = Convert.ToString(rec.COUNTRY);
                REGION.Value = rec.REGION;
                FS.Value = rec.FS;
                VED.Value = rec.VED;
                SED.Value = rec.SED;
                ISE.Value = rec.ISE;
                NOTES.Value = rec.NOTES;
            }
        }
    }

    protected void gvCustRelations_SelectedIndexChanged(object sender, EventArgs e)
    {
        gvCustRelationTypes.DataBind();
    }
    protected void fvCustRelationData_DataBound(object sender, EventArgs e)
    {
        String DATASET_ID = Convert.ToString(fvCustRelationData.DataKey["DATASET_ID"]);
        MultiView mvCustRelationData = fvCustRelationData.FindControl("mvCustRelationData") as MultiView;

        if (mvCustRelationData == null) return;
        switch (DATASET_ID)
        {
            case "SIMPLE":
                mvCustRelationData.ActiveViewIndex = 0;
                break;
            case "VAGA":
                mvCustRelationData.ActiveViewIndex = 1;
                break;
            case "TRUSTEE":
                mvCustRelationData.ActiveViewIndex = 2;
                break;
            default:
                mvCustRelationData.ActiveViewIndex = 0;
                break;
        }
    }
    protected void fvCustRelationData_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        gvCustRelationTypes.DataBind();
    }
    protected void fvCustRelationData_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gvCustRelationTypes.DataBind();
    }
    protected void fvCustRelationData_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        e.Values["RNK"] = RNK;
        e.Values["REL_INTEXT"] = Convert.ToDecimal(gvCustRelations.SelectedDataKey["REL_INTEXT"]);
        Decimal? REL_RNK = (gvCustRelations.SelectedDataKey["RELCUST_RNK"] as Decimal?).HasValue ? (gvCustRelations.SelectedDataKey["RELCUST_RNK"] as Decimal?) : (gvCustRelations.SelectedDataKey["RELEXT_ID"] as Decimal?);
        e.Values["REL_RNK"] = REL_RNK;
    }
    protected void fvCustRelationData_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gvCustRelationTypes.DataBind();
    }
    public void REL_ID_ValueChanged(object sender, EventArgs e)
    {
        DDLList REL_ID = sender as DDLList;
        String DATASET_ID = (new VCustRelTypes()).SelectCustRelType(REL_ID.Value)[0].DATASET_ID;
        MultiView mvCustRelationData = fvCustRelationData.FindControl("mvCustRelationData") as MultiView;

        switch (DATASET_ID)
        {
            case "SIMPLE":
                mvCustRelationData.ActiveViewIndex = 0;
                break;
            case "VAGA":
                mvCustRelationData.ActiveViewIndex = 1;
                break;
            case "TRUSTEE":
                mvCustRelationData.ActiveViewIndex = 2;
                break;
            default:
                mvCustRelationData.ActiveViewIndex = 0;
                break;
        }
    }
    # endregion
}