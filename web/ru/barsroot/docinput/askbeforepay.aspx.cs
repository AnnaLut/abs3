﻿using System;
using System.Data;
using System.Linq;
using Oracle.DataAccess.Client;
using Bars.Oracle;


namespace DocInput
{
    /// <summary>
    /// Summary description for AskBeforePay.
    /// </summary>
    public partial class AskBeforePay : Bars.BarsPage
    {
        private decimal _nSum;
        private decimal _nSumA;
        private decimal _nSumB;
        private int _nKv;
        private int _nKvA;
        private int _nKvB;
        private int _nTt;

        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (!this.IsPostBack)
            {
                // проверочка
                if (!(null != Request.Params["SumA"]
                    && null != Request.Params["SumB"]
                    && null != Request.Params["KvA"]
                    && null != Request.Params["KvB"]
                 || null != Request.Params["Sum"]
                    && null != Request.Params["Kv"]
                    ))
                    throw new Exception("Аргументы URL не содержат необходимых параметров.");
                if (null != Request.Params["Sum"])
                {
                    _nSum = decimal.Parse(Request.Params["Sum"]);
                    _nKv = int.Parse(Request.Params["Kv"]);
                    textSum.Text = ValueSpelledOut(_nSum, _nKv);
                }
                else
                {
                    _nSumA = decimal.Parse(Request.Params["SumA"]);
                    _nKvA = int.Parse(Request.Params["KvA"]);
                    _nSumB = decimal.Parse(Request.Params["SumB"]);
                    _nKvB = int.Parse(Request.Params["KvB"]);
                    textSum.Text = ValueSpelledOut(_nSumA, _nKvA)
                        + " за\n" + ValueSpelledOut(_nSumB, _nKvB);
                }

                if (Request.QueryString.Count > 4)
                {
                    checkWarning();
                }
            }
        }

