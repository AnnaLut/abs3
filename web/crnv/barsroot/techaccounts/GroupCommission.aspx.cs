using System;
using System.Data;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Classes;
using Oracle.DataAccess.Client;

public partial class GroupCommission : Page
{
    /// <summary>
    /// Завантаження сторінки
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        /// Наповнюємо гріди
        FillGrid(); FillGridPaid();
        
        if (IsPostBack)
        {
            /// Обнуляємо інформацію про checkbox
            clientIDs.Value = String.Empty;
        }
    }
    /// <summary>
    /// Подія - заповнення гріда даними 
    /// </summary>
    protected void gridTechAccCredit_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            GridViewRow row = e.Row;
            CheckBox ck = new CheckBox();
            ck.Attributes["onclick"] = string.Format("javascript:markPayments('{0}');", row.Cells[2].Text);
            row.Cells[0].Controls.Add(ck);
            clientIDs.Value += ck.ClientID + "%";
        }
    }
    /// <summary>
    /// Наповнення списку оброблених
    /// безготівкових поповнень
    /// за які вже була стягнена комісія
    /// </summary>
    private void FillGridPaid()
    {
        dsPaid.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsPaid.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");

        string searchQuery = "SELECT " +
                "'<A href=# onclick=''ShowDocCard('||REFL||')''>'||REFL||'</a>' AS REFL, " +
                "'<A href=# onclick=''ShowDocCard('||REF||')''>'||REF||'</a>' AS REF, " +
                "NLS,SUM,LCV,DAT,NAZN " +
                "FROM v_tech_acc_credit WHERE refl is not null";
        dsPaid.SelectCommand = searchQuery;
    }
    /// <summary>
    /// Наповнення списку зроблених
    /// безготівкових поповнень
    /// за які не була стягнена комісія
    /// </summary>
    private void FillGrid()
    {
        dsTechAccCredit.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsTechAccCredit.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");

        string searchQuery = "SELECT NULL as TAKE, " +
                "'<A href=# onclick=''ShowDocCard('||REF||')''>Перегляд</a>' AS REF, " +
                "NLS,SUM,LCV,DAT,NAZN, " +
                "REF as DREF " +
                "FROM v_tech_acc_credit WHERE refl is null";
        dsTechAccCredit.SelectCommand = searchQuery;
    }
    /// <summary>
    /// AJAX метод
    /// Оплата пачки вибраних документів
    /// </summary>
    /// <param name="refin">Референси, розбиті знаком '%'</param>
    /// <returns></returns>
    [WebMethod(EnableSession = true)]
    public static void Pay(string refin)
    {
        OracleConnection connect = new OracleConnection();
        OracleTransaction tx = null;
        bool txCommitted = false;
       
        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            
            tx = connect.BeginTransaction();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdPay = connect.CreateCommand();
            cmdPay.CommandText = "begin dpt_web.p_techacc_nocash_comiss(:ref,:refl); end;";
            String[] arr = refin.Split('%');
            Decimal dummy = Decimal.MinValue; 
            foreach (String val in arr)
            {
                /// Пропускаємо останнє порожнє значення
                if (val == String.Empty) continue;

                cmdPay.Parameters.Clear();
                cmdPay.Parameters.Add("ref", OracleDbType.Decimal, val, ParameterDirection.Input);
                cmdPay.Parameters.Add("refl", OracleDbType.Decimal, dummy, ParameterDirection.Output);
                cmdPay.ExecuteNonQuery();                
            }

            tx.Commit();
            txCommitted = true;
        }
        ///// Перехоплюємо бо ASP.NET ajax НІЯК не обробляє викинуті помилки
        catch (Exception ex)
        {
            Deposit.SaveException(ex);
            throw ex;
        }
        finally
        {
            if (tx != null && !txCommitted) tx.Rollback();
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
}
