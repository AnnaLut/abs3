using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

using System.IO;
using System.Drawing;
using System.Drawing.Imaging;

using Bars.UserControls;

public partial class UserControls_dialogs_ScanIdDocs : System.Web.UI.Page
{
    # region Приватные свойства
    private Button _btnPrevious;
    private Button _btnNext;
    private Int16? _DocType;
    private Boolean? _HasInn;
    private Int16? _SpecialMark;

    private Int16? _EAStructID_Doc;
    private Int16? _EAStructID_Doc_Copy;
    private Int16? _EAStructID_Inn;
    private Int16? _EAStructID_Inn_Copy;
    private Int16? _EAStructID_SpecialDoc;
    private Int16? _EAStructID_SpecialDoc_Copy;

    private IDDocScheme _DocScheme;
    # endregion

    # region Публичные свойства
    public Button btnPrevious
    {
        get
        {
            if (_btnPrevious == null)
                GetNavigationButtons(out _btnPrevious, out _btnNext);
            return _btnPrevious;
        }
    }
    public Button btnNext
    {
        get
        {
            if (_btnNext == null)
                GetNavigationButtons(out _btnPrevious, out _btnNext);
            return _btnNext;
        }
    }

    public Int64 RNK
    {
        get
        {
            return Convert.ToInt64(Request.Params.Get("rnk"));
        }
    }
    public Int16 DocType
    {
        get
        {
            if (!_DocType.HasValue)
                GetRnkParams(out _DocType, out _HasInn);

            return _DocType.Value;
        }
    }
    public Boolean HasInn
    {
        get
        {
            if (!_HasInn.HasValue)
                GetRnkParams(out _DocType, out _HasInn);

            return _HasInn.Value;
        }
    }

    public Int16? SpecialMark
    {
        get
        {
            if (!_SpecialMark.HasValue)
                _SpecialMark = GetSpecialMark();

            return _SpecialMark;
        }
    }

    public Int16 EAStructID_Doc
    {
        get
        {
            if (!_EAStructID_Doc.HasValue)
                GetEAStructIDs(DocType, HasInn, SpecialMark, out _EAStructID_Doc, out _EAStructID_Doc_Copy, out _EAStructID_Inn, out _EAStructID_Inn_Copy, out _EAStructID_SpecialDoc, out _EAStructID_SpecialDoc_Copy);
            return _EAStructID_Doc.Value;
        }
    }
    public Int16 EAStructID_Doc_Copy
    {
        get
        {
            if (!_EAStructID_Doc_Copy.HasValue)
                GetEAStructIDs(DocType, HasInn, SpecialMark, out _EAStructID_Doc, out _EAStructID_Doc_Copy, out _EAStructID_Inn, out _EAStructID_Inn_Copy, out _EAStructID_SpecialDoc, out _EAStructID_SpecialDoc_Copy);
            return _EAStructID_Doc_Copy.Value;
        }
    }
    public Int16 EAStructID_Inn
    {
        get
        {
            if (!_EAStructID_Inn.HasValue)
                GetEAStructIDs(DocType, HasInn, SpecialMark, out _EAStructID_Doc, out _EAStructID_Doc_Copy, out _EAStructID_Inn, out _EAStructID_Inn_Copy, out _EAStructID_SpecialDoc, out _EAStructID_SpecialDoc_Copy);
            return _EAStructID_Inn.Value;
        }
    }
    public Int16 EAStructID_Inn_Copy
    {
        get
        {
            if (!_EAStructID_Inn_Copy.HasValue)
                GetEAStructIDs(DocType, HasInn, SpecialMark, out _EAStructID_Doc, out _EAStructID_Doc_Copy, out _EAStructID_Inn, out _EAStructID_Inn_Copy, out _EAStructID_SpecialDoc, out _EAStructID_SpecialDoc_Copy);
            return _EAStructID_Inn_Copy.Value;
        }
    }
    public Int16 EAStructID_SpecialDoc
    {
        get
        {
            if (!_EAStructID_SpecialDoc.HasValue)
                GetEAStructIDs(DocType, HasInn, SpecialMark, out _EAStructID_Doc, out _EAStructID_Doc_Copy, out _EAStructID_Inn, out _EAStructID_Inn_Copy, out _EAStructID_SpecialDoc, out _EAStructID_SpecialDoc_Copy);
            return _EAStructID_SpecialDoc.Value;
        }
    }
    public Int16 EAStructID_SpecialDoc_Copy
    {
        get
        {
            if (!_EAStructID_SpecialDoc_Copy.HasValue)
                GetEAStructIDs(DocType, HasInn, SpecialMark, out _EAStructID_Doc, out _EAStructID_Doc_Copy, out _EAStructID_Inn, out _EAStructID_Inn_Copy, out _EAStructID_SpecialDoc, out _EAStructID_SpecialDoc_Copy);
            return _EAStructID_SpecialDoc_Copy.Value;
        }
    }

