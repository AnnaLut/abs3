using System;
using Bars.Classes;
using System.Collections;
using System.Globalization;
using Oracle.DataAccess.Types;


public partial class tools_int_statement : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            if (Request.Params.Get("acc") != null)
            {
                FillData();
            }
            else
                throw new Bars.Exception.BarsException("Не задано номер рахунку (acc)!");

        }
    }

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);

        // Наполнение грида
        sdsMain.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
    }

    private void FillData()
    {
        decimal acc = Convert.ToDecimal(Request["acc"]);
        InitOraConnection();
        try
        {

            SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
            SQL_Reader_Exec(@"SELECT a.ostc, a.nms, acrn.FPROCN(a.acc,0,bankdate), a.kv, a.nls, n.nms, n.nls, n.kv, to_char(i.acr_dat,'dd/MM/yyyy'), -(n.ostc)/100, round(i.S,6), i.basey, y.name, to_char(bankdate, 'dd/MM/yyyy'), to_char(last_day(bankdate), 'dd/MM/yyyy')
                             FROM SALDO a , accounts n, int_accn i, basey y
                             WHERE i.basey = y.basey AND a.acc=:acc
                                   and i.acc=a.acc and n.acc=i.acra and i.id=0 ");
            if (SQL_Reader_Read())
            {
                CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                cinfo.DateTimeFormat.DateSeparator = "/";
                NumberFormatInfo nf = new NumberFormatInfo();
                nf.NumberDecimalSeparator = ".";
                nf.NumberGroupSeparator = " ";

                ArrayList reader = SQL_Reader_GetValues();
                decimal ostM = Convert.ToDecimal(reader[0], nf); //:OST_SS,
                string nmsM = Convert.ToString(reader[1]);//:NMS_SS, 
                string ir = Convert.ToString(reader[2]);//:IR, 
                string kvM = Convert.ToString(reader[3]);//:KV_SS, 
                string nlsM = Convert.ToString(reader[4]);//:NLS_SS,
                string nmsI = Convert.ToString(reader[5]);//:NLS_SN,
                string nlsI = Convert.ToString(reader[6]);//:NLS_SN,
                string kvI = Convert.ToString(reader[7]);//:KV_SN,
                string acrDat = Convert.ToString(reader[8]);//:ACR_DAT,
                decimal ostI = Convert.ToDecimal(reader[9], nf);//:OST_SN0, 
                string remi = Convert.ToString(reader[10]);//:nRemi,
                string basey = Convert.ToString(reader[11]);//:nBasey, 
                string baseyТame = Convert.ToString(reader[12]);//:Basey_Name
                string bankDate = Convert.ToString(reader[13]);//:Basey_Name
                string lastDate = Convert.ToString(reader[14]);//:Basey_Name

                tbMainNms.Text = nmsM;
                tbMainNls.Text = nlsM;
                tbMainKv.Text = kvM;
                tbMainIntRate.Text = ir;
                tbMainIntYear.Text = baseyТame;
                tbIntNms.Text = nmsI;
                tbIntNls.Text = nlsI;
                tbIntKv.Text = kvI;


                tbAcrDat.Date = DateTime.Parse(acrDat, cinfo);
                tbDat2.Date = DateTime.Parse(bankDate, cinfo);
                tbDat1.Date = tbDat2.Date.AddDays(-1);
                if (!IsPostBack)
                    tbDat3.Date = DateTime.Parse(lastDate, cinfo);

                neOSTI.Value = Convert.ToDecimal(ostI);

                decimal sum = neSum.Value;
                decimal nInt1 = 0, nInt2 = 0, nInt3 = 0, nInt = 0;
                tbCount1.Text = "0";
                neDOS1.Value = 0;
                neOST1.Value = 0;

                //-----------
                if (tbAcrDat.Date >= tbDat1.Date)
                {
                    tbCount1.Visible = false;
                    neDOS1.Visible = false;
                    neOST1.Visible = false;
                    tbDat1.Visible = false;
                    neOST1.Value = neOSTI.Value;
                }
                else
                {
                    tbCount1.Visible = true;
                    neDOS1.Visible = true;
                    neOST1.Visible = true;
                    tbDat1.Visible = true;
                }

                ostM = ostM - (sum * 100);

                if (tbAcrDat.Date >= tbDat2.Date)
                {
                    tbCount2.Text = "0";
                    neDOS2.Value = 0;
                    neOST2.Value = 0;
                }
                else
                {
                    if (tbAcrDat.Date < tbDat1.Date)
                    {
                        tbCount1.Text = ((tbDat2.Date - tbAcrDat.Date).Days - 1).ToString();
                        SetParameters("dDat1", DB_TYPE.Date, tbAcrDat.Date.AddDays(1), DIRECTION.Input);
                        SetParameters("dDat2", DB_TYPE.Date, tbDat1.Date, DIRECTION.Input);
                        SetParameters("int", DB_TYPE.Decimal, 0, DIRECTION.Output);
                        SQL_NONQUERY("begin acrn.p_int(:acc,0,:dDat1,:dDat2,:int,NULL,1); end;");
                        nInt1 = Convert.ToDecimal(GetParameter("int").ToString().Replace(",","."), nf);
                        neDOS1.Value = (-1) * nInt1 / 100;
                        neOST1.Value = ostI + neDOS1.Value;
                    }
                    ClearParameters();
                    SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
                    SQL_NONQUERY("update int_accn set s=0 where acc=:acc and id=0");

                    SetParameters("dDat1", DB_TYPE.Date, tbDat2.Date, DIRECTION.Input);
                    SetParameters("dDat2", DB_TYPE.Date, tbDat2.Date, DIRECTION.Input);
                    SetParameters("int", DB_TYPE.Decimal, 0, DIRECTION.Output);
                    SetParameters("ost", DB_TYPE.Decimal, ostM, DIRECTION.Input);
                    SQL_NONQUERY("begin acrn.p_int(:acc,0,:dDat1,:dDat2,:int,:ost,1); end;");
                    nInt2 = Convert.ToDecimal(GetParameter("int").ToString().Replace(",", "."), nf);
                    nInt = nInt1 + nInt2;
                    neDOS2.Value = (-1) * nInt / 100;
                    neOST2.Value = ostI + neDOS2.Value;
                    tbCount2.Text = "1";
                }
                if (tbAcrDat.Date >= tbDat3.Date)
                {
                    tbCount3.Text = "0";
                    neDOS3.Value = 0;
                    neOST3.Value = ostI;
                }
                else if (tbDat2.Date == tbDat3.Date)
                {
                    tbCount3.Text = "0";
                    neDOS3.Value = neDOS2.Value;
                    neOST3.Value = neOST2.Value;
                }
                else
                {
                    ClearParameters();
                    SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
                    SetParameters("dDat1", DB_TYPE.Date, tbDat2.Date, DIRECTION.Input);
                    SetParameters("dDat2", DB_TYPE.Date, tbDat3.Date, DIRECTION.Input);
                    SetParameters("int", DB_TYPE.Decimal, 0, DIRECTION.Output);
                    SetParameters("ost", DB_TYPE.Decimal, ostM, DIRECTION.Input);
                    SQL_NONQUERY("begin acrn.p_int(:acc,0,:dDat1,:dDat2,:int,:ost,1); end;");
                    nInt3 = Convert.ToDecimal(GetParameter("int").ToString().Replace(",", "."), nf);
                    nInt = nInt1 + nInt3;
                    neDOS3.Value = (-1) * nInt / 100;
                    neOST3.Value = ostI + neDOS3.Value;
                    tbCount3.Text = ((tbDat3.Date - tbDat2.Date).Days + 1).ToString();
                }

                sdsMain.SelectParameters.Add("acc", TypeCode.Decimal, Convert.ToString(acc));
                sdsMain.SelectParameters.Add("acrdat", TypeCode.DateTime, acrDat);

                sdsMain.SelectCommand = "SELECT fdat, -ost/100 ost FROM sal WHERE  acc=:acc and fdat>=:acrdat ORDER BY fdat desc";

                sdsMain.DataBind();
            }
            else
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "winclose", "alert('Рахунок не доступний для розрахунку'); window.close();", true);
            }

        }
        finally
        {
            DisposeOraConnection();
        }
    }
    protected void btRefresh_Click(object sender, EventArgs e)
    {
        FillData();
    }
}