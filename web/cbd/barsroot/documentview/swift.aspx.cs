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

public partial class Swift : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        decimal Ref = Convert.ToDecimal(Request.Params.Get("ref"));

        //разбор свифт сообщения полностьюаналогичен сентурному
        decimal SWId = 0;
        string Tag = "";
        string Opt = "";
        string Val = "";
        string Seq = "";
        decimal SortN = 0;


        InitOraConnection(Context);
        try
        {
            SetRole(Resources.documentview.Global.AppRole);

            ClearParameters();
            SetParameters("pref", DB_TYPE.Decimal, Ref, DIRECTION.Input);
            SQL_Reader_Exec(@"  SELECT w.swref, w.tag, w.opt, w.value, w.seq, w.n 
					                FROM sw_operw w, sw_oper o 
					                WHERE o.swref = w.swref AND o.ref=:pref 
					                ORDER BY 5, 2, 3");

            if (SQL_Reader_Read())
            {
                decimal SWCurId = -1;
                do
                {
                    if ((string)SQL_Reader_GetValues()[0] != "") SWId = (decimal)SQL_Reader_GetValues()[0];
                    if ((string)SQL_Reader_GetValues()[1] != "") Tag = (string)SQL_Reader_GetValues()[1];
                    if ((string)SQL_Reader_GetValues()[2] != "") Opt = (string)SQL_Reader_GetValues()[2];
                    if ((string)SQL_Reader_GetValues()[3] != "") Val = (string)SQL_Reader_GetValues()[3];
                    if ((string)SQL_Reader_GetValues()[4] != "") Seq = (string)SQL_Reader_GetValues()[4];
                    if ((string)SQL_Reader_GetValues()[5] != "") SortN = (decimal)SQL_Reader_GetValues()[5];

                    if (SWCurId != SWId)
                    {
                        SWCurId = SWId;

                        string MT = "";
                        string Ind = "";
                        string Sender = "";
                        string SndrName = "";
                        string Receiver = "";
                        string RcvrName = "";

                        ClearParameters();
                        SetParameters("pSWCurId", DB_TYPE.Int64, SWCurId, DIRECTION.Input);
                        object[] res = this.SQL_SELECT_reader(@"SELECT j.mt, j.io_ind, 
								j.sender,  NVL(b1.name,'No data'), 
								j.receiver,NVL(b2.name,'No data')  
								FROM sw_journal j, sw_banks b1, sw_banks b2 
								WHERE j.swref = :pSWCurId    AND 
								b1.bic(+)  = j.sender  AND 
								b2.bic(+)  = j.receiver");

                        if (res != null)
                        {
                            if (res[0] != null) MT = Convert.ToString(res[0]);
                            if (res[1] != null) Ind = Convert.ToString(res[1]);
                            if (res[2] != null) Sender = Convert.ToString(res[2]);
                            if (res[3] != null) SndrName = Convert.ToString(res[3]);
                            if (res[4] != null) Receiver = Convert.ToString(res[4]);
                            if (res[5] != null) RcvrName = Convert.ToString(res[5]);

                            edMain.Text = "Message : MT" + MT + " (" + Ind + ")<br>";
                            edMain.Text += "Sender&nbsp&nbsp&nbsp : " + Sender + "<br>";
                            edMain.Text += "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp" + SndrName + "<br>";
                            edMain.Text += "Receiver : " + Receiver + "<br>";
                            edMain.Text += "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp" + RcvrName + "<br>";
                            edMain.Text += "Message Body" + "<br>";
                        }
                    }

                    for (int i = 0; i < (4 - Tag.Length - Opt.Length) * 2; i++) edMain.Text += "&nbsp";
                    edMain.Text += Tag + Opt + ": " + Val + "<br>";

                } while (SQL_Reader_Read());
                SQL_Reader_Close();
            }
            else
            {
                // нет даных свифт сообщения
            }
        }
        finally
        {
            DisposeOraConnection();
        }			
    }
}
