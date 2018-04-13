using System;
using System.Data;
using System.Collections.Generic;
using System.Globalization;
using System.Web;
using System.Web.Services;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Bars.Classes;
using Bars.Logger;

/// <summary>
/// Клас утиліт для роботи з депозитами
/// </summary>
public class Tools
{
    /// <summary>
    /// Перевірка достатньості вказаних реквізитів для пошуку
    /// </summary>
    /// <param name="p_dptid">ІД депозиту</param>
    /// <param name="p_dptnum">Номер договору</param>
    /// <param name="p_custid">РНК вкладника</param>
    /// <param name="p_accnum">номер рахунку</param>
    /// <param name="p_custname">назва вкладника</param>
    /// <param name="p_custcode">ІПН вкладника</param>
    /// <param name="p_birthdate">дата народження вкладника</param>
    /// <param name="p_docserial">серія документу</param>
    /// <param name="p_docnum">номер документу</param>
    /// <param name="p_extended">рівень складністі пошуку</param>
    /// <returns></returns>
    public static Decimal CheckSearchParams(String p_dptid, String p_dptnum, String p_custid, String p_accnum, String p_custname, 
                                     String p_custcode, DateTime? p_birthdate, String p_docserial, String p_docnum, Int32 p_extended)
    {

        OracleConnection connect = new OracleConnection();

        try
        {	
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            OracleCommand cmdCkParams = connect.CreateCommand();
            cmdCkParams.CommandText = "select dpt_web.enough_search_params " +
                "(:p_dptid,    :p_dptnum,    :p_custid,    :p_accnum, :p_custname, " +
                " :p_custcode, :p_birthdate, :p_docserial, :p_docnum, :p_extended) from dual";

            cmdCkParams.Parameters.Clear();

            cmdCkParams.Parameters.Add("p_dptid", OracleDbType.Decimal, p_dptid,  ParameterDirection.Input);
            cmdCkParams.Parameters.Add("p_dptnum", OracleDbType.Decimal, p_dptnum, ParameterDirection.Input);
            cmdCkParams.Parameters.Add("p_custid", OracleDbType.Decimal, p_custid, ParameterDirection.Input);
            cmdCkParams.Parameters.Add("p_accnum", OracleDbType.Varchar2, p_accnum, ParameterDirection.Input);
            cmdCkParams.Parameters.Add("p_custname", OracleDbType.Varchar2, p_custname, ParameterDirection.Input);
            cmdCkParams.Parameters.Add("p_custcode", OracleDbType.Varchar2, p_custcode, ParameterDirection.Input);
            cmdCkParams.Parameters.Add("p_birthdate", OracleDbType.Date, p_birthdate, ParameterDirection.Input);
            cmdCkParams.Parameters.Add("p_docserial", OracleDbType.Varchar2, p_docserial, ParameterDirection.Input);
            cmdCkParams.Parameters.Add("p_docnum", OracleDbType.Varchar2, p_docnum, ParameterDirection.Input);
            cmdCkParams.Parameters.Add("p_extended", OracleDbType.Decimal, p_extended, ParameterDirection.Input);

            return Convert.ToDecimal(cmdCkParams.ExecuteScalar());

            #region HideComments
            // ID вкладу
            //if (String.IsNullOrEmpty(p_dptid))
            //    cmdCkParams.Parameters.Add("p_dptid", OracleDbType.Decimal, null, ParameterDirection.Input);
            //else
            //    cmdCkParams.Parameters.Add("p_dptid", OracleDbType.Decimal, p_dptid, ParameterDirection.Input);

            // Номер вкладу
            //if (String.IsNullOrEmpty(p_dptnum))
            //    cmdCkParams.Parameters.Add("p_dptnum", OracleDbType.Decimal, null, ParameterDirection.Input);
            //else
            //    cmdCkParams.Parameters.Add("p_dptnum", OracleDbType.Decimal, p_dptnum, ParameterDirection.Input);

            //if (String.IsNullOrEmpty(textClientId.Text))
            //    cmdCkParams.Parameters.Add("p_custid", OracleDbType.Decimal, null, ParameterDirection.Input);
            //else
            //    cmdCkParams.Parameters.Add("p_custid", OracleDbType.Decimal, textClientId.Text, ParameterDirection.Input);

            //if (String.IsNullOrEmpty(textAccount.Text))
            //    cmdCkParams.Parameters.Add("p_accnum", OracleDbType.Varchar2, null, ParameterDirection.Input);
            //else
            //    cmdCkParams.Parameters.Add("p_accnum", OracleDbType.Varchar2, textAccount.Text, ParameterDirection.Input);

            //if (String.IsNullOrEmpty(textClientName.Text))
            //    cmdCkParams.Parameters.Add("p_custname", OracleDbType.Varchar2, null, ParameterDirection.Input);
            //else
            //    cmdCkParams.Parameters.Add("p_custname", OracleDbType.Varchar2, textClientName.Text, ParameterDirection.Input);

            //if (String.IsNullOrEmpty(textClientCode.Text))
            //    cmdCkParams.Parameters.Add("p_custcode", OracleDbType.Varchar2, null, ParameterDirection.Input);
            //else
            //    cmdCkParams.Parameters.Add("p_custcode", OracleDbType.Varchar2, textClientCode.Text, ParameterDirection.Input);

            //if (bDate.Date == DateTime.MinValue)
            //    cmdCkParams.Parameters.Add("p_birthdate", OracleDbType.Date, null, ParameterDirection.Input);
            //else
            //    cmdCkParams.Parameters.Add("p_birthdate", OracleDbType.Date, bDate.Date, ParameterDirection.Input);

            //if (String.IsNullOrEmpty(DocSerial.Text))
            //    cmdCkParams.Parameters.Add("p_docserial", OracleDbType.Varchar2, null, ParameterDirection.Input);
            //else
            //    cmdCkParams.Parameters.Add("p_docserial", OracleDbType.Varchar2, DocSerial.Text, ParameterDirection.Input);

            //if (String.IsNullOrEmpty(DocNumber.Text))
            //    cmdCkParams.Parameters.Add("p_docnum", OracleDbType.Varchar2, null, ParameterDirection.Input);
            //else
            //    cmdCkParams.Parameters.Add("p_docnum", OracleDbType.Varchar2, DocNumber.Text, ParameterDirection.Input);
            #endregion
        }
        catch (Exception ex)
        {
            /// Перехоплюємо помилку і записуємо її
            /// щоб потім відобразити тільки у модальному діалозі
            Deposit.SaveException(ex);
            return 0;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }

    /// <summary>
    /// ф-я повертає зображення клієнта
    /// </summary>
    /// <param name="CustomerID">РНК клієнта</param>
    /// <param name="TypePicture">тип зображення (фото/підпис)</param>
    /// <returns></returns>
    public static Byte[] get_cliet_picture(Decimal CustomerID, String TypePicture)
    {
        Byte[] img = new Byte[0];

        OracleConnection connect = OraConnector.Handler.IOraConnection.GetUserConnection();

        try
        {
            OracleCommand cmdSQL = connect.CreateCommand();

            cmdSQL.CommandText = "select IMAGE from CUSTOMER_IMAGES where RNK = :p_rnk and TYPE_IMG = :p_type";

            cmdSQL.Parameters.Add("p_rnk", OracleDbType.Decimal, CustomerID, ParameterDirection.Input);
            cmdSQL.Parameters.Add("p_type", OracleDbType.Varchar2, TypePicture, ParameterDirection.Input);

            OracleDataReader rdr = cmdSQL.ExecuteReader();

            if (rdr.Read())
                img = (Byte[])rdr["image"];

        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }

        return img;
    }

    /// <summary>
    /// Встановлення ознаки перевірки реквізитів ідентифікуючого документу 
    /// </summary>
    /// <param name="CustomerID">РНК клієнта</param>
    public static void Set_DocumentVerifiedState(Decimal CustomerID)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = @"begin EBP.set_verified_state( :p_rnk, 1 ); end;";

            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, CustomerID, ParameterDirection.Input);

