using Bars.UserControls;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.UI;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Web.UI.WebControls;

public partial class CardKievCardKievParams : Page
{
    private const string KkPhotoType = "PHOTO_JPG";
    private const string KkPasswordTag = "W4KKW";
    private const string KkRegisterTypeTag = "W4KKR";
    private const string KkRegisterAreaTag = "W4KKA";
    private const string KkRegisterStreetTypeTag = "W4KKT";
    private const string KkRegisterStreetTag = "W4KKS";
    private const string KkRegisterBuildTag = "W4KKB";
    private const string KkRegisterZipTag = "W4KKZ";
    private const string KkRegisterSKTag = "W4SKS";


    private bool hasCardKiev = false;
    private decimal currentRnk { get; set; }

    private byte[] userPic = null;
    private string currentProduct = null;

    private byte[] GetUserPic()
    {
        if (userPic == null)
        {
            userPic = Tools.get_cliet_picture(currentRnk, KkPhotoType);
        }
        return userPic;
    }

    private string GetNextPageUrl()
    {
        if (Session["docNumberKK"] == null)
        {

	    if (!string.IsNullOrEmpty(Request.Params["frm_id"]))
            {
                return string.Format(
                "/barsroot/barsweb/dynform.aspx?form={0}&rnk={1}&proect_id={2}&card_code={3}",
                Request.Params["frm_id"],
                currentRnk,
                Request.Params["proect_id"],
                Request.Params["card_code"]);
            }
            return string.Format(
                //"/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.newdeal&rnk={0}&proect_id={1}&card_code={2}",
                "/barsroot/bpkw4/RegisteringNewCard?rnk={0}&proectId={1}&cardCode={2}",
                currentRnk,
                Request.Params["proect_id"],
                Request.Params["card_code"]);
        }
        return "/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.portfolio";
    }

    private void ShowPhoto()
    {
        var currentPhoto = GetUserPic();
        if (currentPhoto.Length == 0)
        {
            lblNoPhoto.Visible = true;
            kkPhoto.Visible = false;
        }
        else
        {
            lblNoPhoto.Visible = false;
            kkPhoto.Visible = true;
            kkPhoto.Src = "data:image/jpg;base64," + Convert.ToBase64String(currentPhoto);
        }
    }

    private bool CheckData()
    {
        List<string> errors = new List<string>();
        var userPhoto = GetUserPic();
        if (userPhoto == null || userPhoto.Length == 0)
        {
            errors.Add("Відсутнє фото клієнта.");
        }
        if (String.IsNullOrEmpty(Build.Value))
        {
            errors.Add("Номер будинку не заповнено!");
        }
        string messageFunction = @"barsUiError('" + string.Join("<br/>", errors) + "');";
        ScriptManager.RegisterStartupScript(this, GetType(), "ErrorPayMessage", messageFunction, true);

        return !errors.Any();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["card_kiev"] == "1sch")
        {
            tdPassword.Visible = false;
            pnl_schData.Visible = true;
            trHideMe1.Visible =
            trHideMe2.Visible =
            trHideMe3.Visible =
            trHideMe4.Visible =
            trHideMe5.Visible = false;
            lbl_topicHeader.Text = "Додаткова картка школяра";
        }

