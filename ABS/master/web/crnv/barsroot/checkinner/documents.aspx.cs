using System;
using System.Data;
using System.Web.UI.HtmlControls;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars;
using Bars.Classes;

namespace BarsWeb.CheckInner
{
    public partial class Documents : BarsPage
    {
        protected HtmlTableCell lb_DocsNumb;
        protected HtmlInputHidden hid_VISASIGNT;

        protected HtmlInputHidden __FLAGS;
        protected HtmlInputHidden __VOBCONFIRM;

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
                                                where par = 'CHKDOCDG') as chkdocdg
                                        from banks
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

                        ClientScript.RegisterClientScriptBlock(this.GetType(), "chkdocdg_init", String.Format("ShowDocDialog = {0}; ", rdr1["chkdocdg"]), true);
                    }
                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
            }
            else throw new Exception(Resources.checkinner.LocalRes.text_StraVuzvanaBezNeobhParam);

            lb_GroupName.InnerText = GroupName;
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
    }
}
