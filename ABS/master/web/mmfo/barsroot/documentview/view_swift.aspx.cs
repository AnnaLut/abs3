using System;
using System.Data;

public partial class Swift : Bars.BarsPage
{
    protected System.Collections.Generic.List<decimal> refs_ = new System.Collections.Generic.List<decimal>();

    protected string GetFileName()
    {
        return string.Format("swdoc_{0}.txt", refs_.Count > 1 ? "all" : PrintSwref());
    }

    protected string PrintSwref()
    {
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        for (int i = 0; i < refs_.Count; i++)
        {
            sb.Append(refs_[i].ToString());
            if (i < refs_.Count - 1) { sb.Append(";"); }
        }
        return sb.ToString();
    }

    protected void Page_Load(object sender, EventArgs e)
    {        
        string swref = Request.Params.Get("swref");
        if (!string.IsNullOrEmpty(swref))
        {
            string[] swrefAllArr = swref.Split(';');
            foreach (string r in swrefAllArr)
            {
                try
                {
                    refs_.Add(Convert.ToDecimal(r));
                }
                catch (Exception ex) { }
            }
        }

        lbPageTitle.Text += PrintSwref();
        //разбор свифт сообщения полностьюаналогичен сентурному
        string Tag = "";
        string Opt = "";
        string Val = "";

        InitOraConnection(Context);
        try
        {
            SetRole(Resources.documentview.Global.AppRole);

            edMain.InnerText = "";

            for (int k = 0; k < refs_.Count; k++)
            {
                decimal Ref = refs_[k];

                ClearParameters();
                SetParameters("swpref", DB_TYPE.Decimal, Ref, DIRECTION.Input);
                SQL_Reader_Exec(@"SELECT                        j.mt,
								j.io_ind, 
								j.sender,  NVL(b1.name,'No data'), b1.office, 
								j.receiver,NVL(b2.name,'No data'), b2.office, j.swref, j.sti, j.uetr,
								case when j.cov is not null then to_char(j.mt)||j.cov else to_char(j.mt) end as mt_cov  
								FROM sw_journal j, sw_banks b1, sw_banks b2
								WHERE j.swref =:swpref and
								b1.bic(+)  = j.sender  AND 
								b2.bic(+)  = j.receiver");
                if (SQL_Reader_Read())
                {
                    decimal SWCurId = -1;
                    string MT = "";
		    string MT_COV = "";		
                    string Ind = "";
                    string Sender = "";
                    string SndrName = "";
                    string SndrAdr = "";
                    string Receiver = "";
                    string RcvrName = "";
                    string RcvrAdr = "";
                    string fldName = "";
					string fldSTI = "";
					string fldUETR = "";

                    if (refs_.Count > 1)
                    {
                        edMain.InnerText += Ref.ToString();
                        edMain.InnerText += Environment.NewLine;
                    }

                    do
                    {
                        var rows = SQL_Reader_GetValues();
                        MT = Convert.ToString(rows[0]);
                        Ind = Convert.ToString(rows[1]);
                        Sender = Convert.ToString(rows[2]);
                        SndrName = Convert.ToString(rows[3]);
                        SndrAdr = Convert.ToString(rows[4]);
                        Receiver = Convert.ToString(rows[5]);
                        RcvrName = Convert.ToString(rows[6]);
                        RcvrAdr = Convert.ToString(rows[7]);
                        SWCurId = Convert.ToDecimal(rows[8]);
			fldSTI  = Convert.ToString(rows[9]);
			fldUETR = Convert.ToString(rows[10]);
			MT_COV= Convert.ToString(rows[11]);	

                        edMain.InnerText += "------------------------------------------------------------" + Environment.NewLine;
                        edMain.InnerText += "Message : MT" + MT_COV + " (" + Ind + ")" + Environment.NewLine;
                        edMain.InnerText += "Sender  : " + Sender + Environment.NewLine;
                        edMain.InnerText += "          " + SndrName + Environment.NewLine;
                        if (!string.IsNullOrEmpty(SndrAdr))
                            edMain.InnerText += "          " + SndrAdr + Environment.NewLine;
                        edMain.InnerText += "Receiver: " + Receiver + Environment.NewLine;
                        edMain.InnerText += "          " + RcvrName + Environment.NewLine;
                        if (!string.IsNullOrEmpty(RcvrAdr))
                            edMain.InnerText += "          " + RcvrAdr + Environment.NewLine;
					
					    if (!string.IsNullOrEmpty(fldSTI))
                            edMain.InnerText += "STI     : " + fldSTI + Environment.NewLine;
						if (!string.IsNullOrEmpty(fldUETR))
                            edMain.InnerText += "UETR    : " + fldUETR + Environment.NewLine;
						
                        edMain.InnerText += "------------------------------------------------------------" + Environment.NewLine;
                        edMain.InnerText += "Message Body" + Environment.NewLine;

                        ClearParameters();
                        SetParameters("nMt", DB_TYPE.Decimal, MT, DIRECTION.Input);
                        SetParameters("nMt", DB_TYPE.Decimal, MT, DIRECTION.Input);
                        SetParameters("pSWCurId", DB_TYPE.Int64, SWCurId, DIRECTION.Input);
                        DataTable dt = SQL_SELECT_dataset(@"
                                    SELECT w.swref, w.tag, w.opt, w.seq, w.n, 
                                     substr(bars_swift.get_message_fieldname(:nMt, w.seq, w.tag, w.opt), 1, 100) fldName,
                                     bars_swift.get_message_fieldvalue(:nMt, w.seq, w.tag, w.opt, w.value) value 
					                FROM sw_operw w 
					                WHERE w.swref=:pSWCurId 
					                ORDER BY 5, 2, 3").Tables[0];

                        for (int j = 0; j < dt.Rows.Count; j++)
                        {
                            Tag = Convert.ToString(dt.Rows[j]["tag"]);
                            Opt = Convert.ToString(dt.Rows[j]["opt"]).Trim();
                            Val = Convert.ToString(dt.Rows[j]["value"]);
                            Val = Convert.ToString(dt.Rows[j]["value"]);
                            fldName = Convert.ToString(dt.Rows[j]["fldName"]);
                            for (int i = 0; i < (4 - Tag.Length - Opt.Length); i++) edMain.InnerText += " ";
                            edMain.InnerText += Tag + Opt + ": " + fldName + Environment.NewLine + " ".PadRight(6) + Val.Replace("\n", "\n      ") + Environment.NewLine;
                        }
                        edMain.InnerText += Environment.NewLine;

                    } while (SQL_Reader_Read());
                    SQL_Reader_Close();

                    // add swref-s separator
                    if (k < refs_.Count - 1)
                    {
                        edMain.InnerText += "************************************************************" + Environment.NewLine;
                        edMain.InnerText += Environment.NewLine;
                    }
                }
                else
                {
                    // нет даных свифт сообщения
                }
            }
            
        }
        finally
        {
            DisposeOraConnection();
        }
    }
    protected void btExport_Click(object sender, EventArgs e)
    {
        Response.ClearContent();
        Response.ClearHeaders();
        Response.Charset = "windows-1251";
        Response.ContentEncoding = System.Text.Encoding.GetEncoding("windows-1251");
        Response.AppendHeader("content-disposition", "attachment;filename=" + GetFileName());
        Response.ContentType = "text/html";
        Response.Write(edMain.InnerText.Replace("&nbsp", "").Replace("<br>", "\n"));
        Response.Flush();
        Response.End();
    }
}
