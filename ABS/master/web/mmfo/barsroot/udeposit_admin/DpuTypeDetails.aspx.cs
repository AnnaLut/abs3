using System;
using System.Collections.Generic;
//using System.Linq;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

using Bars.Oracle;
using BarsWeb.Core.Logger;
using Bars.Exception;

public partial class DpuTypeDetails : Bars.BarsPage
{
    private readonly IDbLogger _dbLogger;
    public DpuTypeDetails()
    {
        _dbLogger = DbLoggerConstruct.NewDbLogger();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            FillDropDownLists();

            if (Request["type_id"] == null)
            {
                //
                // створення нового типу
                //
            }
            else
            {
                // 
                // редагування/перегляд типу
                //

                // Тип депозиту (DPU_TYPES.TYPE_ID)
                Int32 type_id = Convert.ToInt32(Request.QueryString["type_id"]);

                // Населяємо форму
                tbTypeId.Text = Request.QueryString["type_id"];

                GetTypeParams(type_id);

                ddlTemplates.SelectedValue = tbTemplateId.Text;

                if (Request["mode"] == "1")
                {
                    // редагування
                }
                else
                {
                    // перегляд
                    foreach (Control ctrl in frmDpuTypeDeails.Controls)
                    {
                        if (ctrl is TextBox)
                            ((TextBox)ctrl).Enabled = false;
                        else if (ctrl is DropDownList)
                            ((DropDownList)ctrl).Enabled = false;
                        else if (ctrl is CheckBox)
                            ((CheckBox)ctrl).Enabled = false;
                        else if (ctrl is HtmlInputButton)
                            ((HtmlInputButton)ctrl).Disabled = true;
                        else if (ctrl is HtmlInputText)
                            ((HtmlInputText)ctrl).Disabled = true;
                        else if (ctrl is HtmlInputCheckBox)
                            ((HtmlInputCheckBox)ctrl).Disabled = true;
                        else if (ctrl is Button)
                            ((Button)ctrl).Enabled = false;
                    }
                    
                    // Вихід
                    btnExit.Enabled = true;
                }
            }
        }
    }

    /// <summary>
    /// Населення випадаючих списків
    /// </summary>
    protected void FillDropDownLists()
    {
        try
        {
            InitOraConnection();
            // Шаблон договору
            ddlTemplates.DataSource = SQL_SELECT_dataset(@"select ID as TEMPLATE_ID, NAME as TEMPLATE_NAME 
                                                             from BARS.DOC_SCHEME 
                                                            where ID in ( SELECT r.id FROM doc_root r, cc_vidd v WHERE r.vidd = v.vidd AND v.custtype = 2 AND v.tipd = 2) ORDER BY 1");
            ddlTemplates.DataBind();
            ddlTemplates.Items.Insert(0, new ListItem("", "", true));
        }
        finally
        {
            DisposeOraConnection();
        }
    }

     /// <summary>
    /// retrieve information (type parameters)
    /// </summary>
    /// <param name="p_type_id"></param>
    private void GetTypeParams(Int32 p_type_id)
    {
        OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

        try
        {
            OracleCommand cmdSQL = connect.CreateCommand();

            cmdSQL.CommandText = @"select t.TYPE_NAME, t.TYPE_CODE, t.SORT_ORD, t.FL_ACTIVE, t.SHABLON
                                     from BARS.DPU_TYPES t
                                    where t.TYPE_ID = :type_id";

            cmdSQL.Parameters.Add("type_id", OracleDbType.Int32, p_type_id, ParameterDirection.Input);

            OracleDataReader rdrSQL = cmdSQL.ExecuteReader();

            if (rdrSQL.Read())
            {
                #region DATABIND

                // TYPE_NAME
                if (!rdrSQL.IsDBNull(0))
                    tbTypeName.Text = rdrSQL.GetString(0);

                // TYPE_CODE
                if (!rdrSQL.IsDBNull(1))
                    tbTypeCode.Text = rdrSQL.GetString(1);

                //SORT_ORD
                if (!rdrSQL.IsDBNull(2))
                    tbTypeOrder.Text = rdrSQL.GetInt32(2).ToString();

                // FL_ACTIVE
                if (!rdrSQL.IsDBNull(3))
                {
                    cbActive.Checked = (rdrSQL.GetOracleDecimal(3) == 1 ? true : false);
                }

                // SHABLON
                if (!rdrSQL.IsDBNull(4))
                    tbTemplateId.Text = rdrSQL.GetString(4);

                #endregion
            }
            else
            {
                String script = "bars.ui.alert({ text: 'Інформація про тип депозиту " + p_type_id.ToString() + " не знайдена!' })";
                ClientScript.RegisterStartupScript(this.GetType(), "Error", script, true);
            }
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            {
                connect.Close();
                connect.Dispose();
            }
        }
    }

    /// <summary>
    /// Реєстрація нової картки
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        _dbLogger.Info("btnSubmit_Click", "udeposit");

        Decimal? type_id = null;
        Decimal? sort_ordr = null;

        OracleString error_msg = null;

        if (Request["type_id"] != null)
        {
            type_id = Convert.ToInt32(Request.QueryString["type_id"]);
        }

        // sort_ordr
        if (!String.IsNullOrEmpty(tbTypeOrder.Text))
        {
            sort_ordr = Convert.ToDecimal(tbTypeOrder.Text);
        }

        OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

        try
        {
            OracleCommand cmd = connect.CreateCommand();

            cmd.CommandType = CommandType.StoredProcedure;

            cmd.BindByName = true;

            if (type_id.HasValue)
            {
                // update
                cmd.CommandText = "DPU_UTILS.UPD_TYPE";

                // Input
                cmd.Parameters.Add("p_tp_id", OracleDbType.Decimal, type_id, ParameterDirection.Input);
            }
            else
            {
                // create new one
                cmd.CommandText = "DPU_UTILS.ADD_TYPE";

                // Output
                cmd.Parameters.Add("p_tp_id", OracleDbType.Decimal, type_id, ParameterDirection.Output);
            }

            // Input
            cmd.Parameters.Add("p_tp_nm", OracleDbType.Varchar2, tbTypeName.Text, ParameterDirection.Input);
            cmd.Parameters.Add("p_tp_code", OracleDbType.Varchar2, tbTypeCode.Text, ParameterDirection.Input);
            cmd.Parameters.Add("p_sort_ordr", OracleDbType.Decimal, sort_ordr, ParameterDirection.Input);
            cmd.Parameters.Add("p_active", OracleDbType.Decimal, (cbActive.Checked ? 1 : 0), ParameterDirection.Input);
            cmd.Parameters.Add("p_tpl_id", OracleDbType.Varchar2, tbTemplateId.Text, ParameterDirection.Input);

            // Output
            cmd.Parameters.Add("p_err_msg", OracleDbType.Varchar2, error_msg, ParameterDirection.Output);

            cmd.ExecuteNonQuery();

            if (!type_id.HasValue)
            {
                type_id = ((OracleDecimal)cmd.Parameters["p_tp_id"].Value).Value;
            }

            String script = null;

            error_msg = (OracleString)cmd.Parameters["p_err_msg"].Value;

            if (error_msg.IsNull)
            {
                // без помилки
                if (Request["type_id"] == null)
                {
                    //script = "bars.ui.alert({ text: 'Тип депозиту успішно створено!' }); ";
                    script = "alert('Створено тип депозиту #" + Convert.ToString(type_id) + "!'); ";
                    _dbLogger.Info("Користувач створив новий тип депозиту #" + Convert.ToString(type_id), "udeposit");
                }
                else
                {
                    //script = "bars.ui.alert({ text: 'Параметри типу депозиту " + Convert.ToString(type_id) + " оновлено!' }); ";
                    script = "alert('Параметри типу депозиту " + Convert.ToString(type_id) + " оновлено!'); ";
                    _dbLogger.Info("Користувач змінив параметри типу депозиту #" + Convert.ToString(type_id), "udeposit");
                }

                script += "location.replace('/barsroot/udeposit_admin/DpuTypeDetails.aspx?mode=1&type_id=" + Convert.ToString(type_id) + "'); ";
            }
            else
            {
                // з помилкою
                if (Request["type_id"] == null)
                {
                    script = "bars.ui.alert({ text: 'Помилка при створенні типу депозиту:" + error_msg.ToString() + "' }); ";
                }
                else
                {
                    script = "bars.ui.alert({ text: 'Помилка при оновленні параметрів типу депозиту:" + error_msg.ToString() + "' }); ";
                }
            }

            ClientScript.RegisterStartupScript(this.GetType(), "Done", script, true);
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

    }
}