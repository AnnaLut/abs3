using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Bars.Classes;

/// <summary>
/// Summary description for ussr_deposit
/// </summary>
public class ussr_deposit
{
    public ussr_deposit(){}
}
public class ussr_payofftype
{
    public decimal dpt_id;
    public decimal type_id;
    public string type_code;
    public string type_name;
    public string type_params;
    public string type_proc;
    
    public string type_tt;
    public decimal fli;
    public decimal inputsignflag;
    
    public ArrayList type_params_val;
    public ussr_payoffdoc pdoc;

    public string sign;
    public string sign_control_name;
    public string ido;
    public string ido_control_name;
    public string buffer;
    public string buffer_control;

    public ussr_payofftype()
    { 
        type_params_val = new ArrayList();
        pdoc = new ussr_payoffdoc();
    }
    public void GetSignTtsInfo()
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetParams = connect.CreateCommand();
            cmdGetParams.CommandText = "select substr(flags,2,1), fli from tts where tt = :TT";
            cmdGetParams.Parameters.Add("TT", OracleDbType.Varchar2, pdoc.tt, ParameterDirection.Input);

            OracleDataReader rdr = cmdGetParams.ExecuteReader();

            if (!rdr.Read()) throw new Exception("Не знайдені параметри підпису!");

            inputsignflag = Convert.ToDecimal(Convert.ToString(rdr.GetOracleValue(0)));
            fli = Convert.ToDecimal(Convert.ToString(rdr.GetOracleValue(1)));

            if (!rdr.IsClosed) rdr.Close();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }

    public string get_buffer()
    {
        return (pdoc.mfoa.PadLeft(9) + pdoc.nlsa.PadLeft(14) +
            pdoc.mfob.PadLeft(9) + pdoc.nlsb.PadLeft(14) + 
            pdoc.dk + pdoc.s.ToString().PadLeft(16) + 
            pdoc.vob.ToString().PadLeft(2) + pdoc.nd.PadLeft(10) +
            pdoc.kv.ToString().PadLeft(3) +
            pdoc.datd.ToString("yyMMdd") + pdoc.datp.ToString("yyMMdd") +
            pdoc.nam_a.PadRight(38) + pdoc.nam_b.PadRight(38) + 
            pdoc.nazn.PadRight(160) + " ".PadRight(60) + " ".PadRight(3) + "10" +
            pdoc.id_a.PadLeft(14) + pdoc.id_b.PadLeft(14) + pdoc.REF.PadLeft(9) +
            ido.PadLeft(6) + " 0" + " ".PadRight(8));
    }
}
public class ussr_payofftype_params
{
    public string par_name;
    public string par_val;
    public string control_name;
    public ussr_payofftype_params() { }
    public ussr_payofftype_params(string par_name_, string par_val_) 
    {
        par_name = par_name_;
        par_val = par_val_;
    }
}

public class ussr_payoffdoc
{
    // необхідно одно з них вертати з процедури
    public decimal dpt_id;
    public decimal type_id;
    public string type_code;

    public string REF;
    public decimal dk;
    public string tt;
    public decimal vob;
    public decimal kv;
    public decimal kv2;
    public decimal s;
    public decimal s2;
    public string nd;
    public DateTime datd;
    public string mfoa;
    public string nlsa;
    public string nam_a;
    public string id_a;
    public string mfob;
    public string nlsb;
    public string nam_b;
    public string id_b;
    public DateTime datp;
    public string nazn;
    public string d_rec;
    public decimal sk;
    public string ref_a;
    public string ref_l;

    public ussr_payoffdoc() { }
    public ussr_payoffdoc(decimal dpt_id_, decimal type_id_, string REF_, decimal dk_,
        string tt_, decimal vob_, decimal kv_, decimal kv2_, decimal s_, decimal s2_, string nd_, DateTime datd_,
        string mfoa_, string nlsa_, string nam_a_, string id_a_,
        string mfob_, string nlsb_, string nam_b_, string id_b_, 
        DateTime datp_, string nazn_, string d_rec_, decimal sk_,
        string ref_a_, string ref_l_) 
    {
        dpt_id = dpt_id_;
        type_id = type_id_;
        REF = REF_;
        dk = dk_;
        tt = tt_;
        vob = vob_;
        kv = kv_;
        kv2 = kv2_;
        s = s_;
        s2 = s2_;
        nd = nd_;
        datd = datd_;
        mfoa = mfoa_;
        nlsa = nlsa_;
        nam_a = nam_a_;
        id_a = id_a_;
        mfob = mfob_;
        nlsb = nlsb_;
        nam_b = nam_b_;
        id_b = id_b_;
        datp = datp_;
        nazn = nazn_;
        d_rec = d_rec_;
        sk = sk_;
        ref_a = ref_a_;
        ref_l = ref_l_;
    }
}