            cmd.ExecuteNonQuery();

        }
        catch (Exception ex)
        {
            // Перехоплюємо бо ASP.NET ajax НІЯК не обробляє викинуті помилки
            Deposit.SaveException(ex);
            throw ex;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    public static void Set_DocumentVerifiedState(Decimal CustomerID, Decimal State)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = @"begin EBP.set_verified_state( :p_rnk, :p_state ); end;";

            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, CustomerID, ParameterDirection.Input);
            cmd.Parameters.Add("p_state", OracleDbType.Decimal, State, ParameterDirection.Input);

            cmd.ExecuteNonQuery();

        }
        catch (Exception ex)
        {
            // Перехоплюємо бо ASP.NET ajax НІЯК не обробляє викинуті помилки
            Deposit.SaveException(ex);
            throw ex;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }

    /// <summary>
    /// отримати статус актуальності реквізитів ідентифікуючого документу
    /// </summary>
    /// <param name="CustomerID">РНК клієнта</param>
    /// <returns></returns>
    public static Boolean Get_DocumentVerifiedState(Decimal CustomerID)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            OracleCommand cmdSQL = connect.CreateCommand();

            cmdSQL.CommandText = "select EBP.get_verified_state( :p_rnk ) from dual";
            cmdSQL.Parameters.Add("p_rnk", OracleDbType.Decimal, CustomerID, ParameterDirection.Input);

            if (Convert.ToInt32(cmdSQL.ExecuteScalar()) == 1)
            {    
                return true;
            }
            else
            {
                return false;
            }

        }
        //catch (Exception ex)
        //{
        //    Deposit.SaveException(ex);
        //    return false;
        //}
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
    /// <summary>
    /// отримати статус актуальності мобільного телефону                       
    /// </summary>
    /// <param name="CustomerID">РНК клієнта</param>
    /// <returns></returns>
    public static Boolean Get_CellPhoneVerifiedState(Decimal CustomerID)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            OracleCommand cmdSQL = connect.CreateCommand();

            cmdSQL.CommandText = "select verify_cellphone_byrnk( :p_rnk ) from dual";
            cmdSQL.Parameters.Add("p_rnk", OracleDbType.Decimal, CustomerID, ParameterDirection.Input);

            if (Convert.ToInt32(cmdSQL.ExecuteScalar()) == 1)
            {
                return true;
            }
            else
            {
                return false;
            }

        }
        //catch (Exception ex)
        //{
        //    Deposit.SaveException(ex);
        //    return false;
        //}
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
    /// <summary>
    /// отримати статус актуальності мобільного телефону                       
    /// </summary>
    /// <param name="p_cell">номер телефону з форми</param>
    /// <returns></returns>
    public static Boolean Get_CellPhoneVerState(String p_cell)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            OracleCommand cmdSQL = connect.CreateCommand();

            cmdSQL.CommandText = "select verify_cellphone( :p_cell ) from dual";
            cmdSQL.Parameters.Add("p_cell", OracleDbType.Varchar2, p_cell, ParameterDirection.Input);

            if (Convert.ToInt32(cmdSQL.ExecuteScalar()) == 1)
            {
                return true;
            }
            else
            {
                return false;
            }

        }
        //catch (Exception ex)
        //{
        //    Deposit.SaveException(ex);
        //    return false;
        //}
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }
    /// <summary>
    /// попередне збереження змін реквізитів клієнта
    /// </summary>
    /// <param name="cust_id">РНК</param>
    /// <param name="par_name">Назва параметру (тег)</param>
    /// <param name="par_value">Значення параметру</param>
    public static void pre_save_customer_changes(Decimal cust_id, String par_name, String par_value, String par_old_value)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = @"begin EBP.PREVIOUS_SAVE_CUSTOMER_PARAMS( :p_rnk, :p_tag, :p_val, :p_val_old ); end;";

            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, cust_id, ParameterDirection.Input);
            cmd.Parameters.Add("p_tag", OracleDbType.Varchar2, par_name, ParameterDirection.Input);
            cmd.Parameters.Add("p_val", OracleDbType.Varchar2, par_value, ParameterDirection.Input);
            cmd.Parameters.Add("p_val_old", OracleDbType.Varchar2, par_old_value, ParameterDirection.Input);

            cmd.ExecuteNonQuery();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }

    /// <summary>
    /// Фіксація змін реквізитів клієнта
    /// </summary>
    /// <param name="cust_id">РНК</param>
    public static void clear_changes_customer_params(Decimal cust_id)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = @"begin dpt_web.CLEAR_CHANGES_CUSTOMER_PARAMS( :p_rnk ); end;";

            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, cust_id, ParameterDirection.Input);

            cmd.ExecuteNonQuery();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }

    /// <summary>
    /// Фіксація змін реквізитів клієнта
    /// </summary>
    /// <param name="cust_id">РНК</param>
    public static void save_changes_customer_params(Decimal cust_id)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = @"begin EBP.SAVE_CHANGES_CUSTOMER_PARAMS( :p_rnk ); end;";

            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, cust_id, ParameterDirection.Input);

            cmd.ExecuteNonQuery();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }

    /// <summary>
    /// Перевірка на наявність у клієнта відкритого рахунка 2625 
    /// </summary>
    /// <param name="cust_id">РНК</param>
    /// /// <param name="curr_id">Код валюти</param>
    /// <returns></returns>
    public static Boolean card_account_exists(Decimal cust_id, Decimal? curr_id)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            OracleCommand cmd = connect.CreateCommand();

            cmd.CommandText = " select count(acc) from accounts where nbs = '2625' and rnk = :p_rnk and dazs is null ";

            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, cust_id, ParameterDirection.Input);

            // Якщо вказано валюту
            if (curr_id.HasValue && curr_id > 0 && (curr_id == 980 || curr_id == 978 ||  curr_id == 840 )) // для інших валют картковий рахунок у тій самій валюті не потрібен
            {
                cmd.CommandText += " and kv = :p_kv ";
                cmd.Parameters.Add("p_kv", OracleDbType.Decimal, curr_id, ParameterDirection.Input);
            }

            if (Convert.ToInt32(cmd.ExecuteScalar()) > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        catch (Exception ex)
        {
            Deposit.SaveException(ex);
            return false;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }

    /// <summary>
    /// Шаблон депозитного договору для друку
    /// </summary>
    /// <param name="vidd_id">Ідентифікатор депозиту</param>
    /// <param name="AgreementID">Код додаткової угоди (основний договір = 1)</param>
    /// <returns></returns>
    public static String Get_TemplateID(Decimal DepositID, Decimal AgreementCode)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            OracleCommand cmd = connect.CreateCommand();

            cmd.CommandText = "select EBP.get_template(:p_dptid, :p_code, :p_fr ) from dual";

            cmd.Parameters.Add("p_dptid", OracleDbType.Decimal, DepositID, ParameterDirection.Input);
            cmd.Parameters.Add("p_code", OracleDbType.Decimal, AgreementCode, ParameterDirection.Input);
            cmd.Parameters.Add("p_fr", OracleDbType.Decimal, 1, ParameterDirection.Input);

            return Convert.ToString(cmd.ExecuteScalar());
        }
        catch (Exception ex)
        {
            Deposit.SaveException(ex);
            return "EMPTY_TEMPLATE";
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }

    /// <summary>
    /// Перевірка ідентифікаційного коду клієнта
    /// </summary>
    /// <param name="Birthday">Дата народження клієнта</param>
    /// <param name="ClientCode">Код клієнта</param>
    /// <returns></returns>
    public static Boolean CheckClientCode(DateTime Birthday, String ClientCode)
    {
        if ((Birthday != DateTime.MinValue) && !(String.IsNullOrEmpty(ClientCode)) && (ClientCode.Length == 10))
        {
            if (ClientCode == "0000000000")
            {
                return true;
            }
            else if (System.Text.RegularExpressions.Regex.IsMatch(ClientCode,"^1{10}|2{10}|3{10}|4{10}|5{10}|6{10}|7{10}|8{10}|9{10}$"))
            {
                return false;
            }
            else
            {
                // Int32 days = Birthday.Subtract(Convert.ToDateTime("31.12.1899")).Days;

                Int32 days = Birthday.Subtract(new DateTime(1899,12,31)).Days;

                if (ClientCode.Substring(0, 5) == days.ToString().PadLeft(5, '0'))
                    return true;
                else
                    return false;
            }
        }
        else
            return false;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="text">Текст для транслітерації</param>
    /// <returns></returns>
    public static String Translate(String text)
    {
        String result = String.Empty;

        OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

        try
        {
            OracleCommand cmdSQL = connect.CreateCommand();

            cmdSQL.CommandText = "select F_TRANSLATE_KMU( :p_text ) from dual";

            cmdSQL.Parameters.Add("p_text", OracleDbType.Varchar2, text.ToUpper(), ParameterDirection.Input);

            OracleDataReader rdr = cmdSQL.ExecuteReader();

            if (rdr.Read())
            {
                if (!rdr.IsDBNull(0))
                    result = rdr.GetOracleString(0).Value;
            }
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            {
                connect.Close();
                connect.Dispose();
            }
        }

        return result;
    }

    /// <summary>
    /// Збереження ідентифікатора договору в ЕАД
    /// (ознака того що договір підписаний клієнтом та створений по схемі ЕБП)
    /// </summary>
    /// <param name="DepositID">ідентифікатор депозиту</param>
    /// <param name="EAdocID">ідентифікатор договору в ЕАД</param>
    public static void set_EADocID(decimal DepositID, decimal EAdocID)
    {
        OracleConnection connect = OraConnector.Handler.IOraConnection.GetUserConnection();

        try
        {
            OracleCommand cmd = connect.CreateCommand();

            cmd.CommandText = @"begin EBP.SET_ARCHIVE_DOCID( :p_dptid, :p_docid ); end;";

            cmd.Parameters.Add("p_dptid", OracleDbType.Decimal, DepositID, ParameterDirection.Input);
            cmd.Parameters.Add("p_docid", OracleDbType.Decimal, EAdocID, ParameterDirection.Input);

            cmd.ExecuteNonQuery();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            {
                connect.Close();
                connect.Dispose();
            }
        }
    }

    /// <summary>
    /// ід депозитного договору в ЕАД (якщо = 0 - вклад відкривався не по ЕБП)
    /// </summary>
    /// <param name="DepositID">ід деп.договору</param>
    /// <returns>ід документу в ЕАД</returns>
    public static Int64 get_EADocID(decimal DepositID)
    {
        Int64 EAD_ID = 0;

        OracleConnection connect = OraConnector.Handler.IOraConnection.GetUserConnection();

        try
        {
            OracleCommand cmd = connect.CreateCommand();

            cmd.CommandText = "select EBP.GET_ARCHIVE_DOCID( :p_dptid ) from DUAL";

            cmd.Parameters.Add("p_dptid", OracleDbType.Decimal, DepositID, ParameterDirection.Input);

            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                if (!rdr.IsDBNull(0))
                    EAD_ID = Convert.ToInt64(rdr.GetOracleDecimal(0).Value);
            }
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

        return EAD_ID;
    }

    /// <summary>
    /// Перевірка необхідності друку анкети Фін.Моніторингу при внесенні коштів клієнтом
    /// </summary>
    /// <param name="Currency">Код валюти</param>
    /// <param name="Amount">Сума (в копійках)</param>
    /// <returns></returns>
    public static Boolean PrintQuestionnaire(Int32 Currency, Decimal Amount)
    {
        Boolean NeedPrint = false;

        OracleConnection connect = OraConnector.Handler.IOraConnection.GetUserConnection();

        try
        {
            OracleCommand cmd = connect.CreateCommand();

            cmd.CommandText = "select round(gl.p_icurval(:p_kv, :p_sum, gl.bd)) from DUAL";

            cmd.Parameters.Add("p_kv", OracleDbType.Decimal, Currency, ParameterDirection.Input);
            cmd.Parameters.Add("p_sum", OracleDbType.Decimal, Amount, ParameterDirection.Input);

            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                if (!rdr.IsDBNull(0))
                {
                    // якщо сума більша або рівна 150 тис. - запавнюється анкета для фін.моніторингу
                    if (rdr.GetOracleDecimal(0).Value >= 15000000)
                        NeedPrint = true;                    
                }
            }
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            {
                connect.Close();
                connect.Dispose();
            }
        }

        return NeedPrint;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    public static CultureInfo Cinfo()
    {
        CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
        
        cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
        cinfo.DateTimeFormat.DateSeparator = "/";

        cinfo.NumberFormat.NumberDecimalSeparator = ".";
        cinfo.NumberFormat.CurrencyDecimalSeparator = ".";

        return cinfo;
    }

    /// <summary>
    /// Схема роботи Депозитного модуля ФО яка використовується у ТВБВ користувача
    /// </summary>
    /// <returns></returns>
    public static String DPT_WORK_SCHEME()
    {
        String WORK_SCHEME = "OLD";
        
        OracleConnection connect = OraConnector.Handler.IOraConnection.GetUserConnection();

        try
        {
            OracleCommand cmd = connect.CreateCommand();

            cmd.CommandText = @" select VAL from BRANCH_PARAMETERS 
                where BRANCH = sys_context('bars_context','user_branch') and TAG = 'DPT_WORKSCHEME' ";

            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                if (!rdr.IsDBNull(0))
                    WORK_SCHEME = rdr.GetOracleString(0).Value;
            }
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
        return WORK_SCHEME;
    }

    /// <summary>
    /// Схема виплати відсотків у відділенні: 1 - можна платити на касу, default = 0, платити на рахунок, відповідно до ЕБП.
    /// </summary>
    /// <returns></returns>
    public static Int32 DPT_PAY_CASHDESK()
    {
        Int32 PAY_CASHDESK = 0;
        String tag = "DPT_PAY_CASHDESK";

        OracleConnection connect = OraConnector.Handler.IOraConnection.GetUserConnection();

        try
        {
            OracleCommand cmd = connect.CreateCommand();

            cmd.CommandText = @"select cast( VAL as decimal ) from BRANCH_PARAMETERS 
                where BRANCH = sys_context('bars_context','user_branch') and TAG =  :p_tag ";

            cmd.Parameters.Add("p_tag", OracleDbType.Varchar2, tag.ToUpper() , ParameterDirection.Input);
            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                
                if (!rdr.IsDBNull(0))
                    PAY_CASHDESK = Convert.ToInt32(rdr.GetOracleDecimal(0).Value);
                
            }
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
        return PAY_CASHDESK;
    }

    /// <summary>
    /// Відправка SMS повідомлень
    /// </summary>
    /// <param name="CustomerID">РНК</param>
    /// <param name="Message">Текст повідомлення</param>
    /// <param name="DepositID">Рефененс депозитного договору</param>
    /// <param name="Amount">Сума операції</param>
    /// <param name="Currency">Код валюти операції</param>
    public static void Send_SMS(Decimal CustomerID, String Message)
    {
        OracleConnection connect = OraConnector.Handler.IOraConnection.GetUserConnection();

        try
        {
            OracleCommand cmd = connect.CreateCommand();

            cmd.CommandText = @"begin DPT_WEB.SEND_SMS( :p_rnk, :p_msg ); end;";

            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, CustomerID, ParameterDirection.Input);
            cmd.Parameters.Add("p_msg", OracleDbType.Varchar2, Message, ParameterDirection.Input);

            cmd.ExecuteNonQuery();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            {
                connect.Close();
                connect.Dispose();
            }
        }
    }
}