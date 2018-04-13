using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Text.RegularExpressions;
using System.Web;
using AjaxPro;
using Bars.Classes;
using barsroot.cim;
using cim;
using System;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json.Serialization;
using JavaScriptSerializer = System.Web.Script.Serialization.JavaScriptSerializer;

public partial class cim_payments_link_form : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.SetPageTitle(this.Title + " по контракту #" + Request["contr_id"], true);

        dsLinks.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        string mode = Request["mode"];
        Master.AddScript("/barsroot/cim/payments/scripts/cim_link_form.js");

        dvBack.Visible = (Request["back"] != "0");
        decimal s = 0;
        decimal s_doc = 0;
        decimal s2 = 0;
        decimal s_total = 0;
        Contract contr = new Contract(Convert.ToDecimal(Request["CONTR_ID"]));
        ScriptManager.GetCurrent(this).RegisterPostBackControl(btExpImpPay);

        string title = " № " + contr.Num + "(#" + Request["contr_id"] + ")";
        if (contr.DateOpen != null)
            title = " № " + contr.Num + "(#" + Request["contr_id"] + ") від " + contr.DateOpen.Value.ToString("dd/MM/yyyy");

        if (mode.Equals("0") || mode.Equals("3") || mode.Equals("5") || mode.Equals("51") || mode.Equals("7") || mode.Equals("9"))
        {
            if (!IsPostBack)
            {
                pnLinkDecl.Visible = true;
                pnLinkPayment.Visible = false;
                pnLinkConclusion.Visible = false;

                if (mode.Equals("9") || mode.Equals("51"))
                {
                    lbRef.Text = "";
                    lbType.Text = Request["bound_type_name"];
                    lbKv.Text = Request["bound_kv"];
                    lbSumVK.Text = CimManager.NumberFormat(Convert.ToDecimal(Request["bound_sum"]));
                    lbZS_VP.Text = CimManager.NumberFormat(Convert.ToDecimal(Request["bound_sum"]));
                    lbZS_VK.Text = CimManager.NumberFormat(Convert.ToDecimal(Request["bound_sumvk"]));
                    lbVDAT.Text = Request["bound_vdat"];
                    if (mode.Equals("9"))
                        s = Convert.ToDecimal(Request["bound_sumvk"]);
                    else
                        s = Convert.ToDecimal(Request["bound_sum"]);
                    s_doc = Convert.ToDecimal(Request["bound_sumvk"]);
                }
                else if (mode.Equals("5"))
                {
                    VCimBoundPayments bp = new VCimBoundPayments();
                    bp.Filter.BOUND_ID.Equal(Convert.ToDecimal(Request["bound_id"]));
                    bp.Filter.TYPE_ID.Equal(Convert.ToDecimal(Request["type_id"]));
                    foreach (VCimBoundPaymentsRecord rec in bp.Select())
                    {
                        lbRef.Text = rec.REF.ToString();
                        lbType.Text = rec.TYPE;
                        lbKv.Text = Convert.ToString(rec.V_PL.Value);
                        lbSumVK.Text = CimManager.NumberFormat(rec.S_VPL.Value);
                        lbVDAT.Text = rec.VDAT.Value.ToString("dd/MM/yyyy");
                        s = rec.S_VPL.Value;
                    }
                }
                else
                {
                    VCimTradePayments tp = new VCimTradePayments();
                    tp.Filter.BOUND_ID.Equal(Convert.ToDecimal(Request["bound_id"]));
                    tp.Filter.TYPE_ID.Equal(Convert.ToDecimal(Request["type_id"]));
                    bool isRecord = false;
                    foreach (VCimTradePaymentsRecord rec in tp.Select())
                    {
                        isRecord = true;
                        lbRef.Text = rec.REF.ToString();
                        lbType.Text = rec.TYPE;
                        lbKv.Text = Convert.ToString(rec.V_PL.Value);
                        lbSumVK.Text = CimManager.NumberFormat(rec.S_VPL.Value);
                        lbZS_VP.Text = CimManager.NumberFormat(rec.ZS_VP.Value);
                        lbZS_VK.Text = CimManager.NumberFormat(rec.ZS_VK.Value);
                        lbVDAT.Text = rec.VDAT.Value.ToString("dd/MM/yyyy");
                        s = rec.ZS_VK.Value;
                        s2 = rec.S_VK.Value;
                        s_total = rec.S_VPL.Value - rec.ZS_VP.Value;
                    }
                    if (!isRecord)
                        throw new SystemException("Не знайдено данних по платежу (bound_id=" + Request["bound_id"] +
                                                  ", type_id=" + Request["type_id"] + ")!");
                }
            }
            if (mode.Equals("3"))
            {
                //contr.DateOpen.ToString("dd/MM/yyyy");
                Master.SetPageTitle("Висновки, пов’язані з платежем по контракту" + title, true);
                pnLinks1.Visible = false;
                pnConclusions1.Visible = true;
                dsLinks.SelectCommand = "select v.*  from (select c.*, cim_mgr.get_cnc_link_sum(c.id, :TYPE_ID, :BOUND_ID) as f_sum from v_cim_conclusion c  where contr_id=:CONTR_ID and kv = " + lbKv.Text + ") v where v.s>v.s_doc and to_date('" + lbVDAT.Text + "','DD/MM/YYYY') < end_date or v.f_sum > 0";

                trConcCol1.Visible = true;
                decimal conlusionSum = contr.GetConclusionSum(Convert.ToDecimal(Request["TYPE_ID"]), Convert.ToDecimal(Request["BOUND_ID"]));
                s_doc = conlusionSum;
                lbConclusionTotalSum.Text = string.Format("{0:F}", conlusionSum);
            }
            else if (mode.Equals("5") || mode.Equals("51"))
            {
                Master.SetPageTitle("Ліцензії, пов’язані з платежем по контракту" + title, true);
                pnLinks1.Visible = false;
                pnConclusions1.Visible = false;
                pnLicenses1.Visible = true;

                trLicenseCol1.Visible = true;
                decimal licenseSum = contr.GetLicenseSum(Convert.ToDecimal(Request["TYPE_ID"]), Convert.ToDecimal(Request["BOUND_ID"]));
                s_doc = licenseSum;
                lbLicenseTotalSum.Text = CimManager.NumberFormat(licenseSum);

                dsLinks.SelectCommand = "select v.* from (select c.*, cim_mgr.get_license_link_sum(c.license_id, :TYPE_ID, :BOUND_ID) as f_sum, :CONTR_ID emp from v_cim_license c where kv=" + lbKv.Text + " and okpo='" + contr.ClientInfo.Okpo + "' ) v where  " + CimManager.StrToNumber(lbLicenseTotalSum.Text) + " < " + CimManager.StrToNumber(lbSumVK.Text) + " and begin_date <= to_date('" + lbVDAT.Text + "','DD/MM/YYYY') and to_date('" + lbVDAT.Text + "','DD/MM/YYYY') <= end_date or v.f_sum > 0";
            }
            else if (mode.Equals("7"))
            {
                Master.SetPageTitle("Акти цінової експертизи, пов’язані з платежем по контракту" + title, true);
                pnLinks1.Visible = false;
                pnConclusions1.Visible = false;
                pnLicenses1.Visible = false;
                pnApes1.Visible = true;

                trApeCol1.Visible = true;
                //if (Request["type_id"] == "0")
                tdAddApe.Visible = true;
                decimal apeSum = contr.GetApeSum(Convert.ToDecimal(Request["TYPE_ID"]), Convert.ToDecimal(Request["BOUND_ID"]));
                s_doc = apeSum;
                lbApeTotalSum.Text = CimManager.NumberFormat(apeSum);
                s = s2;
                dsLinks.SelectCommand = "select v.* from (select c.*, cim_mgr.get_ape_link_sum(c.ape_id, :TYPE_ID, :BOUND_ID) as f_sum from v_cim_ape c where contr_id=:CONTR_ID ) v where  v.f_sum > 0 or " + CimManager.StrToNumber(lbZS_VK.Text) + " <= zs_vk and  " + CimManager.StrToNumber(lbApeTotalSum.Text) + "=0 and begin_date <= to_date('" + lbVDAT.Text + "','DD/MM/YYYY') and to_date('" + lbVDAT.Text + "','DD/MM/YYYY') <= end_date";
            }
            else if (mode.Equals("9"))
            {
                Master.SetPageTitle("Акти цінової експертизи, пов’язані з платежем по контракту" + title, true);
                pnLinks1.Visible = false;
                pnConclusions1.Visible = false;
                pnLicenses1.Visible = false;
                pnApes1.Visible = true;

                trApeCol1.Visible = true;
                //if (Request["type_id"] == "0")
                tdAddApe.Visible = true;
                decimal apeSum = contr.GetApeSum2(contr.ContrId.Value, Convert.ToDecimal(Request["bound_sumvk"]));
                lbApeTotalSum.Text = CimManager.NumberFormat(apeSum);

                dsLinks.SelectCommand = "select v.* from (select c.*, cim_mgr.get_ape_link_sum(c.ape_id, :TYPE_ID, NULL) as f_sum , :BOUND_ID ss from v_cim_ape c where contr_id=:CONTR_ID ) v where v.f_sum > 0 or " + CimManager.StrToNumber(lbZS_VK.Text) + " <= zs_vk and  " + CimManager.StrToNumber(lbApeTotalSum.Text) + "=0";
            }
            else
            {
                Master.SetPageTitle("Митні декларації, пов’язані з платежем по контракту" + title, true);
                pnLinks1.Visible = true;
                pnConclusions1.Visible = false;
                //dsLinks.SelectCommand = "select * from (select cim_mgr.get_link_sum(:TYPE_ID,:BOUND_ID, type_id, bound_id) f_sum, bound_id,contr_id,vmd_id,direct,type_id,doc_type,num,doc_date,allow_date,vt,s_vt,rate_vk,s_vk,file_date,file_name,s_pl_vk,z_vt,z_vk,s_pl_after_vk,control_date,overdue,comments from v_cim_bound_vmd where contr_id=:CONTR_ID) where f_sum > 0 or (trunc(doc_date)=trunc(allow_date) or type_id > 0) and ( z_vk > 0 and nvl(" + CimManager.StrToNumber(lbZS_VK.Text) + ", 0) > 0) order by 1 desc";
                dsLinks.SelectCommand = "select * from ( select l.s/100 f_sum,v.bound_id, v.contr_id,v.vmd_id,v.direct,v.type_id,v.doc_type,v.num,v.doc_date, v.allow_date,v.vt,v.s_vt,v.rate_vk,v.s_vk,v.file_date,v.file_name,v.s_pl_vk,v.z_vt,v.z_vk,v.s_pl_after_vk,v.control_date,v.overdue, v.comments, l.link_date from v_cim_bound_vmd v left outer join (select vmd_id, act_id, nvl(sum(s),0) s, max(create_date) link_date from cim_link where delete_date is null and decode(:TYPE_ID,0,payment_id,fantom_id)=:BOUND_ID group by vmd_id, act_id) l on decode(v.type_id,0,l.vmd_id,l.act_id)=v.bound_id where contr_id=:CONTR_ID ) where f_sum > 0 or ( z_vk > 0 and nvl(" + CimManager.StrToNumber(lbZS_VK.Text) + ", 0) > 0) order by 1 desc";
                if (contr.ContrType == 1)
                {
                    gvCimBoundVmd.Columns[15].Visible = false;
                    gvCimBoundVmd.Columns[16].Visible = false;
                }
                btExpImpPay.Visible = true;
            }
            if (Request["addpay"] == "1" || mode.Equals("5") || mode.Equals("51"))
            {
                tdZS_VK1.Visible = false;
                tdZS_VK2.Visible = false;
                tdZS_VP1.Visible = false;
                tdZS_VP2.Visible = false;
                trApeCol1.Visible = false;
                trConcCol1.Visible = false;
                //trLicenseCol1.Visible = false;
            }
        }
        else if (mode.Equals("1"))
        {
            btExpImpPay.Visible = true;
            decimal zvk = 0;
            if (!IsPostBack)
            {
                Master.SetPageTitle("Платежі, пов’язані з МД контракту" + title, true);
                pnLinkDecl.Visible = false;
                pnLinkPayment.Visible = true;
                pnLinkConclusion.Visible = false;
            }
            VCimBoundVmd tp = new VCimBoundVmd();
            tp.Filter.BOUND_ID.Equal(Convert.ToDecimal(Request["bound_id"]));
            tp.Filter.TYPE_ID.Equal(Convert.ToDecimal(Request["type_id"]));
            trDeclCol1.Visible = true;

            decimal declSum = contr.GetDeclarationSum(Convert.ToDecimal(Request["TYPE_ID"]), Convert.ToDecimal(Request["BOUND_ID"]));
            //lbDeclarationTotalSum.Text = CimManager.NumberFormat(declSum);
            s_doc = declSum;

            foreach (VCimBoundVmdRecord rec in tp.Select())
            {
                lbDeclId.Text = rec.VMD_ID.ToString();
                lbDeclNum.Text = rec.NUM;
                lbDeclType.Text = rec.DOC_TYPE;
                lbDeclKv.Text = rec.VT.Value.ToString();
                lbDeclSVT.Text = CimManager.NumberFormat(rec.S_VT.Value);
                lbDeclDocDate.Text = rec.ALLOW_DATE.Value.ToString("dd/MM/yyyy");
                decimal svk = (rec.S_VK.HasValue) ? (rec.S_VK.Value) : (0);
                lbDeclSVK.Text = CimManager.NumberFormat(svk);
                lbDeclarationTotalSum.Text = CimManager.NumberFormat(rec.S_VK - rec.Z_VK);
                s_total = rec.S_VK.Value - rec.Z_VK.Value;
                zvk = rec.Z_VK.Value;
                s = svk;
            }

            //dsLinks.SelectCommand = "select * from (select cim_mgr.get_link_sum(type_id, bound_id, :TYPE_ID, :BOUND_ID) f_sum, bound_id,contr_id,pay_flag,ref,direct,type_id,type,vdat,account,nazn,v_pl,s_vpl,sk_vpl,rate,s_vk,s_pd,zs_vp,zs_vk,control_date,overdue,s_pd_after from v_cim_trade_payments where contr_id=:CONTR_ID ) where f_sum > 0 or ( zs_vk > 0 and nvl(" + zvk + ",0) > 0) order by 1 desc";
            dsLinks.SelectCommand = "select * from (select l.s/100 f_sum, p.bound_id,p.contr_id,p.pay_flag,p.ref,p.direct,p.type_id,p.type,p.vdat,p.account,p.nazn,p.v_pl,p.s_vpl,p.sk_vpl,p.rate,p.s_vk,p.s_pd,p.zs_vp,p.zs_vk,p.control_date,p.overdue,p.s_pd_after,l.link_date from v_cim_trade_payments p left outer join (select payment_id, fantom_id, nvl(sum(s),0) s, max(create_date) link_date from cim_link where delete_date is null and decode(:TYPE_ID,0,vmd_id,act_id)=:BOUND_ID group by payment_id, fantom_id) l on decode(p.type_id,0,l.payment_id,fantom_id)=p.bound_id  where contr_id=:CONTR_ID ) where f_sum > 0 or ( zs_vk > 0 and nvl(" + zvk + ",0) > 0) order by 1 desc ";
        }
        else if (mode.Equals("11"))
        {
            if (!IsPostBack)
            {
                Master.SetPageTitle("Висновки, пов’язані з МД контракту" + title, true);
                pnLinkDecl.Visible = false;
                pnLinkPayment.Visible = true;
                pnLinkConclusion.Visible = false;
                pnLinks2.Visible = false;
                pnLinks5.Visible = true;
                VCimBoundVmd tp = new VCimBoundVmd();
                tp.Filter.BOUND_ID.Equal(Convert.ToDecimal(Request["bound_id"]));
                tp.Filter.TYPE_ID.Equal(Convert.ToDecimal(Request["type_id"]));
                foreach (VCimBoundVmdRecord rec in tp.Select())
                {
                    lbDeclId.Text = rec.VMD_ID.ToString();
                    lbDeclNum.Text = rec.NUM;
                    lbDeclType.Text = rec.DOC_TYPE;
                    lbDeclKv.Text = rec.VT.Value.ToString();
                    lbDeclSVT.Text = CimManager.NumberFormat(rec.S_VT.Value);
                    lbDeclDocDate.Text = rec.ALLOW_DATE.Value.ToString("dd/MM/yyyy");
                    decimal svk = (rec.S_VK.HasValue) ? (rec.S_VK.Value) : (0);
                    lbDeclSVK.Text = CimManager.NumberFormat(svk);
                    s = svk;
                }
            }
            dsLinks.SelectCommand = "select v.*  from (select c.*, cim_mgr.get_cnc_link_sum(c.id, :TYPE_ID, :BOUND_ID) as f_sum from v_cim_conclusion c  where contr_id=:CONTR_ID and kv = " + lbDeclKv.Text + ") v where v.s>v.s_doc and  to_date('" + lbDeclDocDate.Text + "','DD/MM/YYYY') < end_date  or v.f_sum > 0";
        }
        else if (mode.Equals("2"))
        {
            Master.SetPageTitle("Платежі, пов’язані з висновком по контракту" + title, true);
            if (!IsPostBack)
            {
                pnLinkDecl.Visible = false;
                pnLinkPayment.Visible = false;
                pnLinkConclusion.Visible = true;
                VCimConclusion cc = new VCimConclusion();

                cc.Filter.ID.Equal(Convert.ToDecimal(Request["bound_id"]));
                foreach (VCimConclusionRecord rec in cc.Select())
                {
                    lbConclNum.Text = rec.OUT_NUM;
                    lbConclOutDat.Text = (rec.OUT_DATE.HasValue) ? (rec.OUT_DATE.Value.ToString("dd/MM/yyyy")) : ("");
                    lbConclOrgan.Text = rec.ORG_NAME;
                    lbConclSumDoc.Text = CimManager.NumberFormat(rec.S_DOC.Value);
                    s_doc = rec.S_DOC.Value;
                    s = rec.S.Value;
                    lbConclKv.Text = rec.KV.ToString();
                    lbConclSum.Text = CimManager.NumberFormat(rec.S.Value);
                    lbConclBeginDat.Text = (rec.BEGIN_DATE.HasValue) ? (rec.BEGIN_DATE.Value.ToString("dd/MM/yyyy")) : ("");
                    lbConclEndDat.Text = (rec.END_DATE.HasValue) ? (rec.END_DATE.Value.ToString("dd/MM/yyyy")) : ("");
                }
            }
            dsLinks.SelectCommand = "select * from (select :TYPE_ID emp, cim_mgr.get_cnc_link_sum(:BOUND_ID, type_id, bound_id) f_sum, bound_id,contr_id,pay_flag,ref,direct,type_id,type,vdat,account,nazn,v_pl,s_vpl,sk_vpl,rate,s_vk,s_pd,zs_vp,zs_vk,control_date,overdue,s_pd_after from v_cim_trade_payments where contr_id=:CONTR_ID and v_pl=" + lbConclKv.Text + " ) where  f_sum > 0 or " + CimManager.StrToNumber(lbConclSumDoc.Text) + " < " + CimManager.StrToNumber(lbConclSum.Text) + " and vdat < to_date('" + lbConclEndDat.Text + "','DD/MM/YYYY')  order by 1 desc";
        }
        else if (mode.Equals("21"))
        {
            Master.SetPageTitle("МД, пов’язані з висновком по контракту" + title, true);
            if (!IsPostBack)
            {
                pnLinkDecl.Visible = false;
                pnLinkPayment.Visible = false;
                pnLinkConclusion.Visible = true;
                pnLinks3.Visible = false;
                pnLinks4.Visible = true;
                VCimConclusion cc = new VCimConclusion();

                cc.Filter.ID.Equal(Convert.ToDecimal(Request["bound_id"]));
                foreach (VCimConclusionRecord rec in cc.Select())
                {
                    lbConclNum.Text = rec.OUT_NUM;
                    lbConclOutDat.Text = (rec.OUT_DATE.HasValue) ? (rec.OUT_DATE.Value.ToString("dd/MM/yyyy")) : ("");
                    lbConclOrgan.Text = rec.ORG_NAME;
                    lbConclSumDoc.Text = CimManager.NumberFormat(rec.S_DOC.Value);
                    s_doc = rec.S_DOC.Value;
                    s = rec.S.Value;
                    lbConclKv.Text = rec.KV.ToString();
                    lbConclSum.Text = CimManager.NumberFormat(rec.S.Value);//string.Format("{0:F}", rec.S.Value);
                    lbConclBeginDat.Text = (rec.CREATE_DATE.HasValue) ? (rec.CREATE_DATE.Value.ToString("dd/MM/yyyy")) : ("");
                    lbConclEndDat.Text = (rec.END_DATE.HasValue) ? (rec.END_DATE.Value.ToString("dd/MM/yyyy")) : ("");
                }
            }
            dsLinks.SelectCommand = "select * from (select cim_mgr.get_cnc_link_sum(:BOUND_ID, type_id, bound_id) f_sum, :TYPE_ID d1, bound_id,contr_id,vmd_id,direct,type_id,doc_type,num,doc_date,allow_date,vt,s_vt,rate_vk,s_vk,file_date,file_name,s_pl_vk,z_vt,z_vk,s_pl_after_vk,control_date,overdue,comments from v_cim_bound_vmd where contr_id=:CONTR_ID and vt=" + lbConclKv.Text + ") where f_sum > 0 or " + CimManager.StrToNumber(lbConclSumDoc.Text) + " < " + CimManager.StrToNumber(lbConclSum.Text) + " and doc_date < to_date('" + lbConclEndDat.Text + "','DD/MM/YYYY') order by 1 desc";
        }
        else if (mode.Equals("4"))
        {
            Master.SetPageTitle("Платежі, пов’язані з ліцензією по контракту" + title, true);
            if (!IsPostBack)
            {
                pnLinkDecl.Visible = false;
                pnLinkPayment.Visible = false;
                pnLinkConclusion.Visible = false;
                pnLinkLicenses.Visible = true;
                VCimLicense cl = new VCimLicense();
                cl.Filter.LICENSE_ID.Equal(Convert.ToDecimal(Request["bound_id"]));
                foreach (VCimLicenseRecord rec in cl.Select())
                {
                    lbLicenseNum.Text = rec.NUM;
                    lbLicenseBeginDate.Text = (rec.BEGIN_DATE.HasValue) ? (rec.BEGIN_DATE.Value.ToString("dd/MM/yyyy")) : ("");
                    lbLicenseEndDate.Text = (rec.END_DATE.HasValue) ? (rec.END_DATE.Value.ToString("dd/MM/yyyy")) : ("");
                    lbLicenseType.Text = rec.TYPE_TXT;
                    s_doc = (rec.S_DOC.HasValue) ? (rec.S_DOC.Value) : (0);
                    s = rec.S.Value;

                    lbLicenseSDoc.Text = CimManager.NumberFormat(s_doc);
                    lbLicenseSum.Text = CimManager.NumberFormat(s);
                    lbLicenseKv.Text = rec.KV.ToString();
                    lbKv.Text = lbLicenseKv.Text;
                    lbLicenseComment.Text = rec.COMMENTS;
                }
            }
            dsLinks.SelectCommand = "select * from  (select :TYPE_ID emp, cim_mgr.get_license_link_sum(:BOUND_ID, p.type_id, p.bound_id) f_sum, direct,type_id, type, bound_id, account,nazn,v_pl, s_vpl, rate, vdat, ref, s_vk,contr_id from v_cim_bound_payments p where v_pl= " + lbLicenseKv.Text + " and direct=1 and contr_id=:CONTR_ID) v where " + s + ">" + s_doc + " and to_date('" + lbLicenseBeginDate.Text + "','DD/MM/YYYY') <= vdat and vdat <= to_date('" + lbLicenseEndDate.Text + "','DD/MM/YYYY') or v.f_sum > 0 order by 1 desc";
        }
        else if (mode.Equals("6"))
        {
            Master.SetPageTitle("Платежі, пов’язані з актом цінової экспертизи по контракту" + title, true);
            if (!IsPostBack)
            {
                pnLinkDecl.Visible = false;
                pnLinkPayment.Visible = false;
                pnLinkConclusion.Visible = false;
                pnLinkApes.Visible = true;
                contr.DeleteUnboundApe(Convert.ToDecimal(Request["bound_id"]));

                VCimApe ca = new VCimApe();
                ca.Filter.APE_ID.Equal(Convert.ToDecimal(Request["bound_id"]));
                foreach (VCimApeRecord rec in ca.Select())
                {
                    lbApeNum.Text = rec.NUM;
                    lbApeBeginDate.Text = (rec.BEGIN_DATE.HasValue) ? (rec.BEGIN_DATE.Value.ToString("dd/MM/yyyy")) : ("");
                    lbApeEndDate.Text = (rec.END_DATE.HasValue) ? (rec.END_DATE.Value.ToString("dd/MM/yyyy")) : ("");
                    lbApeRate.Text = string.Format("{0:N8}", rec.RATE);
                    s_doc = (rec.ZS_VK.HasValue) ? (rec.ZS_VK.Value) : (0);
                    s = rec.S.Value;
                    lbApeZS_VK.Text = CimManager.NumberFormat(s_doc);
                    lbApeSumVK.Text = CimManager.NumberFormat(rec.S_VK);
                    lbApeSum.Text = CimManager.NumberFormat(s);
                    lbApeKv.Text = rec.KV.ToString();
                    lbApeComment.Text = rec.COMMENTS;
                }
            }
            dsLinks.SelectCommand = "select * from  (select :TYPE_ID emp, cim_mgr.get_ape_link_sum(:BOUND_ID, p.type_id, p.bound_id) f_sum, direct,type_id, type, bound_id, account,nazn,v_pl, s_vpl, rate, vdat, ref, s_vk from v_cim_bound_payments p where direct=1 and contr_id=:CONTR_ID) v where to_date('" + lbApeBeginDate.Text + "','DD/MM/YYYY') <= vdat and vdat <= to_date('" + lbApeEndDate.Text + "','DD/MM/YYYY') and s_vk <= " + s_doc + " or v.f_sum > 0 order by 1 desc";
        }
        else
        {
            pnLinkDecl.Visible = false;
            pnLinkPayment.Visible = false;
            pnLinkConclusion.Visible = false;
        }
        DateTime bdate = DateTime.Now;
        if (Session[Constants.StateKeys.BankDate] == null)
        {
            CimManager cm = new CimManager(true);
            if (cm.BankDate != null) bdate = cm.BankDate.Value;
        }

        if (!ClientScript.IsStartupScriptRegistered(this.GetType(), "init"))
        {
            var objJson = new Dictionary<string, object>
                {
                    {"bdate",  bdate.ToString("ddMMyyyy")},
                    {"nmk", contr.ClientInfo.NmkK},
                    {"contrKv", contr.Kv},
                    {"contrType", contr.ContrType} 
                };
            string strJson = new JavaScriptSerializer().Serialize(objJson);
            ClientScript.RegisterStartupScript(this.GetType(), "init", "CIM.setVariables('" + Request["contr_id"] + "','" + mode + "','" + Request["bound_id"] + "','" + Request["direct"] + "','" + Request["type_id"] + "', '" + s + "', '" + s_doc + "', '" + Request["service_code"] + "','" + lbKv.Text + "','" + s_total + "'," + strJson + "); ", true);
        }
    }

    protected void gvCimBoundVmd_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string parMaskInt = "\"{0}\":{1},";
            string rowdata = "{";
            rowdata += string.Format(parMaskInt, "bi", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BOUND_ID")));
            rowdata += string.Format(parMaskInt, "fs", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "F_SUM")));
            rowdata += string.Format(parMaskInt, "vi", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "VMD_ID")));
            rowdata += string.Format(parMaskInt, "ti", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "TYPE_ID")));
            rowdata += string.Format(parMaskInt, "di", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "DIRECT")));
            rowdata += string.Format(parMaskInt, "svk", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "S_VK")));
            rowdata += string.Format(parMaskInt, "svt", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "S_VT")));
            rowdata += string.Format(parMaskInt, "zvk", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "Z_VK")));

            rowdata = rowdata.Substring(0, rowdata.Length - 1);
            rowdata += "}";
            e.Row.Attributes.Add("rd", rowdata);

            decimal fsum = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "F_SUM"));
            if (fsum <= 0)
                e.Row.Cells[0].Controls[1].Visible = false;
            object oZVK = DataBinder.Eval(e.Row.DataItem, "Z_VK");


            if (oZVK != DBNull.Value)
            {
                decimal z_vk = Convert.ToDecimal(oZVK);
                if (z_vk <= 0 || (Request["mode"] != "21" && CimManager.StrToNumber(lbZS_VK.Text) <= 0) || (Request["mode"] == "21" && CimManager.StrToNumber(lbConclSum.Text) <= CimManager.StrToNumber(lbConclSumDoc.Text)))
                    e.Row.Cells[1].Controls[1].Visible = false;
            }

            string paymentType = Convert.ToString(Request["type_id"]);
            string paymentId = Convert.ToString(Request["bound_id"]);

            string vmdType = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "TYPE_ID"));
            string vmdId = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BOUND_ID"));

            //decimal paymentType, decimal paymentId, decimal vmdType, decimal vmdId
            e.Row.Cells[e.Row.Cells.Count - 1].Text =
                                "<img src='/Common/Images/default/16/document.png' title='Змінити дату привязки' onclick='curr_module.EditRegDate(" +
                                paymentType + "," + paymentId + "," + vmdType + "," + vmdId + ",\"" + Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "LINK_DATE")).ToString("dd/MM/yyyy") + "\")'></img>&nbsp;&nbsp;" + e.Row.Cells[e.Row.Cells.Count - 1].Text;
        }
    }

    protected void gvVCimBoundPayments_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string parMaskStr = "\"{0}\":'{1}',";
            string parMaskInt = "\"{0}\":{1},";
            string rowdata = "{";
            rowdata += string.Format(parMaskInt, "bi", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BOUND_ID")));
            rowdata += string.Format(parMaskInt, "fs", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "F_SUM")));
            rowdata += string.Format(parMaskInt, "ti", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "TYPE_ID")));
            rowdata += string.Format(parMaskInt, "di", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "DIRECT")));
            rowdata += string.Format(parMaskInt, "svk", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "S_VK")));
            rowdata += string.Format(parMaskInt, "zsvk", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ZS_VK")));
            rowdata = rowdata.Substring(0, rowdata.Length - 1);
            rowdata += "}";
            e.Row.Attributes.Add("rd", rowdata);
            decimal fsum = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "F_SUM"));
            if (fsum <= 0)
                e.Row.Cells[0].Controls[1].Visible = false;

            decimal zs_vk = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "ZS_VK"));
            if (zs_vk <= 0)
                e.Row.Cells[1].Controls[1].Visible = false;

            if (CimManager.StrToNumber(lbDeclSVK.Text) <= CimManager.StrToNumber(lbDeclarationTotalSum.Text))
                e.Row.Cells[1].Controls[1].Visible = false;

            string vmdType = Convert.ToString(Request["type_id"]);
            string vmdId = Convert.ToString(Request["bound_id"]);

            string paymentType = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "TYPE_ID"));
            string paymentId = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BOUND_ID"));

            //decimal paymentType, decimal paymentId, decimal vmdType, decimal vmdId
            e.Row.Cells[e.Row.Cells.Count - 1].Text =
                                "<img src='/Common/Images/default/16/document.png' title='Змінити дату привязки' onclick='curr_module.EditRegDate(" +
                                paymentType + "," + paymentId + "," + vmdType + "," + vmdId + ",\"" + Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "LINK_DATE")).ToString("dd/MM/yyyy") + "\")'></img>&nbsp;&nbsp;" + e.Row.Cells[e.Row.Cells.Count - 1].Text;
        }
    }

    protected void gvCimConclusionLink_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string parMaskStr = "\"{0}\":'{1}',";
            string parMaskInt = "\"{0}\":{1},";
            string rowdata = "{";
            rowdata += string.Format(parMaskInt, "bi", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BOUND_ID")));
            rowdata += string.Format(parMaskInt, "fs", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "F_SUM")));
            rowdata += string.Format(parMaskInt, "ti", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "TYPE_ID")));
            rowdata += string.Format(parMaskInt, "di", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "DIRECT")));
            rowdata += string.Format(parMaskInt, "svp", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "S_VPL")));
            rowdata = rowdata.Substring(0, rowdata.Length - 1);
            rowdata += "}";
            e.Row.Attributes.Add("rd", rowdata);
            decimal fsum = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "F_SUM"));
            decimal svpl = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "S_VPL"));
            if (fsum <= 0)
                e.Row.Cells[0].Controls[1].Visible = false;
            if (Convert.ToDecimal(lbConclSumDoc.Text) >= Convert.ToDecimal(lbConclSum.Text) || fsum >= svpl)
                e.Row.Cells[1].Controls[1].Visible = false;
        }
    }

    [WebMethod(EnableSession = true)]
    public static void LinkDecl(decimal typeId, decimal boundId, int typeDecl, decimal declId, decimal sum)
    {
        Contract contractInfo = new Contract();
        contractInfo.LinkDecl(typeId, boundId, typeDecl, declId, sum);
    }
    [WebMethod(EnableSession = true)]
    public static void UnLinkDecl(decimal typeId, decimal boundId, int typeDecl, decimal declId, string comment)
    {
        Contract contractInfo = new Contract();
        contractInfo.UnLinkDecl(typeId, boundId, typeDecl, declId, comment);
    }

    [WebMethod(EnableSession = true)]
    public static void LinkConclusion(decimal typeId, decimal boundId, decimal conclId, decimal sum)
    {
        Contract contractInfo = new Contract();
        contractInfo.LinkConclusion(typeId, boundId, conclId, sum);
    }
    [WebMethod(EnableSession = true)]
    public static void UnLinkConclusion(decimal typeId, decimal boundId, decimal conclId)
    {
        Contract contractInfo = new Contract();
        contractInfo.UnLinkConclusion(typeId, boundId, conclId);
    }

    [WebMethod(EnableSession = true)]
    public static void LinkLicense(decimal typeId, decimal boundId, decimal licenseId, decimal sum, decimal kv, decimal svp)
    {
        Contract contractInfo = new Contract();
        contractInfo.LinkLicense(typeId, boundId, licenseId, sum, kv, svp);
    }
    [WebMethod(EnableSession = true)]
    public static void UnLinkLicense(decimal typeId, decimal boundId, decimal licenseId)
    {
        Contract contractInfo = new Contract();
        contractInfo.UnLinkLicense(typeId, boundId, licenseId);
    }

    [WebMethod(EnableSession = true)]
    public static void LinkApe(decimal typeId, decimal boundId, decimal apeId, decimal? sum, string serviceCode)
    {
        Contract contractInfo = new Contract();
        contractInfo.LinkApe(typeId, boundId, apeId, sum, serviceCode);
    }
    [WebMethod(EnableSession = true)]
    public static void UnLinkApe(decimal typeId, decimal boundId, decimal apeId)
    {
        Contract contractInfo = new Contract();
        contractInfo.UnLinkApe(typeId, boundId, apeId);
    }
    [WebMethod(EnableSession = true)]
    public static void UpdateApe(ApeClass ac)
    {
        Contract contractInfo = new Contract();
        contractInfo.UpdateApe(ac);
    }

    [WebMethod(EnableSession = true)]
    public static ResultData FormSendToBankMail(decimal mailId, BindClass bindInfo)
    {
        CimManager cm = new CimManager(false);
        return cm.FormSendToBankMail(mailId, bindInfo);
    }

    [WebMethod(EnableSession = true)]
    public static string SaveLinkRegDate(decimal paymentType, decimal paymentId, decimal vmdType, decimal vmdId, string date)
    {
        Contract contractInfo = new Contract();
        return contractInfo.SaveLinkRegDate(paymentType, paymentId, vmdType, vmdId, date);
    }

    protected void gvCimConclusions_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string parMaskStr = "\"{0}\":'{1}',";
            string parMaskInt = "\"{0}\":{1},";
            string rowdata = "{";
            rowdata += string.Format(parMaskInt, "ri", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ID")));
            rowdata += string.Format(parMaskInt, "ori", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ORG_ID")));
            rowdata += string.Format(parMaskStr, "onm", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "OUT_NUM")));
            rowdata += string.Format(parMaskStr, "bdt", Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "BEGIN_DATE")).ToString("dd/MM/yyyy"));
            rowdata += string.Format(parMaskStr, "edt", Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "END_DATE")).ToString("dd/MM/yyyy"));
            string dat = (DataBinder.Eval(e.Row.DataItem, "OUT_DATE") == DBNull.Value) ? ("") : (Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "OUT_DATE")).ToString("dd/MM/yyyy"));
            rowdata += string.Format(parMaskStr, "odt", dat);
            rowdata += string.Format(parMaskInt, "sum", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "S")));
            rowdata += string.Format(parMaskInt, "sd", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "S_DOC")));
            rowdata = rowdata.Substring(0, rowdata.Length - 1);
            rowdata += "}";
            e.Row.Attributes.Add("rd", rowdata);
            decimal fsum = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "F_SUM"));
            decimal s = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "S"));
            decimal sdoc = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "S_DOC"));
            if (fsum <= 0)
                e.Row.Cells[0].Controls[1].Visible = false;

            if (Request["mode"] == "11")
            {
                if (s <= sdoc)
                    e.Row.Cells[1].Controls[1].Visible = false;
            }
            else
                if (Convert.ToDecimal(lbSumVK.Text) <= Convert.ToDecimal(lbConclusionTotalSum.Text))
                    e.Row.Cells[1].Controls[1].Visible = false;

        }
    }
    protected void gvnLinkLicenses_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string parMaskStr = "\"{0}\":'{1}',";
            string parMaskInt = "\"{0}\":{1},";
            string rowdata = "{";
            rowdata += string.Format(parMaskInt, "bi", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BOUND_ID")));
            rowdata += string.Format(parMaskInt, "fs", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "F_SUM")));
            rowdata += string.Format(parMaskInt, "ti", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "TYPE_ID")));
            rowdata += string.Format(parMaskInt, "di", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "DIRECT")));
            rowdata += string.Format(parMaskInt, "svk", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "S_VK")));
            rowdata += string.Format(parMaskInt, "svp", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "S_VPL")));
            rowdata = rowdata.Substring(0, rowdata.Length - 1);
            rowdata += "}";
            e.Row.Attributes.Add("rd", rowdata);
            decimal fsum = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "F_SUM"));
            if (fsum <= 0)
                e.Row.Cells[0].Controls[1].Visible = false;

            decimal svpl = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "S_VPL"));
            if (fsum <= 0)
                e.Row.Cells[0].Controls[1].Visible = false;
            if (Convert.ToDecimal(lbLicenseSDoc.Text) >= Convert.ToDecimal(lbLicenseSum.Text) || fsum >= svpl)
                e.Row.Cells[1].Controls[1].Visible = false;
        }
    }
    protected void gvCimLicenses_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string parMaskStr = "\"{0}\":'{1}',";
            string parMaskInt = "\"{0}\":{1},";
            string rowdata = "{";
            rowdata += string.Format(parMaskInt, "li", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "LICENSE_ID")));
            rowdata += string.Format(parMaskStr, "okpo", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "OKPO")));
            rowdata += string.Format(parMaskStr, "nm", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "NUM")));
            rowdata += string.Format(parMaskStr, "tp", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "TYPE")));
            rowdata += string.Format(parMaskStr, "kv", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "KV")));
            rowdata += string.Format(parMaskInt, "s", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "S")));
            rowdata += string.Format(parMaskStr, "sd", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "S_DOC")));
            string dat = (DataBinder.Eval(e.Row.DataItem, "BEGIN_DATE") == DBNull.Value) ? ("") : (Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "BEGIN_DATE")).ToString("dd/MM/yyyy"));
            rowdata += string.Format(parMaskStr, "bd", dat);
            dat = (DataBinder.Eval(e.Row.DataItem, "END_DATE") == DBNull.Value) ? ("") : (Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "END_DATE")).ToString("dd/MM/yyyy"));
            rowdata += string.Format(parMaskStr, "ed", dat);
            rowdata += string.Format(parMaskStr, "com", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "COMMENTS")));

            rowdata = rowdata.Substring(0, rowdata.Length - 1);
            rowdata += "}";
            e.Row.Attributes.Add("rd", rowdata);

            decimal fsum = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "F_SUM"));
            if (fsum <= 0)
                e.Row.Cells[0].Controls[1].Visible = false;

            decimal s = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "S"));
            decimal s_doc = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "S_DOC"));

            if (fsum >= s || CimManager.StrToNumber(lbLicenseTotalSum.Text) >= CimManager.StrToNumber(lbSumVK.Text) || s <= s_doc)
                e.Row.Cells[1].Controls[1].Visible = false;
        }
    }
    protected void gvLinkApes_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string parMaskStr = "\"{0}\":'{1}',";
            string parMaskInt = "\"{0}\":{1},";
            string rowdata = "{";
            rowdata += string.Format(parMaskInt, "bi", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BOUND_ID")));
            rowdata += string.Format(parMaskInt, "fs", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "F_SUM")));
            rowdata += string.Format(parMaskInt, "ti", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "TYPE_ID")));
            rowdata += string.Format(parMaskInt, "di", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "DIRECT")));
            rowdata += string.Format(parMaskInt, "svk", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "S_VK")));
            rowdata += string.Format(parMaskInt, "svp", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "S_VPL")));
            rowdata = rowdata.Substring(0, rowdata.Length - 1);
            rowdata += "}";
            e.Row.Attributes.Add("rd", rowdata);
            decimal fsum = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "F_SUM"));
            if (fsum <= 0)
                e.Row.Cells[0].Controls[1].Visible = false;

            decimal svk = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "S_VK"));
            if (svk >= CimManager.StrToNumber(lbApeZS_VK.Text))
                e.Row.Cells[1].Controls[1].Visible = false;
        }
    }
    protected void gvCimApes_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string parMaskStr = "\"{0}\":'{1}',";
            string parMaskInt = "\"{0}\":{1},";
            string rowdata = "{";
            rowdata += string.Format(parMaskInt, "ai", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "APE_ID")));
            rowdata += string.Format(parMaskStr, "nm", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "NUM")));
            rowdata += string.Format(parMaskStr, "rt", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "RATE")));
            rowdata += string.Format(parMaskStr, "kv", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "KV")));
            rowdata += string.Format(parMaskInt, "s", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "S")));
            rowdata += string.Format(parMaskStr, "kvk", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "KV_K")));
            rowdata += string.Format(parMaskInt, "svk", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "S_VK")));
            rowdata += string.Format(parMaskInt, "zsvk", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ZS_VK")));

            string dat = (DataBinder.Eval(e.Row.DataItem, "BEGIN_DATE") == DBNull.Value) ? ("") : (Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "BEGIN_DATE")).ToString("dd/MM/yyyy"));
            rowdata += string.Format(parMaskStr, "bd", dat);
            dat = (DataBinder.Eval(e.Row.DataItem, "END_DATE") == DBNull.Value) ? ("") : (Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "END_DATE")).ToString("dd/MM/yyyy"));
            rowdata += string.Format(parMaskStr, "ed", dat);
            rowdata += string.Format(parMaskStr, "com", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "COMMENTS")));

            rowdata = rowdata.Substring(0, rowdata.Length - 1);
            rowdata += "}";
            e.Row.Attributes.Add("rd", rowdata);

            decimal fsum = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "F_SUM"));
            if (fsum <= 0 || Convert.ToDecimal(Request["bound_id"]) < 0)
                e.Row.Cells[0].Controls[1].Visible = false;

            decimal s = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "S"));
            if (fsum >= s)
                e.Row.Cells[1].Controls[1].Visible = false;

            if (CimManager.StrToNumber(lbApeTotalSum.Text) > 0)
                e.Row.Cells[1].Controls[1].Visible = false;
        }
    }

    protected void btExpImpPay_OnClick(object sender, EventArgs e)
    {
        FrxParameters pars = new FrxParameters();
        string fileFrx = string.Empty;
        Contract contr = new Contract(Convert.ToDecimal(Request["CONTR_ID"]));
        string parPrefix = string.Empty;
        if (Request["mode"] == "0")
        {
            parPrefix = "pl";
            if (contr.ContrType == 1)
                fileFrx = "xls_md_Imp_link.frx";
            else
                fileFrx = "xls_md_Exp_link.frx";
        }
        else if (Request["mode"] == "1")
        {
            parPrefix = "md";
            if (contr.ContrType == 1)
                fileFrx = "xls_pl_Imp_link.frx";
            else
                fileFrx = "xls_pl_Exp_link.frx";
        }

        string templatePath = Path.Combine(Server.MapPath("/barsroot/cim/tools/templates"), fileFrx);
        pars.Add(new FrxParameter("p_" + parPrefix + "_type", TypeCode.String, Request["type_id"]));
        pars.Add(new FrxParameter("p_" + parPrefix + "_bound_id", TypeCode.String, Request["bound_id"]));
        FrxDoc doc = new FrxDoc(templatePath, pars, null);
        string tmpFileName = doc.Export(FrxExportTypes.Excel2007);
        string fileName = string.Format("report_links{0}{1}", Request["contr_id"], Path.GetExtension(tmpFileName));
        Response.ClearContent();
        Response.ClearHeaders();
        Response.Charset = "windows-1251";
        Response.AppendHeader("content-disposition", "attachment;filename=" + fileName);
        Response.ContentType = "application/octet-stream";
        Response.WriteFile(tmpFileName, true);
        Response.Flush();
        Response.End();
    }
}