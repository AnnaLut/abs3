using System;
using System.Data;
using System.Web.UI.HtmlControls;
using Oracle.DataAccess.Client;

public partial class Dialogs_DialogFullAdr : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            try
            {
                FullDDL(new HtmlSelect[]{StreetType1, StreetType2, StreetType3}, con, "address_street_type", 0);
                FullDDL(new HtmlSelect[]{HomeType1, HomeType2, HomeType3}, con, "address_home_type", 0);
                FullDDL(new HtmlSelect[]{HomePartType1, HomePartType2, HomePartType3}, con, "address_homepart_type", 0);
                FullDDL(new HtmlSelect[]{RoomType1, RoomType2, RoomType3}, con, "address_room_type",0 );
                FullDDL(new HtmlSelect[]{LocalityType1, LocalityType2, LocalityType3}, con, "address_locality_type", 0);
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }
    }
    private void FullDDL(HtmlSelect[] ddl, OracleConnection con, string tableName, int selectedId)
    {
        OracleCommand cmd = new OracleCommand("select id, value from "+tableName+" order by id", con);
        OracleDataAdapter ad = new OracleDataAdapter(cmd);
        DataSet ds = new DataSet();
        ad.Fill(ds);
        try
        {
            foreach (var i in ddl)
            {
                i.DataSource = ds;
                i.DataValueField = "ID";
                i.DataTextField = "VALUE";
                i.DataBind();
                i.SelectedIndex = i.Items.Count-1;
            }
        }
        finally
        {
            cmd.Dispose();
            ad.Dispose();
            ds.Dispose();
        }
    }
}
