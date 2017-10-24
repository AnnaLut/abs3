using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Classes;
using barsroot.cim;
using FastReport.Data;

namespace cim.payments
{
    public partial class CimPaymentsUnboundDeclarations : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            dsCimTypes.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
            dsCimActTypes.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

            Master.SetPageTitle(Title, true);

            string payflag = (Request["payflag"] == null) ? ("2") : (Request["payflag"]);
            string contrType = Convert.ToString(Request["contr_type"]);
            string direct = contrType;
            if (contrType == "0")
                direct = "1";
            else
                direct = "0";
            string initParams = string.Format("CIM.setVariables('{0}','{1}','{2}','{3}','{4}', '{5}');", gvVCimUnboundVmd.ClientID, Request["contr_id"], direct, payflag, DateTime.Now.ToString("yyyyMMdd"), Session[Constants.StateKeys.ParamsAutoFillAllowDate]);

            // Привязка 
            if (Request["contr_id"] != null)
            {
                Master.SetPageTitle(Title + " (для привязки по контракту #" + Request["contr_id"] + ", ОКПО - " + Request["okpo"] + ")", true);
                cblTypesDirect.Enabled = false;
                if (contrType == "0")
                    cblTypesDirect.SelectedValue = "1";
                else if (contrType == "1")
                    cblTypesDirect.SelectedValue = "0";
                dvBack.Visible = true;
                pnAutoBind.Visible = false;
                pnAddFilter.Visible = true;
            }
            else
            {
                if (!IsPostBack && Session["cim_decl_type"] != null)
                    cblTypesDirect.SelectedValue = Convert.ToString(Session["cim_decl_type"]);

                DateTime bdate = DateTime.Now;
                if (Session[Constants.StateKeys.BankDate] != null)
                    bdate = (DateTime)Session[Constants.StateKeys.BankDate];

                tbABindFinish.Value = bdate.ToString("dd/MM/yyyy");
                tbABindStart.Value = bdate.AddDays(-30).ToString("dd/MM/yyyy");
            }

