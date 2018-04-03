using System;
using System.Web;
using System.Collections;
using System.Globalization;
using Oracle.DataAccess.Client;
using System.Data;
using Bars.Oracle;
using Bars.Logger;
using Bars.Exception;
using Bars.Classes;

/// <summary>
/// Клас роботи з
/// банківським файлом
/// зачислення пенсій та 
/// матерійальної допомоги
/// </summary>
public class BankFile
{
	public FileHeader		header;
	public FileInfoLine[]	info;
	/// Тип зарахування
	public Decimal			type_id;
    /// 
    public Decimal AGENCY_TYPE;

    private Decimal[] get_header_id()
    {
        Decimal[] result = new Decimal[info.Length];

        for (int i = 0; i<info.Length; i++)
            result[i] = header.id;

        return result;
    }
    private String[] get_filename()
    {
        String[] result = new String[info.Length];

        for (int i = 0; i<info.Length; i++)
            result[i] = header.filename;

        return result;
    }
    private int[] get_filename_size()
    {
        int[] result = new int[info.Length];

        for (int i = 0; i<info.Length; i++)
            result[i] = header.filename.Length;

        return result;
    }
    private DateTime[] get_dat()
    {
        DateTime[] result = new DateTime[info.Length];

        for (int i = 0; i<info.Length; i++)
            result[i] = header.dtCreated;

        return result;
    }
    private String[] get_nls()
    {
        String[] result = new String[info.Length];

        for (int i = 0; i<info.Length; i++)
            result[i] = info[i].NLS;

        return result;
    }
    private int[] get_nls_size()
    {
        int[] result = new int[info.Length];

        for (int i = 0; i<info.Length; i++)
            result[i] = info[i].NLS.Length;

        return result;
    }
    private Decimal[] get_branch_code()
    {
        Decimal[] result = new Decimal[info.Length];

        for (int i = 0; i<info.Length; i++)
            result[i] = info[i].Branch_code;

        return result;
    }
    private Decimal[] get_dpt_code()
    {
        Decimal[] result = new Decimal[info.Length];

        for (int i = 0; i<info.Length; i++)
            result[i] = info[i].Dpt_code;

        return result;
    }
    private Decimal[] get_sum()
    {
        Decimal[] result = new Decimal[info.Length];

        for (int i = 0; i<info.Length; i++)
            result[i] = info[i].Sum;

        return result;
    }
    private String[] get_fio()
    {
        String[] result = new String[info.Length];

        for (int i = 0; i<info.Length; i++)
            result[i] = info[i].FIO;

        return result;
    }
    private int[] get_fio_size()
    {
        int[] result = new int[info.Length];

        for (int i = 0; i<info.Length; i++)
            result[i] = info[i].FIO.Length;

        return result;
    }
    private String[] get_pasp()
    {
        String[] result = new String[info.Length];

        for (int i = 0; i<info.Length; i++)
            result[i] = info[i].Pasp;

        return result;
    }
    private int[] get_pasp_size()
    {
        int[] result = new int[info.Length];

        for (int i = 0; i<info.Length; i++)
            result[i] = info[i].Pasp.Length;

        return result;
    }
    /// <summary>
	/// Конструктор
	/// </summary>
	/// <param name="arr">Масив рядків файлу</param>
	public BankFile(ArrayList arr)
	{
		header = new FileHeader((String)arr[0]);
		info = new FileInfoLine[Int32.Parse(header.numInfo.ToString())];

		if (header.numInfo > arr.Count - 1)
			throw new DepositException("Недостатньо стрічок у прийнятому банківському файлі!");
		if (header.numInfo < arr.Count - 1)
            throw new DepositException("Надлишкові стрічки у прийнятому банківському файлі!");

		for (int i = 0; i< header.numInfo; i++)
		{
			info[i] = new FileInfoLine((String)arr[i + 1]);
		}
	}

