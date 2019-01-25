using System;
using System.Data;
using System.Web.UI.HtmlControls;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars;
using Bars.Classes;
using Bars.Oracle;
using BarsWeb.Models;

namespace BarsWeb.CheckInner
{
    public partial class Documents : BarsPage
    {
        protected HtmlTableCell lb_DocsNumb;
        protected HtmlInputHidden hid_VISASIGNT;

        protected HtmlInputHidden __FLAGS;
        protected HtmlInputHidden __VOBCONFIRM;
        protected Int32 IS_TELLER_BUTTON_VISIBLE = -1;

        protected void Page_Load(object sender, EventArgs e)
        {
            string GroupName = "";

            if (Request.Params.Get("type") != null && Request.Params.Get("grpid") != null)
            {
                hid_grpid.Value = Request.Params.Get("grpid").Trim();

                OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
                OracleCommand cmd = con.CreateCommand();
                try
                {
                    AppPars Params = new AppPars(Request.Params.Get("type"));
                    switch (Request.Params.Get("type"))
                    {
                        //-- самовиза 
                        case "0":
                            {
                                //-забираем функ возврат на одну визу
                                bt_OneStepBack.Visible = false;

                                cmd.Parameters.Clear();
                                cmd.CommandText = "select name, idchk from chklist where idchk = chk.get_selfvisa_grp_id";

                                OracleDataReader rdr = cmd.ExecuteReader();
                                if (rdr.Read())
                                {
                                    GroupName = Convert.ToString(rdr["name"]);
                                    hid_grpid.Value = Convert.ToString(rdr["idchk"]);
                                }

                                break;
                            }
                        //-- визирование всех документов
                        case "1":
                        //-- визирование документов отделения
                        case "2":
                        //-- (SWIFT) візи "71_Підбір НОСТРО" на документі за типом операції NOS після повного візування документу по операції D07
                        case "8":
                        //-- визирование документов своего и подчиненных отделений
                        case "4":
                            {
                                cmd.Parameters.Clear();
                                cmd.Parameters.Add("pgrpid", OracleDbType.Varchar2, Request.Params.Get("grpid").Trim(), ParameterDirection.Input);
                                cmd.CommandText = "select grpname from v_user_visa where grpid = :pgrpid";
                                GroupName = Convert.ToString(cmd.ExecuteScalar());

                                if (String.IsNullOrEmpty(GroupName))
                                    throw new Exception(Resources.checkinner.LocalRes.text_NedopustimyiKodGrupyVizirovania);

                                break;
                            }
                        //-- визирование кассовых документов
                        case "5":
                        //-- візування сховищних операцій
                        case "6":
                            {
                                cmd.Parameters.Clear();
                                cmd.Parameters.Add("pgrpid", OracleDbType.Varchar2, Request.Params.Get("grpid").Trim(), ParameterDirection.Input);
                                cmd.CommandText = "select name from chklist where idchk = :pgrpid";
                                GroupName = Convert.ToString(cmd.ExecuteScalar());

                                if (String.IsNullOrEmpty(GroupName))
                                    throw new Exception(Resources.checkinner.LocalRes.text_NedopustimyiKodGrupyVizirovania);

                                break;
                            }
                    }

                    var parSignMixedMode = Bars.Configuration.ConfigurationSettings.AppSettings["Crypto.SignMixedMode"];
                    __SIGN_MIXED_MODE.Value = parSignMixedMode;
                    if ("1" == parSignMixedMode)
                    {
                        var signVer = "1.0.2";
                        if (!ClientScript.IsClientScriptBlockRegistered("barsSigner"))
                            ClientScript.RegisterClientScriptBlock(Page.GetType(), "barsSigner", "<script language=\"javascript\" src=\"/barsroot/Scripts/crypto/barsCrypto.js?v" + signVer + "\"></script>");
                    }
                    cmd.Parameters.Clear();
                    cmd.CommandText = @"select to_char(web_utl.get_bankdate, 'yyyy/mm/dd hh:mm:ss') as bdate,
                                            mfo,
                                            docsign.getidoper as idoper,
                                            (select nvl(min(to_char(val)), '') from params where par = 'REGNCODE') as regncode,
                                            (select nvl(min(to_number(val)), 0) from params where par = 'INTSIGN') as intsign,
                                            (select nvl(min(to_number(val)), 0)
                                                from params
                                                where par = 'VISASIGN') as visasign,
                                            (select nvl(min(to_char(val)), '') from params where par = 'SIGNTYPE') as signtype,
                                            (select chk.get_signlng from dual) as signlng,
                                            (select nvl(min(to_number(val)), 0) from params where par = 'SEPNUM') as sepnum,
                                            (select nvl(min(to_number(val)), 0) from params where par = 'VOB2SEP') as vob2sep,
                                            (select nvl(min(to_number(val)), 0)
                                                from params
                                                where par = 'W_SIGNCC') as signcc,
                                            to_char(sysdate, 'yyyy/mm/dd hh:mm:ss') as sdate,
                                            (select nvl(min(to_number(val)), 0)
                                                from params
                                                where par = 'CHKDOCDG') as chkdocdg, "
                                            + ((parSignMixedMode == "1") ? ("docsign.get_user_sign_type") : ("null")) + " USER_SIGN_TYPE, "
                                            + ((parSignMixedMode == "1") ? ("docsign.get_user_keyid") : ("null")) + " USER_KEYID, "
                                            + "(select nvl(ssp,0) from banks where mfo=f_ourmfo) as SSP, "
                                            + "(select val from params where par='CRYPTO_USE_VEGA2') CRYPTO_USE_VEGA2, "
                                            + "(select val from params where par='CRYPTO_CA_KEY') CRYPTO_CA_KEY " +
                                        @"from banks
                                        where mfo = (select val from params where par = 'MFO')";

                    OracleDataReader rdr1 = cmd.ExecuteReader();
                    if (rdr1.Read())
                    {
                        __BDATE.Value = Convert.ToString(rdr1["bdate"]);
                        __OURMFO.Value = Convert.ToString(rdr1["mfo"]);
                        __DOCKEY.Value = Convert.ToString(rdr1["idoper"]);
                        __REGNCODE.Value = Convert.ToString(rdr1["regncode"]);
                        __INTSIGN.Value = Convert.ToString(rdr1["intsign"]);
                        __VISASIGN.Value = Convert.ToString(rdr1["visasign"]);
                        __SIGNTYPE.Value = Convert.ToString(rdr1["signtype"]);
                        __SIGNLNG.Value = Convert.ToString(rdr1["signlng"]);
                        __SEPNUM.Value = Convert.ToString(rdr1["sepnum"]);
                        __VOB2SEP.Value = Convert.ToString(rdr1["vob2sep"]);
                        __SIGNCC.Value = Convert.ToString(rdr1["signcc"]);
                        __SYSDATE.Value = Convert.ToString(rdr1["sdate"]);
                        __SYSDATE.Value = Convert.ToString(rdr1["sdate"]);
                        __USER_SIGN_TYPE.Value = Convert.ToString(rdr1["USER_SIGN_TYPE"]);
                        __USER_KEYID.Value = Convert.ToString(rdr1["USER_KEYID"]);
                        __SSP.Value = Convert.ToString(rdr1["SSP"]);
                        __CRYPTO_USE_VEGA2.Value = Convert.ToString(rdr1["CRYPTO_USE_VEGA2"]);
                        __CRYPTO_CA_KEY.Value = Convert.ToString(rdr1["CRYPTO_CA_KEY"]);

                        ClientScript.RegisterClientScriptBlock(this.GetType(), "chkdocdg_init", String.Format("ShowDocDialog = {0}; ", rdr1["chkdocdg"]), true);
                    }
                    else // запрет на визирование на уровне /
                        throw new Exception("Візування на рівні на найвищому рівні (/) неможливе. Представтесь потрібним відділенням");
                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
            }
            else throw new Exception(Resources.checkinner.LocalRes.text_StraVuzvanaBezNeobhParam);

            lb_GroupName.InnerText = GroupName;
            if (IfTellerActive())
                __ISTELLERACTIVE.Value = "1";
            else
            {
                __ISTELLERACTIVE.Value = "0";
                tellerProc.Visible = false;
            }
            if (IS_TELLER_BUTTON_VISIBLE == 0)
                tellerProc.Visible = false;

        }

        #region Web Form Designer generated code
        override protected void OnInit(EventArgs e)
        {
            //
            // CODEGEN: This call is required by the ASP.NET Web Form Designer.
            //
            InitializeComponent();
            base.OnInit(e);
        }

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {

        }
        #endregion

        private Boolean IfTellerActive()
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            TELLER_USER_PARAM TELLER_USER_PARAM = new TELLER_USER_PARAM();

            using (OracleConnection con = conn.GetUserConnection(Context))
            {
                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = conn.GetSetRoleCommand("WR_DOC_INPUT");
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = @"begin 
                            :hasTellerRole := bars.teller_tools.is_teller();
                            :isTellerOn := bars.teller_tools.get_teller();
                            :isTellerButtonVisible := bars.teller_tools.is_button_visible(:p_op_code);
                            end;";
                    cmd.Parameters.Add("hasTellerRole", OracleDbType.Int32, TELLER_USER_PARAM.HAS_TELLER_ROLE, ParameterDirection.Output);
                    cmd.Parameters.Add("IsTellerOn", OracleDbType.Int32, TELLER_USER_PARAM.IS_TELLER_ON, ParameterDirection.Output);
                    cmd.Parameters.Add("isTellerButtonVisible", OracleDbType.Int32, IS_TELLER_BUTTON_VISIBLE, ParameterDirection.Output);
                    cmd.Parameters.Add("p_op_code", OracleDbType.Varchar2, "", ParameterDirection.Input);
                    try
                    {
                        using (var reader = cmd.ExecuteReader())
                        {
                            OracleDecimal returnResult = (OracleDecimal)cmd.Parameters["hasTellerRole"].Value;
                            TELLER_USER_PARAM.HAS_TELLER_ROLE = (int)returnResult.Value;
                            OracleDecimal isTeller = (OracleDecimal)cmd.Parameters["isTellerOn"].Value;
                            TELLER_USER_PARAM.IS_TELLER_ON = (int)isTeller.Value;
                            OracleDecimal isButtonVisibleDec = (OracleDecimal)cmd.Parameters["isTellerButtonVisible"].Value;
                            IS_TELLER_BUTTON_VISIBLE = Convert.ToInt32(isButtonVisibleDec.Value);
                        }
                    }
                    catch (Exception e)
                    {
                        IS_TELLER_BUTTON_VISIBLE = 0;
                    }
                }
            }
            if (TELLER_USER_PARAM.HAS_TELLER_ROLE == 1 && TELLER_USER_PARAM.IS_TELLER_ON == 1)
                return true;
            return false;
        }

    }
}
