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

public partial class checkinner_verifdoc : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            cbNlsA.Attributes["onclick"] = "hideColumn(this)";
            cbMfoB.Attributes["onclick"] = "hideColumn(this)";
            cbNlsB.Attributes["onclick"] = "hideColumn(this)";
            cbOkpoB.Attributes["onclick"] = "hideColumn(this)";
            hid_grpid.Value = Request.Params.Get("grpid").Trim();
            try
            {
                InitOraConnection();
                SetRole("wr_verifdoc");
				ArrayList reader = SQL_reader(@"SELECT to_char(web_utl.get_bankdate, 'yyyy/MM/dd hh:mm:ss') as BDATE, 
												MFO, 
												docsign.GetIdOper as IDOPER, 
												(SELECT nvl(min(to_char(val)),'') FROM PARAMS WHERE PAR = 'REGNCODE') as REGNCODE, 
												(SELECT nvl(min(to_number(val)),0) FROM PARAMS WHERE PAR = 'INTSIGN') as INTSIGN, 
												(SELECT nvl(min(to_number(val)),0) FROM PARAMS WHERE PAR = 'VISASIGN') as VISASIGN, 
												(SELECT nvl(min(to_char(val)),'') FROM PARAMS WHERE PAR = 'SIGNTYPE') as SIGNTYPE,
												(SELECT chk.get_SignLng FROM dual) as SIGNLNG,	
												(SELECT nvl(min(to_number(val)),0) FROM PARAMS WHERE PAR = 'SEPNUM') as SEPNUM, 
												(SELECT nvl(min(to_number(val)),0) FROM PARAMS WHERE PAR = 'VOB2SEP') as VOB2SEP, 
												(SELECT nvl(min(to_number(val)),0) FROM PARAMS WHERE PAR = 'W_SIGNCC') as SIGNCC,
												to_char(SYSDATE, 'yyyy/MM/dd hh:mm:ss') as SDATE  	
											    FROM BANKS WHERE MFO = (SELECT VAL FROM PARAMS WHERE PAR = 'MFO')");
				__BDATE.Value = Convert.ToString(reader[0]);
				__OURMFO.Value = Convert.ToString(reader[1]);
				__DOCKEY.Value = Convert.ToString(reader[2]);
                __REGNCODE.Value = Convert.ToString(reader[3]);
				__INTSIGN.Value = Convert.ToString(reader[4]);
				__VISASIGN.Value = Convert.ToString(reader[5]);
				__SIGNTYPE.Value = Convert.ToString(reader[6]);
				__SIGNLNG.Value = Convert.ToString(reader[7]);
				__SEPNUM.Value = Convert.ToString(reader[8]);
				__VOB2SEP.Value = Convert.ToString(reader[9]);
				__SIGNCC.Value = Convert.ToString(reader[10]);
				__SYSDATE.Value = Convert.ToString(reader[11]);
            }
            finally
            {
                DisposeOraConnection();
            }
        }

    }
}
