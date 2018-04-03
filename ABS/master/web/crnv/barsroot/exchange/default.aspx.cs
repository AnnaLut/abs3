using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Globalization;
using Bars.Exception;
using Bars.Oracle;
using Bars.Classes;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;


public partial class _Default : Bars.BarsPage
{
    /// <summary>
    /// Обработка параметров строки запроса
    /// </summary>
    private void ProcessRequestParams()
    {
        if (Request.Params["check_svc"] != null && Request.Params["check_svc"].ToLower() == "true")
            this.chk_service_line.Checked = true;
        if (Request.Params["check_hdr"] != null && Request.Params["check_hdr"].ToLower() == "true")
            this.chk_header_line.Checked = true;
        if (Request.Params["encoding"] != null && Request.Params["encoding"].ToLower() == "dos")
            this.rb_dos.Checked = true;
        else if (Request.Params["encoding"] != null && Request.Params["encoding"].ToLower() == "win")
            this.rb_win.Checked = true;
        if (Request.Params["linesize"] != null)
            tbLineSize.Text = Request.Params["linesize"].ToString();
        
        if (Request.Params["inttt"] == null)
        {
            throw new BarsException("Не задано параметры inttt - внутрішня операція.");
        }
        if (Request.Params["exttt"] == null)
        {
            throw new BarsException("Не задано параметры exttt - внутрішня операція.");
        }
    }

