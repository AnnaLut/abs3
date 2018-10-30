using System;
using System.Web;
using System.Collections;
using System.Globalization;
using Oracle.DataAccess.Client;
using System.Data;
using Bars.Oracle;
using Bars.Exception;
using Bars.Classes;
using BarsWeb.Core.Logger;

/// <summary>
/// Клас роботи з
/// банківським файлом
/// зарахування пенсій та 
/// матерійальної допомоги
/// версія файла 2
/// </summary>
public class BankFileExt
{
	public FileHeaderExt		header;
	public FileInfoLineExt[]	info;
	/// Тип зарахування
	public Decimal			type_id;
    /// 
    public Decimal AGENCY_TYPE;

    public String Acc_Type;

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
    private String[] get_id_code()
    {
        String[] result = new String[info.Length];

        for (int i = 0; i<info.Length; i++)
            result[i] = info[i].Id_Code;

        return result;
    }
    private int[] get_id_code_size()
    {
        int[] result = new int[info.Length];

        for (int i = 0; i<info.Length; i++)
            result[i] = info[i].Id_Code.Length;

        return result;
    }
    private String[] get_file_payoff()
    {
        String[] result = new String[info.Length];

        for (int i = 0; i < info.Length; i++)
            result[i] = info[i].File_Payoff_date;

        return result;
    }
    private int[] get_file_payoff_size()
    {
        int[] result = new int[info.Length];

        for (int i = 0; i < info.Length; i++)
            result[i] = info[i].File_Payoff_date.Length;

        return result;
    }
    private DateTime?[] get_payoff_date()
    {
        DateTime?[] result = new DateTime?[info.Length];

        for (int i = 0; i < info.Length; i++)
            result[i] = info[i].Payoff_date;

        return result;
    }
    private String[] get_acc_type()
    {
        String[] result = new String[info.Length];

        for (int i = 0; i < info.Length; i++)
            result[i] = this.Acc_Type;

        return result;
    }    
    private readonly IDbLogger _dbLogger; 
    
    /// <summary>
	/// Конструктор
	/// </summary>
	/// <param name="arr">Масив рядків файлу</param>
	public BankFileExt(ArrayList arr, int month, int year)
    {
        _dbLogger = DbLoggerConstruct.NewDbLogger();
		header = new FileHeaderExt((String)arr[0]);
		info = new FileInfoLineExt[Int32.Parse(header.numInfo.ToString())];

		if (header.numInfo > arr.Count - 1)
			throw new DepositException("Недостатньо рядків у прийнятому банківському файлі!");
		if (header.numInfo < arr.Count - 1)
            throw new DepositException("Надлишкові рядки у прийнятому банківському файлі!");

		for (int i = 0; i< header.numInfo; i++)
		{
			info[i] = new FileInfoLineExt( i + 1, (String)arr[i + 1], month, year);
		}
	}
	/// <summary>
	/// Конструктор
	/// </summary>
	/// <param name="filename">Імя файлу</param>
	/// <param name="dat">Дата</param>
	public BankFileExt(String filename,DateTime dat,Decimal header_id)
	{
        _dbLogger = DbLoggerConstruct.NewDbLogger();
		header = new FileHeaderExt();

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
        WriteToDatabaseExt(true);
    }
    /// <summary>
    /// Запис в базу
    /// </summary>
    public void WriteToDatabaseExt(bool setupAgencies)
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
                "  :dest,:branch_num,:dpt_code,:exec_ord,:ks_ep,:type_id,:agency_type,:header_id,'2'); " +
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
            cmdInsertInfo.CommandText = " begin dpt_social.create_file_row_ext_group( " +
                " :header_id, :filename,:dat,:nls,:branch_code,:dpt_code,:sum,:fio,:id_code, " +
                " :file_payoff, :payoff_date, :acc_type, :info_id); end;";

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

            OracleParameter id_code = cmdInsertInfo.Parameters.Add("id_code", OracleDbType.Varchar2);
            id_code.Direction = ParameterDirection.Input;
            id_code.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
            id_code.Value = get_id_code();
            id_code.Size = info.Length;
            id_code.ArrayBindSize = get_id_code_size();