	/// <summary>
	/// Конструктор
	/// </summary>
	/// <param name="filename">Імя файлу</param>
	/// <param name="dat">Дата</param>
	public BankFile(String filename,DateTime dat,Decimal header_id)
	{
		header = new FileHeader();

		header.filename = filename;
		header.dtCreated = dat;
        header.id = header_id;

		ReadFromDatabase();
	}
	/// <summary>
	/// Запис в базу
	/// </summary>
	public void WriteToDatabase()
	{
		OracleConnection connect = new OracleConnection();

        bool txCommitted = false;

        IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
        connect = conn.GetUserConnection();
        

        OracleTransaction tx = connect.BeginTransaction();

        try
		{

			// Устанавливаем роль
			OracleCommand cmdSetRole = connect.CreateCommand();
			cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmdSetRole.ExecuteNonQuery();

			OracleCommand cmdInsertHeader = connect.CreateCommand();
			cmdInsertHeader.CommandText = "BEGIN " +
				" dpt_social.create_file_header(:filename,:header_length,:dat,:info_length, " +
                "  :mfo_a,:nls_a,:mfo_b,:nls_b,:DK,:SUM,:TYPE,:num,:has_add,:name_a,:name_b, " +
                "  :dest,:branch_num,:dpt_code,:exec_ord,:ks_ep,:type_id,:agency_type,:header_id); " +
				" end; ";
			
			cmdInsertHeader.Parameters.Add("filename",		OracleDbType.Varchar2,	header.filename,		ParameterDirection.Input);
			cmdInsertHeader.Parameters.Add("header_length",	OracleDbType.Decimal,	header.headerLength,	ParameterDirection.Input);
			cmdInsertHeader.Parameters.Add("dat",			OracleDbType.Date,		header.dtCreated,		ParameterDirection.Input);
			cmdInsertHeader.Parameters.Add("info_length",	OracleDbType.Decimal,	header.numInfo,			ParameterDirection.Input);
			cmdInsertHeader.Parameters.Add("mfo_a",			OracleDbType.Varchar2,	header.MFO_A.Trim(),	ParameterDirection.Input);
			cmdInsertHeader.Parameters.Add("nls_a",			OracleDbType.Varchar2,	header.NLS_A.Trim(),	ParameterDirection.Input);
			cmdInsertHeader.Parameters.Add("mfo_b",			OracleDbType.Varchar2,	header.MFO_B.Trim(),	ParameterDirection.Input);
			cmdInsertHeader.Parameters.Add("nls_b",			OracleDbType.Varchar2,	header.NLS_B.Trim(),	ParameterDirection.Input);
			cmdInsertHeader.Parameters.Add("DK",			OracleDbType.Decimal,	header.DK,				ParameterDirection.Input);
			cmdInsertHeader.Parameters.Add("SUM",			OracleDbType.Decimal,	header.Sum,				ParameterDirection.Input);
			cmdInsertHeader.Parameters.Add("TYPE",			OracleDbType.Decimal,	header.Typ,				ParameterDirection.Input);
			cmdInsertHeader.Parameters.Add("num",			OracleDbType.Varchar2,	header.Number,			ParameterDirection.Input);
			cmdInsertHeader.Parameters.Add("has_add",		OracleDbType.Varchar2,	header.AddExists,		ParameterDirection.Input);
			cmdInsertHeader.Parameters.Add("name_a",		OracleDbType.Varchar2,	header.NMK_A,			ParameterDirection.Input);
			cmdInsertHeader.Parameters.Add("name_b",		OracleDbType.Varchar2,	header.NMK_B,			ParameterDirection.Input);
			cmdInsertHeader.Parameters.Add("dest",			OracleDbType.Varchar2,	header.Nazn,			ParameterDirection.Input);
			cmdInsertHeader.Parameters.Add("branch_code",	OracleDbType.Decimal,	header.Branch_code,		ParameterDirection.Input);
			cmdInsertHeader.Parameters.Add("dpt_code",		OracleDbType.Decimal,	header.Dpt_code,		ParameterDirection.Input);
			cmdInsertHeader.Parameters.Add("exec_ord",		OracleDbType.Varchar2,	header.Exec_ord,		ParameterDirection.Input);
			cmdInsertHeader.Parameters.Add("ks_ep",			OracleDbType.Varchar2,	header.KS_EP,			ParameterDirection.Input);
            cmdInsertHeader.Parameters.Add("type_id",       OracleDbType.Decimal,   this.type_id,           ParameterDirection.Input);
            cmdInsertHeader.Parameters.Add("agency_type",   OracleDbType.Decimal,   this.AGENCY_TYPE,       ParameterDirection.Input);
            cmdInsertHeader.Parameters.Add("header_id",     OracleDbType.Decimal,   this.header.id,         ParameterDirection.Output);

			cmdInsertHeader.ExecuteNonQuery();

            this.header.id = Convert.ToDecimal(Convert.ToString(cmdInsertHeader.Parameters[22].Value));

			OracleCommand cmdInsertInfo = connect.CreateCommand();
            cmdInsertInfo.CommandText = " begin dpt_social.create_file_row_group( " +
                " :header_id, :filename,:dat,:nls,:branch_code,:dpt_code,:sum,:fio,:pasp, " +
                " :info_id); end;";

            TrimNls();

			cmdInsertInfo.Parameters.Clear();
            cmdInsertInfo.BindByName = true;
                
            OracleParameter header_id = cmdInsertInfo.Parameters.Add("header_id",   OracleDbType.Decimal);
            header_id.Direction = ParameterDirection.Input;
            header_id.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
            header_id.Value = get_header_id();
            header_id.Size = info.Length;
            header_id.ArrayBindSize = null;

            OracleParameter filename = cmdInsertInfo.Parameters.Add("filename", OracleDbType.Varchar2);
            filename.Direction = ParameterDirection.Input;
            filename.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
            filename.Value = get_filename();
            filename.Size = info.Length;
            filename.ArrayBindSize = get_filename_size();

            OracleParameter dat = cmdInsertInfo.Parameters.Add("dat", OracleDbType.Date);
            dat.Direction = ParameterDirection.Input;
            dat.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
            dat.Value = get_dat();
            dat.Size = info.Length;

            OracleParameter nls = cmdInsertInfo.Parameters.Add("nls", OracleDbType.Varchar2);
            nls.Direction = ParameterDirection.Input;
            nls.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
            nls.Value = get_nls();
            nls.Size = info.Length;
            nls.ArrayBindSize = get_nls_size();

            OracleParameter branch_code = cmdInsertInfo.Parameters.Add("branch_code", OracleDbType.Decimal);
            branch_code.Direction = ParameterDirection.Input;
            branch_code.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
            branch_code.Value = get_branch_code();
            branch_code.Size = info.Length;


            OracleParameter dpt_code = cmdInsertInfo.Parameters.Add("dpt_code", OracleDbType.Decimal);
            dpt_code.Direction = ParameterDirection.Input;
            dpt_code.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
            dpt_code.Value = get_dpt_code();
            dpt_code.Size = info.Length;

            OracleParameter sum = cmdInsertInfo.Parameters.Add("sum", OracleDbType.Decimal);
            sum.Direction = ParameterDirection.Input;
            sum.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
            sum.Value = get_sum();
            sum.Size = info.Length;

            OracleParameter fio = cmdInsertInfo.Parameters.Add("fio", OracleDbType.Varchar2);
            fio.Direction = ParameterDirection.Input;
            fio.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
            fio.Value = get_fio();
            fio.Size = info.Length;
            fio.ArrayBindSize = get_fio_size();

            OracleParameter pasp = cmdInsertInfo.Parameters.Add("pasp", OracleDbType.Varchar2);
            pasp.Direction = ParameterDirection.Input;
            pasp.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
            pasp.Value = get_pasp();
            pasp.Size = info.Length;
            pasp.ArrayBindSize = get_pasp_size();

            OracleParameter info_id = cmdInsertInfo.Parameters.Add("info_id", OracleDbType.Decimal);
            info_id.Direction = ParameterDirection.Output;
            info_id.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
            info_id.Value = null;
            info_id.Size = info.Length;
            
			cmdInsertInfo.ExecuteNonQuery();

            for (int i = 0; i<info.Length; i++)
                info[i].ID = Convert.ToDecimal(Convert.ToString(
                    (cmdInsertInfo.Parameters["info_id"].Value as Array).GetValue(i)
                    ));

            OracleCommand cmdFinish = connect.CreateCommand();
            cmdFinish.CommandText = "begin dpt_social.set_agencyid(:header_id); end;";

            cmdFinish.Parameters.Add("header_id", OracleDbType.Decimal, header.id, ParameterDirection.Input);
            cmdFinish.ExecuteNonQuery();

            DBLogger.Debug("Пользователь успешно принял банковский файл " 
				+ header.filename + " за " + header.dtCreated.ToShortDateString()
				,"deposit");

            tx.Commit();
            txCommitted = true;
		}
		finally
		{
            if (!txCommitted) tx.Rollback();

			if ( connect.State != ConnectionState.Closed )
			{connect.Close();connect.Dispose();}
		}
	}
	/// <summary>
	/// Вичитка з бази
	/// </summary>
	public void ReadFromDatabase()
	{
		OracleConnection connect = new OracleConnection();

		try
		{
			// Создаем соединение
			IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

			// Открываем соединение с БД
			

			// Устанавливаем роль
			OracleCommand cmdSetRole = connect.CreateCommand();
			cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdReadHeader = connect.CreateCommand();
			cmdReadHeader.CommandText = "SELECT " +
				"FILENAME,  HEADER_LENGTH, to_char(DAT,'dd/MM/yyyy'), INFO_LENGTH, MFO_A, NLS_A, " +
				"MFO_B, NLS_B, DK, SUM, TYPE, NUM, HAS_ADD, NAME_A, NAME_B, " +
				"NAZN, BRANCH_CODE, DPT_CODE, EXEC_ORD, KS_EP, TYPE_ID, AGENCY_TYPE " +
				"FROM DPT_FILE_HEADER " +
                "WHERE header_id=:header_id";
            cmdReadHeader.Parameters.Add("header_id", OracleDbType.Decimal, header.id, ParameterDirection.Input);

			OracleDataReader hRead = cmdReadHeader.ExecuteReader();
			if (!hRead.Read())
			{
				throw new DepositException("Не знайдено заголовок банківського файлу id = " + header.id + 
					" з іменем: " + header.filename + " за дату: " + header.dtCreated.ToShortDateString());
			}

			if (!hRead.IsDBNull(0))
				header.filename = Convert.ToString(hRead.GetOracleString(0).Value);
			if (!hRead.IsDBNull(1))
				header.headerLength = Convert.ToDecimal(hRead.GetOracleDecimal(1).Value);
			if (!hRead.IsDBNull(2))
			{
				CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
				cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
				cinfo.DateTimeFormat.DateSeparator = "/";

				header.dtCreated = Convert.ToDateTime(Convert.ToString(hRead.GetOracleString(2).Value),cinfo);
			}
			if (!hRead.IsDBNull(3))
				header.numInfo = Convert.ToDecimal(hRead.GetOracleDecimal(3).Value);
			if (!hRead.IsDBNull(4))
				header.MFO_A = Convert.ToString(hRead.GetOracleString(4).Value);
			if (!hRead.IsDBNull(5))
				header.NLS_A = Convert.ToString(hRead.GetOracleString(5).Value);
			if (!hRead.IsDBNull(6))
				header.MFO_B = Convert.ToString(hRead.GetOracleString(6).Value);
			if (!hRead.IsDBNull(7))
				header.NLS_B = Convert.ToString(hRead.GetOracleString(7).Value);				
			if (!hRead.IsDBNull(8))
				header.DK = Convert.ToDecimal(hRead.GetOracleDecimal(8).Value);
			if (!hRead.IsDBNull(9))
				header.Sum = Convert.ToDecimal(hRead.GetOracleDecimal(9).Value);
			if (!hRead.IsDBNull(10))
				header.Typ = Convert.ToDecimal(hRead.GetOracleDecimal(10).Value);
			if (!hRead.IsDBNull(11))
				header.Number = Convert.ToString(hRead.GetOracleString(11).Value);
			if (!hRead.IsDBNull(12))
				header.AddExists = Convert.ToString(hRead.GetOracleString(12).Value);
			if (!hRead.IsDBNull(13))
				header.NMK_A = Convert.ToString(hRead.GetOracleString(13).Value);
			if (!hRead.IsDBNull(14))
				header.NMK_B = Convert.ToString(hRead.GetOracleString(14).Value);
			if (!hRead.IsDBNull(15))
				header.Nazn = Convert.ToString(hRead.GetOracleValue(15));
			if (!hRead.IsDBNull(16))
				header.Branch_code = Convert.ToDecimal(hRead.GetOracleDecimal(16).Value);
			if (!hRead.IsDBNull(17))
				header.Dpt_code = Convert.ToDecimal(hRead.GetOracleDecimal(17).Value);
			if (!hRead.IsDBNull(18))
				header.Exec_ord = Convert.ToString(hRead.GetOracleString(18).Value);
			if (!hRead.IsDBNull(19))
				header.KS_EP = Convert.ToString(hRead.GetOracleString(19).Value);
            if (!hRead.IsDBNull(20))
                this.type_id = Convert.ToDecimal(hRead.GetOracleDecimal(20).Value);
            if (!hRead.IsDBNull(21))
                this.AGENCY_TYPE = Convert.ToDecimal(hRead.GetOracleDecimal(21).Value);
			
			if (!hRead.IsClosed){ hRead.Close();}
            hRead.Dispose(); 

			info = new FileInfoLine[Int32.Parse(header.numInfo.ToString())];			

			OracleCommand cmdGetFileRow = connect.CreateCommand();
			cmdGetFileRow.CommandText = "SELECT info_id, nls,branch_code,dpt_code,SUM,fio,pasp,REF,incorrect,closed,excluded, branch " +
                "FROM DPT_FILE_ROW WHERE header_id=:header_id order by info_id";

            cmdGetFileRow.Parameters.Add("header_id", OracleDbType.Decimal, header.id, ParameterDirection.Input);

			OracleDataReader iReader = cmdGetFileRow.ExecuteReader();
			int i = 0;

			while (iReader.Read())
			{
				info[i] = new FileInfoLine();

				if (!iReader.IsDBNull(0))
					info[i].ID = Convert.ToDecimal(iReader.GetOracleDecimal(0).Value);
				if (!iReader.IsDBNull(1))
					info[i].NLS = Convert.ToString(iReader.GetOracleString(1).Value);
				if (!iReader.IsDBNull(2))
					info[i].Branch_code = Convert.ToDecimal(iReader.GetOracleDecimal(2).Value);
				if (!iReader.IsDBNull(3))
					info[i].Dpt_code = Convert.ToDecimal(iReader.GetOracleDecimal(3).Value);
				if (!iReader.IsDBNull(4))
					info[i].Sum = Convert.ToDecimal(iReader.GetOracleDecimal(4).Value);
				if (!iReader.IsDBNull(5))
					info[i].FIO = Convert.ToString(iReader.GetOracleString(5).Value);
				if (!iReader.IsDBNull(6))
					info[i].Pasp = Convert.ToString(iReader.GetOracleString(6).Value);
				if (!iReader.IsDBNull(7))
					info[i].Ref = Convert.ToDecimal(iReader.GetOracleDecimal(7).Value);
				if (!iReader.IsDBNull(8))
					info[i].Incorrect = Convert.ToDecimal(iReader.GetOracleDecimal(8).Value);
				if (!iReader.IsDBNull(9))
					info[i].Closed = Convert.ToDecimal(iReader.GetOracleDecimal(9).Value);
				if (!iReader.IsDBNull(10))
					info[i].Excluded = Convert.ToDecimal(iReader.GetOracleDecimal(10).Value);
                if (!iReader.IsDBNull(11))
                    info[i].Branch = Convert.ToString(iReader.GetOracleString(11).Value);

				i++;
			}

            if (!iReader.IsClosed) iReader.Close();
            iReader.Dispose();
		}
		finally
		{
			if ( connect.State != ConnectionState.Closed )
			{connect.Close();connect.Dispose();}
		}
	}
	/// <summary>
	/// Оплата
	/// </summary>
	public void Pay()
	{
		OracleConnection connect = new OracleConnection();

		try
		{
			// Создаем соединение
			IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

			// Открываем соединение с БД
			

			// Устанавливаем роль
			OracleCommand cmdSetRole = connect.CreateCommand();
			cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
			cmdSetRole.ExecuteNonQuery();

			OracleCommand cmdRunPayProcedure = connect.CreateCommand();
			cmdRunPayProcedure.CommandText = "BEGIN dpt_social.pay_bankfile(:header_id,:typeid); end;";
            cmdRunPayProcedure.Parameters.Add("header_id",  OracleDbType.Decimal,   header.id,          ParameterDirection.Input);
			cmdRunPayProcedure.Parameters.Add("typeid",		OracleDbType.Decimal,	this.type_id,		ParameterDirection.Input);
			cmdRunPayProcedure.ExecuteNonQuery();

			DBLogger.Debug("Успешно прошла оплата проводок по банковскому файлу " 
				+ header.filename + " за " + header.dtCreated.ToShortDateString()
				,"deposit");
		}
		finally
		{
			if ( connect.State != ConnectionState.Closed )
			{connect.Close();connect.Dispose();}
		}		
	}
    
