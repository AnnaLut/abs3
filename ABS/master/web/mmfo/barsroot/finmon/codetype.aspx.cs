﻿using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;
using System.Data;
using Bars.Classes;
using Bars.Oracle;
using Oracle.DataAccess.Types;
using System.Globalization;
using Bars.UserControls;
using Bars.Oracle;
using Bars.Classes;
using System.Web.Services;


public partial class finmon_codetype : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            FillData();
        }
    }

    protected void FillData()
    {
        tbCode.Text = Request["code"];
        if (Request["code"] == "999999999999999")
        {
            tbClaclProvidedCode.Text = Request["code"].Substring(0, 1);
            tbClaclProvidedName.Text = "";

            tbClaclReceivCode.Text = Request["code"].Substring(1, 1);
            tbClaclReceivName.Text = "";

            tbAssetProvidedCode.Text = Request["code"].Substring(2, 1);
            tbAssetProvidedName.Text = "";

            tbAssetReceivCode.Text = Request["code"].Substring(3, 1);
            tbAssetReceivName.Text = "";

            tbLocationProvided.Text = Request["code"].Substring(4, 1);
            tbLocationNameProvided.Text = "";

            tbLocationReceiv.Text = Request["code"].Substring(5, 1);
            tbLocationNameReceiv.Text = "";

            tbObjectProvided.Text = Request["code"].Substring(6, 4);
            tbObjectNameProvided.Text = "";

            tbObjectReceiv.Text = Request["code"].Substring(10, 4);
            tbObjectNameReceiv.Text = "";

        }
        else
        {
            ClaclCode(Request["code"].Substring(0, 1), "provided");
            ClaclCode(Request["code"].Substring(1, 1), "received");
            AssetCode(Request["code"].Substring(2, 1), "provided");
            AssetCode(Request["code"].Substring(3, 1), "received");
            LocationCode(Request["code"].Substring(4, 1), "provided");
            LocationCode(Request["code"].Substring(5, 1), "received");
            ObjectCode(Request["code"].Substring(6, 4), "provided");
            ObjectCode(Request["code"].Substring(10, 4), "received");
        }
        NlsCode(Request["code"].Substring(14, 1));
        tbCode.Text = tbClaclProvidedCode.Text + tbClaclReceivCode.Text + tbAssetProvidedCode.Text + tbAssetReceivCode.Text + tbLocationProvided.Text + tbLocationReceiv.Text + tbObjectProvided.Text + tbObjectReceiv.Text + tbNls.Text;

    }

    protected void tbClaclProvidedCode_TextChanged(object sender, EventArgs e)
    {
        ClaclCode(tbClaclProvidedCode.Text, "provided");
    }
    protected void tbClaclReceivCode_TextChanged(object sender, EventArgs e)
    {
        ClaclCode(tbClaclReceivCode.Text, "received");
    }
    protected void tbAssetProvidedCode_TextChanged(object sender, EventArgs e)
    {
        AssetCode(tbAssetProvidedCode.Text, "provided");
    }
    protected void tbAssetReceivName_TextChanged(object sender, EventArgs e)
    {
        AssetCode(tbAssetReceivCode.Text, "received");
    }
    protected void tbLocationProvided_TextChanged(object sender, EventArgs e)
    {
        LocationCode(tbLocationProvided.Text, "provided");
    }
    protected void tbLocationReceiv_TextChanged(object sender, EventArgs e)
    {
        LocationCode(tbLocationReceiv.Text, "received");
    }
    protected void tbObjectProvided_TextChanged(object sender, EventArgs e)
    {
        ObjectCode(tbObjectProvided.Text, "provided");
    }
    protected void tbObjectReceiv_TextChanged(object sender, EventArgs e)
    {
        ObjectCode(tbObjectReceiv.Text, "received");
    }
    protected void tbNls_TextChanged(object sender, EventArgs e)
    {
        NlsCode(tbNls.Text);
    }
    protected void btOK_Click(object sender, EventArgs e)
    {
        var defaultCheck = tbClaclProvidedCode.Text == "9" || tbClaclReceivCode.Text == "9" || tbLocationProvided.Text == "9" || tbLocationReceiv.Text == "9" || tbObjectProvided.Text == "9999" || tbObjectReceiv.Text == "9999";
        if (tbCode.Text.Length < 15 || (defaultCheck && (tbCode.Text.Substring(0, 2) + tbCode.Text.Substring(4, 10) != "999999999999")) )
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Невірний код операції');", true);
            FillData();
            return;
        }        
        ScriptManager.RegisterStartupScript(this, this.GetType(), "close_pay_dialog", "Close('" + tbCode.Text + "');", true);
    }
    protected void btCancel_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "close_pay_dialog", "Close('" + Request["code"] + "');", true);
    }
    protected void ClaclCode(string code, string type)
    {
        string l_calc = code;
        InitOraConnection();
        try
        {
            ClearParameters();
            SetParameters("l_calc", DB_TYPE.Varchar2, l_calc, DIRECTION.Input);
            object[] resCalc = SQL_SELECT_reader("select code,name from k_dfm01a where to_char(code) = :l_calc and (d_close is null or d_close > sysdate) order by code");

            if (null != resCalc)
            {
                if (type == "provided")
                {
                    tbClaclProvidedCode.Text = Convert.ToString(resCalc[0]);
                    tbClaclProvidedName.Text = Convert.ToString(resCalc[1]);
                }

                if (type == "received")
                {
                    tbClaclReceivCode.Text = Convert.ToString(resCalc[0]);
                    tbClaclReceivName.Text = Convert.ToString(resCalc[1]);
                }

            }
            else
            {
                if (type == "provided")
                {
                    tbClaclProvidedCode.Text = "";
                    tbClaclProvidedName.Text = "";
                }
                if (type == "received")
                {
                    tbClaclReceivCode.Text = "";
                    tbClaclReceivName.Text = "";
                }
            }
        }
        finally
        {
            DisposeOraConnection();
        }

        tbCode.Text = tbClaclProvidedCode.Text + tbClaclReceivCode.Text + tbAssetProvidedCode.Text + tbAssetReceivCode.Text + tbLocationProvided.Text + tbLocationReceiv.Text + tbObjectProvided.Text + tbObjectReceiv.Text + tbNls.Text;
    }

    protected void AssetCode(string code, string type)
    {
        string l_asset = code;
        InitOraConnection();
        try
        {
            ClearParameters();
            SetParameters("l_asset", DB_TYPE.Varchar2, l_asset, DIRECTION.Input);
            object[] resAsset = SQL_SELECT_reader("select code,name from k_dfm01b where to_char(code) = :l_asset and (d_close is null or d_close > sysdate) order by code");

            if (null != resAsset)
            {
                if (type == "provided")
                {
                    tbAssetProvidedCode.Text = Convert.ToString(resAsset[0]);
                    tbAssetProvidedName.Text = Convert.ToString(resAsset[1]);
                }

                if (type == "received")
                {
                    tbAssetReceivCode.Text = Convert.ToString(resAsset[0]);
                    tbAssetReceivName.Text = Convert.ToString(resAsset[1]);
                }

            }
            else
            {
                if (type == "provided")
                {
                    tbAssetProvidedCode.Text = "";
                    tbAssetProvidedName.Text = "";
                }
                if (type == "received")
                {
                    tbAssetReceivCode.Text = "";
                    tbAssetReceivName.Text = "";
                }
            }
        }
        finally
        {
            DisposeOraConnection();
        }
        tbCode.Text = tbClaclProvidedCode.Text + tbClaclReceivCode.Text + tbAssetProvidedCode.Text + tbAssetReceivCode.Text + tbLocationProvided.Text + tbLocationReceiv.Text + tbObjectProvided.Text + tbObjectReceiv.Text + tbNls.Text;

    }
    protected void LocationCode(string code, string type)
    {
        string l_location = code;
        InitOraConnection();
        try
        {
            ClearParameters();
            SetParameters("l_location", DB_TYPE.Varchar2, l_location, DIRECTION.Input);
            object[] resLocation = SQL_SELECT_reader("select code,name from k_dfm01c where to_char(code) = :l_location and (d_close is null or d_close > sysdate) order by code");

            if (null != resLocation)
            {
                if (type == "provided")
                {
                    tbLocationProvided.Text = Convert.ToString(resLocation[0]);
                    tbLocationNameProvided.Text = Convert.ToString(resLocation[1]);
                }

                if (type == "received")
                {
                    tbLocationReceiv.Text = Convert.ToString(resLocation[0]);
                    tbLocationNameReceiv.Text = Convert.ToString(resLocation[1]);
                }

            }
            else
            {
                if (type == "provided")
                {
                    tbLocationProvided.Text = "";
                    tbLocationNameProvided.Text = "";
                }
                if (type == "received")
                {
                    tbLocationReceiv.Text = "";
                    tbLocationNameReceiv.Text = "";
                }
            }
        }
        finally
        {
            DisposeOraConnection();
        }
        tbCode.Text = tbClaclProvidedCode.Text + tbClaclReceivCode.Text + tbAssetProvidedCode.Text + tbAssetReceivCode.Text + tbLocationProvided.Text + tbLocationReceiv.Text + tbObjectProvided.Text + tbObjectReceiv.Text + tbNls.Text;

    }

    protected void ObjectCode(string code, string type)
    {
        string l_object = code;
        InitOraConnection();
        try
        {
            ClearParameters();
            SetParameters("l_object", DB_TYPE.Varchar2, l_object, DIRECTION.Input);
            object[] resObject = SQL_SELECT_reader("select code,name from k_dfm01d where to_char(code) = :l_object and (d_close is null or d_close > sysdate) order by code");

            if (null != resObject)
            {
                if (type == "provided")
                {
                    tbObjectProvided.Text = Convert.ToString(resObject[0]);
                    tbObjectNameProvided.Text = Convert.ToString(resObject[1]);
                }

                if (type == "received")
                {
                    tbObjectReceiv.Text = Convert.ToString(resObject[0]);
                    tbObjectNameReceiv.Text = Convert.ToString(resObject[1]);
                }

            }
            else
            {
                if (type == "provided")
                {
                    tbObjectProvided.Text = "";
                    tbObjectNameProvided.Text = "";
                }
                if (type == "received")
                {
                    tbObjectReceiv.Text = "";
                    tbObjectNameReceiv.Text = "";
                }
            }
        }
        finally
        {
            DisposeOraConnection();
        }
        tbCode.Text = tbClaclProvidedCode.Text + tbClaclReceivCode.Text + tbAssetProvidedCode.Text + tbAssetReceivCode.Text + tbLocationProvided.Text + tbLocationReceiv.Text + tbObjectProvided.Text + tbObjectReceiv.Text + tbNls.Text;

    }

    protected void NlsCode(string code)
    {
        string l_nls = code;
        InitOraConnection();
        try
        {
            ClearParameters();
            SetParameters("l_nls", DB_TYPE.Varchar2, l_nls, DIRECTION.Input);
            object[] resNls = SQL_SELECT_reader("select code,name from k_dfm01e where to_char(code) = :l_nls and (d_close is null or d_close > sysdate) order by code");

            if (null != resNls)
            {
                tbNls.Text = Convert.ToString(resNls[0]);
                tbNlsName.Text = Convert.ToString(resNls[1]);
            }
            else
            {
                tbNls.Text = "";
                tbNlsName.Text = "";

            }
        }
        finally
        {
            DisposeOraConnection();
        }
        tbCode.Text = tbCode.Text.Substring(0,14) + tbNls.Text;

    }
}