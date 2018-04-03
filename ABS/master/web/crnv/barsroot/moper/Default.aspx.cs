using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Collections;
using Bars.Doc;
using Bars.Classes;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Globalization;


public partial class _Default : Bars.BarsPage
{
    private string TempDirName = "MOPER";
    private DBFFile MOPERFile;
    private MOperErr CurErr = null;
    ArrayList Hidden_Controls = new ArrayList();
    //------------------------------------------------------
    protected void Page_Load(object sender, EventArgs e)
    {
        // если мы перешли к подписыванию
        if (AvtomatState.Value == "4")
        {
            for (int i = 0; i < grd_Data.Rows.Count; i++)
                Hidden_Controls.Add(grd_Data.Rows[i].Cells[0].Text);

            CreateHiddenFields();
        }
    }
    protected override void OnPreRender(EventArgs e)
    {
        switch (AvtomatState.Value)
        {
            // начало работы
            case "0":
                SetAvtomatState(0);
                break;

            // выбрали файл данных, переходим к системной проверке
            case "1":

                string tempPath = CreateTempFolder();
                DBFFileFirstName.Value = MakeFileName(ed_MOperFile.PostedFile.FileName);
                DBFFilePath.Value = tempPath + "\\" + CreateTempFileName(DBFFileFirstName.Value);

                ed_MOperFile.PostedFile.SaveAs(DBFFilePath.Value);

                FileInfo file = new FileInfo(DBFFilePath.Value);
                MOPERFile = new DBFFile(file, Server.MapPath("/barsroot/moper"), DBFFileFirstName.Value);

                // системная проверка
                if ((CurErr = MOPERFile.SystemCheck()).HasErr) AvtomatState.Value = "6";
                else AvtomatState.Value = "2";

                OnPreRender(e);

                break;

            // конвертация данных в необходимый формат и формирование недостающих данных
            case "2":
                // смотрим переданные операции для ввода
                // по дефолту стоят NM1, NM2, NMI, NMU, NMD
                if (Request.Params.Get("inttt") != null) MOPERFile.IntTT = Request.Params.Get("inttt").ToUpper();
                if (Request.Params.Get("exttt") != null) MOPERFile.ExtTT = Request.Params.Get("exttt").ToUpper();
                if (Request.Params.Get("infexttt") != null) MOPERFile.InfExtTT = Request.Params.Get("infexttt").ToUpper();
                if (Request.Params.Get("infinttt") != null) MOPERFile.InfIntTT = Request.Params.Get("infinttt").ToUpper();
                if (Request.Params.Get("infdebtt") != null) MOPERFile.InfDebTT = Request.Params.Get("infdebtt").ToUpper();

                if ((CurErr = MOPERFile.ConvertDataToNewScheme()).HasErr) AvtomatState.Value = "6";
                else AvtomatState.Value = "3";

                OnPreRender(e);

                break;

            // проверку содержимого и формирование недостающих данных
            case "3":
                //if ((CurErr = MOPERFile.ContentsCheck()).HasErr) AvtomatState.Value = "6";
                //else
                    AvtomatState.Value = "4";

                OnPreRender(e);

                break;

            // Отображение и Подпись
            case "4":
                SetAvtomatState(4);

                // берем глобальные параметры
                InitOraConnection();
                try
                {
                    SetRole("WR_MOPER");

                    SEPNUM.Value = Convert.ToString(SQL_SELECT_scalar("SELECT NVL( min(to_number(VAL)),1 ) FROM PARAMS WHERE PAR = 'SEPNUM'"));
                    SIGNTYPE.Value = Convert.ToString(SQL_SELECT_scalar("SELECT NVL(min(val),'NBU') FROM PARAMS WHERE PAR = 'SIGNTYPE'"));
                    SIGNLNG.Value = Convert.ToString(SQL_SELECT_scalar("SELECT chk.get_SignLng FROM dual"));
                    DOCKEY.Value = Convert.ToString(SQL_SELECT_scalar("SELECT docsign.getIdOper() FROM dual"));
                    BDATE.Value = Convert.ToString(SQL_SELECT_scalar("SELECT to_char(web_utl.get_bankdate, 'yyyy/MM/dd hh:mm:ss') FROM dual"));
                    VISASIGN.Value = Convert.ToString(SQL_SELECT_scalar("SELECT NVL( min(to_number(VAL)),1 ) FROM PARAMS WHERE PAR = 'VISASIGN'"));
                    INTSIGN.Value = Convert.ToString(SQL_SELECT_scalar("SELECT NVL( min(to_number(VAL)),1 ) FROM PARAMS WHERE PAR = 'INTSIGN'"));
                    REGNCODE.Value = Convert.ToString(SQL_SELECT_scalar("SELECT NVL( min(to_number(VAL)),1 ) FROM PARAMS WHERE PAR = 'REGNCODE'"));
                }
                finally
                { DisposeOraConnection(); }

                grd_Data.DataSource = MOPERFile.TableData;
                grd_Data.DataBind();
                lbCountVal.Text = grd_Data.Rows.Count.ToString();
                for (int i = 0; i < grd_Data.Rows.Count; i++)
                    Hidden_Controls.Add(grd_Data.Rows[i].Cells[0].Text);

                CreateHiddenFields();

                break;

            // Получили подписи, оплачиваем
            case "5":
                CurErr = new MOperErr();

                // культура
                CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
                cinfo.DateTimeFormat.FullDateTimePattern = "dd.MM.yyyy";
                cinfo.DateTimeFormat.DateSeparator = ".";
                cinfo.DateTimeFormat.TimeSeparator = ":";

                // смотрим небыло ли при подписи ошибок
                if (ScriptErrors.Value == "1")
                {
                    CurErr.SetErr(Resources.moper.GlobalResource.Msg_OshibkaPodpisi);
                }
                else
                {
                    bool fCommit = false;
                    OracleTransaction tx;
                    OracleConnection con = OraConnector.Handler.UserConnection;
                    OracleCommand cmd = new OracleCommand();
                    cmd.Connection = con;
                    tx = con.BeginTransaction();
                    try
                    {
                        cmd.CommandText = "SET ROLE WR_MOPER";
                        cmd.ExecuteNonQuery();

                        for (int i = 0; i < grd_Data.Rows.Count; i++)
                        {
                            /*
                            0  REF
                            1  ND
                            2  MFOA
                            3  NLSA
                            4  OKPOA
                            5  S
                            6  MFOB
                            7  NLSB
                            8  OKPOB
                            9  NAMEB
                            10 NAMEA
                            11 NAZN
                            12 DK
                            13 DATD
                            14 VDAT
                            15 TT
                            16 VOB
                            17 FLI
                            18 INPUTSIGNFLAG
                            19 NOMINAL
                            20 SEPBUF
                            21 INTBUF
                            22 PRTY  
                            23 KV
                            24 SK
                            */

                            GridViewRow row = grd_Data.Rows[i];

                            long Ref = Convert.ToInt64(row.Cells[0].Text);
                            string TT = Convert.ToString(row.Cells[15].Text);
                            byte Dk = Convert.ToByte(row.Cells[12].Text);
                            string OperId = DOCKEY.Value;
                            string Nd = Convert.ToString(row.Cells[1].Text);
                            DateTime DatD = Convert.ToDateTime(row.Cells[13].Text, cinfo);

                            string NlsA = Convert.ToString(row.Cells[3].Text);
                            string NamA = Convert.ToString(row.Cells[10].Text);
                            string BankA = Convert.ToString(row.Cells[2].Text);
                            short KvA = Convert.ToInt16(row.Cells[23].Text);
                            string OkpoA = Convert.ToString(row.Cells[4].Text);

                            string NlsB = Convert.ToString(row.Cells[7].Text);
                            string NamB = Convert.ToString(row.Cells[9].Text);
                            string BankB = Convert.ToString(row.Cells[6].Text);
                            short KvB = Convert.ToInt16(row.Cells[23].Text);
                            string OkpoB = Convert.ToString(row.Cells[8].Text);
                            short prty = Convert.ToInt16(row.Cells[22].Text);

                            string Nazn = Convert.ToString(row.Cells[11].Text);

                            decimal kopA = 1;
                            decimal kopB = 1;

                            string decSep = System.Threading.Thread.CurrentThread.CurrentCulture.NumberFormat.NumberDecimalSeparator;
                            string correctSum = row.Cells[5].Text.Replace(" ", "").Replace(".", decSep).Replace(",", decSep);
                            decimal SA = Convert.ToDecimal(Convert.ToDouble(correctSum) * 100);
                            decimal SB = Convert.ToDecimal(Convert.ToDouble(correctSum) * 100);

                            cmd.CommandText = "SELECT web_utl.get_bankdate FROM dual";
                            DateTime DatP = Convert.ToDateTime(cmd.ExecuteScalar(), cinfo);

                            DateTime DatV1 = Convert.ToDateTime(row.Cells[14].Text, cinfo);
                            DateTime DatV2 = Convert.ToDateTime(row.Cells[14].Text, cinfo);

                            byte Sk = Convert.ToByte(row.Cells[24].Text);
                            short Vob = Convert.ToInt16(row.Cells[16].Text);

                            // внешняя ЭЦП
                            string ExtSignHex = GetHiddenFieldValue(Convert.ToString(Ref), "ext");
                            byte[] Sign = new byte[ExtSignHex.Length / 2];
                            for (int k = 0; k < Sign.Length; k += 1)
                                Sign[k] = Convert.ToByte(ExtSignHex.Substring(k * 2, 2), 16);

                            // внутренняя ЭЦП
                            string IntSignHex = GetHiddenFieldValue(Convert.ToString(Ref), "int");

                            cDoc ourDoc = new cDoc(con, Ref, TT, Dk, Vob, Nd, DatD, DatP, DatV1, DatV2, NlsA, NamA, BankA, "", KvA, SA, OkpoA, NlsB, NamB, BankB, "", KvB, SB, OkpoB, Nazn, "", OperId, Sign, Sk, prty, 0, ExtSignHex, IntSignHex, string.Empty, string.Empty);
                            ourDoc.Nom = 0;

                            try
                            {
                                if (!ourDoc.oDocument())
                                {
                                    CurErr.SetErr(Resources.moper.GlobalResource.Msg_Dokument + " №" + Ref + " " + Resources.moper.GlobalResource.Msg_NeOplachen);
                                }
                                else
                                    Bars.Logger.DBLogger.Financial("Импорт Moper: док Ref" + Ref + ": " + NlsA + "(" + KvA + ") " + SA.ToString("F0") + " -> " + BankB + " " + NlsB + "(" + KvB + ") " + SB.ToString("F0") + "[" + NamB + "],[" + Nazn + "] " + OperId);
                            }
                            catch (Exception exc)
                            {
                                CurErr.SetErr(exc.Message);
                            }
                        }

                        // делаем запись про добавление
                        if (!CurErr.HasErr)
                        {
                            file = new FileInfo(DBFFilePath.Value);
                            MOPERFile = new DBFFile(file, Server.MapPath("/barsroot/moper"), DBFFileFirstName.Value);
                            MOPERFile.SystemCheck();

                            cmd.CommandText = "SET ROLE WR_MOPER";
                            cmd.ExecuteNonQuery();

                            cmd.Parameters.Add("fname", OracleDbType.Varchar2, DBFFileFirstName.Value, ParameterDirection.Input);
                            cmd.Parameters.Add("fsum", OracleDbType.Varchar2, MOPERFile.CheckSum, ParameterDirection.Input);
                            cmd.CommandText = "INSERT INTO MOPER_ACCERTED_FILES(FNAME, FSUM) VALUES(:fname, :fsum)";
                            cmd.ExecuteNonQuery();

                            fCommit = true;
                        }
                        else
                            fCommit = false;
                    }
                    finally
                    {
                        if (fCommit) tx.Commit(); else tx.Rollback();
                        con.Close();
                        con.Dispose();
                    }
                }

                AvtomatState.Value = "6";
                OnPreRender(e);

                break;

            // состояние отображения ошибок или успешного выполнения 
            case "6":
                SetAvtomatState(6);

                // Удаляем файл 
                try
                {
                    File.Delete(DBFFilePath.Value);
                }
                catch { }
                if (CurErr != null && CurErr.HasErr)
                {
                    lb_Err.InnerHtml = CurErr.GetHtmlView();
                }
                else
                {
                    lb_Err.InnerText = Resources.moper.GlobalResource.Msg_FailUspechnoOplachen;
                }

                break;

        }
    }
    protected void bt_MOperFileUpload_Click(object sender, EventArgs e)
    {
        if (ed_MOperFile.HasFile) AvtomatState.Value = "1";
        else
        {
            CurErr = new MOperErr();
            CurErr.SetErr(Resources.moper.GlobalResource.Msg_NeobhodimoVybratFailTipaODD);
            AvtomatState.Value = "6";
        }
    }
    protected void bt_Pay_ServerClick(object sender, EventArgs e)
    {
        AvtomatState.Value = "5";
    }

