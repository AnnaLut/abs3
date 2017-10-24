using System;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using System.Web;
using System.Data;

/// <summary>
/// Банки
/// </summary>
public class BankType
{
	public BankType(){}
	/// <summary>
	/// Банк, чию базу використовуємо
	/// </summary>
	/// <returns>БАНК</returns>
	public static BANKTYPE GetCurrentBank()
	{
		OracleConnection connect = new OracleConnection();

		// Заполняем свое МФО
		try 
		{
			// Создаем соединение
			IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

			// Установка роли
			OracleCommand cmdSetRole = connect.CreateCommand();
			cmdSetRole.CommandText = conn.GetSetRoleCommand("BASIC_INFO");
			cmdSetRole.ExecuteNonQuery();

			OracleCommand cmdGetMFO = connect.CreateCommand();
			cmdGetMFO.CommandText = "select val from params where par='BANKTYPE'";

			String result = Convert.ToString(cmdGetMFO.ExecuteScalar());
            connect.Close(); connect.Dispose();

            if (result == "UPB")
				return BANKTYPE.UPB;
			else if (result == "PRVX")
				return BANKTYPE.PRVX;
            else if (result == "SBER")
				return BANKTYPE.PRVX;
		}
		finally
		{
			if (connect.State != ConnectionState.Closed)
				{connect.Close();connect.Dispose();}
		}
										
		return BANKTYPE.DEFAULT;				
	}
    /// <summary>
    /// Тип банківської схеми роботи з депозитами
    /// </summary>
    /// <returns>BANKTYPE</returns>
    public static BANKTYPE GetDptBankType()
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            // Создаем соединение
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            // Установка роли
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("BASIC_INFO");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetMFO = connect.CreateCommand();
            cmdGetMFO.CommandText = "select val from params where par='DPT_BANK_TYPE'";

            String result = Convert.ToString(cmdGetMFO.ExecuteScalar());
            connect.Close(); connect.Dispose();

            if (result == "UPB")
                return BANKTYPE.UPB;
            else if (result == "PRVX")
                return BANKTYPE.PRVX;
            else if (result == "SBER")
                return BANKTYPE.SBER;
            else if (result == "SBER_EBP")
                return BANKTYPE.SBER_EBP;
            else if (result == "NADRA")
                return BANKTYPE.NADRA;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }

        return BANKTYPE.DEFAULT;
    }

	/// <summary>
	/// Код операції викупу центів
	/// </summary>
	/// <returns></returns>
	public static String GetDpfOper(Decimal dpt_id)
	{
		OracleConnection connect = new OracleConnection();
		String result = String.Empty;

		try 
		{
			IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

			OracleCommand cmdSetRole = connect.CreateCommand();
			cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmdSetRole.ExecuteNonQuery();

			OracleCommand getDpfOper = connect.CreateCommand();
            getDpfOper.CommandText = @"select nvl(max(op_type),'DPF') 
                from v_dpt_vidd_tts t, dpt_deposit d
                where T.DPTTYPE_ID = D.VIDD and D.DEPOSIT_ID = :dpt_id and tt_id =  7";
            getDpfOper.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
			result =  Convert.ToString(getDpfOper.ExecuteScalar());			
		}
		finally
		{
			if (connect.State != ConnectionState.Closed)
			{connect.Close();connect.Dispose();}
		}

		return result;
	}
    
    /// <summary>
    /// Банківська дата
    /// </summary>
    /// <returns></returns>
    public static String GetBankDate()
    {
        OracleConnection connect = new OracleConnection();
        String result = String.Empty;

        try
        {
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("BASIC_INFO");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdBankdate = connect.CreateCommand();
            cmdBankdate.CommandText = @"SELECT TO_CHAR(BANKDATE,'DD/MM/YYYY') FROM DUAL";
            result = Convert.ToString(cmdBankdate.ExecuteScalar());
            return result;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    public static String GetOurMfo()
    {
        OracleConnection connect = new OracleConnection();
        String result = String.Empty;

        try
        {
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("BASIC_INFO");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdBankdate = connect.CreateCommand();
            cmdBankdate.CommandText = @"SELECT val from params where par = 'MFO'";
            result = Convert.ToString(cmdBankdate.ExecuteScalar());
            return result;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
}
/// <summary>
/// Типи банків
/// </summary>
public enum BANKTYPE
{
	/// <summary>
	/// По замовчуванню
	/// </summary>
	DEFAULT = 0,
	/// <summary>
	/// УкрПрофБанк
	/// </summary>		
	UPB = 1,
	/// <summary>
	/// Правекс
    /// </summary>
	PRVX = 2,
    /// <summary>
    /// Ощадбанк
    /// </summary>
    SBER = 3,
    /// <summary>
    /// Надра
    /// </summary>
    NADRA = 4,
    /// <summary>
    /// Ощадбанк (обслуговування згідно вимог ЕБП)
    /// </summary>
    SBER_EBP = 5
};