    private void TrimNls()
    {
        for (int i = 0; i < info.Length; i++)
        {
            info[i].NLS = info[i].NLS.Trim();

            String tmp = info[i].NLS.TrimStart('0');

            if (tmp[0] == 'T')
                info[i].NLS = "000" + tmp;
            else if (tmp.Length > 1 && tmp[1] == 'T')
                info[i].NLS = "00" + tmp;
            else if (tmp.Length > 2 && tmp[2] == 'T')
                info[i].NLS = "0" + tmp;
            else
                info[i].NLS = tmp;
        }
    }
	/// <summary>
	/// 
	/// </summary>
	/// <returns></returns>
	public bool HasInvalidNLS()
	{
		foreach (FileInfoLine fl in info)
		{
			if (fl.Incorrect != 0 && fl.Excluded != 1)
			{
				return true;
			}
		}
		return false;
	}
	/// <summary>
	/// 
	/// </summary>
	/// <returns></returns>
	public bool IsPaid()
	{
		if (info[0].Ref != Decimal.MinValue)
			return true;
		return false;			
	}
    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    public static String GetUFilename()
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdGetName = connect.CreateCommand();
            cmdGetName.CommandText = "select '.' || lpad(S_SOC_FILENAME.nextval,9,'0') from dual";

            return Convert.ToString(cmdGetName.ExecuteScalar());
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
    /// <param name="header_id"></param>
    public static void UpdateDptHeader(Decimal header_id)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdUpdateHeader = connect.CreateCommand();
            cmdUpdateHeader.CommandText = "update dpt_file_header " +
                "set (info_length,sum) = (select count(info_id),nvl(sum(sum),0) from dpt_file_row where header_id = :header_id) " +
                "where header_id = :header_id";