            OracleParameter file_payoff = cmdInsertInfo.Parameters.Add("file_payoff", OracleDbType.Varchar2);
            file_payoff.Direction = ParameterDirection.Input;
            file_payoff.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
            file_payoff.Value = get_file_payoff();
            file_payoff.Size = info.Length;
            file_payoff.ArrayBindSize = get_file_payoff_size();

            OracleParameter payoff_date = cmdInsertInfo.Parameters.Add("payoff_date", OracleDbType.Date);
            payoff_date.Direction = ParameterDirection.Input;
            payoff_date.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
            payoff_date.Value = get_payoff_date();
            payoff_date.Size = info.Length;

            OracleParameter acc_type = cmdInsertInfo.Parameters.Add("acc_type", OracleDbType.Char);
            acc_type.Direction = ParameterDirection.Input;
            acc_type.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
            acc_type.Value = get_acc_type();
            acc_type.Size = info.Length;

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

            string isUniqueFileMessage = String.Empty;
            using (OracleCommand cmd = connect.CreateCommand())
            {
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = @"select dpt_social.CHK_PYMT_FILE(:p_hdr_id) from dual";
                cmd.Parameters.Add("p_hdr_id", OracleDbType.Decimal, header.id, ParameterDirection.Input);
                using (OracleDataReader rdr = cmd.ExecuteReader())
                    if (rdr.Read())
                        isUniqueFileMessage = String.IsNullOrEmpty(rdr.GetValue(0).ToString()) ? String.Empty : rdr.GetString(0);

            }

            if (isUniqueFileMessage == String.Empty)
            {

                if (setupAgencies)
                {
                    OracleCommand cmdFinish = connect.CreateCommand();
                    cmdFinish.CommandText = "begin dpt_social.set_agencyid(:header_id); end;";

                    cmdFinish.Parameters.Add("header_id", OracleDbType.Decimal, header.id, ParameterDirection.Input);
                    cmdFinish.ExecuteNonQuery();
                }

                _dbLogger.Debug("Пользователь успешно принял банковский файл "
                    + header.filename + " за " + header.dtCreated.ToShortDateString()
                    , "deposit");

                tx.Commit();
                txCommitted = true;
            }
            else
            {
                _dbLogger.Debug("Користувач спробував завантажити не унікальний файл "
                      + header.filename + " за " + header.dtCreated.ToShortDateString()
                      , "deposit");
                throw new SocialDepositException(isUniqueFileMessage);
            }
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
                "WHERE header_id=:header_id and file_version = '2'";
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

			info = new FileInfoLineExt[Int32.Parse(header.numInfo.ToString())];			

			OracleCommand cmdGetFileRow = connect.CreateCommand();
			cmdGetFileRow.CommandText = @"SELECT info_id, nls, branch_code, dpt_code, SUM, fio,
                id_code, payoff_date, REF,
                incorrect, closed, excluded, branch, marked4payment
                FROM DPT_FILE_ROW 
                WHERE header_id=:header_id order by info_id";

            cmdGetFileRow.Parameters.Add("header_id", OracleDbType.Decimal, header.id, ParameterDirection.Input);

			OracleDataReader iReader = cmdGetFileRow.ExecuteReader();
			int i = 0;

			while (iReader.Read())
			{
				info[i] = new FileInfoLineExt();

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
					info[i].Id_Code = Convert.ToString(iReader.GetOracleString(6).Value);
                if (!iReader.IsDBNull(7))
                    info[i].Payoff_date = iReader.GetOracleDate(7).Value;
				if (!iReader.IsDBNull(8))
					info[i].Ref = Convert.ToDecimal(iReader.GetOracleDecimal(8).Value);
				if (!iReader.IsDBNull(9))
					info[i].Incorrect = Convert.ToDecimal(iReader.GetOracleDecimal(9).Value);
				if (!iReader.IsDBNull(10))
					info[i].Closed = Convert.ToDecimal(iReader.GetOracleDecimal(10).Value);
				if (!iReader.IsDBNull(11))
					info[i].Excluded = Convert.ToDecimal(iReader.GetOracleDecimal(11).Value);
                if (!iReader.IsDBNull(12))
                    info[i].Branch = Convert.ToString(iReader.GetOracleString(12).Value);
                if (!iReader.IsDBNull(13))
                    info[i].Marked4payment = iReader.GetOracleDecimal(13).Value;

				i++;
			}

