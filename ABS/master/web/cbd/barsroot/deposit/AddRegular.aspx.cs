using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Oracle;
using Oracle.DataAccess.Client;

public partial class deposit_AddRegular : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        var rnkParam = HttpContext.Current.Request.Params.GetValues("RNK");
        if (rnkParam != null)
        {
            var rnk = Convert.ToDecimal(rnkParam.GetValue(0));
            IOraConnection conn = (IOraConnection) this.Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection();
            try
            {
                var command = connect.CreateCommand();
                command.CommandText = "select * from customer where rnk = :p_rnk";
                command.Parameters.Add("p_rnk", OracleDbType.Decimal, Convert.ToDecimal(rnk), ParameterDirection.Input);
                var reader = command.ExecuteReader();

                if (reader.Read())
                {
                    NMK.Value = Convert.ToString(reader["NMK"]) + " (" + Convert.ToString(reader["OKPO"]) + ")";
                    RNK.Value = Convert.ToString(reader["RNK"]);
                    RNKtext.Value = Convert.ToString(reader["RNK"]);

                    NdSearch(rnk, connect);
                    GridFill(rnk, connect);
                    regPrForCurentCust.Style.Add("display", "block");

                }
                else
                {
                    regPrForCurentCust.Style.Add("display", "none");
                }
            }
            finally
            {
                connect.Close();
                connect.Dispose();
            }


        }
    }
    protected void NdSearch(Decimal rnk,OracleConnection connect)
    {
        var command = connect.CreateCommand();
        command.CommandText = @"select c.nd, concatstr(A.NLS) as NLS, a.kv, c.sdate, c.cc_id
								  from cc_deal c, nd_acc ca, accounts a
								 where ca.nd = c.nd
								   and ca.acc = a.acc
								   and c.rnk = :p_rnk
								   and c.sos not in (14, 15)
								   and (a.tip in ('SS ', 'SG ') or a.nbs in('2620','2625'))
								 group by c.nd, a.kv, c.sdate, c.cc_id";

        command.Parameters.Add("p_rnk", OracleDbType.Decimal, Convert.ToDecimal(rnk), ParameterDirection.Input);

        NdList.Items.Clear();

        var ndListParam = HttpContext.Current.Request.Params.GetValues("NdList");
        decimal nd = 0;
        if (ndListParam != null)
        {
            nd = Convert.ToDecimal(ndListParam.GetValue(0));
        }

        var reader = command.ExecuteReader();
        decimal selectedNd;
        var count = 0;
        if (reader.HasRows)
        {
            while (reader.Read())
            {
                var readerNd = Convert.ToDecimal(reader["ND"]);
                NdList.Items.Add(new ListItem()
                {
                    Selected = (nd == readerNd),
                    Value = Convert.ToString(reader["ND"]),
                    Text =
                        "№ " + Convert.ToString(reader["cc_id"]) + " Рахунки(SS, SG) " + Convert.ToString(reader["NLS"]) +
                        " /Валюта/ " + Convert.ToString(reader["kv"]),
                });
                count ++;
            }

            AcctInit(rnk, Convert.ToDecimal(NdList.Value ?? NdList.Items[0].Value), connect);
        }

    }
    protected void AcctInit(decimal rnk, decimal nd, OracleConnection connect)
    {
        var command = connect.CreateCommand();
        command.CommandText = @"select *
								  from (select a.nls, a.kv 
										  from cc_deal c, nd_acc ca, accounts a
										 where ca.nd = c.nd
										   and ca.acc = a.acc
										   and c.rnk = :rnk
										   and c.nd = :p_nd
										   and ( a.nbs in ('2620','2625') or a.tip = 'SG ')
										 order by a.acc desc)
								 where rownum = 1";

        command.Parameters.Add("p_rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input);
        command.Parameters.Add("p_nd", OracleDbType.Decimal, nd, ParameterDirection.Input);

        var reader = command.ExecuteReader();
        if (reader.Read())
        {
            NLS.Value = Convert.ToString(reader["NLS"]);
            NLStext.Value = Convert.ToString(reader["NLS"]);
            CodeVal.Value = Convert.ToString(reader["KV"]);
            NLSblock.Attributes.Add("class", "");
            NLSblockErrorText.InnerText = "";
            addRegPlButtonBlock.Style.Add("display", "block");
        }
        else
        {
            NLS.Value = "";
            NLStext.Value = "";
            NLSblock.Attributes.Add("class", "k-block k-error-colored");
            NLSblockErrorText.InnerText = "Не знайдено рахунок 2620";
            addRegPlButtonBlock.Style.Add("display", "none");
        }
        
    }
    protected void GridFill(Decimal rnk, OracleConnection connect)
    {
        DataSet dsRegular = new DataSet();
        OracleCommand command = connect.CreateCommand();

        command.Connection = connect;
        // Завантажуємо всі договора про регулярні платежі в наявності по клієнту        
        command.CommandText = @"SELECT 
                                    distinct SD.ORD, 
                                    F.NAME FREQ, 
                                    TO_CHAR(SD.DAT1,'dd/mm/rr') DAT1,
                                    TO_CHAR(SD.DAT2,'dd/mm/rr') DAT2 ,
                                    SD.NLSA, 
                                    SD.NLSB,
                                    decode(
                                        nvl(TRIM(TRANSLATE(SD.FSUM, ' +-.0123456789', ' ')),' '), ' ',to_char( to_number(SD.FSUM)/100,'9999999999999990D00'),'Формула'
                                        ) as FSUM,
                                    SD.NAZN
                                FROM 
                                    BARS.STO_LST SA,
                                    BARS.STO_DET SD, 
                                    FREQ F
                                Where 
                                    SD.IDS = SA.IDS
                                    and SA.RNK = :p_rnk 
                                    and F.FREQ = SD.FREQ 
                                order by 1";

        command.Parameters.Add("p_rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input);

        OracleDataAdapter adapterSearchAgreement = new OracleDataAdapter();
        adapterSearchAgreement.SelectCommand = command;
        adapterSearchAgreement.Fill(dsRegular);

        gridRegular.DataSource = dsRegular;
        gridRegular.DataBind();

        //gridRegular.HeaderStyle.BackColor = Color.WhiteSmoke;
        //gridRegular.HeaderStyle.Font.Bold = true;
        //gridRegular.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
    }
}