            Master.AddScript("/barsroot/cim/payments/scripts/cim_declarations.js");
            Master.AddInitScript(initParams);
        }

        protected void gvVCimUnboundVmd_PreRender(object sender, EventArgs e)
        {
            odsVCimUnboundVmd.SelectParameters["CUST_OKPO"].DefaultValue = Request["okpo"];
        }

        protected void gvVCimUnboundVmd_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                /*string parMaskStr = "\"{0}\":'{1}',";
                string parMaskInt = "\"{0}\":{1},";
                string docdata = "{";
                docdata += string.Format(parMaskInt, "rf", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "VMD_ID")));
                docdata += string.Format(parMaskInt, "vtp", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "VMD_TYPE")));
                docdata += string.Format(parMaskInt, "vkd", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "VMD_KIND")));
                docdata += string.Format(parMaskStr, "nm", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "NUM")));
                docdata += string.Format(parMaskInt, "kv", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "KV")));
                docdata += string.Format(parMaskInt, "ts", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "S")));
                docdata += string.Format(parMaskInt, "us", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "UNBOUND_S")));
                docdata += string.Format(parMaskInt, "di", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "DIRECT")));
                docdata += string.Format(parMaskStr, "cnm", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "NMK")));
                docdata += string.Format(parMaskStr, "cop", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "OKPO")));
                docdata += string.Format(parMaskStr, "bnm", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BENEF_NAME")).Replace("'", "\\'"));
                docdata += string.Format(parMaskStr, "bad", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BENEF_ADR")));
                docdata += string.Format(parMaskStr, "bcn", Convert.ToString(DataBinder.Eval(e.Row.DataItem, "COUNTRY")));
                string dat = (DataBinder.Eval(e.Row.DataItem, "ALLOW_DATE") == DBNull.Value) ? ("") : (Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "ALLOW_DATE")).ToString("dd/MM/yyyy"));
                docdata += string.Format(parMaskStr, "ald", dat);

                object obj = DataBinder.Eval(e.Row.DataItem, "DOC_DATE");
                dat = (obj == DBNull.Value || Convert.ToString(obj) == "") ? ("") : (Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "DOC_DATE")).ToString("dd/MM/yyyy"));
                docdata += string.Format(parMaskStr, "dd", dat);

                docdata = docdata.Substring(0, docdata.Length - 1);
                docdata += "}";*/

                var objJson = new Dictionary<string, object>
                {
                    {"rf", getJsonMapping(e.Row.DataItem, "VMD_ID")},
                    {"vtp", getJsonMapping(e.Row.DataItem, "VMD_TYPE")},
                    {"vkd", getJsonMapping(e.Row.DataItem, "VMD_KIND")},
                    {"nm", getJsonMapping(e.Row.DataItem, "NUM")},
                    {"kv", getJsonMapping(e.Row.DataItem, "KV")},
                    {"ts", getJsonMapping(e.Row.DataItem, "S")},
                    {"us", getJsonMapping(e.Row.DataItem, "UNBOUND_S")},
                    {"di", getJsonMapping(e.Row.DataItem, "DIRECT")},
                    {"cnm", getJsonMapping(e.Row.DataItem, "NMK")},
                    {"cop", getJsonMapping(e.Row.DataItem, "OKPO")},
                    {"bnm", getJsonMapping(e.Row.DataItem, "BENEF_NAME")},
                    {"bad", getJsonMapping(e.Row.DataItem, "BENEF_ADR")},
                    {"bcn", getJsonMapping(e.Row.DataItem, "COUNTRY")},
                    {"ald", getJsonMapping(e.Row.DataItem, "ALLOW_DATE")},
                    {"dd", getJsonMapping(e.Row.DataItem, "DOC_DATE")},
                    {"fn", getJsonMapping(e.Row.DataItem, "F_NAME")},
                    {"fd", getJsonMapping(e.Row.DataItem, "F_DATE")}
                };

                e.Row.Attributes.Add("rd", new JavaScriptSerializer().Serialize(objJson));

                decimal type = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "VMD_TYPE"));
                decimal s = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "S"));
                decimal us = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "UNBOUND_S"));
                string vmdid = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "VMD_ID"));
                if (type >= 1)
                    e.Row.ForeColor = Color.Blue;

                if (s - us <= 0)
                {
                    if (type >= 1)
                    {
                        e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Left;
                        e.Row.Cells[0].Text = "&nbsp;<img src='/Common/Images/default/16/cancel_blue.png' title='Видалити акт' onclick='curr_module.DeleteAct(" + vmdid + ")'></img>&nbsp;&nbsp;" + e.Row.Cells[0].Text;
                    }
                    else
                    {
                        e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Left;
                        e.Row.Cells[0].Text = "&nbsp;<img src='/Common/Images/default/16/cancel_blue.png' title='Сховати МД' onclick='curr_module.HideDecl(" + vmdid + ")'></img>&nbsp;&nbsp;" + e.Row.Cells[0].Text;
                    }
                }

                decimal totalSum = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "S"));
                decimal unboundSum = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "UNBOUND_S"));
                // еще не привязан 
                if (unboundSum == totalSum)
                {
                    e.Row.Cells[4].Font.Bold = true;
                    e.Row.Cells[4].ForeColor = Color.Maroon;
                }
                else if (unboundSum < totalSum && unboundSum > 0) // частично привязан
                {
                    e.Row.Cells[4].Font.Bold = true;
                    e.Row.Cells[4].ForeColor = Color.Green;
                }
                else
                    e.Row.Cells[4].ForeColor = Color.Black;
            }
        }

        private object getJsonMapping(object dataItem, string sourceField)
        {
            var obj = DataBinder.Eval(dataItem, sourceField);
            if (obj is DateTime)
                obj = (obj == DBNull.Value || Convert.ToString(obj) == "") ? ("") : (Convert.ToDateTime(obj).ToString("dd/MM/yyyy"));

            return obj;
        }

        protected void cblTypesDirect_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["cim_decl_type"] = cblTypesDirect.SelectedValue;
            gvVCimUnboundVmd.DataBind();
        }

        #region Page Methods
        [WebMethod(EnableSession = true)]
        public static Contract PopulateContract(decimal? contrId)
        {
            Contract contractInfo = new Contract(contrId);
            return contractInfo;
        }
        [WebMethod(EnableSession = true)]
        public static ResultData CheckBind(Contract contract, BindClass bindInfo)
        {
            return contract.CheckBind(bindInfo);
        }

        [WebMethod(EnableSession = true)]
        public static decimal SaveDeclBind(Contract contract, BindClass bindInfo)
        {
            return contract.SaveDeclBind(bindInfo);
        }

        [WebMethod(EnableSession = true)]
        public static ResultData AutoBind(string dateStart, string dateFinish, string okpo)
        {
            CimManager cm = new CimManager(false);
            return cm.AutoBind(dateStart, dateFinish, okpo);
        }

        [WebMethod(EnableSession = true)]
        public static ResultData PrepareForSend(decimal vmdId, string okpo)
        {
            CimManager cm = new CimManager(false);
            return cm.PrepareSendDecl(vmdId, okpo);
        }

        [WebMethod(EnableSession = true)]
        public static ResultData SendToBank(decimal vmdId, BindClass bindInfo)
        {
            CimManager cm = new CimManager(false);
            return cm.SendToBank(vmdId, bindInfo);
        }

        [WebMethod(EnableSession = true)]
        public static void DeleteAct(string vmdId)
        {
            CimManager cm = new CimManager(false);
            cm.DeleteAct(vmdId);
        }

        [WebMethod(EnableSession = true)]
        public static void HideDecl(string vmdId)
        {
            CimManager cm = new CimManager(false);
            cm.HideDecl(vmdId);
        }

        #endregion

        protected void cbFilterByOkpo_OnCheckedChanged(object sender, EventArgs e)
        {
            gvVCimUnboundVmd.DataBind();
        }
    }
}