            if (!iReader.IsClosed) { iReader.Close(); }
            iReader.Dispose();
		}
		finally
		{
			if ( connect.State != ConnectionState.Closed )
			{connect.Close();connect.Dispose();}
		}
	}
	/// <summary>
    /// !!! Оплата
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
			cmdRunPayProcedure.CommandText = "BEGIN dpt_social.pay_bankfile_ext(:header_id,:typeid); end;";
            cmdRunPayProcedure.Parameters.Add("header_id",  OracleDbType.Decimal,   header.id,          ParameterDirection.Input);
			cmdRunPayProcedure.Parameters.Add("typeid",		OracleDbType.Decimal,	this.type_id,		ParameterDirection.Input);
			cmdRunPayProcedure.ExecuteNonQuery();

			_dbLogger.Debug("Успешно прошла оплата проводок по банковскому файлу " 
				+ header.filename + " за " + header.dtCreated.ToShortDateString()
				,"deposit");
		}
		finally
		{
			if ( connect.State != ConnectionState.Closed )
			{connect.Close();connect.Dispose();}
		}		
	}

    /// <summary>
    /// !!! Оплата
    /// </summary>
    public void PayGb(Decimal agency_id)
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
            cmdRunPayProcedure.CommandText = "BEGIN dpt_social.pay_bankfile_ext_center(:header_id,:typeid,:agency_id); end;";
            cmdRunPayProcedure.Parameters.Add("header_id", OracleDbType.Decimal, header.id, ParameterDirection.Input);
            cmdRunPayProcedure.Parameters.Add("typeid", OracleDbType.Decimal, this.type_id, ParameterDirection.Input);
            cmdRunPayProcedure.Parameters.Add("agency_id", OracleDbType.Decimal, agency_id, ParameterDirection.Input);            
            cmdRunPayProcedure.ExecuteNonQuery();

            _dbLogger.Debug("Успешно прошла оплата проводок по банковскому файлу "
                + header.filename + " за " + header.dtCreated.ToShortDateString()
                , "deposit");
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
    private void TrimNls()
    {
		for (int i = 0; i < info.Length; i++)
		{
			info[i].NLS = info[i].NLS.Trim();

			String tmp = info[i].NLS.TrimStart('0');

			if (tmp == String.Empty)
				continue;

			if (tmp.Length == 9)
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
		foreach (FileInfoLineExt fl in info)
		{
			if (fl.Incorrect != 0 && fl.Excluded != 1 && fl.Marked4payment == 1)
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
		bool paid = true;

        for (int i = 0; i < info.Length; i++)
        {
            if (info[i].Ref == Decimal.MinValue && 
                info[i].Excluded != 1 &&
                info[i].Closed != 1)
            {
                paid = false;
                break;
            }
        }

		return paid;
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
            cmdGetName.CommandText = "select '.' || lpad(S_SOC_FILENAME.nextval,15,'0') from dual";

            return Convert.ToString(cmdGetName.ExecuteScalar());
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }		        
    }
    /// <summary>
    /// !!! 
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
    /// !!! 
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
public class FileHeaderExt
{
    public Decimal      id;                 // not in file
	public String		filename;			// 16
    public String       mainFilialNumber;   //      5
    public String       subFilialNumber;    //      5
    public String       filePayoffDate;     //      2
    public String       separator;          //      1
    public String       regionCode;         //      3
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
	public Decimal		Branch_code;		// 5
	public Decimal		Dpt_code;			// 3
	public String		Exec_ord;			// 10
	public String		KS_EP;				// 32
	/// <summary>
	/// Конструктор
	/// </summary>
	/// <param name="str">Строка ініціалізації</param>
	public FileHeaderExt(String str)	
	{
		CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
		cinfo.DateTimeFormat.ShortDatePattern = "dd\\MM\\yy";
		cinfo.DateTimeFormat.DateSeparator = "\\";

        CultureInfo cinfo_alt = CultureInfo.CreateSpecificCulture("en-GB");
        cinfo_alt.DateTimeFormat.ShortDatePattern = "ddMMyyyy";

        try
        {
            filename = str.Substring(0, 16);
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору заголовка: імя файлу (символи 1-16)");
        }
        try
        {
            mainFilialNumber = str.Substring(0,5);
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору заголовка: код філії (символи 1-5)");
        }
        try
        {
            subFilialNumber = str.Substring(5,5);
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору заголовка: код відділення (символи 6-10)");
        }
        try
        {
            filePayoffDate = str.Substring(10, 2);
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору заголовка: дата виплати (символи 11-12)");
        }
        try
        {
            separator = str.Substring(12, 1);
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору заголовка: роздільник (символ 13)");
        }
        try
        {
            regionCode = str.Substring(13, 3);
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору заголовка: код регіону (символи 14-16)");
        }
        try
        {
            headerLength = Convert.ToDecimal(str.Substring(16, 3));
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору заголовка: довжина заголовку (символи 17-19)");
        }
        try
        {
            dtCreated = Convert.ToDateTime(str.Substring(19, 8), cinfo);
        }
        catch (Exception)
        {
            try
            {
                dtCreated = new DateTime(Convert.ToInt32(str.Substring(23, 4)),
                    Convert.ToInt32(str.Substring(21, 2)),
                    Convert.ToInt32(str.Substring(19, 2)));

            }
            catch (Exception ex)
            {
                throw new SocialDepositException("Помилка розбору заголовка: дата створення (символи 20-27)");
            }
        }
        try
        {
            numInfo = Convert.ToDecimal(str.Substring(27, 6));
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору заголовка: кількість рядків (символи 28-33)");
        }
        try
        {
            MFO_A = str.Substring(33, 9);
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору заголовка: мфо платника (символи 34-42)");
        }
        try
        {
            NLS_A = str.Substring(42, 9);
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору заголовка: рахунок платника (символи 43-51)");
        }
        try
        {
            MFO_B = str.Substring(51, 9);
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору заголовка: мфо одержувача (символи 52-60)");
        }
        try
        {
            NLS_B = str.Substring(60, 9);
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору заголовка: рахунок одержувача (символи 61-69)");
        }
        try
        {		
		    String sdk = str.Substring(69,1);
		    if (sdk == " ")
			    DK = 1;
		    else
                DK = Convert.ToDecimal(str.Substring(69, 1));
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору заголовка: дебет-кредит (символ 70)");
        }
        try
        {
            Sum = Convert.ToDecimal(str.Substring(70, 19));
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору заголовка: сума файла (символи 71-89)");
        }
        try
        {
            Typ = Convert.ToDecimal(str.Substring(89, 2));
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору заголовка: тип (символи 90-91)");
        }
        try
        {
            Number = str.Substring(91, 10);
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору заголовка: номер (символи 92-101)");
        }
        try
        {
            AddExists = str.Substring(101, 1);
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору заголовка: (символ 102)");
        }
        try
        {
            NMK_A = str.Substring(102, 27);
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору заголовка: найменування платника (символи 103-129)");
        }
        try
        {
            NMK_B = str.Substring(129, 27);
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору заголовка: найменування одержувача (символи 130-156)");
        }
        try
        {
            Nazn = str.Substring(156, 160);
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору заголовка: призначення (символи 157-316)");
        }
        try
        {
            Branch_code = Convert.ToDecimal(str.Substring(316, 5));
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору заголовка: код відділення (символи 317-321)");
        }
        try
        {
            if (String.IsNullOrEmpty(str.Substring(321, 3).Trim()))
                Dpt_code = 0;
            else
                Dpt_code = Convert.ToDecimal(str.Substring(321, 3));
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору заголовка: код депозита (символи 322-324)");
        }
        try
        {
            Exec_ord = str.Substring(324, 10);
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору заголовка: порядок виконання (символи 325-334)");
        }
        try
        {
            KS_EP = str.Substring(334, 32);
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору заголовка: (символи 335-366)");
        }
	}
	/// <summary>
	/// Конструктор без параметрів
	/// </summary>
	public FileHeaderExt()
	{
        id                  = Decimal.MinValue;
		filename		    = String.Empty;
        mainFilialNumber    = String.Empty;
        subFilialNumber     = String.Empty;
        filePayoffDate      = String.Empty;
        separator           = String.Empty;
        regionCode          = String.Empty;
		headerLength	    = Decimal.MinValue;		
		dtCreated		    = DateTime.MinValue;			
		numInfo			    = Decimal.MinValue;					
		MFO_A			    = String.Empty;				
		NLS_A			    = String.Empty;				
		MFO_B			    = String.Empty;					
		NLS_B			    = String.Empty;					
		DK				    = Decimal.MinValue;							
		Sum				    = Decimal.MinValue;						
		Typ				    = Decimal.MinValue;						
		Number			    = String.Empty;					
		AddExists		    = String.Empty;				
		NMK_A			    = String.Empty;					
		NMK_B			    = String.Empty;					
		Nazn			    = String.Empty;					
		Branch_code		    = Decimal.MinValue;				
		Dpt_code		    = Decimal.MinValue;					
		Exec_ord		    = String.Empty;				
		KS_EP			    = String.Empty;
	}
}
/// <summary>
/// Інформаційний рядок
/// банківського файлу
/// </summary>
public class FileInfoLineExt
{
	public Decimal		ID;					// Sequence.nextval
	public String		NLS;				// 19
	public Decimal		Branch_code;		// 5
	public Decimal		Dpt_code;			// 3
	public Decimal		Sum;				// 19
	public String		FIO;				// 100
	public String		Id_Code;			// 10
    public String       File_Payoff_date;   // 2
    public DateTime?    Payoff_date;        // not in file
    public String       Branch;             // branch
	public Decimal		Ref;				// Reference
	public Decimal		Incorrect;			// 1 - wrong; 0 - correct;
	public Decimal		Closed;				// 1 - isClosed; 0 - correct;
	public Decimal		Excluded;			// 1 - excluded; 0 - correct;
    public Decimal      Marked4payment;     // 1 - yes; 0 - no;
	/// <summary>
	/// Конструктор
	/// </summary>
	/// <param name="str">Строка ініціалізації</param>
	public FileInfoLineExt(int str_num, String str, int month, int year)
	{
		ID = Decimal.MinValue;	
        
        try
        {
		    NLS = str.Substring(0,19);
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору стрічки №" + Convert.ToString(str_num) + ": рахунок (символи 1-19)");
        }
        try
        {
            Branch_code = Convert.ToDecimal(str.Substring(19, 5));
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору стрічки №" + Convert.ToString(str_num) + ": код відділення (символи 20-24)");
        }
        try
        {
            Dpt_code = Convert.ToDecimal(str.Substring(24, 3));
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору стрічки №" + Convert.ToString(str_num) + ": код депозиту (символи 25-27)");
        }
        try
        {
            Sum = Convert.ToDecimal(str.Substring(27, 19));
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору стрічки №" + Convert.ToString(str_num) + ": сума(символи 28-46)");
        }
        try
        {
            FIO = str.Substring(46, 100);
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору стрічки №" + Convert.ToString(str_num) + ": піб (символи 47-146)");
        }
        try
        {
            Id_Code = str.Substring(146, 10);
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору стрічки №" + Convert.ToString(str_num) + ": ід. код. (символи 147-156)");
        }
        try
        {
            File_Payoff_date = str.Substring(156, 2);
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору стрічки №" + Convert.ToString(str_num) + ": дата виплати (символи 157-158)");
        }
        try
        {
            Payoff_date = new DateTime(year, month, 1);
        }
        catch (Exception ex)
        {
            throw new SocialDepositException("Помилка розбору стрічки №" + Convert.ToString(str_num) + ": помилка формування дати проплати");
        }
        
        Branch              = String.Empty;
		Ref				    = Decimal.MinValue;
		Incorrect		    = 0;
		Closed			    = 0;
		Excluded		    = 0;
	}
	/// <summary>
	/// Конструктор без параметрів
	/// </summary>
	public FileInfoLineExt()
	{
		ID				    = Decimal.MinValue;					
		NLS				    = String.Empty;				
		Branch_code		    = Decimal.MinValue;		
		Dpt_code		    = Decimal.MinValue;			
		Sum				    = Decimal.MinValue;				
		FIO				    = String.Empty;
        Id_Code             = String.Empty;
        File_Payoff_date    = String.Empty;
        Payoff_date         = null;
        Branch              = String.Empty;	
		Ref				    = Decimal.MinValue;				
		Incorrect		    = Decimal.MinValue;			
		Closed			    = Decimal.MinValue;				
		Excluded		    = Decimal.MinValue;
	}
}

