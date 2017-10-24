using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Bars.EAD;
using ibank.core;
using Bars.Exception;
using Bars.UserControls;
using BarsWeb.Core.Logger;
using System.Collections;
using Oracle.DataAccess.Client;

public partial class deposit_dialog_DptDocPrint : System.Web.UI.Page
{
    private IDbLogger _dbLogger;

    protected string getDocTemplate(Int16 type_id, Int64? dpt_id) 
    { 
         string Template = String.Empty;       
         OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
         if (type_id != 99)
         {
             try
             {
                 OracleCommand cmd_findtemplate = con.CreateCommand();

                 cmd_findtemplate.CommandText = "select dvc.id_fr id from dpt_deposit d, dpt_vidd_scheme dvc where d.deposit_id = :p_deposit_id and dvc.vidd = d.vidd and dvc.flags = :p_flags";
                 cmd_findtemplate.Parameters.Add("p_deposit_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                 cmd_findtemplate.Parameters.Add("p_flags", OracleDbType.Decimal, type_id, ParameterDirection.Input);

                 using (OracleDataReader rdr_findtemplate = cmd_findtemplate.ExecuteReader())
                 {
                     if (rdr_findtemplate.Read())
                     {
                         Template = Convert.ToString(rdr_findtemplate["id"]);
                     }
                     else
                     {
                         throw new System.Exception(String.Format("Не знайдено шаблон {0} у таблиці doc_scheme, або шаблон не описано як FastReport", Template));
                     }
                 }
             }
             finally
             {
                 con.Dispose();
             }
         }
         else if (type_id == 99) Template = "DPT_FINMON_QUESTIONNAIRE";
          
        return Template;
    }

    protected void Page_Load(object sender, EventArgs e)
    {

        _dbLogger = DbLoggerConstruct.NewDbLogger();
        EADoc EADocXRM = new EADoc();
        EadPack ep = new EadPack(new BbConnection());
        Int16 type_prnt = Convert.ToInt16(Request.Params.Get("type"));
        EADocXRM.AgrID  = Convert.ToInt64(Request.Params.Get("DPT_ID"));        
        EADocXRM.RNK = Convert.ToInt64(Request.Params.Get("rnk"));
        EADocXRM.AddParams.Add(new FrxParameter("p_agrmnt_id", TypeCode.Int64, Convert.ToInt64(Request.Params.Get("AGR_ID"))));
        _dbLogger.Info("type_prnt= " + type_prnt, "deposit");
        _dbLogger.Info("EADocXRM.AgrID = " + EADocXRM.AgrID.Value, "deposit");
        _dbLogger.Info("Request.Params.Get(DPT_ID)=" + Request.Params.Get("DPT_ID"));
        decimal? _DocId = null;        
        try{

        switch (type_prnt)
        {
            case 1: // основной договор
                EADocXRM.EAStructID = 212; 
                EADocXRM.TemplateID = getDocTemplate(type_prnt, EADocXRM.AgrID.Value);
                break;
            case 101: // осн.дог на бенеф
                EADocXRM.EAStructID = 212;
                EADocXRM.TemplateID = getDocTemplate(type_prnt, EADocXRM.AgrID.Value);
                break;
            case 99: // тут анкета финмониторинга
                EADocXRM.EAStructID = 212;
                EADocXRM.TemplateID = getDocTemplate(type_prnt, EADocXRM.AgrID.Value);
                break;
                // тут будут все додугоды
            case 7:
                EADocXRM.EAStructID = 222;
                EADocXRM.TemplateID = getDocTemplate(type_prnt, EADocXRM.AgrID.Value);
                break;
            case 8:
                EADocXRM.EAStructID = 223;
                EADocXRM.TemplateID = getDocTemplate(type_prnt, EADocXRM.AgrID.Value);
                break;
            case 9:
                EADocXRM.EAStructID = 226;
                EADocXRM.TemplateID = getDocTemplate(type_prnt, EADocXRM.AgrID.Value);
                break;
            case 12:
                EADocXRM.EAStructID = 222;
                EADocXRM.TemplateID = getDocTemplate(type_prnt, EADocXRM.AgrID);
                break;
            case 13:
                EADocXRM.EAStructID = 225;
                EADocXRM.TemplateID = getDocTemplate(type_prnt, EADocXRM.AgrID.Value);
                break;
            case 18:
                EADocXRM.EAStructID = 211;
                EADocXRM.TemplateID = getDocTemplate(type_prnt, EADocXRM.AgrID.Value);
                break;
            default: 
                EADocXRM.EAStructID = 213;
                EADocXRM.TemplateID = getDocTemplate(type_prnt, EADocXRM.AgrID.Value);
                break;
        }       
            _dbLogger.Info("TemplateID = " + EADocXRM.TemplateID, "deposit");
            _dbLogger.Info("EAStructID = " + EADocXRM.EAStructID.ToString(), "deposit");


            if (EADocXRM.EAStructID.HasValue)
                _DocId = ep.DOC_CREATE("DOC", EADocXRM.TemplateID, null, EADocXRM.EAStructID, EADocXRM.RNK, EADocXRM.AgrID);


            // печатаем документ
            FrxParameters pars = new FrxParameters();
            if (_DocId != null)
            {
                pars.Add(new FrxParameter("p_doc_id", TypeCode.Int64, Convert.ToInt64(_DocId.Value.ToString())));
                _dbLogger.Info("p_doc_id = " + _DocId.Value.ToString(), "deposit");
            }

            if (EADocXRM.RNK.HasValue)
            {
                pars.Add(new FrxParameter("p_rnk", TypeCode.Int64, EADocXRM.RNK));
                _dbLogger.Info("p_rnk = " + EADocXRM.RNK.ToString(), "deposit");
            }
            if (EADocXRM.AgrID.HasValue)
            {
                pars.Add(new FrxParameter("p_agr_id", TypeCode.Int64, EADocXRM.AgrID));
                _dbLogger.Info("p_agr_id = " + EADocXRM.AgrID.ToString(), "deposit");
            }
            if (EADocXRM.AgrUID.HasValue)
            {
                pars.Add(new FrxParameter("p_agrmnt_id", TypeCode.Int32, EADocXRM.AgrUID));
                _dbLogger.Info("p_agrmnt_id = " + EADocXRM.AgrUID.ToString(), "deposit");
            }


            // дополнительные параметры
            foreach (FrxParameter par in EADocXRM.AddParams) pars.Add(par);
            FrxDoc doc = new FrxDoc(FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(EADocXRM.TemplateID)), pars, this.Page);

            _dbLogger.Info("doc.TemplatePath = " + doc.TemplatePath, "deposit");
            // выбрасываем в поток в формате PDF
            doc.Print(FrxExportTypes.Pdf);
        }
        catch (DepositException ex)
        {
            throw new DepositException(ex.Message, ex.InnerException);
        }
        /*
        switch (type_prnt)
        {
            case "print_file":
                {
                    string fileName = Request.Params.Get("filename");
                    if (Uri.IsWellFormedUriString(fileName, new UriKind()))
                    {
                        Response.Redirect(fileName);
                    }
                    else
                    {
                        Response.ClearContent();
                        Response.ClearHeaders();
                        Response.Charset = "windows-1251";
                        Response.AppendHeader("content-disposition", "attachment;filename=ticket.barsprn");
                        Response.ContentType = "application/octet-stream";
                        Response.WriteFile(Request.Params.Get("filename"), true);
                        Response.Flush();
                        Response.End();
                        try
                        {
                            File.Delete(fileName);
                        }
                        catch { }
                    }

                    break;
                }
        }*/

    }
}