using System;
using System.Collections.Generic;
using System.Web;
using System.IO;
using System.Text;
using System.Data;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using FastReport;
using FastReport.Web;
using FastReport.Data;

using Bars.Classes;
using Bars.Oracle;

using Oracle.DataAccess.Client;

using FastReport.Export;
using FastReport.Export.Pdf;
using FastReport.Export.Csv;
using FastReport.Export.Dbf;
using FastReport.Export.OoXML;
using FastReport.Export.Xml;
using FastReport.Export.RichText;
using FastReport.Export.Html;
using FastReport.Export.Mht;
using FastReport.Export.Odf;


using FastReport.Export.Text;

public enum FrxExportTypes
{
    Csv = 0,
    Dbf = 1,
    Excel2007 = 2,
    Html = 3,
    Mht = 4,
    Ods = 5,
    Odt = 6,
    Pdf = 7,
    PowerPoint2007 = 8,
    Rtf = 9,
    Text = 10,
    Word2007 = 11,
    XmlExcel = 12,
    Xps = 13
}

/// <summary>
/// Параметр отчета FastReport
/// </summary>
public class FrxParameter
{
    # region Приватные свойства
    private string _name = String.Empty;
    private Object _value = String.Empty;
    private TypeCode _type;
    # endregion

    # region Публичные свойства
    public string Name
    {
        get { return _name; }
        set { _name = value; }
    }
    public Object Value
    {
        get { return _value; }
        set { _value = value; }
    }
    public TypeCode Type
    {
        get { return _type; }
        set { _type = value; }
    }
    # endregion

    # region Конструктор
    public FrxParameter(String Name, TypeCode Type, Object Value)
    {
        _name = Name;
        _type = Type;
        _value = Value;
    }
    # endregion
}

/// <summary>
/// Параметры отчета FastReport
/// </summary>
public class FrxParameters : ICollection<FrxParameter>
{
    # region Приватные свойства
    private List<FrxParameter> _parameters = new List<FrxParameter>();
    # endregion

    # region Публичные свойства
    public FrxParameter this[int Index]
    {
        get { return _parameters[Index]; }
        set { _parameters[Index] = value; }
    }
    public int Count { get { return _parameters.Count; } }
    public void Add(FrxParameter Parameter)
    {
        _parameters.Add(Parameter);
    }
    public void Clear()
    {
        _parameters.Clear();
    }
    public bool Contains(FrxParameter item)
    {
        return _parameters.Contains(item);
    }
    public void CopyTo(FrxParameter[] array, int arrayIndex)
    {
        _parameters.CopyTo(array, arrayIndex);
    }
    public bool IsReadOnly
    {
        get { return false; }
    }
    public bool Remove(FrxParameter item)
    {
        return _parameters.Remove(item);
    }
    # endregion

    # region Методы
    public IEnumerator<FrxParameter> GetEnumerator()
    {
        return _parameters.GetEnumerator();
    }
    System.Collections.IEnumerator System.Collections.IEnumerable.GetEnumerator()
    {
        return _parameters.GetEnumerator();
    }
    # endregion
}

public class FrxDoc
{
    # region Приватные свойства
    private String _templatePath;
    private FrxParameters _frxParameters;
    private Page _page;
    # endregion

    # region Публичные свойства
    public String TemplatePath
    {
        get { return _templatePath; }
        set { _templatePath = value; }
    }
    # endregion

    # region Конструктор
    public FrxDoc(String TemplatePath, FrxParameters Parameters, Page Page)
    {
        ValidateTemplatePath(TemplatePath);

        _templatePath = TemplatePath;
        _frxParameters = Parameters;
        _page = Page;
        FastReport.Utils.RegisteredObjects.AddConnection(typeof(OracleDataConnection));
    }
    # endregion

    # region Приватные методы
    public void ValidateTemplatePath(String TemplatePath)
    {
        if (!System.IO.File.Exists(TemplatePath))
            throw new Bars.Exception.BarsException(String.Format("Файл шаблону {0} не знайдено", TemplatePath));
    }
    # endregion

