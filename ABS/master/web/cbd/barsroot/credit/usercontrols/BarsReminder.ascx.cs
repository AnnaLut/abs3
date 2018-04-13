using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.ComponentModel;
using System.Data;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Oracle;


public partial class credit_usercontrols_BarsReminder : System.Web.UI.UserControl
{
    # region Публичные свойства
    /// <summary>
    /// Путь к картинке
    /// </summary>
    public string pathToTabImage { get; set;}
    /// <summary>
    /// Высота картинки
    /// </summary>
    [DefaultValue(20)]
    public int imageHeight { get; set; }
    /// <summary>
    /// Ширина картинки
    /// </summary>
    [DefaultValue(108)]
    public int imageWidth { get; set; }
    /// <summary>
    /// Позиция на экране
    /// </summary>
    [DefaultValue("bottom")]
    public string tabLocation { get; set; }
    /// <summary>
    /// Скорость вывода на экран
    /// </summary>
    [DefaultValue(1000)]
    public int speed { get; set; }
    /// <summary>
    /// Метод открытия
    /// </summary>
    [DefaultValue("click")]
    public string action { get; set; }
    /// <summary>
    /// Вертикальная позиция
    /// </summary>
    [DefaultValue("200px")]
    public string topPos { get; set; }
    /// <summary>
    /// Горизонтальная позиция
    /// </summary>
    [DefaultValue("800px")]
    public string leftPos { get; set; }
    [DefaultValue("5px")]
    public string rightPos { get; set; }

    [DefaultValue("BRS")]
    public string moduleId { get; set; }

    [DefaultValue(null)]
    public Decimal? objId { get; set; }

    #endregion
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected override void OnPreRender(EventArgs e)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("$(document).ready(function () {");
        sb.Append("   $('#divslide').tabSlideOut({");
        sb.Append("     tabHandle: '.handle',");
        sb.Append("     pathToTabImage: \'" + pathToTabImage + "\',");
        sb.Append("     imageHeight:" + imageHeight + ",");
        sb.Append("     imageWidth:" + imageWidth + ",");
        sb.Append("     tabLocation: \'" + tabLocation + "\',");
        sb.Append("     speed: " + speed + ",");
        sb.Append("     action: \'" + action + "\',");
        sb.Append("     topPos: \'" + topPos + "\',");
        sb.Append("     rightPos: \'" + rightPos + "\',");
        sb.Append("     fixedPosition: false,");
        sb.Append("     onLoadSlideOut: true,");
        sb.Append("     toogleHandle: true,");
        sb.Append("     closeButton: '.close-slide'");
        sb.Append("   });");
        sb.Append("});");
        //Page.ClientScript.RegisterStartupScript(Page.GetType(), "newScript", sb.ToString(), true);
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "showSlide", sb.ToString(), true);
    }
    protected void imgBtn_Click(object sender, ImageClickEventArgs e)
    {
        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        String mId = String.IsNullOrEmpty(moduleId) ? "BRS" : moduleId;
        Decimal? oId = objId == null ? null : objId;
        try
        {
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = "declare max_id decimal; l_user_id decimal; begin select max(id) into max_id from reminders; select user_id into l_user_id from dual; insert into reminders values (decode(max_id, null, 1, max_id+ 1), '" + mId + "', l_user_id, to_date(:p_date, 'dd/mm/yyyy'), :p_msg, 0, :p_obj); end;";
                //"insert into reminders values (max(id) + 1, 'INS', 20094, " + tbDate.Value + ", " + tbMsg.Value + ", 0, null)";
            cmd.Parameters.Add("p_date", OracleDbType.Date, tbDate.Value, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_msg", OracleDbType.Varchar2, tbMsg.Value, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_obj", OracleDbType.Decimal, oId, System.Data.ParameterDirection.Input);
            //cmd.Parameters.Add("p_module", OracleDbType.Varchar2, mId, System.Data.ParameterDirection.Input);
            cmd.ExecuteNonQuery();
            tbDate.Value = null;
            tbMsg.Value = "";
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }
}