        /// <summary>
        /// возвращает сумму прописью
        /// </summary>
        /// <returns></returns>
        private string ValueSpelledOut(decimal nSum, int nKv)
        {
            string strSum = "";
            IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
            OracleConnection con = icon.GetUserConnection(Context);
            try
            {
                OracleCommand cmd = con.CreateCommand();
                cmd.CommandText = icon.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();
                cmd.CommandText = "select f_sumpr(:nSum,:nKv,(select gender from tabval where kv=:nKv)) from dual";
                cmd.Parameters.Add("nSum", OracleDbType.Decimal, nSum, ParameterDirection.Input);
                cmd.Parameters.Add("nKv", OracleDbType.Decimal, nKv, ParameterDirection.Input);
                OracleDataReader rdr = cmd.ExecuteReader();
                rdr.Read();
                if (!rdr.IsDBNull(0))
                    strSum = rdr.GetOracleString(0).Value;
                rdr.Close();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            return strSum;
        }
        /// <summary>
        /// Проверка на блокировку счетов и допустимых остатков.
        /// </summary>
        private void checkWarning()
        {
            string warnMessage = string.Empty, warnMessage2 = string.Empty;
            IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
            OracleConnection con = icon.GetUserConnection();
            try
            {
                if (null != Request.Params["Sum"])
                {
                    _nSum = decimal.Parse(Request.Params["Sum"]);
                    _nKv = int.Parse(Request.Params["Kv"]);
                    _nKvA = _nKvB = _nKv;
                    _nSumA = _nSumB = _nSum;
                }
                else
                {
                    _nSumA = decimal.Parse(Request.Params["SumA"]);
                    _nKvA = int.Parse(Request.Params["KvA"]);
                    _nSumB = decimal.Parse(Request.Params["SumB"]);
                    _nKvB = int.Parse(Request.Params["KvB"]);
                }
                string Tt = Request.Params["tt"];
                string NlsA = Request.Params["nlsA"];
                string NlsB = Request.Params["nlsB"];
                string NmkA = Request.Params["nmkA"];
                string NmkB = Request.Params["nmkB"];
                int nDk = int.Parse(Request.Params["dk"]);
                int nFli = int.Parse(Request.Params["fli"]);
                int nFaktPlan = int.Parse(Request.Params["fPlan"]);
                decimal nOst, nOstb, nOstc, nOstx, nLim, nDelta;
                decimal nBlkk, nBlkd, nPap;

                nDelta = (nDk == 0) ? (_nSumA) : (_nSumA * (-1));

                OracleCommand cmd = con.CreateCommand();
                cmd.CommandText = icon.GetSetRoleCommand("WR_DOC_INPUT");
                cmd.ExecuteNonQuery();
                cmd.CommandText = "SELECT nvl(ostb,0), nvl(ostc, 0), nvl(ostx,0), nvl(lim, 0), nvl(pap,0), nvl(blkd,0), nvl(blkk,0) FROM accounts WHERE nls = :nls AND kv = :kv AND dazs IS NULL";
                cmd.Parameters.Add("nls", OracleDbType.Varchar2, NlsA, ParameterDirection.Input);
                cmd.Parameters.Add("kv", OracleDbType.Decimal, _nKvA, ParameterDirection.Input);
                OracleDataReader rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    nOstb = rdr.GetDecimal(0);
                    nOstc = rdr.GetDecimal(1);
                    nOstx = rdr.GetDecimal(2);
                    nLim = rdr.GetDecimal(3);
                    nPap = rdr.GetDecimal(4);
                    nBlkd = rdr.GetDecimal(5);
                    nBlkk = rdr.GetDecimal(6);
                    if (nFaktPlan == 1)
                        nOst = nOstc;
                    else
                        nOst = nOstb;

                    if (nDelta < 0 && nBlkd > 0)
                        warnMessage += Resources.docinput.GlobalResources.WarnBlockDeb + "\n";
                    else if (nDelta > 0 && nBlkk > 0)
                        warnMessage += Resources.docinput.GlobalResources.WarnBlockKred + "\n";

                    if (nPap == 1 && nDelta > 0 && nOst + nLim + nDelta > 0
                       ||
                       nPap == 2 && nDelta < 0 && nOst + nLim + nDelta < 0)
                        warnMessage += Resources.docinput.GlobalResources.WarnNoMoney + "\n";

                    if (nOstx != 0 && nPap == 1 && nDelta < 0 && nOst + nDelta - nOstx < 0
                       ||
                       nOstx != 0 && nPap == 2 && nDelta > 0 && nOst + nDelta - nOstx > 0)
                        warnMessage += Resources.docinput.GlobalResources.WarnToMuch + "\n";
                }
                warnMessage += WarnIfPublicPerson(NlsA, Tt, NmkA);
                if (!string.IsNullOrEmpty(warnMessage))
                    warnMessage = Resources.docinput.GlobalResources.WarnAcc + " " + NlsA + "(" + _nKvA + "):\n" + warnMessage;

                if (nFli == 1)
                {
                    nDelta = (nDk == 0) ? ((-1) * _nSumB) : (_nSumB);

                    cmd.Parameters["nls"].Value = NlsB;
                    cmd.Parameters["kv"].Value = _nKvB;

                    rdr = cmd.ExecuteReader();
                    if (rdr.Read())
                    {
                        nOstb = rdr.GetDecimal(0);
                        nOstc = rdr.GetDecimal(1);
                        nOstx = rdr.GetDecimal(2);
                        nLim = rdr.GetDecimal(3);
                        nPap = rdr.GetDecimal(4);
                        nBlkd = rdr.GetDecimal(5);
                        nBlkk = rdr.GetDecimal(6);
                        if (nFaktPlan == 1)
                            nOst = nOstc;
                        else
                            nOst = nOstb;

                        if (nDelta < 0 && nBlkd > 0)
                            warnMessage2 += Resources.docinput.GlobalResources.WarnBlockDeb + "\n";
                        else if (nDelta > 0 && nBlkk > 0)
                            warnMessage2 += Resources.docinput.GlobalResources.WarnBlockKred + "\n";

                        if (nPap == 1 && nDelta > 0 && nOst + nLim + nDelta > 0
                           ||
                           nPap == 2 && nDelta < 0 && nOst + nLim + nDelta < 0)
                            warnMessage2 += Resources.docinput.GlobalResources.WarnNoMoney + "\n";

                        if (nOstx != 0 && nPap == 1 && nDelta < 0 && nOst + nDelta - nOstx < 0
                           ||
                           nOstx != 0 && nPap == 2 && nDelta > 0 && nOst + nDelta - nOstx > 0)
                            warnMessage2 += Resources.docinput.GlobalResources.WarnToMuch + "\n";
                        if (!string.IsNullOrEmpty(warnMessage2))
                            warnMessage2 = Resources.docinput.GlobalResources.WarnAcc + " " + NlsB + "(" + _nKvB + "):\n" + warnMessage2;
                    }

                    warnMessage2 += WarnIfPublicPerson(NlsB, Tt, NmkB);
                }

                warnMessage += "\n\n" + warnMessage2;

                // код K060 != 99
                cmd.CommandText = "SELECT f_check_insider(:nlsa, :kva, :nlsb, :kvb, :dk) from dual";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("nlsa", OracleDbType.Varchar2, NlsA, ParameterDirection.Input);
                cmd.Parameters.Add("kva", OracleDbType.Decimal, _nKvA, ParameterDirection.Input);
                cmd.Parameters.Add("nlsb", OracleDbType.Varchar2, NlsB, ParameterDirection.Input);
                cmd.Parameters.Add("kvb", OracleDbType.Decimal, _nKvB, ParameterDirection.Input);
                cmd.Parameters.Add("dk", OracleDbType.Decimal, nDk, ParameterDirection.Input);
                string warnMessage3 = Convert.ToString(cmd.ExecuteScalar());

                if (!string.IsNullOrEmpty(warnMessage3))
                    warnMessage += "\n" + warnMessage3;
                //----

                rdr.Close();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            if (warnMessage.Length > 0)
            {
                lbWarning.Text = warnMessage;
                pnWarning.Visible = true;
            }
            else
                pnWarning.Visible = false;
        }

        /// <summary>
        /// Виводить інформаційне повідомлення 
        /// про збіг з переліком публічних діячів
        /// </summary>
        /// <param name="nls"></param>
        /// <param name="tt">Номер операції</param>
        /// <param name="nmk"></param>
        /// <returns></returns>
        private string WarnIfPublicPerson(string nls, string tt, string nmk)
        {
            var warnMessage = string.Empty;

            // COBUSUPABS-6070
            string[] publicAccounts = { "2620", "2625", "2630", "2635" };

            if (publicAccounts.Any(nls.StartsWith) && (tt == "027" && _nSumB >= 150000 || tt != "027"))
            {
                int flag;
                var icon = (IOraConnection)Context.Application["OracleConnectClass"];
                using (OracleConnection con = icon.GetUserConnection(Context))
                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = @"select finmon_is_public(:p_name, :p_rnk, 1) fl from dual";
                    cmd.Parameters.Add("p_name", OracleDbType.Varchar2, nmk, ParameterDirection.Input);
                    cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, null, ParameterDirection.Input);

                    if (con.State != ConnectionState.Open)
                        con.Open();

                    flag = int.Parse(cmd.ExecuteScalar().ToString());
                }

                if (0 != flag)
                    warnMessage += string.Format(format: Resources.docinput.GlobalResources.WarnPublic, arg0: flag, arg1: nmk);
            }

            return warnMessage;
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