    // ==========================================================================
    //                      Для системных нужд :)
    // ==========================================================================


    /// <summary>
    /// Возвращает имя файла с расширением dbf с полного пути
    /// </summary>
    /// <param name="fullPath">Полный путь</param>
    /// <returns>Обрезаное имя файла с расширением dbf</returns>
    private string MakeDbfFileName(string fullPath)
    {
        int idx1 = fullPath.LastIndexOf(".");
        string fileName = fullPath.Substring(0, idx1) + ".dbf";
        return fileName;
    }
    /// <summary>
    /// Возвращает имя файла с полного пути
    /// </summary>
    /// <param name="fullPath"></param>
    /// <returns></returns>
    private string MakeFileName(string fullPath)
    {
        int idx1 = fullPath.LastIndexOf("\\");

        string fileName = fullPath.Substring(idx1 + 1);

        return fileName;
    }
    /// <summary>
    /// Создает или берет и возвращает темповую директорию в TempDir
    /// </summary>
    private string CreateTempFolder()
    {
        string tempDirPath = Path.GetTempPath() + TempDirName;

        if (!Directory.Exists(tempDirPath))
            Directory.CreateDirectory(tempDirPath);

        return tempDirPath;
    }
    /// <summary>
    /// Создает уникальное имя файла на базе заданого
    /// </summary>
    private string CreateTempFileName(string fName)
    {
        Random rndm = new Random();
        string uniqueNumber = Convert.ToString(rndm.Next(100000, 999999));

        string name = fName.Substring(0, fName.LastIndexOf("."));
        string ext = fName.Substring(fName.LastIndexOf("."));

        name = ""; //!!!Потомучто ДБФ у которого имя больше 8 символов работать не будет

        string res = name + uniqueNumber + ext;
        return res;
    }
    /// <summary>
    /// Создает скрытые поля на странице
    /// </summary>
    private void CreateHiddenFields()
    {
        for (int i = 0; i < Hidden_Controls.Count; i++)
        {
            string nameInt = "ed_hid_int_" + Convert.ToString(Hidden_Controls[i]).ToLower();
            string nameExt = "ed_hid_ext_" + Convert.ToString(Hidden_Controls[i]).ToLower();

            HtmlInputHidden ed_hid_int = new HtmlInputHidden();
            ed_hid_int.ID = nameInt;
            hid_Signs.Controls.Add(ed_hid_int);

            HtmlInputHidden ed_hid_ext = new HtmlInputHidden();
            ed_hid_ext.ID = nameExt;
            hid_Signs.Controls.Add(ed_hid_ext);
        }
    }
    /// <summary>
    /// Возвращает значение скрытого поля
    /// </summary>
    /// <param name="refNo">Референс</param>
    /// <param name="IntExt">int/ext - внутр, внеш подпись</param>
    /// <returns>Строковое представление подписи</returns>
    private string GetHiddenFieldValue(string refNo, string IntExt)
    {
        string editName = "ed_hid_" + IntExt + "_" + refNo;

        for (int i = 0; i < hid_Signs.Controls.Count; i++)
            if (((HtmlInputHidden)hid_Signs.Controls[i]).ID == editName)
                return ((HtmlInputHidden)hid_Signs.Controls[i]).Value;

        return null;
    }
    /// <summary>
    /// Устанавливает параметры отображения в зависимости от состояния
    /// </summary>
    /// <param name="state">Состояние автомата</param>
    private void SetAvtomatState(int state)
    {
        switch (state)
        {
            case 0:
            case 1:
            case 2:
            case 3:
                td_MOperFileTitle.Visible = true;
                td_MOperFile.Visible = true;

                td_DataTable.Visible = false;
                td_DataTableKeys.Visible = false;

                td_Err.Visible = false;

                break;
            case 4:
            case 5:
                td_MOperFileTitle.Visible = false;
                td_MOperFile.Visible = false;

                td_DataTable.Visible = true;
                td_DataTableKeys.Visible = true;

                td_Err.Visible = false;

                break;
            case 6:
                td_MOperFileTitle.Visible = false;
                td_MOperFile.Visible = false;

                td_DataTable.Visible = false;
                td_DataTableKeys.Visible = false;

                td_Err.Visible = true;

                break;
        }
    }
}