    # region Статические методы
    public static String GetTemplatePathByFileName(String FileName)
    {
        return HttpContext.Current.Server.MapPath("/TEMPLATE.RPT/" + FileName);
    }
    public static String GetTemplateFileNameByID(String TemplateID)
    {
        String res = String.Empty;
        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        try
        {
            OracleCommand cmd = new OracleCommand("select ds.file_name from doc_scheme ds where lower(ds.id) = :p_id", con);
            cmd.Parameters.Add("p_id", OracleDbType.Varchar2, TemplateID.ToLower(), ParameterDirection.Input);

            res = Convert.ToString(cmd.ExecuteScalar());
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        return res;
    }
    # endregion

    # region Публичные методы
    public void Print(FrxExportTypes ExportType)
    {
        WebReport wrpt = new WebReport();

        //на страницу данный объект добавить нужно обязательно 
        HtmlGenericControl div = new HtmlGenericControl("div");
        div.Visible = false;
        div.Style.Add("visibility", "hidden");
        div.Controls.Add(wrpt);
        _page.Controls.Add(div);
        wrpt.Visible = false;

        //шаблон отчета
        Report rpt = new Report();
        wrpt.Report = rpt;

        try
        {
            //настройка шаблона
            setupReport(rpt);

            //это или баг или фича, если стейт не установить - работать не будет
            wrpt.State = ReportState.Done;
            
            // экспорт в нужный формат
            switch (ExportType)
            {
                case FrxExportTypes.Csv:
                    wrpt.ExportCsv(HttpContext.Current);
                    break;
                case FrxExportTypes.Dbf:
                    wrpt.ExportDbf(HttpContext.Current);
                    break;
                case FrxExportTypes.Excel2007:
                    wrpt.ExportExcel2007(HttpContext.Current);
                    break;
                case FrxExportTypes.Html:
                    wrpt.ExportHtml(HttpContext.Current, false);
                    break;
                case FrxExportTypes.Mht:
                    wrpt.ExportMht(HttpContext.Current);
                    break;
                case FrxExportTypes.Ods:
                    wrpt.ExportOds(HttpContext.Current);
                    break;
                case FrxExportTypes.Odt:
                    wrpt.ExportOdt(HttpContext.Current);
                    break;
                case FrxExportTypes.Pdf:
                    wrpt.ExportPdf(HttpContext.Current);
                    break;
                case FrxExportTypes.PowerPoint2007:
                    wrpt.ExportPowerPoint2007(HttpContext.Current);
                    break;
                case FrxExportTypes.Rtf:
                    wrpt.ExportRtf(HttpContext.Current);
                    break;
                case FrxExportTypes.Text:
                    wrpt.ExportText(HttpContext.Current);
                    break;
                case FrxExportTypes.Word2007:
                    wrpt.ExportWord2007(HttpContext.Current);
                    break;
                case FrxExportTypes.XmlExcel:
                    wrpt.ExportXmlExcel(HttpContext.Current);
                    break;
                case FrxExportTypes.Xps:
                    wrpt.ExportXps(HttpContext.Current);
                    break;
            }

        }
            /*
		catch(System.Exception e)
        {
            HttpContext.Current.Response.Write(e.Message);
			 var t= e;
        }*/
        finally
        {
            wrpt.Dispose();
        }
    }
    public String Export(FrxExportTypes ExportType)
    {
        String res = Path.GetTempPath() + Path.GetFileNameWithoutExtension(System.IO.Path.GetTempFileName());
        string ext = ".tmp";

        ExportBase export = null;

        // объект отчета
        Report rpt = new Report();

        try
        {
            setupReport(rpt);

            // выгрузка на диск
            switch (ExportType)
            {
                case FrxExportTypes.Csv:
                    export = new CSVExport();
                    ext = ".csv";
                    break;
                case FrxExportTypes.Dbf:
                    export = new DBFExport();
                    break;
                case FrxExportTypes.Excel2007:
                    export = new Excel2007Export();
                    ext = ".xls";
                    break;
                case FrxExportTypes.Html:
                    export = new HTMLExport();
                    ext = ".html";
                    break;
                case FrxExportTypes.Mht:
                    export = new MHTExport();
                    break;
                case FrxExportTypes.Ods:
                    export = new ODSExport();
                    break;
                case FrxExportTypes.Odt:
                    export = new ODTExport();
                    break;
                case FrxExportTypes.Pdf:
                    export = new PDFExport();
                    ext = ".pdf";
                    break;
                case FrxExportTypes.PowerPoint2007:
                    export = new PowerPoint2007Export();
                    ext = ".pptx";
                    break;
                case FrxExportTypes.Rtf:
                    export = new RTFExport();
                    ext = ".rtf";
                    break;
                case FrxExportTypes.Text:
                    export = new TextExport();
                    ext = ".txt";
                    break;
                case FrxExportTypes.Word2007:
                    export = new Word2007Export();
                    ext = ".doc";
                    break;
                case FrxExportTypes.XmlExcel:
                    export = new XMLExport();
                    break;
                case FrxExportTypes.Xps:
                    export = new XPSExport();
                    break;
                default:
                    throw new Exception(String.Format("Формат экспорту {0} не підтримується", ExportType.ToString()));
            }

            res = res + ext;
            rpt.Export(export, res);
        }
        finally
        {
            rpt.Dispose();
            export.Dispose();
        }

        return res;
    }

    private void setupReport(Report rpt)
    {
        // загрузка шаблона
        rpt.Load(_templatePath);

        // соединение
        rpt.Report.Dictionary.Connections[0].ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

        // параметры
        if (null != _frxParameters)
        {
            foreach (FrxParameter p in _frxParameters)
            {
                rpt.Report.SetParameterValue(p.Name, p.Value);
            }
        }

        rpt.Prepare();

    }
    # endregion

    # region Приватные события

    # endregion
}
