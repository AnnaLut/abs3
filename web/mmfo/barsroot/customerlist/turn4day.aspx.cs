using System;
using System.Collections;
using Bars.Classes;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class customerlist_turn4day : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
       

        if (!IsPostBack)
        {
            tbDat1.Value = DateTime.Now;
            tbDat2.Value = DateTime.Now;

            try
            {
                InitOraConnection();
                ClearParameters();
                //in
                SetParameters("acc", DB_TYPE.Int64, Convert.ToInt64(Request["acc"]), DIRECTION.Input);
                SetParameters("dat1", DB_TYPE.Date, tbDat1.Value, DIRECTION.Input);
                SetParameters("acc", DB_TYPE.Int64, Convert.ToInt64(Request["acc"]), DIRECTION.Input);
                SetParameters("dat1", DB_TYPE.Date, tbDat1.Value, DIRECTION.Input);
                SetParameters("dat1", DB_TYPE.Date, tbDat1.Value, DIRECTION.Input);
                SetParameters("acc", DB_TYPE.Int64, Convert.ToInt64(Request["acc"]), DIRECTION.Input);
                SetParameters("dat1", DB_TYPE.Date, tbDat1.Value, DIRECTION.Input);
                SetParameters("dat1", DB_TYPE.Date, tbDat1.Value, DIRECTION.Input);
                //dos
                SetParameters("acc", DB_TYPE.Int64, Convert.ToInt64(Request["acc"]), DIRECTION.Input);
                SetParameters("dat1", DB_TYPE.Date, tbDat1.Value, DIRECTION.Input);
                SetParameters("dat2", DB_TYPE.Date, tbDat2.Value, DIRECTION.Input);
                //kos
                SetParameters("acc", DB_TYPE.Int64, Convert.ToInt64(Request["acc"]), DIRECTION.Input);
                SetParameters("dat1", DB_TYPE.Date, tbDat1.Value, DIRECTION.Input);
                SetParameters("dat2", DB_TYPE.Date, tbDat2.Value, DIRECTION.Input);
                //Out
                SetParameters("acc", DB_TYPE.Int64, Convert.ToInt64(Request["acc"]), DIRECTION.Input);
                SetParameters("dat2", DB_TYPE.Date, tbDat2.Value, DIRECTION.Input);
                SQL_Reader_Exec(@"SELECT to_char((fost_h(:acc,:dat1) + fdos(:acc,:dat1,:dat1) - fkos(:acc,:Dat1,:Dat1))/100,'fm99999999999990.00') in_turn,
                                to_char(fdos(:acc,:Dat1,:Dat2)/100,'fm99999999999990.00') dos, 
                                to_char(fkos(:acc,:Dat1,:Dat2)/100,'fm9999999990.00') kos, 
                                to_char(fost_h(:acc,:Dat2)/100,'fm99999999999990.00') out_turn FROM dual");
                if (SQL_Reader_Read())
                {
                    ArrayList reader = SQL_Reader_GetValues();

                    lbInTurn.Text = Convert.ToString(reader[0]);
                    lbDos.Text = Convert.ToString(reader[1]);
                    lbKos.Text = Convert.ToString(reader[2]);
                    lbOutTurn.Text = Convert.ToString(reader[3]);

                    if (Convert.ToDecimal(reader[0]) < 0)
                    {
                        lbInTurn.ForeColor = System.Drawing.Color.Red;
                    }
                    else if (Convert.ToDecimal(reader[0]) > 0)
                    {
                        lbInTurn.ForeColor = System.Drawing.Color.Blue;
                    }


                    if (Convert.ToDecimal(reader[1]) < 0)
                    {
                        lbDos.ForeColor = System.Drawing.Color.Red;
                    }
                    else if (Convert.ToDecimal(reader[1]) > 0)
                    {
                        lbDos.ForeColor = System.Drawing.Color.Blue;
                    }


                    if (Convert.ToDecimal(reader[2]) < 0)
                    {
                        lbKos.ForeColor = System.Drawing.Color.Red;
                    }
                    else if (Convert.ToDecimal(reader[2]) > 0)
                    {
                        lbKos.ForeColor = System.Drawing.Color.Blue;
                    }


                    if (Convert.ToDecimal(reader[3]) < 0)
                    {
                        lbOutTurn.ForeColor = System.Drawing.Color.Red;
                    }
                    else if (Convert.ToDecimal(reader[3]) > 0)
                    {
                        lbOutTurn.ForeColor = System.Drawing.Color.Blue;
                    }
                }
                dsMain.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
                String SelectCommand = @"SELECT o.tt, o.ref, case o.dk when 0 then  to_char(o.s/100,'fm99999999999990.00') else to_char(0,'fm99999999999990.00') end dt,
                                        case o.dk when 1 then  to_char(o.s/100,'fm99999999999990.00') else to_char(0,'fm99999999999990.00') end kt,
                                        -- decode(o.tt,p.tt,NVL(p.nazn,o.txt),o.txt) comm, o.fdat 
                                                    p.nazn, o.fdat 
                                                    FROM (SELECT o.REF, o.TT, o.DK, o.ACC, o.FDAT, o.S, o.SQ, o.TXT, o.STMT, o.SOS 
                                                           FROM opldok o, accounts a 
                                                          WHERE o.acc=a.acc AND o.acc=" + Convert.ToString(Request["acc"]) + @" AND o.sos=5
                                                            AND o.fdat BETWEEN to_date('" + tbDat1.Value + @"','dd.mm.yyyy HH24:MI:SS') AND to_date('" + tbDat2.Value + @"','dd.mm.yyyy HH24:MI:SS')
                                                          union all 
                                                         SELECT o.REF, o.TT, o.DK, a.ACCC, o.FDAT, o.S, o.SQ, o.TXT, o.STMT, o.SOS 
                                                           FROM opldok o, accounts a 
                                                          WHERE o.acc=a.acc AND a.accc is not null AND a.accc=" + Convert.ToString(Request["acc"]) + @" AND o.sos=5
                                                            AND o.fdat BETWEEN to_date('" + tbDat1.Value + @"','dd.mm.yyyy HH24:MI:SS') AND to_date('" + tbDat2.Value + @"','dd.mm.yyyy HH24:MI:SS')
                                                        ) o, oper p 
                                                  WHERE o.ref=p.ref AND o.fdat BETWEEN to_date('" + tbDat1.Value + @"','dd.mm.yyyy HH24:MI:SS') AND to_date('" + tbDat2.Value + @"','dd.mm.yyyy HH24:MI:SS') 
                                                  order by dt desc, kt asc, fdat";

                dsMain.SelectCommand = SelectCommand;


            }
            finally
            {
                DisposeOraConnection();
            }
        }
        else
        {
            try
            {
                dsMain.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
                String SelectCommand = @"SELECT o.tt, o.ref, case o.dk when 0 then  to_char(o.s/100, 'fm99999999999990.00') else to_char(0,'fm99999999999990.00') end dt,
                                        case o.dk when 1 then  to_char(o.s/100,'fm99999999999990.00') else to_char(0,'fm99999999999990.00') end kt,
                                        -- decode(o.tt,p.tt,NVL(p.nazn,o.txt),o.txt) comm, o.fdat 
                                                    p.nazn, o.fdat 
                                                    FROM (SELECT o.REF, o.TT, o.DK, o.ACC, o.FDAT, o.S, o.SQ, o.TXT, o.STMT, o.SOS 
                                                           FROM opldok o, accounts a 
                                                          WHERE o.acc=a.acc AND o.acc=" + Convert.ToString(Request["acc"]) + @" AND o.sos=5
                                                            AND o.fdat BETWEEN to_date('" + tbDat1.Value + @"','dd.mm.yyyy HH24:MI:SS') AND to_date('" + tbDat2.Value + @"','dd.mm.yyyy HH24:MI:SS')
                                                          union all 
                                                         SELECT o.REF, o.TT, o.DK, a.ACCC, o.FDAT, o.S, o.SQ, o.TXT, o.STMT, o.SOS 
                                                           FROM opldok o, accounts a 
                                                          WHERE o.acc=a.acc AND a.accc is not null AND a.accc=" + Convert.ToString(Request["acc"]) + @" AND o.sos=5
                                                            AND o.fdat BETWEEN to_date('" + tbDat1.Value + @"','dd.mm.yyyy HH24:MI:SS') AND to_date('" + tbDat2.Value + @"','dd.mm.yyyy HH24:MI:SS')
                                                        ) o, oper p 
                                                  WHERE o.ref=p.ref AND o.fdat BETWEEN to_date('" + tbDat1.Value + @"','dd.mm.yyyy HH24:MI:SS') AND to_date('" + tbDat2.Value + @"','dd.mm.yyyy HH24:MI:SS') 
                                                  order by dt desc, kt asc, fdat";

                dsMain.SelectCommand = SelectCommand;

              //  gvMain.DataBind();


            }
            finally
            {
                DisposeOraConnection();
            }

        }

        if (cb.Checked)
        {
            try
            {
                dsMainSos.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
                String SelectCommand = @"SELECT o.tt, o.ref, case o.dk when 0 then  to_char(o.s/100,'fm99999999999990.00') else to_char(0,'fm99999999999990.00') end dt,
                                    case o.dk when 1 then  to_char(o.s/100,'fm99999999999990.00') else to_char(0,'fm99999999999990.00') end kt,
                                        -- decode(o.tt,p.tt,NVL(p.nazn,o.txt),o.txt) comm, o.fdat 
                                                    p.nazn, o.fdat 
                                                                  FROM 
                                                        (SELECT /*+ ORDERED INDEX(o XAK_REF_OPLDOK)*/
                                                                o.REF, o.TT, o.DK, o.ACC, o.FDAT, o.S, o.SQ, o.TXT, o.STMT, o.SOS
                                                           FROM ref_que q, opldok o, accounts a
                                                          WHERE q.ref=o.ref AND o.acc=a.acc AND o.acc=" + Convert.ToInt64(Request["acc"]) + @"
                                                          union all
                                                         SELECT /*+ ORDERED INDEX(o XAK_REF_OPLDOK)*/
                                                                o.REF, o.TT, o.DK, a.ACCC, o.FDAT, o.S, o.SQ, o.TXT, o.STMT, o.SOS
                                                           FROM ref_que q, opldok o, accounts a
                                                          WHERE q.ref=o.ref AND o.acc=a.acc AND a.accc is not null AND a.accc=" + Convert.ToInt64(Request["acc"]) + @"
                                                        ) o, oper p 
                                                 WHERE o.ref = p.ref";

                dsMainSos.SelectCommand = SelectCommand;

                gvMainSos.DataBind();
            }
            finally
            {
                DisposeOraConnection();
            }
        }
        else
        {
            gvMainSos.DataBind();
        }


    }

    protected void btSearh_Click(object sender, EventArgs e)
    {

        try
        {
            InitOraConnection();
            ClearParameters();
            //in
            SetParameters("acc", DB_TYPE.Int64, Convert.ToInt64(Request["acc"]), DIRECTION.Input);
            SetParameters("dat1", DB_TYPE.Date, tbDat1.Value, DIRECTION.Input);
            SetParameters("acc", DB_TYPE.Int64, Convert.ToInt64(Request["acc"]), DIRECTION.Input);
            SetParameters("dat1", DB_TYPE.Date, tbDat1.Value, DIRECTION.Input);
            SetParameters("dat1", DB_TYPE.Date, tbDat1.Value, DIRECTION.Input);
            SetParameters("acc", DB_TYPE.Int64, Convert.ToInt64(Request["acc"]), DIRECTION.Input);
            SetParameters("dat1", DB_TYPE.Date, tbDat1.Value, DIRECTION.Input);
            SetParameters("dat1", DB_TYPE.Date, tbDat1.Value, DIRECTION.Input);
            //dos
            SetParameters("acc", DB_TYPE.Int64, Convert.ToInt64(Request["acc"]), DIRECTION.Input);
            SetParameters("dat1", DB_TYPE.Date, tbDat1.Value, DIRECTION.Input);
            SetParameters("dat2", DB_TYPE.Date, tbDat2.Value, DIRECTION.Input);
            //kos
            SetParameters("acc", DB_TYPE.Int64, Convert.ToInt64(Request["acc"]), DIRECTION.Input);
            SetParameters("dat1", DB_TYPE.Date, tbDat1.Value, DIRECTION.Input);
            SetParameters("dat2", DB_TYPE.Date, tbDat2.Value, DIRECTION.Input);
            //Out
            SetParameters("acc", DB_TYPE.Int64, Convert.ToInt64(Request["acc"]), DIRECTION.Input);
            SetParameters("dat2", DB_TYPE.Date, tbDat2.Value, DIRECTION.Input);
            SQL_Reader_Exec(@"SELECT to_char((fost_h(:acc,:dat1) + fdos(:acc,:dat1,:dat1) - fkos(:acc,:Dat1,:Dat1))/100,'fm99999999999990.00') in_turn,
                                to_char(fdos(:acc,:Dat1,:Dat2)/100,'fm99999999999990.00') dos, 
                                to_char(fkos(:acc,:Dat1,:Dat2)/100,'fm99999999999990.00') kos, 
                                to_char(fost_h(:acc,:Dat2)/100,'fm99999999999990.00') out_turn FROM dual");
            if (SQL_Reader_Read())
            {
                ArrayList reader = SQL_Reader_GetValues();

                lbInTurn.Text = Convert.ToString(reader[0]);
                lbDos.Text = Convert.ToString(reader[1]);
                lbKos.Text = Convert.ToString(reader[2]);
                lbOutTurn.Text = Convert.ToString(reader[3]);

                if (Convert.ToDecimal(reader[0]) < 0)
                {
                    lbInTurn.ForeColor = System.Drawing.Color.Red;
                }
                else if (Convert.ToDecimal(reader[0]) > 0)
                {
                    lbInTurn.ForeColor = System.Drawing.Color.Blue;
                }


                if (Convert.ToDecimal(reader[1]) < 0)
                {
                    lbDos.ForeColor = System.Drawing.Color.Red;
                }
                else if (Convert.ToDecimal(reader[1]) > 0)
                {
                    lbDos.ForeColor = System.Drawing.Color.Blue;
                }


                if (Convert.ToDecimal(reader[2]) < 0)
                {
                    lbKos.ForeColor = System.Drawing.Color.Red;
                }
                else if (Convert.ToDecimal(reader[2]) > 0)
                {
                    lbKos.ForeColor = System.Drawing.Color.Blue;
                }


                if (Convert.ToDecimal(reader[3]) < 0)
                {
                    lbOutTurn.ForeColor = System.Drawing.Color.Red;
                }
                else if (Convert.ToDecimal(reader[3]) > 0)
                {
                    lbOutTurn.ForeColor = System.Drawing.Color.Blue;
                }
            }

            dsMain.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
            String SelectCommand = @"SELECT o.tt, o.ref, case o.dk when 0 then  to_char(o.s/100,'fm99999999999990.00') else to_char(0,'fm99999999999990.00') end dt,
                                        case o.dk when 1 then  to_char(o.s/100,'fm99999999999990.00') else to_char(0,'fm99999999999990.00') end kt,
                                        -- decode(o.tt,p.tt,NVL(p.nazn,o.txt),o.txt) comm, o.fdat 
                                                    p.nazn, o.fdat 
                                                    FROM (SELECT o.REF, o.TT, o.DK, o.ACC, o.FDAT, o.S, o.SQ, o.TXT, o.STMT, o.SOS 
                                                           FROM opldok o, accounts a 
                                                          WHERE o.acc=a.acc AND o.acc=" + Convert.ToString(Request["acc"]) + @" AND o.sos=5
                                                            AND o.fdat BETWEEN to_date('" + tbDat1.Value + @"','dd.mm.yyyy HH24:MI:SS') AND to_date('" + tbDat2.Value + @"','dd.mm.yyyy HH24:MI:SS')
                                                          union all 
                                                         SELECT o.REF, o.TT, o.DK, a.ACCC, o.FDAT, o.S, o.SQ, o.TXT, o.STMT, o.SOS 
                                                           FROM opldok o, accounts a 
                                                          WHERE o.acc=a.acc AND a.accc is not null AND a.accc=" + Convert.ToString(Request["acc"]) + @" AND o.sos=5
                                                            AND o.fdat BETWEEN to_date('" + tbDat1.Value + @"','dd.mm.yyyy HH24:MI:SS') AND to_date('" + tbDat2.Value + @"','dd.mm.yyyy HH24:MI:SS')
                                                        ) o, oper p 
                                                  WHERE o.ref=p.ref AND o.fdat BETWEEN to_date('" + tbDat1.Value + @"','dd.mm.yyyy HH24:MI:SS') AND to_date('" + tbDat2.Value + @"','dd.mm.yyyy HH24:MI:SS') 
                                                  order by dt desc, kt asc, fdat";

            dsMain.SelectCommand = SelectCommand;

            gvMain.DataBind();


        }


        finally
        {
            SQL_Reader_Close();
            DisposeOraConnection();
        }


        

    }

    protected void cb_CheckedChanged(object sender, EventArgs e)
    {
        if (cb.Checked)
        {
            try
            {
                dsMainSos.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
                String SelectCommand = @"SELECT o.tt, o.ref, case o.dk when 0 then  to_char(o.s/100,'fm99999999999990.00') else to_char(0,'fm99999999999990.00') end dt,
                                    case o.dk when 1 then  to_char(o.s/100,'fm99999999999990.00') else to_char(0,'fm99999999999990.00') end kt,
                                        -- decode(o.tt,p.tt,NVL(p.nazn,o.txt),o.txt) comm, o.fdat 
                                                    p.nazn, o.fdat 
                                                                  FROM 
                                                        (SELECT /*+ ORDERED INDEX(o XAK_REF_OPLDOK)*/
                                                                o.REF, o.TT, o.DK, o.ACC, o.FDAT, o.S, o.SQ, o.TXT, o.STMT, o.SOS
                                                           FROM ref_que q, opldok o, accounts a
                                                          WHERE q.ref=o.ref AND o.acc=a.acc AND o.acc=" + Convert.ToInt64(Request["acc"]) + @"
                                                          union all
                                                         SELECT /*+ ORDERED INDEX(o XAK_REF_OPLDOK)*/
                                                                o.REF, o.TT, o.DK, a.ACCC, o.FDAT, o.S, o.SQ, o.TXT, o.STMT, o.SOS
                                                           FROM ref_que q, opldok o, accounts a
                                                          WHERE q.ref=o.ref AND o.acc=a.acc AND a.accc is not null AND a.accc=" + Convert.ToInt64(Request["acc"]) + @"
                                                        ) o, oper p 
                                                 WHERE o.ref = p.ref";

                dsMainSos.SelectCommand = SelectCommand;

                gvMainSos.DataBind();
            }
            finally
            {
                DisposeOraConnection();
            }
        }
        else
        {
            gvMainSos.DataBind();
        }
    }
}