    private void LoadFileTypes()
    {
        string dataPath = Server.MapPath("/barsroot/exchange/data/");
        if (!Directory.Exists(dataPath))
            throw new BarsException("Не знайдено директорії шаблонів для імпорту.");
        string[] templateFiles = Directory.GetFiles(dataPath,"*.xsd");
        if (templateFiles.Length == 0)
            throw new BarsException("Не знайдено жодного шаблону для імпорту.");
        foreach (string templateFile in templateFiles)
        {
            DataSet ds = new DataSet();
            ds.ReadXmlSchema(templateFile);
            string file = Convert.ToString(ds.ExtendedProperties["file"]);
            if (string.IsNullOrEmpty(file))
                file = "Шаблон імпорту [" + Path.GetFileName(templateFile) + "]";
            ddFileTypes.Items.Add(new ListItem(file, templateFile));
        }

        
    }
    private void SetTemplate(string templateFile)
    {
        if ((string)Session["exchange.Template"] == templateFile)
            return;

        DataSet ds = new DataSet();
        ds.ReadXmlSchema(templateFile);
        string encode = Convert.ToString(ds.ExtendedProperties["encode"]);
        string linesize = Convert.ToString(ds.ExtendedProperties["linesize"]);
        rb_dos.Checked = rb_win.Checked = false;
     
        if (encode == "DOS")
            rb_dos.Checked = true;
        else if (encode == "WIN")
            rb_win.Checked = true;
        else
            rb_dos.Checked = true;

        if (!string.IsNullOrEmpty(linesize))
        {
            tbLineSize.Text = linesize;
        }
        Session["exchange.Template"] = templateFile;
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ProcessRequestParams();
            LoadFileTypes();
            Session["exchange.url"] = Request.Url.PathAndQuery;
        }
        SetTemplate(ddFileTypes.SelectedValue);
    }

    /// <summary>
    /// Проверка структуры файла
    /// </summary>
    private void CheckStructure(FileStream fs)
    {
        fs.Seek(0, SeekOrigin.Begin);
        // проверка служебной строки
        if (this.chk_service_line.Checked)
        {
            byte[] bt_svc_line = new byte[100];
            byte[] bt_crlf = new byte[2];
            int nRes = fs.Read(bt_svc_line, 0, 100);
            if (nRes < 100)
                throw new BarsException("Неможливо прочитати перші 100 пробілів службової стрічки");
            bool isOk = true;
            for (int i = 0; i < 100 && isOk; ++i) if (bt_svc_line[i] != 0x20) isOk = false;
            if (!isOk)
                throw new BarsException("Відсутні перші 100 пробілів службової стрічки");
            nRes = fs.Read(bt_crlf, 0, 2);
            if (nRes < 2)
                throw new BarsException("Неможливо прочитати CRLF в конці службової стрічки");
            if (bt_crlf[0] != 0x0D || bt_crlf[1] != 0x0A)
                throw new BarsException("Відсутнє CRLF в конці службової стрічки");

        }
        // проверка заглавной строки
        if (this.chk_header_line.Checked)
        {
            throw new BarsException("Работа с заглавной строкой не поддерживается");
        }
    }

    private string Data_Asc_Hex(string Data)
    {
        string sHex = "";
        byte[] bData = System.Text.ASCIIEncoding.Default.GetBytes(Data);

        for (int i = 0; i < bData.Length; i++)
            sHex += bData[i].ToString("X");

        return sHex;
    }

    void RequiredChecker(int line, string fieldName, object obj)
    {
        if (obj == null || obj != null && obj.ToString().Length == 0)
            throw new BarsException("Не заповнено поле " + fieldName + " в стрічці " + line);
    }

    /// <summary>
    /// Чтение содержимого файла платежей
    /// </summary>
    /// <param name="fs"></param>
    private void ReadContent(FileStream fs, string strFileName)
    {
        this.InitOraConnection();
        try
        {
            this.SetRole("WR_IMPEXP");

            ArrayList db_list = this.SQL_reader(
                 "select web_utl.get_bankdate, to_char(web_utl.get_bankdate,'YYMMDD'), "
                + "DocSign.GetIdOper, "
                + "(select val from params where par='REGNCODE'), "
                + "to_char(web_utl.get_bankdate,'YYYY/MM/DD')||' '||to_char(sysdate,'HH24:MI:SS'), "
                + "extract(year from web_utl.get_bankdate), "
                + "web_impexp.get_file_md "
                + "from dual");
            DateTime dt_bankdate = Convert.ToDateTime(db_list[0]);
            string str_bankdate = Convert.ToString(db_list[1]);
            string str_tt_int = Request.Params.Get("inttt").ToUpper();
            string str_tt_ext = Request.Params.Get("exttt").ToUpper();
            string str_key_id = Convert.ToString(db_list[2]);
            string str_regncode = Convert.ToString(db_list[3]);
            string str_debug_bankdate = Convert.ToString(db_list[4]);
            int num_year = Convert.ToInt32(db_list[5]);
            string str_file_md = Convert.ToString(db_list[6]);

            // проверка: файл нашего банковского дня?
            //if (str_file_md != strFileName.Substring(6, 2))
            //    throw new BarsException("Файл " + strFileName + " не текущего банковского дня. "
            //        +"Ожидается файл по маске $B____" + str_file_md + ".___");

            // проверка: импортировали мы этот файл раньше?
            this.ClearParameters();
            this.SetParameters("p_yr", DB_TYPE.Int32, num_year, DIRECTION.Input);
            this.SetParameters("p_fn", DB_TYPE.Varchar2, strFileName, DIRECTION.Input);
            db_list = this.SQL_reader("select fn from web_import_files where yr=:p_yr and fn=:p_fn");
            if (db_list.Count > 0) throw new BarsException("Файл " + strFileName + " вже приймався.");

            this.ClearParameters();
            this.SetParameters("p_tt", DB_TYPE.Varchar2, str_tt_int, DIRECTION.Input);
            string str_int_flag = (string)this.SQL_SELECT_scalar("select substr(flags, 2, 1) from tts where tt=:p_tt");
            this.ClearParameters();
            this.SetParameters("p_tt", DB_TYPE.Varchar2, str_tt_ext, DIRECTION.Input);
            string str_ext_flag = (string)this.SQL_SELECT_scalar("select substr(flags, 2, 1) from tts where tt=:p_tt");

            DataSet ds = new DataSet();
            ds.ReadXmlSchema((string)Session["exchange.Template"]);

            Session["exchange.FileName"] = strFileName;
            int nLineCount = 0;

            int nLineSize = Convert.ToInt32(tbLineSize.Text);

            byte[] bt = new byte[nLineSize];
            int nRes = 0;
            System.Text.Encoding enc866 = System.Text.Encoding.GetEncoding(866);
            System.Text.Encoding enc1251 = System.Text.Encoding.GetEncoding(1251);
            System.Text.Encoding encUTF8 = System.Text.Encoding.UTF8;
            string str = "";
            while (fs.CanRead)
            {
                nRes = fs.Read(bt, 0, nLineSize);
                if (0 == nRes) break;
                if (nRes < nLineSize)
                    throw new BarsException("Порушена структура файлу. Довжина стрічки номер " + nLineCount + "-" + nRes + "байт при заданій довжині " + nLineSize);
                nLineCount++;
                DataRow row = ds.Tables[0].NewRow();
                if (rb_dos.Checked)
                {
                    byte[] btu = System.Text.Encoding.Convert(enc866, encUTF8, bt);
                    str = encUTF8.GetString(btu).Replace('ў', 'і');
                }
                else if (rb_win.Checked)
                {
                    byte[] btu = System.Text.Encoding.Convert(enc1251, encUTF8, bt);
                    str = encUTF8.GetString(btu);
                }

                str = str.PadRight(594);

                Int64 new_ref = 0;
                this.ClearParameters();
                this.SetParameters("new_ref", DB_TYPE.Int64, new_ref, DIRECTION.Output);
                this.SQL_NONQUERY("begin gl.ref(:new_ref); end;");
                new_ref = ((OracleDecimal)this.GetParameter("new_ref")).ToInt64();

                row["REC"] = nLineCount;
                row["REF"] = new_ref;
                row["MFOA"] = str.Substring(0, 9).Trim();
                RequiredChecker(nLineCount, "MFOA", row["MFOA"]);
                row["NLSA"] = str.Substring(9, 14).Trim();
                RequiredChecker(nLineCount, "NLSA", row["NLSA"]);
                row["MFOB"] = str.Substring(23, 9).Trim();
                RequiredChecker(nLineCount, "MFOB", row["MFOB"]);
                row["NLSB"] = str.Substring(32, 14).Trim();
                RequiredChecker(nLineCount, "NLSA", row["NLSA"]);
                try
                { row["DK"] = Convert.ToDecimal(str.Substring(46, 1)); }
                catch (FormatException fe)
                { throw new BarsException("Невірний  формат поля DK, стрічка " + nLineCount, fe); }
                // проверка: разрешено только DK=1
                if ((decimal)row["DK"] != 1)
                    throw new BarsException("Признак Дебет/Кредит не рівен 1, стрічка " + nLineCount);
                try
                { row["S"] = Convert.ToDecimal(str.Substring(47, 16)); }
                catch (FormatException fe)
                { throw new BarsException("Невірний формат поля S, стрічка " + nLineCount, fe); }
                try
                { row["SUM100"] = Convert.ToDecimal(str.Substring(47, 16)) / 100; }
                catch (FormatException fe)
                { throw new BarsException("Невірний формат поля SUM100, стрічка " + nLineCount, fe); }
                try
                { row["VOB"] = Convert.ToDecimal(str.Substring(63, 2)); }
                catch (FormatException fe)
                { throw new BarsException("Невірний формат поля VOB, стрічка " + nLineCount, fe); }
                row["ND"] = str.Substring(65, 10);
                RequiredChecker(nLineCount, "ND", row["ND"]);
                try
                { row["KV"] = Convert.ToDecimal(str.Substring(75, 3)); }
                catch (FormatException fe)
                { throw new BarsException("Невірный формат поля KV, стрічка " + nLineCount, fe); }

                // проверка: право на дебет для NLSA
                this.ClearParameters();
                this.SetParameters("p_kv", DB_TYPE.Decimal, (decimal)row["KV"], DIRECTION.Input);
                this.SetParameters("p_nls", DB_TYPE.Varchar2, (string)row["NLSA"], DIRECTION.Input);
                db_list = this.SQL_reader("select nls from saldod where kv=:p_kv and nls=:p_nls");
                if (db_list.Count == 0)
                    throw new BarsException("Рахунок " + (string)row["NLSA"]
                        + " не існує або не доступний на дебет. Стрічка " + nLineCount);
                string str_dt = str.Substring(78, 6).Trim();
                RequiredChecker(nLineCount, "DATD", str_dt);
                try
                {
                    row["DATD"] = new DateTime(
                        2000 + Convert.ToInt32(str_dt.Substring(0, 2)),
                        Convert.ToInt32(str_dt.Substring(2, 2)),
                        Convert.ToInt32(str_dt.Substring(4, 2)));
                }
                catch (FormatException fe)
                { throw new BarsException("Невірний формат поля DATD, стрічка " + nLineCount, fe); }

                row["DATP"] = dt_bankdate;
                str = str.Substring(0, 84) + str_bankdate + str.Substring(90);

                row["NAM_A"] = str.Substring(90, 38).Trim();
                RequiredChecker(nLineCount, "NAM_A", row["NAM_A"]);
                row["NAM_B"] = str.Substring(128, 38).Trim();
                RequiredChecker(nLineCount, "NAM_B", row["NAM_B"]);
                row["NAZN"] = str.Substring(166, 160).Trim();
                RequiredChecker(nLineCount, "NAZN", row["NAZN"]);
                row["D_REC"] = "";
                row["NAZNK"] = "";
                row["NAZNS"] = "10";
                str = str.Substring(0, 389) + "10" + str.Substring(391);
                row["ID_A"] = str.Substring(391, 14).Trim();
                RequiredChecker(nLineCount, "ID_A", row["ID_A"]);
                str = str.Substring(0, 391) + str.Substring(391, 14).Trim().PadLeft(14) + str.Substring(405);
                row["ID_B"] = str.Substring(405, 14).Trim();
                RequiredChecker(nLineCount, "ID_B", row["ID_B"]);
                str = str.Substring(0, 405) + str.Substring(405, 14).Trim().PadLeft(14) + str.Substring(419);
                row["REF_A"] = new_ref.ToString().PadLeft(9);
                row["ID_O"] = str_key_id;
                row["BIS"] = 0;
                str = str.Substring(0, 419) + row["REF_A"] + row["ID_O"] + " 0" + str.Substring(436);
                row["SEPBUF2SIGN"] = str.Substring(0, 444).Replace(" ", "&nbsp;");
                /*
    select nvl(rpad(nd,10),rpad(' ',10))||nvl(to_char(datd,'YYMMDD'),rpad(' ',6))    
    ||nvl(lpad(to_char(dk),1),' ')
    ||nvl(lpad(mfoa,9),rpad(' ',9))||nvl(lpad(nlsa,14),rpad(' ',14))
    ||nvl(lpad(to_char(kv),3),rpad(' ',3))||nvl(lpad(to_char(s),16),rpad(' ',16))
    ||nvl(lpad(mfob,9),rpad(' ',9))||nvl(lpad(nlsb,14),rpad(' ',14))
    ||nvl(lpad(to_char(kv2),3),rpad(' ',3))||nvl(lpad(to_char(s2),16),rpad(' ',16))
                 */
                string STR_INTBUF2SIGN =
                      row["ND"].ToString().PadRight(10)
                    + str.Substring(78, 6).Trim() // DATD
                    + row["DK"].ToString()
                    + row["MFOA"].ToString().PadLeft(9)
                    + row["NLSA"].ToString().PadLeft(14)
                    + row["KV"].ToString()
                    + row["S"].ToString().PadLeft(16)
                    + row["MFOB"].ToString().PadLeft(9)
                    + row["NLSB"].ToString().PadLeft(14)
                    + row["KV"].ToString()
                    + row["S"].ToString().PadLeft(16)
                    ;
                byte[] BT_INTBUF2SIGN = enc1251.GetBytes(STR_INTBUF2SIGN);
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                foreach (byte b in BT_INTBUF2SIGN)
                    sb.Append(Convert.ToString(b, 16));
                string HEX_INTBUF2SIGN = sb.ToString().ToUpper();
                row["INTBUF2SIGN"] = HEX_INTBUF2SIGN.Replace(" ", "&nbsp;");
                ds.Tables[0].Rows.Add(row);
            }
            Session["exchange.LineCount"] = nLineCount;
            Session["exchange.ds"] = ds;
            Session["exchange.bankdate"] = str_bankdate;
            Session["exchange.tt_int"] = str_tt_int;
            Session["exchange.tt_ext"] = str_tt_ext;
            Session["exchange.key_id"] = str_key_id;
            Session["exchange.int_flag"] = str_int_flag;
            Session["exchange.ext_flag"] = str_ext_flag;
            Session["exchange.regncode"] = str_regncode;
            Session["exchange.debug_bankdate"] = str_debug_bankdate;
        }
        finally
        {
            this.DisposeOraConnection();
        }
    }

    /// <summary>
    /// Импорт файла платежей
    /// </summary>
    /// <param name="strFilePath"></param>
    /// <param name="strFileName"></param>
    private void ImportFile(string strFilePath, string strFileName)
    {
        FileStream fs = new FileStream(strFilePath, FileMode.Open, FileAccess.Read, FileShare.None);
        try
        {
            CheckStructure(fs);
            ReadContent(fs, strFileName.ToUpper());
            this.Response.Redirect("payments.aspx");
        }
        finally
        {
            fs.Close();
        }
    }

    protected void bt_submit_Click(object sender, EventArgs e)
    {
        if (fu_import.HasFile)
        {
            string strTempFileName = Path.GetTempFileName();
            string strTempFilePath = strTempFileName + "." + fu_import.FileName;
            fu_import.PostedFile.SaveAs(strTempFilePath);

            try
            {
                ImportFile(strTempFilePath, fu_import.FileName);
            }
            catch (BarsException be)
            {
                label_error.Visible = true;
                text_error.Visible = true;
                text_error.Text = be.Message;
            }
            finally
            {
                File.Delete(strTempFilePath);
                File.Delete(strTempFileName);
            }
        }
        else
        {
            label_error.Visible = true;
            text_error.Visible = true;
            text_error.Text = "Не задано файл для імпорту";
        }
    }
    protected void rb_win_CheckedChanged(object sender, EventArgs e)
    {

    }
    protected void ddFileTypes_SelectedIndexChanged(object sender, EventArgs e)
    {
        SetTemplate(ddFileTypes.SelectedValue);
    }
}