        if (Session["currentRnk"] != null && Request.Params["form"] != "bpkw4.ref.card")
        {
            currentRnk = (decimal)(Session["currentRnk"] as List<object>)[0];
            if (Request["card_kiev"] == "1sch")
            { // введенный рнк с txbx rnk для карты школьника считать за текущий рнк
                int i = 0;
                if (int.TryParse(txbx_rnk.Text, out i))
                {
                    currentRnk = Decimal.Parse(txbx_rnk.Text);
                    ShowPhoto();
                }
                else
                    currentRnk = 0;
            }
            currentProduct = (string)(Session["product"] as List<object>)[0];
            var currentNd = (decimal)(Session["docNumberKK"] as List<object>)[0];
            btnSaveKKParams.Visible = true;
            if (Request["card_kiev"] != "1sch")
            {
                if (CheckDod(currentNd))
                {
                    Label8.Visible = true;
                    DOP_CARD_TYPE.Visible = true;
                }
                DOP_CARD_TYPE.Visible = true;
            }
        }
        else
        {
            Session["currentRnk"] = null;
            Session["docNumberKK"] = null;
            currentRnk = Convert.ToDecimal(Request.Params["rnk"]);
            Label8.Visible = false;
            DOP_CARD_TYPE.Visible = false;
        }
        if (!IsPostBack)
        {
            if (Request["card_kiev"] != "1" && Request["card_kiev"] != "1sch")
            {
                //если продукт выбранный ранее, не является картой киевлянина то идем обычным путем - ничего не сканируем
                Response.Redirect(GetNextPageUrl());
            }
            ShowPhoto();
            LoadPassword();
            LoadOtherParams();
        }
        REGISTER_TYPE.Attributes["onChange"] = "custRegistrationTypeChange();";

    }

    protected void sc_DocumentScaned(object sender, EventArgs e)
    {
        // контрол сканера
        string imageId = null;
        decimal? currentNd = null;
        if (Session["docNumberKK"] != null)
        {
            currentNd = (decimal?)(Session["docNumberKK"] as List<object>)[0];
        }

        foreach (var key in Session.Keys)
        {
            if (key.ToString().StartsWith("IMAGE_DATA_"))
            {
                imageId = key.ToString();
            }
        }
        ByteData uploadedImage = (ByteData)Session[imageId];
        userPic = uploadedImage.GetPageFromPdfFile(1);
        /*TextBoxScanner sc = (sender as TextBoxScanner);
        userPic = sc.Value;*/
        if (userPic != null && userPic.Length > 0)
        {
            SaveImage(KkPhotoType, userPic, currentNd);
            ShowPhoto();
        }
    }


    private void SaveImage(String imgType, Byte[] imgData, decimal? currentNd)
    {
        // !!! переделать на процедуру
        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmdInsert = con.CreateCommand();
        OracleCommand cmdDelete = con.CreateCommand();
        OracleCommand cmdSql = con.CreateCommand();
        try
        {
            cmdDelete.CommandText = "delete from customer_images ci where ci.rnk = :p_rnk and ci.type_img = :p_type";
            cmdDelete.Parameters.Add("p_rnk", OracleDbType.Int64, currentRnk, System.Data.ParameterDirection.Input);
            cmdDelete.Parameters.Add("p_type", OracleDbType.Varchar2, imgType, System.Data.ParameterDirection.Input);
            cmdDelete.ExecuteNonQuery();

            cmdInsert.CommandText = "insert into customer_images (rnk, type_img, date_img, image) values (:p_rnk, :p_type, sysdate, :p_image)";
            cmdInsert.Parameters.Add("p_rnk", OracleDbType.Int64, currentRnk, System.Data.ParameterDirection.Input);
            cmdInsert.Parameters.Add("p_type", OracleDbType.Varchar2, imgType, System.Data.ParameterDirection.Input);
            cmdInsert.Parameters.Add("p_image", OracleDbType.Blob, imgData, System.Data.ParameterDirection.Input);
            cmdInsert.ExecuteNonQuery();

            if(hasCardKiev == true && currentNd != null)
            {
                cmdSql.CommandText =
                @"begin
                    bars_ow.ADD_DEAL_TO_CMQUE(:p_nd, 3);
                end;";
                cmdSql.Parameters.Add("p_nd", OracleDbType.Decimal, currentNd, ParameterDirection.Input);
                cmdSql.ExecuteNonQuery();
            }


        }
        catch (Exception ex)
        {
           ex.Message.ToString();
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    private void LoadOtherParams()
    {
        OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        try
        {
            OracleCommand cmdSQL = connect.CreateCommand();
            cmdSQL.CommandText = "select VALUE from customerw where RNK = :p_rnk and tag = :p_tag";

            cmdSQL.Parameters.Add("p_rnk", OracleDbType.Decimal, currentRnk, System.Data.ParameterDirection.Input);
            cmdSQL.Parameters.Add("p_tag", OracleDbType.Varchar2, KkRegisterTypeTag, System.Data.ParameterDirection.Input);

            OracleDataReader rdr = cmdSQL.ExecuteReader();
            if (rdr.Read())
                REGISTER_TYPE.Value = rdr["value"].ToString();

            cmdSQL.Parameters["p_tag"].Value = KkRegisterAreaTag;
            rdr = cmdSQL.ExecuteReader();
            if (rdr.Read())
                ID_CITY_AREA.Value = rdr["value"].ToString();

            cmdSQL.Parameters["p_tag"].Value = KkRegisterStreetTypeTag;
            rdr = cmdSQL.ExecuteReader();
            if (rdr.Read())
                ID_STREET_TYPE.Value = rdr["value"].ToString();

            cmdSQL.Parameters["p_tag"].Value = KkRegisterStreetTag;
            rdr = cmdSQL.ExecuteReader();
            if (rdr.Read())
                STREET.Value = rdr["value"].ToString();

            cmdSQL.Parameters["p_tag"].Value = KkRegisterBuildTag;
            rdr = cmdSQL.ExecuteReader();
            if (rdr.Read())
                Build.Value = rdr["value"].ToString();

            cmdSQL.Parameters["p_tag"].Value = KkRegisterZipTag;
            rdr = cmdSQL.ExecuteReader();
            if (rdr.Read())
                Zip.Value = rdr["value"].ToString();

            cmdSQL.Parameters.Clear();
            string tableName = Request["card_kiev"] == "1sch" ? "V_BPK_SK" : "V_BPK_KK";
            cmdSQL.CommandText = "select distinct KK_CODE, KK_SUB_NAME from  " + tableName  + "  where product_code = :p_product_code";
            cmdSQL.Parameters.Add("p_product_code", OracleDbType.Varchar2, currentProduct, System.Data.ParameterDirection.Input);
            DataSet cardTypesKk = new DataSet();
            OracleDataAdapter cardTypeAdapter = new OracleDataAdapter()
            {
                SelectCommand = cmdSQL
            };
            cardTypeAdapter.Fill(cardTypesKk);
            // get ow_schooltypes 888888888888888888888888888888
            cmdSQL.Parameters.Clear();
            cmdSQL.CommandText = "select * from ow_schooltypes";
            DataSet dds_cardTypesKk = new DataSet();
            OracleDataAdapter dds1Adapter = new OracleDataAdapter()
            {
                SelectCommand = cmdSQL
            };
            dds1Adapter.Fill(dds_cardTypesKk);
            // ************************************************

            DOP_CARD_TYPE.DataSource = cardTypesKk;
            DOP_CARD_TYPE.DataTextField = "KK_SUB_NAME";
            DOP_CARD_TYPE.DataValueField = "KK_CODE";
            DOP_CARD_TYPE.DataBind();
            DOP_CARD_TYPE.Items.Insert(0, new ListItem("- Оберiть тип карти -", ""));

            ddl_schooltypeid.DataSource = dds_cardTypesKk;
            ddl_schooltypeid.DataTextField = "INFO";
            ddl_schooltypeid.DataValueField = "SCHOOLTYPEID";
            ddl_schooltypeid.DataBind();
            ddl_schooltypeid.Items.Insert(0, new ListItem("- Тип нав. закладу -", ""));
        }
        finally
        {
            connect.Close();
            connect.Dispose();
        }
    }


    private void SaveAddress()
    {
        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        try
        {
            //тип регистрации
            OracleCommand cmdInsert = con.CreateCommand();
            OracleCommand cmdDelete = con.CreateCommand();
            cmdDelete.CommandText = "delete from customerw cw where cw.rnk = :p_rnk and cw.tag = :p_tag";
            cmdDelete.Parameters.Add("p_rnk", OracleDbType.Int64, currentRnk, System.Data.ParameterDirection.Input);
            cmdDelete.Parameters.Add("p_tag", OracleDbType.Varchar2, KkRegisterTypeTag, System.Data.ParameterDirection.Input);
            cmdDelete.ExecuteNonQuery();

            cmdInsert.CommandText = "insert into customerw (rnk, tag, value, isp) values (:p_rnk, :p_tag, :p_val, 0)";
            cmdInsert.Parameters.Add("p_rnk", OracleDbType.Int64, currentRnk, System.Data.ParameterDirection.Input);
            cmdInsert.Parameters.Add("p_tag", OracleDbType.Varchar2, KkRegisterTypeTag, System.Data.ParameterDirection.Input);
            cmdInsert.Parameters.Add("p_val", OracleDbType.Varchar2, REGISTER_TYPE.Value, System.Data.ParameterDirection.Input);
            cmdInsert.ExecuteNonQuery();


            //код района
            cmdDelete.Parameters["p_tag"].Value = KkRegisterAreaTag;
            cmdDelete.ExecuteNonQuery();

            cmdInsert.Parameters["p_tag"].Value = KkRegisterAreaTag;
            cmdInsert.Parameters["p_val"].Value = ID_CITY_AREA.Value;
            cmdInsert.ExecuteNonQuery();


            //тип улицы
            cmdDelete.Parameters["p_tag"].Value = KkRegisterStreetTypeTag;
            cmdDelete.ExecuteNonQuery();

            cmdInsert.Parameters["p_tag"].Value = KkRegisterStreetTypeTag;
            cmdInsert.Parameters["p_val"].Value = ID_STREET_TYPE.Value;
            cmdInsert.ExecuteNonQuery();

            //улица
            cmdDelete.Parameters["p_tag"].Value = KkRegisterStreetTag;
            cmdDelete.ExecuteNonQuery();

            cmdInsert.Parameters["p_tag"].Value = KkRegisterStreetTag;
            cmdInsert.Parameters["p_val"].Value = STREET.Value;
            cmdInsert.ExecuteNonQuery();

            //Индекс
            cmdDelete.Parameters["p_tag"].Value = KkRegisterZipTag;
            cmdDelete.ExecuteNonQuery();

            cmdInsert.Parameters["p_tag"].Value = KkRegisterZipTag;
            cmdInsert.Parameters["p_val"].Value = Zip.Value;
            cmdInsert.ExecuteNonQuery();


            //№ дома
            cmdDelete.Parameters["p_tag"].Value = KkRegisterBuildTag;
            cmdDelete.ExecuteNonQuery();

            cmdInsert.Parameters["p_tag"].Value = KkRegisterBuildTag;
            cmdInsert.Parameters["p_val"].Value = Build.Value;
            cmdInsert.ExecuteNonQuery();
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    private void SavePassword(String pass)
    {
        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmdInsert = con.CreateCommand();
        OracleCommand cmdDelete = con.CreateCommand();
        try
        {
            cmdDelete.CommandText = "delete from customerw cw where cw.rnk = :p_rnk and cw.tag = :p_tag";
            cmdDelete.Parameters.Add("p_rnk", OracleDbType.Int64, currentRnk, System.Data.ParameterDirection.Input);
            cmdDelete.Parameters.Add("p_tag", OracleDbType.Varchar2, KkPasswordTag, System.Data.ParameterDirection.Input);
            cmdDelete.ExecuteNonQuery();

            cmdInsert.CommandText = "insert into customerw (rnk, tag, value, isp) values (:p_rnk, :p_tag, :p_pass, 0)";
            cmdInsert.Parameters.Add("p_rnk", OracleDbType.Int64, currentRnk, System.Data.ParameterDirection.Input);
            cmdInsert.Parameters.Add("p_tag", OracleDbType.Varchar2, KkPasswordTag, System.Data.ParameterDirection.Input);
            cmdInsert.Parameters.Add("p_pass", OracleDbType.Varchar2, pass, System.Data.ParameterDirection.Input);
            cmdInsert.ExecuteNonQuery();
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    private void LoadPassword()
    {
        OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        try
        {
            OracleCommand cmdSQL = connect.CreateCommand();
            cmdSQL.CommandText = "select VALUE from customerw where RNK = :p_rnk and tag = :p_tag";

            cmdSQL.Parameters.Add("p_rnk", OracleDbType.Decimal, currentRnk, System.Data.ParameterDirection.Input);
            cmdSQL.Parameters.Add("p_tag", OracleDbType.Varchar2, KkPasswordTag, System.Data.ParameterDirection.Input);

            OracleDataReader rdr = cmdSQL.ExecuteReader();
            if (rdr.Read())
                tbPassWord.Text = rdr["value"].ToString();

        }
        finally
        {
            connect.Close();
            connect.Dispose();
        }
    }

    private void SaveAdditionalCard(decimal docNumber, string CardCode)
    {
        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmdSql = con.CreateCommand();
        cmdSql.CommandText =
            @"begin
                bars_ow.create_dop_kk(:p_docNumber, :p_cardcode);
              end;";
        cmdSql.Parameters.Add("p_docNumber", OracleDbType.Decimal, docNumber, ParameterDirection.Input);
        cmdSql.Parameters.Add("p_cardcode", OracleDbType.Varchar2, CardCode, ParameterDirection.Input);
        cmdSql.ExecuteNonQuery();
    }

    private string Check_AdPupilCardAdditionalCard(decimal p_nd, decimal p_pupil_rnk, string p_msg = "")
    {
        string result = string.Empty;
        OracleString errMessage = "";
        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmdSql = con.CreateCommand();
        cmdSql.CommandText =
            @"begin
                bars_ow.check_ad_pupil_card(:p_nd,
                              :p_pupil_rnk,
                              :p_msg);
              end;";
        cmdSql.Parameters.Add("p_nd", OracleDbType.Decimal, p_nd, ParameterDirection.Input);
        cmdSql.Parameters.Add("p_pupil_rnk", OracleDbType.Decimal, p_pupil_rnk, ParameterDirection.Input);
        cmdSql.Parameters.Add("p_msg", OracleDbType.Varchar2, 50000, p_msg, ParameterDirection.Output);
        cmdSql.ExecuteNonQuery();
        result = ((errMessage = (OracleString)cmdSql.Parameters["p_msg"].Value).IsNull) ? ("") : (errMessage.Value);

        return result;
    }

    protected void btnSaveKKParams_Click(object sender, EventArgs e)
    {
        if (Request["card_kiev"] == "1sch")
        {
            if (string.IsNullOrEmpty(txbx_rnk.Text)) // РНК пустой
            {
                const string messageFunction = @"barsUiAlert('Введiть правильний номер РНК школяра.', function() { });";
                ScriptManager.RegisterStartupScript(this, GetType(), "SuccessAddCardSchool", messageFunction, true);
            }

                decimal currentNd = (decimal)(Session["docNumberKK"] as List<object>)[0];
                string p_pupil_rnk = txbx_rnk.Text;

                // 1). сохраняем ид школы
                    SaveSchoolId();

                // 2). Делай два - heck_AdPupilCard
                var message = Check_AdPupilCardAdditionalCard(currentNd, Convert.ToDecimal(p_pupil_rnk), "");
                if (string.IsNullOrEmpty(message)) // ЗАПУСК ПРОЦЕДУРЫ ДОБАВЛЕНИЕ КАРТЫ УЧЕНИКА
                {
                 // 3). Делай три - heck_AdPupilCard
                    string result_create = Create_AdPupilCard(currentNd, p_pupil_rnk, DOP_CARD_TYPE.Value, 60);
                    if (!string.IsNullOrEmpty(result_create))
                    {
                        lbl_result_create_pupil.Text = result_create;
                    }
                    else
                    {
                      // 4). Делай четыре
                         Response.Redirect(GetNextPageUrl());
                    }
                }
                else
                {
                    string messageFunction = @"barsUiAlert('"+ message + "', function() { });";
                    ScriptManager.RegisterStartupScript(this, GetType(), "SuccessAddCardSchool", messageFunction, true);
                }

        }
        else
        if (CheckData())
        {
            SavePassword(tbPassWord.Text.Trim());
            SaveAddress();

            if (Session["docNumberKK"] != null)
            {
                var documentNumber = (decimal)(Session["docNumberKK"] as List<object>)[0];

                SaveAdditionalCard(documentNumber, DOP_CARD_TYPE.Value);

                const string messageFunction = @"barsUiAlert('Запит на додаткову карту КК сформовано', function() { window.location = '/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.portfolio'});";
                ScriptManager.RegisterStartupScript(this, GetType(), "SuccessAddCard", messageFunction, true);
                Session["alreadySaved"] = true;
                btnSaveKKParams.Enabled = false;
            }
            if (Request.Params["form"] == "bpkw4.ref.card")
            {
                Response.Redirect(GetNextPageUrl());
            }
        }
    }

    private void SaveSchoolId()
    {
        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        try
        {
            //тип регистрации
            OracleCommand cmdInsert = con.CreateCommand();
            OracleCommand cmdDelete = con.CreateCommand();
            cmdDelete.CommandText = "delete from customerw cw where cw.rnk = :p_rnk and cw.tag = :p_tag";
            cmdDelete.Parameters.Add("p_rnk", OracleDbType.Int64, txbx_rnk.Text, System.Data.ParameterDirection.Input);
            cmdDelete.Parameters.Add("p_tag", OracleDbType.Varchar2, KkRegisterSKTag, System.Data.ParameterDirection.Input);
            cmdDelete.ExecuteNonQuery();

            cmdInsert.CommandText = "insert into customerw (rnk, tag, value, isp) values (:p_rnk, :p_tag, :p_val, 0)";
            cmdInsert.Parameters.Add("p_rnk", OracleDbType.Int64, txbx_rnk.Text, System.Data.ParameterDirection.Input);
            cmdInsert.Parameters.Add("p_tag", OracleDbType.Varchar2, KkRegisterSKTag, System.Data.ParameterDirection.Input);
            cmdInsert.Parameters.Add("p_val", OracleDbType.Varchar2, ddl_schoolid.SelectedValue, System.Data.ParameterDirection.Input);
            cmdInsert.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            lbl_result_create_pupil.Text = ex.ToString();
        }
    }

    private string Create_AdPupilCard(decimal currentNd, string p_pupil_rnk, string dop_card_type, int term)
    {
        string result = "";
        try
        {
            OracleString errMessage = "";

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmdSql = con.CreateCommand();
            cmdSql.CommandText =
                @"begin
                  bars_ow.create_ad_pupil_card(:p_nd,
                               :p_pupil_rnk,
                               :p_cardcode,
                               :p_term);
            end;";
            cmdSql.Parameters.Add("p_nd", OracleDbType.Decimal, currentNd, ParameterDirection.Input);
            cmdSql.Parameters.Add("p_pupil_rnk", OracleDbType.Decimal, Convert.ToDecimal(p_pupil_rnk), ParameterDirection.Input);
            cmdSql.Parameters.Add("p_cardcode", OracleDbType.Varchar2, 50000, dop_card_type, ParameterDirection.Input);
            cmdSql.Parameters.Add("p_term", OracleDbType.Decimal, term, ParameterDirection.Input);
            cmdSql.ExecuteNonQuery();
            return result;
        }
        catch (Exception ex)
        {
            result = ex.Message;
            return result;
        }
    }

    private bool CheckDod(decimal docNumber)
    {
        OracleString errMessage = "";
        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmdSql = con.CreateCommand();
        cmdSql.CommandText =
            @"begin
                 bars_ow.check_dop_kk(:p_nd, :p_msg);
            end;";
        cmdSql.Parameters.Add("p_nd", OracleDbType.Decimal, docNumber, ParameterDirection.Input);
        cmdSql.Parameters.Add("p_msg", OracleDbType.Varchar2, 50000, null, ParameterDirection.Output);
        cmdSql.ExecuteNonQuery();
        string mess = ((errMessage = (OracleString)cmdSql.Parameters["p_msg"].Value).IsNull) ? ("") : (errMessage.Value);
        if (mess.Contains("вже відкрито Картку киянина"))
        {
            btnSaveKKParams.Visible = false;
            string errorMessage = "barsUiError({text:'" + mess + "'});";
            ScriptManager.RegisterStartupScript(this, GetType(), "ErrorCheckDod", errorMessage, true);
            ScriptManager.RegisterClientScriptInclude(this, GetType(), "ReadOnlyScript", ResolveClientUrl("../documentsview/ReadOnlyScript.js"));
            hasCardKiev = true;
            return false;
        }
        else if (mess != "")
        {
            btnSaveKKParams.Visible = false;
            string messageFunction = "barsUiError({text:'" + mess + "', func: function() {window.location='/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.portfolio'}});";
            ScriptManager.RegisterStartupScript(this, GetType(), "ErrorCheckDod", messageFunction, true);
            return false;
        }
        return true;
    }

    protected void tbPassWord_TextChanged(object sender, EventArgs e)
    {

    }

    protected void ddl_schooltypeid_SelectedIndexChanged(object sender, EventArgs e)
    {
        OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        try
        {
            OracleCommand cmdSQL = connect.CreateCommand();
            cmdSQL.CommandText = "select * from ow_schools where schooltypeid = :p_schooltypeid";
            var selected = ddl_schooltypeid.SelectedValue;
            cmdSQL.Parameters.Add("p_schooltypeid", OracleDbType.Decimal, selected, System.Data.ParameterDirection.Input);

            DataSet ds_result = new DataSet();
            OracleDataAdapter cardTypeAdapter = new OracleDataAdapter()
            {
                SelectCommand = cmdSQL
            };
            cardTypeAdapter.Fill(ds_result);
            ddl_schoolid.DataSource = ds_result;
            ddl_schoolid.DataTextField = "NAME";
            ddl_schoolid.DataValueField = "SCHOOLID";
            ddl_schoolid.DataBind();

        }
        finally
        {
            connect.Close();
            connect.Dispose();
        }

        if (ddl_schooltypeid.SelectedIndex!=0)
        {
            btnSaveKKParams.Visible = true;
        }
    }
}