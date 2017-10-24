using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Data;
using System.Globalization;
using System.IO;
using Bars.Web.Report;

/// <summary>
/// Summary description for SurveyService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class SurveyService : Bars.BarsWebService
{
    public SurveyService () {}
    /// <summary>
    /// Вичитка з бази параметрів для ініціалізації
    /// сторінки на клієнті
    /// (вичитуються параметри для групи питань)
    /// </summary>
    /// <param name="par_id">Параметризоване імя анкети</param>
    /// <param name="grp_ord">Група</param>
    /// <returns>Масив обєктів для ініціалізації</returns>
    [WebMethod(EnableSession = true)]
    public object[][] LoadSurvey(String par_id, String grp_ord, String rnk, String tr) 
    {
        object[][] result;
        ArrayList arr = new ArrayList();
        ArrayList grp = new ArrayList();

        IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
		OracleConnection connect = new OracleConnection();
        
        try
        {
            connect = conn.GetUserConnection(Context);
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("SUR_ROLE");
            cmdSetRole.ExecuteNonQuery();
            
            OracleDataReader rdr;
            Decimal session_id = Decimal.MinValue;

            if (grp_ord == "1")
            {                
                OracleCommand cmdGetSurveyInfo = connect.CreateCommand();
                if (tr == "params")
                    cmdGetSurveyInfo.CommandText = @"SELECT DISTINCT v.survey_name, v.survey_template, v.survey_id 
                        FROM v_surveyquest v
                        WHERE v.survey_id = cust_survey.get_survey_id(:par_id)";
                else
                    cmdGetSurveyInfo.CommandText = @"SELECT DISTINCT v.survey_name, v.survey_template, v.survey_id 
                        FROM v_surveyquest v
                        WHERE v.survey_id = :par_id";

                cmdGetSurveyInfo.Parameters.Add("par_id", OracleDbType.Varchar2, par_id, ParameterDirection.Input);
                rdr = cmdGetSurveyInfo.ExecuteReader();
                if (!rdr.Read())
                    throw new ApplicationException("Анкети з імям " + par_id + " в системі не існує!");

                grp.Add(rdr.GetOracleString(0).Value);
                grp.Add(rdr.GetOracleString(1).Value);
                grp.Add(rdr.GetOracleDecimal(2).Value);

                rdr.Close();

                OracleCommand cmdOpenSession = connect.CreateCommand();
                cmdOpenSession.CommandText = "begin cust_survey.start_session(:rnk,:sur,0,:s_id); end;";
                cmdOpenSession.Parameters.Add("rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input);
                cmdOpenSession.Parameters.Add("sur", OracleDbType.Decimal, grp[2], ParameterDirection.Input);
                cmdOpenSession.Parameters.Add("s_id", OracleDbType.Decimal, session_id, ParameterDirection.Output);

                cmdOpenSession.ExecuteNonQuery();

                session_id = Convert.ToDecimal(Convert.ToString(cmdOpenSession.Parameters["s_id"].Value));
            }

            OracleCommand cmdGetSurveyQuest = connect.CreateCommand();
            if (tr == "params")
                cmdGetSurveyQuest.CommandText = @"SELECT Q.GRP_ID, Q.GRP_NAME, Q.GRP_ORD, Q.QUEST_ID, Q.QUEST_NAME,  
                     Q.QUEST_ORD, Q.FMT_ID, Q.LIST_ID, Q.QUEST_MULTI, Q.FL_PARENT,  
                     A.ANSWER_KEY, A.ANSWER_VALUE, A.ANSWER_ORD,  
                     A.ANSWER_DEFAULT, A.ANSWER_TYPE, cust_survey.get_default_answer(Q.QUEST_ID,:p_rnk,:p_sess_id)
                    FROM V_SURVEYQUEST Q,V_SURVEYANSWER A 
                    WHERE q.survey_id = cust_survey.get_survey_id(:par_id) AND Q.QUEST_STATE=1 AND A.SURVEY_ID = Q.SURVEY_ID AND Q.QUEST_ID=A.QUEST_ID AND Q.GRP_ORD = :GRP_ORD
                    ORDER BY Q.GRP_ORD,Q.QUEST_ORD,A.ANSWER_ORD";
            else
                cmdGetSurveyQuest.CommandText = @"SELECT Q.GRP_ID, Q.GRP_NAME, Q.GRP_ORD, Q.QUEST_ID, Q.QUEST_NAME,  
                     Q.QUEST_ORD, Q.FMT_ID, Q.LIST_ID, Q.QUEST_MULTI, Q.FL_PARENT,  
                     A.ANSWER_KEY, A.ANSWER_VALUE, A.ANSWER_ORD,  
                     A.ANSWER_DEFAULT, A.ANSWER_TYPE, cust_survey.get_default_answer(Q.QUEST_ID,:p_rnk,:p_sess_id)
                    FROM V_SURVEYQUEST Q,V_SURVEYANSWER A 
                    WHERE Q.SURVEY_ID=:PAR_ID AND Q.QUEST_STATE=1 AND A.SURVEY_ID = Q.SURVEY_ID AND Q.QUEST_ID=A.QUEST_ID AND Q.GRP_ORD = :GRP_ORD
                    ORDER BY Q.GRP_ORD,Q.QUEST_ORD,A.ANSWER_ORD";

            cmdGetSurveyQuest.Parameters.Add("p_rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input);
            cmdGetSurveyQuest.Parameters.Add("p_sess_id", OracleDbType.Decimal, session_id, ParameterDirection.Input);
            cmdGetSurveyQuest.Parameters.Add("par_id", OracleDbType.Varchar2, par_id, ParameterDirection.Input);
            cmdGetSurveyQuest.Parameters.Add("grp_ord", OracleDbType.Decimal,   grp_ord,    ParameterDirection.Input);

            rdr = cmdGetSurveyQuest.ExecuteReader();
            
            while (rdr.Read())
            {
                ArrayList row = new ArrayList();

                if (!rdr.IsDBNull(0)) row.Add(rdr.GetOracleDecimal(0).Value);
                else row.Add("");
                if (!rdr.IsDBNull(1)) row.Add(rdr.GetOracleString(1).Value);
                else row.Add("");
                if (!rdr.IsDBNull(2)) row.Add(rdr.GetOracleDecimal(2).Value);
                else row.Add("");
                if (!rdr.IsDBNull(3)) row.Add(rdr.GetOracleDecimal(3).Value);
                else row.Add("");
                if (!rdr.IsDBNull(4)) row.Add(rdr.GetOracleString(4).Value);
                else row.Add("");
                if (!rdr.IsDBNull(5)) row.Add(rdr.GetOracleDecimal(5).Value);
                else row.Add("");
                if (!rdr.IsDBNull(6)) row.Add(rdr.GetOracleDecimal(6).Value);
                else row.Add("");
                if (!rdr.IsDBNull(7)) row.Add(rdr.GetOracleDecimal(7).Value);
                else row.Add("");
                if (!rdr.IsDBNull(8)) row.Add(rdr.GetOracleDecimal(8).Value);
                else row.Add("");
                if (!rdr.IsDBNull(9)) row.Add(rdr.GetOracleDecimal(9).Value);
                else row.Add("");
                if (!rdr.IsDBNull(10)) row.Add(rdr.GetOracleDecimal(10).Value);
                else row.Add("");
                if (!rdr.IsDBNull(11)) row.Add(rdr.GetOracleString(11).Value);
                else row.Add("");
                if (!rdr.IsDBNull(12)) row.Add(rdr.GetOracleDecimal(12).Value);
                else row.Add("");
                if (!rdr.IsDBNull(13)) row.Add(rdr.GetOracleDecimal(13).Value);
                else row.Add("");
                if (!rdr.IsDBNull(14)) row.Add(rdr.GetOracleString(14).Value);
                else row.Add("");
                if (!rdr.IsDBNull(15)) row.Add(rdr.GetOracleString(15).Value);
                else row.Add("");

                arr.Add(row);
            }

            rdr.Close();

            result = new object[arr.Count + 1][];

            if (grp_ord == "1")
            {
                result[0] = new object[3];
                result[0][0] = grp[0].ToString();
                result[0][1] = grp[1].ToString();
                result[0][2] = session_id.ToString();
            }
            else
            {
                result[0] = null;
            }

            for ( int i = 1; i < arr.Count + 1; i++ )
            { result[i] = new object[16]; }

            for (int i = 0; i < arr.Count; i++)
            {
                ArrayList row = (ArrayList)arr[i];

                for (int j = 0; j < 16; j++)
                {
                     result[i + 1][j] = row[j];
                }
            }

            return result;
        }
        catch(Exception ex)
        {
            SaveExeption(ex);
            throw ex;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Запис в базу відмови клієнта 
    /// заповняти анкету
    /// </summary>
    /// <param name="rnk">РНК</param>
    /// <param name="par">параметризоване імя анкети</param>
    [WebMethod(EnableSession = true)]
    public void Decline(String rnk, String par, String tr)
    {
        IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = conn.GetUserConnection(Context);
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("SUR_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSetDecline = connect.CreateCommand();
            if (tr == "params")
                cmdSetDecline.CommandText = @"declare 
                    sess_id SURVEY_SESSION.session_id%TYPE; 
                    begin 
                        cust_survey.start_session(:rnk,cust_survey.get_survey_id(:par_id),1,sess_id); 
                    end;";
            else
                cmdSetDecline.CommandText = @"declare 
                    sess_id SURVEY_SESSION.session_id%TYPE; 
                    begin 
                        cust_survey.start_session(:rnk,:par,1,sess_id); 
                    end;";

            cmdSetDecline.Parameters.Add("rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input);
            cmdSetDecline.Parameters.Add("par", OracleDbType.Decimal, par, ParameterDirection.Input);

            cmdSetDecline.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            SaveExeption(ex);
            throw ex;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Обробка відповідей на питання
    /// </summary>
    /// <param name="answers"></param>
    [WebMethod(EnableSession = true)]
    public void SubmitGroup(string[][] answers)
    {
        Decimal s_id = Convert.ToDecimal(answers[0][0]);
        String err = String.Empty;

        IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
        OracleConnection connect = new OracleConnection();
        OracleTransaction tx = null;
        bool isCommitted = false;

        try
        {
            connect = conn.GetUserConnection(Context);
            tx = connect.BeginTransaction();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("SUR_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSubmitAnswer = connect.CreateCommand();
            cmdSubmitAnswer.CommandText = "begin cust_survey.fix_answer(:s_id,:q_id,:key,:ch,:num,:dat,:err); end;";

            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";


            for (int i = 1; i < answers.Length; i++)
            {
                cmdSubmitAnswer.Parameters.Clear();

                cmdSubmitAnswer.Parameters.Add("s_id",  OracleDbType.Decimal,  s_id,                ParameterDirection.Input);
                cmdSubmitAnswer.Parameters.Add("q_id",  OracleDbType.Decimal,  answers[i][0],      ParameterDirection.Input);
                
                if (Convert.ToString(answers[i][1]) == "1" || Convert.ToString(answers[i][1]) == "2")
                    cmdSubmitAnswer.Parameters.Add("key",   OracleDbType.Decimal, answers[i][2]  ,    ParameterDirection.Input);
                else
                    cmdSubmitAnswer.Parameters.Add("key", OracleDbType.Decimal, null, ParameterDirection.Input);
                
                if (Convert.ToString(answers[i][1]) == "3")
                    cmdSubmitAnswer.Parameters.Add("ch", OracleDbType.Varchar2, answers[i][2], ParameterDirection.Input);
                else
                    cmdSubmitAnswer.Parameters.Add("ch", OracleDbType.Varchar2, null, ParameterDirection.Input);

                if (Convert.ToString(answers[i][1]) == "4")
                    cmdSubmitAnswer.Parameters.Add("num", OracleDbType.Decimal, answers[i][2], ParameterDirection.Input);
                else
                    cmdSubmitAnswer.Parameters.Add("num", OracleDbType.Decimal, null, ParameterDirection.Input);

                if (Convert.ToString(answers[i][1]) == "5" && answers[i][2] != String.Empty)
                    cmdSubmitAnswer.Parameters.Add("dat", OracleDbType.Date, Convert.ToDateTime(answers[i][2], cinfo), ParameterDirection.Input);
                else
                    cmdSubmitAnswer.Parameters.Add("dat", OracleDbType.Date, null, ParameterDirection.Input);

                cmdSubmitAnswer.Parameters.Add("err",   OracleDbType.Decimal,   err,    ParameterDirection.Input);

                cmdSubmitAnswer.ExecuteNonQuery();
            }

            tx.Commit();
            isCommitted = true;
        }
        catch (Exception ex)
        {
            SaveExeption(ex);
            throw ex;
        }
        finally
        {
            if (!isCommitted) tx.Rollback();
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Перевірка на існування дочірніх 
    /// питань в базі
    /// </summary>
    /// <param name="par">Параметризоване імя анкети</param>
    /// <param name="id">Ід питання</param>
    /// <param name="val">Відповідь на питання</param>
    /// <returns>Список дочірніх питань</returns>
    [WebMethod(EnableSession = true)]
    public object[][] GetChildren(string par, string id, string val, string tr, String rnk, String session_id)
    {
        object[][] result;
        ArrayList Quest = new ArrayList();
        String sur = String.Empty;

        ArrayList QuestId = new ArrayList();

        IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = conn.GetUserConnection(Context);

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("SUR_ROLE");
            cmdSetRole.ExecuteNonQuery();

            if (tr == "params")
            {
                OracleCommand cmdGetSurveyId = connect.CreateCommand();
                cmdGetSurveyId.CommandText = "select cust_survey.get_survey_id(:par_id) from dual";
                cmdGetSurveyId.Parameters.Add("par_id", OracleDbType.Varchar2, par, ParameterDirection.Input);

                sur = Convert.ToString(cmdGetSurveyId.ExecuteScalar());
            }
            else
                sur = par;

            OracleCommand cmdCheckDepends = connect.CreateCommand();
            cmdCheckDepends.CommandText = "begin cust_survey.child_questions(:sur,:quest,:ans,:children); end;";
            cmdCheckDepends.Parameters.Add("sur",   OracleDbType.Decimal,   sur,    ParameterDirection.Input);
            cmdCheckDepends.Parameters.Add("quest", OracleDbType.Decimal,   id,     ParameterDirection.Input);
            cmdCheckDepends.Parameters.Add("ans",   OracleDbType.Decimal,   val,    ParameterDirection.Input);
            cmdCheckDepends.Parameters.Add("children", OracleDbType.RefCursor, ParameterDirection.Output);

            cmdCheckDepends.ExecuteNonQuery();

            OracleRefCursor refcur = (OracleRefCursor)cmdCheckDepends.Parameters["children"].Value;
            OracleDataReader rdr = refcur.GetDataReader();

            while (rdr.Read())
            {
                ArrayList row = new ArrayList();

                if (!rdr.IsDBNull(0)) row.Add(rdr.GetOracleDecimal(0).Value);
                else row.Add("");
                if (!rdr.IsDBNull(1)) row.Add(rdr.GetOracleDecimal(1).Value);
                else row.Add("");

                QuestId.Add(row);
            }

            if (!rdr.IsClosed) rdr.Close();

            for (int i = 0; i < QuestId.Count; i++)
            {
                ArrayList row = (ArrayList) QuestId[i];

                if (Convert.ToString(row[1]) == "1")
                {
                    OracleCommand cmdGetSurveyQuest = connect.CreateCommand();
                    cmdGetSurveyQuest.CommandText = @"SELECT Q.GRP_ID, Q.GRP_NAME, Q.GRP_ORD, Q.QUEST_ID, Q.QUEST_NAME,  
                         Q.QUEST_ORD, Q.FMT_ID, Q.LIST_ID, Q.QUEST_MULTI, Q.FL_PARENT,  
                         A.ANSWER_KEY, A.ANSWER_VALUE, A.ANSWER_ORD,  
                         A.ANSWER_DEFAULT, A.ANSWER_TYPE,  cust_survey.get_default_answer(Q.QUEST_ID,:p_rnk,:p_sess_id)
                        FROM V_SURVEYQUEST Q,V_SURVEYANSWER A 
                        WHERE Q.SURVEY_ID=:SUR_ID AND Q.QUEST_STATE=0 AND A.SURVEY_ID = Q.SURVEY_ID AND Q.QUEST_ID=A.QUEST_ID AND Q.QUEST_ID=:Q_ID
                        ORDER BY Q.QUEST_ID";

                    cmdGetSurveyQuest.Parameters.Add("p_rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input);
                    cmdGetSurveyQuest.Parameters.Add("p_sess_id", OracleDbType.Decimal, session_id, ParameterDirection.Input);
                    cmdGetSurveyQuest.Parameters.Add("sur_id", OracleDbType.Decimal, sur, ParameterDirection.Input);
                    cmdGetSurveyQuest.Parameters.Add("Q_ID",   OracleDbType.Decimal, Convert.ToDecimal(row[0]), ParameterDirection.Input);

                    rdr = cmdGetSurveyQuest.ExecuteReader();

                    while (rdr.Read())
                    {
                        ArrayList newQuestion = new ArrayList();

                        if (!rdr.IsDBNull(0)) newQuestion.Add(rdr.GetOracleDecimal(0).Value);
                        else newQuestion.Add("");
                        if (!rdr.IsDBNull(1)) newQuestion.Add(rdr.GetOracleString(1).Value);
                        else newQuestion.Add("");
                        if (!rdr.IsDBNull(2)) newQuestion.Add(rdr.GetOracleDecimal(2).Value);
                        else newQuestion.Add("");
                        if (!rdr.IsDBNull(3)) newQuestion.Add(rdr.GetOracleDecimal(3).Value);
                        else newQuestion.Add("");
                        if (!rdr.IsDBNull(4)) newQuestion.Add(rdr.GetOracleString(4).Value);
                        else newQuestion.Add("");
                        if (!rdr.IsDBNull(5)) newQuestion.Add(rdr.GetOracleDecimal(5).Value);
                        else newQuestion.Add("");
                        if (!rdr.IsDBNull(6)) newQuestion.Add(rdr.GetOracleDecimal(6).Value);
                        else newQuestion.Add("");
                        if (!rdr.IsDBNull(7)) newQuestion.Add(rdr.GetOracleDecimal(7).Value);
                        else newQuestion.Add("");
                        if (!rdr.IsDBNull(8)) newQuestion.Add(rdr.GetOracleDecimal(8).Value);
                        else newQuestion.Add("");
                        if (!rdr.IsDBNull(9)) newQuestion.Add(rdr.GetOracleDecimal(9).Value);
                        else newQuestion.Add("");
                        if (!rdr.IsDBNull(10)) newQuestion.Add(rdr.GetOracleDecimal(10).Value);
                        else newQuestion.Add("");
                        if (!rdr.IsDBNull(11)) newQuestion.Add(rdr.GetOracleString(11).Value);
                        else newQuestion.Add("");
                        if (!rdr.IsDBNull(12)) newQuestion.Add(rdr.GetOracleDecimal(12).Value);
                        else newQuestion.Add("");
                        if (!rdr.IsDBNull(13)) newQuestion.Add(rdr.GetOracleDecimal(13).Value);
                        else newQuestion.Add("");
                        if (!rdr.IsDBNull(14)) newQuestion.Add(rdr.GetOracleString(14).Value);
                        else newQuestion.Add("");
                        /// додаємо ідентифікатор батьківського питання
                        newQuestion.Add(id);

                        Quest.Add(newQuestion);
                    }

                    rdr.Close();
                }
                else
                {
                    ArrayList newQuestion = new ArrayList();
                    /// Це питання треба сховати
                    newQuestion.Add(row[0]);
                    newQuestion.Add(row[1]);

                    Quest.Add(newQuestion);
                }                
            }

            result = new object[Quest.Count][];
            for (int i = 0; i < result.Length; i++)
            { result[i] = new object[16]; }

            for (int i = 0; i < Quest.Count; i++)
            {
                ArrayList row = (ArrayList)Quest[i];
                for (int j = 0; j < row.Count; j++)
                    result[i][j] = row[j];
            }

            return result;
        }
        catch (Exception ex)
        {
            SaveExeption(ex);
            throw ex;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Отримання тексту по шаблону.
    /// </summary>
    /// <param name="template_id"></param>
    [WebMethod(EnableSession=true, BufferResponse = true)]
    public String PrintSurvey(String template_id, String rnk)
    {
        RtfReporter rep = null;

        String mainDir = Path.GetTempPath() + "sur\\";
        String file = mainDir + "survey.mht";

        try { Directory.Delete(mainDir,true); }
        catch(Exception)
        {
            /// Давимо всі помилки при видалені директорії
        }

        if (!Directory.Exists(mainDir))
            Directory.CreateDirectory(mainDir);

        try
        {
            rep = new RtfReporter(HttpContext.Current);
            
            rep.RoleList = "reporter,dpt_role,cc_doc";
            rep.ContractNumber = Convert.ToInt64(rnk);
            rep.TemplateID = template_id;

            rep.Generate();

            File.Copy(rep.ReportFile, file);
            
            return file;
        }
        catch (Exception ex)
        {
            SaveExeption(ex);
            throw ex;
        }
        finally
        {
            rep.DeleteReportFiles();
        }
    }
    /// <summary>
    /// Завершення анкетування
    /// </summary>
    /// <param name="session_id">Ід Сесії</param>
    [WebMethod(EnableSession = true)]
    public void WrapUp(String session_id)
    {
        IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = conn.GetUserConnection(Context);
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("SUR_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdWrapUp = connect.CreateCommand();
            cmdWrapUp.CommandText = @"begin cust_survey.finish_session(:p_sess_id); end;";
            cmdWrapUp.Parameters.Add("p_sess_id", OracleDbType.Decimal, session_id, ParameterDirection.Input);
            cmdWrapUp.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            SaveExeption(ex);
            throw ex;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
}