            cmdUpdateHeader.BindByName = true;
            cmdUpdateHeader.Parameters.Add("header_id", OracleDbType.Decimal, header_id, ParameterDirection.Input);

            cmdUpdateHeader.ExecuteNonQuery();

            OracleCommand cmdFinish = connect.CreateCommand();
            cmdFinish.CommandText = "begin dpt_social.set_agencyid(:header_id); end;";

            cmdFinish.Parameters.Add("header_id", OracleDbType.Decimal, header_id, ParameterDirection.Input);
            cmdFinish.ExecuteNonQuery();
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
    /// <param name="nls"></param>
    /// <returns></returns>
    public static bool IsCardAcc(String nls)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdCk = connect.CreateCommand();
            cmdCk.CommandText = @"select nvl(dpt_web.account_is_card (bars_context.extract_mfo(sys_context('bars_context','user_branch'))
                    ,:NLS),0) from dual";
            cmdCk.Parameters.Add("NLS", OracleDbType.Varchar2, nls, ParameterDirection.Input);

            String res = Convert.ToString(cmdCk.ExecuteScalar());
            
            return (res != "0");
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
    /// <param name="header_id"></param>
    public static void CopyAdjustDptFileHeader(Decimal header_id)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdUpdateHeader = connect.CreateCommand();
            cmdUpdateHeader.CommandText = "update dpt_file_header " +
                "set info_length = null, sum = null " +
                "where header_id = :header_id";

            cmdUpdateHeader.BindByName = true;
            cmdUpdateHeader.Parameters.Add("header_id", OracleDbType.Decimal, header_id, ParameterDirection.Input);

            cmdUpdateHeader.ExecuteNonQuery();
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
}
/// <summary>
/// Заголовок банківського файлу
/// </summary>
public class FileHeader
{
    public Decimal      id;                 // not in file
	public String		filename;			// 12
	public Decimal		headerLength;		// 3
	public DateTime		dtCreated;			// 8
	public Decimal		numInfo;			// 6
	public String		MFO_A;				// 9
	public String		NLS_A;				// 9
	public String		MFO_B;				// 9
	public String		NLS_B;				// 9
	public Decimal		DK;					// 1
	public Decimal		Sum;				// 19
	public Decimal		Typ;				// 2
	public String		Number;				// 10
	public String		AddExists;			// 1
	public String		NMK_A;				// 27
	public String		NMK_B;				// 27
	public String		Nazn;				// 160
	public Decimal		Branch_code;		// 4
	public Decimal		Dpt_code;			// 3
	public String		Exec_ord;			// 10
	public String		KS_EP;				// 32
	/// <summary>
	/// Конструктор
	/// </summary>
	/// <param name="str">Строка ініціалізації</param>
	public FileHeader(String str)	
	{
		CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
		cinfo.DateTimeFormat.ShortDatePattern = "dd\\MM\\yy";
		cinfo.DateTimeFormat.DateSeparator = "\\";

		filename		= str.Substring(0,12);
		headerLength	= Convert.ToDecimal(str.Substring(12,3));
		dtCreated		= Convert.ToDateTime(str.Substring(15,8),cinfo);
		numInfo			= Convert.ToDecimal(str.Substring(23,6));
		MFO_A			= str.Substring(29,9);
		NLS_A			= str.Substring(38,9);
		MFO_B			= str.Substring(47,9);
        NLS_B			= str.Substring(56,9);
		
		String sdk = str.Substring(65,1);
		if (sdk == " ")
			DK = 1;
		else
            DK				= Convert.ToDecimal(str.Substring(65,1));

		Sum				= Convert.ToDecimal(str.Substring(66,19));
		Typ				= Convert.ToDecimal(str.Substring(85,2));
		Number			= str.Substring(87,10);
		AddExists		= str.Substring(97,1);
		NMK_A			= str.Substring(98,27);
		NMK_B			= str.Substring(125,27);
		Nazn			= str.Substring(152,160);
		Branch_code		= Convert.ToDecimal(str.Substring(312,4));
		Dpt_code		= Convert.ToDecimal(str.Substring(316,3));
		Exec_ord		= str.Substring(319,10);
		KS_EP			= str.Substring(329,32);
	}
	/// <summary>
	/// Конструктор без параметрів
	/// </summary>
	public FileHeader()
	{
        id              = Decimal.MinValue;
		filename		= String.Empty;			
		headerLength	= Decimal.MinValue;		
		dtCreated		= DateTime.MinValue;			
		numInfo			= Decimal.MinValue;					
		MFO_A			= String.Empty;				
		NLS_A			= String.Empty;				
		MFO_B			= String.Empty;					
		NLS_B			= String.Empty;					
		DK				= Decimal.MinValue;							
		Sum				= Decimal.MinValue;						
		Typ				= Decimal.MinValue;						
		Number			= String.Empty;					
		AddExists		= String.Empty;				
		NMK_A			= String.Empty;					
		NMK_B			= String.Empty;					
		Nazn			= String.Empty;					
		Branch_code		= Decimal.MinValue;				
		Dpt_code		= Decimal.MinValue;					
		Exec_ord		= String.Empty;				
		KS_EP			= String.Empty;
	}
}
/// <summary>
/// Інформаційний рядок
/// банківського файлу
/// </summary>
public class FileInfoLine
{
	public Decimal		ID;					// Sequence.nextval
	public String		NLS;				// 19
	public Decimal		Branch_code;		// 4
	public Decimal		Dpt_code;			// 3
	public Decimal		Sum;				// 19
	public String		FIO;				// 100
	public String		Pasp;				// 16
    public String       Branch;             // branch
	public Decimal		Ref;				// Reference
	public Decimal		Incorrect;			// 1 - wrong; 0 - correct;
	public Decimal		Closed;				// 1 - isClosed; 0 - correct;
	public Decimal		Excluded;			// 1 - excluded; 0 - correct;
	/// <summary>
	/// Конструктор
	/// </summary>
	/// <param name="str">Строка ініціалізації</param>
	public FileInfoLine(String str)
	{
		ID				= Decimal.MinValue;	
		NLS				= str.Substring(0,19);
		Branch_code		= Convert.ToDecimal(str.Substring(19,4));
		Dpt_code		= Convert.ToDecimal(str.Substring(23,3));
		Sum				= Convert.ToDecimal(str.Substring(26,19));
		FIO				= str.Substring(45,100);
		Pasp			= str.Substring(145,16);
        Branch          = String.Empty;
		Ref				= Decimal.MinValue;
		Incorrect		= 0;
		Closed			= 0;
		Excluded		= 0;
	}
	/// <summary>
	/// Конструктор без параметрів
	/// </summary>
	public FileInfoLine()
	{
		ID				= Decimal.MinValue;					
		NLS				= String.Empty;				
		Branch_code		= Decimal.MinValue;		
		Dpt_code		= Decimal.MinValue;			
		Sum				= Decimal.MinValue;				
		FIO				= String.Empty;				
		Pasp			= String.Empty;
        Branch          = String.Empty;	
		Ref				= Decimal.MinValue;				
		Incorrect		= Decimal.MinValue;			
		Closed			= Decimal.MinValue;				
		Excluded		= Decimal.MinValue;
	}
}