    public IDDocScheme DocScheme
    {
        get
        {
            if (_DocScheme == null) _DocScheme = new IDDocScheme();
            return _DocScheme;
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void wzd_ActiveStepChanged(object sender, EventArgs e)
    {
        // заголовок
        wzd.HeaderText = wzd.ActiveStep.Title;

        String CurrentStepID = wzd.ActiveStep.ID;

        // выполняем проверку схемы работы с идент док
        switch (CurrentStepID)
        {
            // Сканування/фотографування документу, що посвідчує особу
            case "scan_doc":
                // переходим дальше если сканирование/фото паспорта не нужно
                if (DocScheme.ClientPhoto != 1 &&
                    DocScheme.ClientSign != 1 &&
                    DocScheme.DocsOriginals != 1 &&
                    DocScheme.DocsSignedCopies != 1)
                {
                    WizardMoveNext();
                    return;
                }
                else
                {
                    byte[] scannedDoc = GetDataFromEA(new[] {EAStructID_Doc});
                    scDoc.Value = scannedDoc;
                }
                break;
            case "cut_photo":
                // переходим дальше если вырезание фото не нужно
                if (DocScheme.ClientPhoto != 1)
                {
                    WizardMoveNext();
                    return;
                }
                break;
            case "wc_photo":
                // переходим дальше если захват фото через веб-камеру не нужен
                if (DocScheme.ClientPhoto != 2)
                {
                    WizardMoveNext();
                    return;
                }
                break;
            case "cut_sign":
                // переходим дальше если вырезание подписи не нужно
                if (DocScheme.ClientSign != 1)
                {
                    WizardMoveNext();
                    return;
                }
                break;
            case "scan_inn":
                // переходим дальше если сканирование/фото ИНН не нужно
                if (DocScheme.DocsOriginals != 1 &&
                    DocScheme.DocsSignedCopies != 1)
                {
                    WizardMoveNext();
                    return;
                }
                else
                {   byte[] scannedInn = GetDataFromEA(new[] {EAStructID_Inn});
                    scInn.Value = scannedInn;
                }
                break;
            case "scan_SpecialDoc":
                // переходим дальше если сканирование/фото докум. не нужно или для спец.отметки сканирование не нужно
                if ((DocScheme.DocsOriginals != 1 && DocScheme.DocsSignedCopies != 1) || !ScanSpecialDoc(SpecialMark))
                {
                    WizardMoveNext();
                    return;
                }
                else
                {
                    byte[] scannedSpecialDoc = GetDataFromEA(new[] { EAStructID_SpecialDoc });
                    scSpecialDoc.Value = scannedSpecialDoc;
                }
                break;
            case "print_pagecount":
                // переходим дальше если ввод кол-ва страничек не нужен
                if (DocScheme.DocsOriginals != 2 &&
                    DocScheme.DocsSignedCopies != 2)
                {
                    WizardMoveNext();
                    return;
                }
                break;
            case "print":
                // переходим дальше если заверенные копии не нужны
                if (DocScheme.DocsSignedCopies == 0)
                {
                    WizardMoveNext();
                    return;
                }
                break;

            case "print_SpecialDoc":
                // переходим дальше если заверенные копии не нужны или не указана спец.отметка
                if (DocScheme.DocsSignedCopies == 0 || !ScanSpecialDoc(SpecialMark))
                {
                    WizardMoveNext();
                    return;
                }
                break;
        }

        // дополнительные настройки контролов
        switch (CurrentStepID)
        {
            case "scan_doc":
                btnNext.Enabled = true;
                break;
            case "cut_photo":
                // для вырезки фото берем сканкопию паспорта
                bicCutPhoto.Value = scDoc.Value;
                btnNext.Enabled = false;
                break;
            case "wc_photo":
                btnNext.Enabled = true;
                break;
            case "cut_sign":
                // для вырезки подписи берем сканкопию паспорта
                bicCutSign.Value = scDoc.Value;
                btnNext.Enabled = false;
                break;
            case "scan_inn":
                break;
            case "print":
                // проставляем параметры печати документов
                eadDoc.RNK = this.RNK;
                eadDoc.EAStructID = this.EAStructID_Doc_Copy;

                eadInn.RNK = this.RNK;
                eadInn.EAStructID = this.EAStructID_Inn_Copy;

                // сохраняем сканкопию в БД для последующей печати
                OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
                try
                {
                    switch (DocScheme.DocsSignedCopies)
                    {
                        case 1:
                            CreatePrintSession("PS_DOC_" + Convert.ToString(this.RNK), scDoc.Value, con);
                            CreatePrintSession("PS_INN_" + Convert.ToString(this.RNK), scInn.Value, con);
                            break;
                        case 2:
                            CreateBlankPrintSession("PS_DOC_" + Convert.ToString(this.RNK), Convert.ToInt16(ddlDocPageCount.SelectedValue), con);
                            CreateBlankPrintSession("PS_INN_" + Convert.ToString(this.RNK), 1, con);
                            break;
                    }
                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
                break;
            case "print_SpecialDoc":
                // проставляем параметры печати документов
                eadSpecialDoc.RNK = this.RNK;
                eadSpecialDoc.EAStructID = this.EAStructID_SpecialDoc_Copy;

                // сохраняем сканкопию в БД для последующей печати
                OracleConnection con1 = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
                try
                {
                    switch (DocScheme.DocsSignedCopies)
                    {
                        case 1:
                            CreatePrintSession("PS_SPDOC_" + Convert.ToString(this.RNK), scSpecialDoc.Value, con1);
                            break;
                        case 2:
                            CreateBlankPrintSession("PS_SPDOC_" + Convert.ToString(this.RNK), 1, con1); // ??? кол. страниц
                            break;
                    }
                }
                finally
                {
                    con1.Close();
                    con1.Dispose();
                }
                break;
        }
    }
    protected void wzd_NextButtonClick(object sender, WizardNavigationEventArgs e)
    {
        String CurrentStepID = wzd.WizardSteps[e.CurrentStepIndex].ID;

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        try
        {
            switch (CurrentStepID)
            {
                case "cut_photo":
                    // сохраняем то что вырезали
                    SaveImage("PHOTO", bicCutPhoto.Value);
                    break;
                case "wc_photo":
                    // сохраняем то что сфоткали
                    SaveImage("PHOTO", scWCPhoto.Value);
                    break;
                case "cut_sign":
                    // сохраняем то что вырезали
                    SaveImage("SIGN", bicCutSign.Value);
                    break;
            }
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }
    protected void bicCutPhoto_DocumentSaved(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", String.Format("alert('{0}'); ", "Фото клієнта збережено"), true);
        btnNext.Enabled = true;
    }
    protected void bicCutSign_DocumentSaved(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", String.Format("alert('{0}'); ", "Підпис клієнта збережено"), true);
        btnNext.Enabled = true;
    }
    protected void eadDoc_DocSigned(object sender, EventArgs e)
    {
        if (DocScheme.DocsOriginals == 1)
        {
            // отправляем сканкопию в ЭА
            Bars.EAD.EadPack ep = new Bars.EAD.EadPack(new ibank.core.BbConnection());
            Decimal? DOC_ID = ep.DOC_CREATE("SCAN", null, scDoc.Value, this.EAStructID_Doc, this.RNK);
            ep.DOC_SIGN(DOC_ID);
        }
    }
    protected void eadInn_DocSigned(object sender, EventArgs e)
    {
        if (DocScheme.DocsOriginals == 1)
        {
            // отправляем сканкопию в ЭА
            Bars.EAD.EadPack ep = new Bars.EAD.EadPack(new ibank.core.BbConnection());
            Decimal? DOC_ID = ep.DOC_CREATE("SCAN", null, scInn.Value, this.EAStructID_Inn, this.RNK);
            ep.DOC_SIGN(DOC_ID);
        }
    }
    protected void eadSpecialDoc_DocSigned(object sender, EventArgs e)
    {
        if (DocScheme.DocsOriginals == 1)
        {
            // отправляем сканкопию в ЭА
            Bars.EAD.EadPack ep = new Bars.EAD.EadPack(new ibank.core.BbConnection());
            Decimal? DOC_ID = ep.DOC_CREATE("SCAN", null, scSpecialDoc.Value, this.EAStructID_SpecialDoc, this.RNK);
            ep.DOC_SIGN(DOC_ID);
        }
    }

    protected void wzd_FinishButtonClick(object sender, WizardNavigationEventArgs e)
    {
        // чистим сессию печати
        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        try
        {
            ClearPrintSession("PS_DOC_" + Convert.ToString(this.RNK), con);
            ClearPrintSession("PS_INN_" + Convert.ToString(this.RNK), con);
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        // закрываем диалог
        ScriptManager.RegisterStartupScript(this, this.GetType(), "close_dialog", "window.returnValue = true; window.close(); ", true);
    }
    protected override void OnPreRender(EventArgs e)
    {
        if (!IsPostBack)
            wzd_ActiveStepChanged(null, null);

        base.OnPreRender(e);
    }
    # endregion

    # region Приватные методы
    private void GetNavigationButtons(out Button btnPrevious, out Button btnNext)
    {
        switch (wzd.ActiveStep.StepType)
        {
            case WizardStepType.Start:
                btnPrevious = null;
                btnNext = wzd.FindControl("StartNavigationTemplateContainerID$btnNext") as Button;
                break;
            case WizardStepType.Finish:
                btnPrevious = wzd.FindControl("FinishNavigationTemplateContainerID$btnPrevious") as Button;
                btnNext = wzd.FindControl("FinishNavigationTemplateContainerID$btnNext") as Button;
                break;
            default:
                btnPrevious = wzd.FindControl("StepNavigationTemplateContainerID$btnPrevious") as Button;
                btnNext = wzd.FindControl("StepNavigationTemplateContainerID$btnNext") as Button;
                break;
        }
    }
    private void GetRnkParams(out Int16? DocType, out Boolean? HasInn)
    {
        DocType = 1;
        HasInn = true;

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        try
        {
            cmd.CommandText = "select c.okpo, p.passp from customer c, person p where c.rnk = :p_rnk and c.rnk = p.rnk";
            cmd.Parameters.Add("p_rnk", OracleDbType.Int64, this.RNK, System.Data.ParameterDirection.Input);

            OracleDataReader rdr = cmd.ExecuteReader();
            if (rdr.Read())
            {
                DocType = Convert.ToInt16(rdr["passp"]);
                HasInn = rdr["okpo"] != DBNull.Value && (String)rdr["okpo"] != "0000000000";
            }
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <returns>Код "Особливої відмітки" клієнта ФО</returns>
    private Int16? GetSpecialMark()
    {
        Int16? SpecialMark = null;

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

        OracleCommand cmd = con.CreateCommand();

        try
        {
            cmd.CommandText = "select VALUE from customerW where rnk = :p_rnk and tag = 'SPMRK' ";

            cmd.Parameters.Add("p_rnk", OracleDbType.Int64, this.RNK, System.Data.ParameterDirection.Input);

            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                if (!rdr.IsDBNull(0))
                {
                    SpecialMark = Convert.ToInt16(rdr.GetOracleString(0).Value);
                }
            }
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        return SpecialMark;
    }

    /// <summary>
    /// Необхідність сканування додаткового документу для 
    /// </summary>
    /// <returns></returns>
    private Boolean ScanSpecialDoc(Int16? SpecialMark)
    {
        Boolean NeedScan = false;

        if (SpecialMark.HasValue)
        {
            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

            OracleCommand cmd = con.CreateCommand();

            try
            {
                cmd.CommandText = "select NEED_DOCS from CUST_MARK_TYPES where MARK_CODE = :p_code";

                cmd.Parameters.Add("p_code", OracleDbType.Int64, SpecialMark.Value, System.Data.ParameterDirection.Input);

                OracleDataReader rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    if (!rdr.IsDBNull(0))
                    {
                        NeedScan = rdr.GetOracleDecimal(0).Value.Equals(1);
                    }
                }
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }

        return NeedScan;
    }

    private void GetEAStructIDs(Int16 DocType, Boolean HasInn, Int16? SpecialMark, out Int16? EAStructID_Doc, out Int16? EAStructID_Doc_Copy,
        out Int16? EAStructID_Inn, out Int16? EAStructID_Inn_Copy, out Int16? EAStructID_SpecialDoc, out Int16? EAStructID_SpecialDoc_Copy)
    {
        switch (this.DocType)
        {
            case -1: // Інший документ
            case 2: // Військовий квиток
            case 4: // Пенсійне посвідчення
            case 6: // Пропуск
            case 12: // Дипломатичний паспорт гр.України
            case 14: // Паспорт моряка
            case 99: // Iнший документ
            default:
                EAStructID_Doc = 111;
                EAStructID_Doc_Copy = 131;
                break;
            case 1:
                // Паспорт (Паспорт громадянина України)
                EAStructID_Doc = 111;
                EAStructID_Doc_Copy = 131;
                break;
            case 3:
                // Свідоцтво про народження (Свідоцтво про народження громадянина України)
                EAStructID_Doc = 1111;
                EAStructID_Doc_Copy = 1311;
                break;
            case 5:
                // Тимчасова посвідка (Тимчасова посвідка, яка посвідчує особу громадянина)
                EAStructID_Doc = 113;
                EAStructID_Doc_Copy = 133;
                break;
            case 11:
                // Закордонний паспорт гр.України (Паспорт громадянина України для виїзду за кордон)
                EAStructID_Doc = 114;
                EAStructID_Doc_Copy = 134;
                break;
            case 13:
                // Паспорт нерезидента (Паспорт іноземця)
                EAStructID_Doc = 119;
                EAStructID_Doc_Copy = 139;
                break;
            case 15:
                // Тимчасове посвідчення особи (Тимчасове посвідчення громадянина України)
                EAStructID_Doc = 112;
                EAStructID_Doc_Copy = 132;
                break;
            case 16:
                // Посвідчення біженця (Посвідчення біженця)
                EAStructID_Doc = 118;
                EAStructID_Doc_Copy = 138;
                break;
        }
        /* !!! Нет соответствия
        115 Паспорт громадянина України для виїзду за кордон з дозволом на постійне проживання за кордоном
        116 Паспортний документ іноземця з дозволом на постійне місце проживання в Україні
        117 Посвідка на постійне проживання в Україні (для осіб без громадянства)
        1110 Паспорт особи без громадянства
        1112 Документ, що підтверджує місце тимчасового перебування або реєстрації в Україні
        */

        if (HasInn)
        {
            EAStructID_Inn = 121;
            EAStructID_Inn_Copy = 1315;
        }
        else
        {
            EAStructID_Inn = 122;
            EAStructID_Inn_Copy = 1316;
        }

        // Особлива відмітка клієнта
        if (SpecialMark.HasValue)
        {
            switch (SpecialMark.Value)
            {
                case 1: // Неповнолітній
                    // Документ, що підтверджує місце тимчасового перебування або реєстрації в Україні
                    EAStructID_SpecialDoc = 147;
                    EAStructID_SpecialDoc_Copy = 1314;
                    break;

                case 2: // Недієздатний
                case 3: // Обмеженодієздатний
                    EAStructID_SpecialDoc = 145;
                    EAStructID_SpecialDoc_Copy = 1318;
                    break;

                case 4: // Неписьменний
                case 6: // Незрячий
                    EAStructID_SpecialDoc = 142;
                    EAStructID_SpecialDoc_Copy = 1317;
                    break;

                default:
                    // 0 - Малолітній / 5 - Неграмотний / ...
                    EAStructID_SpecialDoc = null;
                    EAStructID_SpecialDoc_Copy = null;
                    break;
            }
        }
        else
        {
            EAStructID_SpecialDoc = null;
            EAStructID_SpecialDoc_Copy = null;
        }

    }
    private void CreatePrintSession(String PrintSessionID, Byte[] Image, OracleConnection con)
    {
        // чистим сессию
        ClearPrintSession(PrintSessionID, con);

        // записываем новые данные
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandText = "insert into wcs_print_scans (print_session_id, ord, scan_data) values (:p_ps_id, :p_ord, :p_scan_data)";
        cmd.Parameters.Add("p_ps_id", OracleDbType.Varchar2, PrintSessionID, System.Data.ParameterDirection.Input);
        cmd.Parameters.Add("p_ord", OracleDbType.Int16, System.Data.ParameterDirection.Input);
        cmd.Parameters.Add("p_scan_data", OracleDbType.Blob, System.Data.ParameterDirection.Input);

        // сохраняем страницы отдельно
        ByteData imageData = new ByteData(Image);
        for (Int32 i = 0; i < imageData.PageCount; i++)
        {
            cmd.Parameters["p_ord"].Value = i;
            cmd.Parameters["p_scan_data"].Value = imageData.GetPage(i).MainData;
            cmd.ExecuteNonQuery();
        }
    }
    private void CreateBlankPrintSession(String PrintSessionID, Int16 PageCount, OracleConnection con)
    {
        // чистим сессию
        ClearPrintSession(PrintSessionID, con);

        // записываем новые данные
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandText = "insert into wcs_print_scans (print_session_id, ord, scan_data) values (:p_ps_id, :p_ord, :p_scan_data)";
        cmd.Parameters.Add("p_ps_id", OracleDbType.Varchar2, PrintSessionID, System.Data.ParameterDirection.Input);
        cmd.Parameters.Add("p_ord", OracleDbType.Int16, System.Data.ParameterDirection.Input);
        cmd.Parameters.Add("p_scan_data", OracleDbType.Blob, System.Data.ParameterDirection.Input);

        // сохраняем страницы отдельно
        for (Int32 i = 0; i < PageCount; i++)
        {
            cmd.Parameters["p_ord"].Value = i;
            cmd.Parameters["p_scan_data"].Value = null;
            cmd.ExecuteNonQuery();
        }
    }
    private void ClearPrintSession(String PrintSessionID, OracleConnection con)
    {
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandText = "delete from wcs_print_scans ps where ps.print_session_id = :p_ps_id";
        cmd.Parameters.Add("p_ps_id", OracleDbType.Varchar2, PrintSessionID, System.Data.ParameterDirection.Input);
        cmd.ExecuteNonQuery();
    }
    private void WizardMoveNext()
    {
        // если шаг последний то завершаем визард
        if (wzd.ActiveStepIndex < wzd.WizardSteps.Count - 1)
        {
            wzd.ActiveStepIndex++;
            wzd.MoveTo(wzd.ActiveStep);
        }
        else
        {
            wzd_FinishButtonClick(wzd, null);
        }
    }
    private void SaveImage(String ImgType, Byte[] ImgData)
    {
        // !!! переделать на процедуру
        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmdInsert = con.CreateCommand();
        OracleCommand cmdDelete = con.CreateCommand();
        try
        {
            cmdDelete.CommandText = "delete from customer_images ci where ci.rnk = :p_rnk and ci.type_img = :p_type";
            cmdDelete.Parameters.Add("p_rnk", OracleDbType.Int64, this.RNK, System.Data.ParameterDirection.Input);
            cmdDelete.Parameters.Add("p_type", OracleDbType.Varchar2, ImgType, System.Data.ParameterDirection.Input);
            cmdDelete.ExecuteNonQuery();

            cmdInsert.CommandText = "insert into customer_images (rnk, type_img, date_img, image) values (:p_rnk, :p_type, sysdate, :p_image)";
            cmdInsert.Parameters.Add("p_rnk", OracleDbType.Int64, this.RNK, System.Data.ParameterDirection.Input);
            cmdInsert.Parameters.Add("p_type", OracleDbType.Varchar2, ImgType, System.Data.ParameterDirection.Input);
            cmdInsert.Parameters.Add("p_image", OracleDbType.Blob, ImgData, System.Data.ParameterDirection.Input);
            cmdInsert.ExecuteNonQuery();
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }
    private Byte[] GetDataFromEA(Int16[] DocCodes)
    {
        Byte[] DocData = null;
        try
        {
            // Получаем перечень документов из ЕА
            List<Bars.EAD.Structs.Result.DocumentData> docs = Bars.EAD.EADService.GetDocumentData(null, this.RNK, (Int64?)null, 1);

            // смотрим есть ли тут паспорт
            String DocUrl = String.Empty;
            foreach (Bars.EAD.Structs.Result.DocumentData doc in docs)
                if (DocCodes.Contains(doc.Struct_Code))
                {
                    DocUrl = doc.DocLink;
                    break;
                }

            // закачиваем файл если есть
            if (!String.IsNullOrEmpty(DocUrl))
                using (System.Net.WebClient wc = new System.Net.WebClient())
                {
                    DocData = wc.DownloadData(DocUrl);
                }
        }
        catch (System.Exception ex)
        {
            String ErrorText = "Виникли помилки при отриманні відповіді від ЕА: Message = " + ex.Message + "; StackTrace = " + ex.StackTrace;
            Decimal RecID = Bars.Logger.DBLogger.Error(ErrorText.Length > 3000 ? ErrorText.Substring(0, 3000) : ErrorText);

            ScriptManager.RegisterStartupScript(this, this.GetType(), "ead_errors", String.Format("alert('Виникли помилки при отриманні відповіді від ЕА. Номер запису в журналі аудиту {0}'); ", RecID), true);
        }

        return DocData;
    }
    private Byte[] GetDocFromEA()
    {
        // Паспорт и прочее
        Int16[] DocCodes = new Int16[7] { 111, 1111, 113, 114, 119, 112, 118 };
        return GetDataFromEA(DocCodes);
    }
    private Byte[] GetInnFromEA()
    {
        // ИНН и прочее
        Int16[] InnCodes = new Int16[2] { 121, 122 };
        return GetDataFromEA(InnCodes);
    }
    # endregion
}
