using System;
using System.Data;
using System.Web;
using Bars.Oracle;
using Bars.Logger;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Collections;

/// <summary>
/// Класс для работы с клиентом
/// </summary>
public class Client : System.Object
{
    /// <summary>
    /// Идентификатор (РНК)
    /// </summary>
    public decimal ID;
    /// Полное наименование клиента
    public string Name;
    /// Повне імя в родовому відмінку
    public string NameGenitive;
    /// Имя
    public string FirstName;
    /// <summary>
    /// Прізвище клієнта
    /// </summary>
    public string LastName;
    /// <summary>
    /// По батькові
    /// </summary>
    public string Patronymic;
    /// Тип идентификационного кода
    public decimal CodeType;
    /// Типа идентификационного кода
    public string textCodeType;
    /// Идинтификационный код
    public string Code;
    /// Код Країни
    public decimal CountryCode;
    /// <summary>
    /// Назва країни
    /// </summary>
    public string Country;
    /// <summary>
    /// Резидент
    /// </summary>
    public bool isResident;
    /// <summary>
    /// Повна адреса
    /// </summary>
    public string Address;
    /// <summary>
    /// Код території
    /// </summary>
    public decimal Territory;
    
    ///////////////////////
    /// Юридична адреса ///
    ///////////////////////
    /// <summary>
    /// Юридична адреса: індекс
    /// </summary>
    public string Index;
    /// <summary>
    /// Область
    /// </summary>
    public string Region;
    /// <summary>
    /// Район 
    /// </summary>
    public string District;
    /// <summary>
    /// Юридична адреса: населений пункт
    /// </summary>
    public string Settlement;
    /// <summary>
    /// Юридична адреса: вулиця, будинок, квартира
    /// </summary>
    public string Location;
    
    ///////////////////////
    /// Фактична адреса ///
    ///////////////////////
    /// <summary>
    /// Фактична адреса: індекс
    /// </summary>
    public string fact_index;
    /// <summary>
    /// Фактична адреса: область
    /// </summary>
    public string fact_region;
    /// <summary>
    /// Фактична адреса: район
    /// </summary>
    public string fact_district;
    /// <summary>
    /// Фактична адреса: населений пункт
    /// </summary>
    public string fact_settlement;
    /// <summary>
    /// Фактична адреса: вулиця, будинок, квартира
    /// </summary>
    public string fact_location;
    ///
    /// Тип документу (код)
    public decimal DocType;
    /// Тип документу (назва)
    public string DocTypeName;
    /// Серия документу
    public string DocSerial;
    /// Номер документу
    public string DocNumber;
    /// Дата видачі документу
    public DateTime DocDate;
    /// <summary>
    /// Ким виданий документ
    /// </summary>
    public string DocOrg;
    /// <summary>
    /// Дата вклеювання фото у паспорт
    /// </summary>
    public DateTime PhotoDate;
    /// <summary>
    /// Дата народження
    /// </summary>
    public DateTime BirthDate;
    /// Место рождения
    public string BirthPlace;
    /// <summary>
    /// Стать (код)
    /// </summary>
    public decimal Sex;
    /// <summary>
    /// Стать (назва)
    /// </summary>
    public string textSex;
    /// Домашний телефон
    public string HomePhone;
    /// <summary>
    /// Робочий телефон
    /// </summary>
    public string WorkPhone;
    /// <summary>
    /// Мобільний телефон
    /// </summary>
    public string CellPhone;
    /// <summary>
    /// Чи є клієнт інсайдером
    /// </summary>
    public bool isInsider;
    /// <summary>
    /// Чи є самозайнятою особою
    /// </summary>
    public bool isSelfEmployer;
    /// <summary>
    /// Код ДПА (код області)
    /// </summary>
    public decimal TaxAgencyCode;
    /// <summary>
    /// Код органу реєстрації самозайнятоЇ особИ
    /// </summary>
    public decimal RegAgencyCode;
    /// <summary>
    /// Код «Особливої відмітки» (для "нестандартних" клієнтів)
    /// </summary>
    public decimal? SpecialMarks;

    /// <summary>
    /// Конструктор
    /// </summary>
    public Client()
    {
        Clear();
    }
    
    /// <summary>
    /// Конструктор
    /// </summary>
    /// <param name="rnk">РНК</param>
    public Client(Decimal rnk)
    {
        ID = rnk;
        ReadFromDatabase();
    }
    
    /// <summary>
    /// Очистка параметров клиента
    /// </summary>
    public void Clear()
    {
        ID = decimal.MinValue;
        Name = string.Empty;
        NameGenitive = string.Empty;
        FirstName = string.Empty;
        LastName = string.Empty;
        Patronymic = string.Empty;
        CodeType = decimal.MinValue;
        textCodeType = string.Empty;
        Code = string.Empty;
        CountryCode = decimal.MinValue;
        isResident = true;
        Address = string.Empty;
        Country = string.Empty;
        Index = string.Empty;
        Region = String.Empty; //Resources.Deposit.GlobalResources.client_region;
        District = String.Empty; //Resources.Deposit.GlobalResources.client_district;
        Settlement = String.Empty; //Resources.Deposit.GlobalResources.client_city;
        Location = String.Empty; //Resources.Deposit.GlobalResources.client_address;
        fact_index = Index; ;
        fact_region = Region;
        fact_district = District;
        fact_settlement = Settlement;
        fact_location = Location;
        DocType = decimal.MinValue;
        DocTypeName = string.Empty;
        DocSerial = string.Empty;
        DocNumber = string.Empty;
        DocDate = DateTime.MinValue;
        DocOrg = string.Empty;
        PhotoDate = DateTime.MinValue;
        BirthDate = DateTime.MinValue;
        BirthPlace = string.Empty;
        Sex = decimal.MinValue;
        textSex = string.Empty;
        WorkPhone = string.Empty;
        HomePhone = string.Empty;
        CellPhone = string.Empty;
        isInsider = false;
        isSelfEmployer = false;
        TaxAgencyCode = -1;
        RegAgencyCode = -1;
        Territory = decimal.MinValue;
        SpecialMarks = null;
    }

    /// <summary>
    /// Порівняння реквізитів клієнта
    /// </summary>
    /// <param name="obj">Інший клієнт</param>
    /// <returns></returns>
    public override bool Equals(object obj)
    {
        return (
            this.ID == ((Client)obj).ID &&
            this.Name == ((Client)obj).Name &&
            this.NameGenitive == ((Client)obj).NameGenitive &&
            this.FirstName == ((Client)obj).FirstName &&
            this.LastName == ((Client)obj).LastName &&
            this.Patronymic == ((Client)obj).Patronymic &&
            this.CodeType == ((Client)obj).CodeType &&
            this.Code == ((Client)obj).Code &&
            this.CountryCode == ((Client)obj).CountryCode &&
            this.Country == ((Client)obj).Country &&
            this.fact_index == ((Client)obj).fact_index &&
            this.fact_region == ((Client)obj).fact_region &&
            this.fact_district == ((Client)obj).fact_district &&
            this.fact_settlement == ((Client)obj).fact_settlement &&
            this.fact_location == ((Client)obj).fact_location &&
            this.isResident == ((Client)obj).isResident &&
            this.isSelfEmployer == ((Client)obj).isSelfEmployer &&
            this.TaxAgencyCode == ((Client)obj).TaxAgencyCode &&
            this.RegAgencyCode == ((Client)obj).RegAgencyCode &&
            this.Index == ((Client)obj).Index &&
            this.Region == ((Client)obj).Region &&
            this.District == ((Client)obj).District &&
            this.Settlement == ((Client)obj).Settlement &&
            this.Location == ((Client)obj).Location &&
            this.DocType == ((Client)obj).DocType &&
            this.DocSerial == ((Client)obj).DocSerial &&
            this.DocNumber == ((Client)obj).DocNumber &&
            this.DocDate == ((Client)obj).DocDate &&
            this.DocOrg == ((Client)obj).DocOrg &&
            this.PhotoDate == ((Client)obj).PhotoDate &&
            this.BirthDate == ((Client)obj).BirthDate &&
            this.BirthPlace == ((Client)obj).BirthPlace &&
            this.Sex == ((Client)obj).Sex &&
            this.WorkPhone == ((Client)obj).WorkPhone &&
            this.HomePhone == ((Client)obj).HomePhone &&
            this.CellPhone == ((Client)obj).CellPhone &&
            this.Territory == ((Client)obj).Territory &&
            (this.SpecialMarks ?? -1) == (((Client)obj).SpecialMarks ?? -1) );
    }

    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    public override int GetHashCode()
    {
        return base.GetHashCode();
    }

    /// <summary>
    /// Оператор рівності реквізитів
    /// </summary>
    /// <param name="Client1">Клієнт 1</param>
    /// <param name="Client2">Клієнт 2</param>
    /// <returns></returns>
    public static bool operator ==(Client Client1, Client Client2)
    {
        return Client1.Equals(Client2);
    }
    
    /// <summary>
    /// Оператор нерівності реквізитів
    /// </summary>
    /// <param name="Client1">Клієнт 1</param>
    /// <param name="Client2">Клієнт 2</param>
    /// <returns></returns>
    public static bool operator !=(Client Client1, Client Client2)
    {
        return !Client1.Equals(Client2);
    }

    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    public bool short_registered()
    {
        return (
            this.Code == String.Empty ||
            this.Settlement == String.Empty ||
            //this.Location == String.Empty ||
            //this.DocSerial == String.Empty ||
            this.DocNumber == String.Empty ||
            this.DocOrg == String.Empty ||
            this.DocDate == DateTime.MinValue
            );
    }
    
    /// <summary>
    /// Метод получает параметры клиента из базы данных
    /// </summary>
    /// <param name="ctx">Контекст приложения</param>
    public void ReadFromDatabase()
    {
        HttpContext ctx = HttpContext.Current;
        // Сохраняем идентификатор
        decimal ClientID = this.ID;

        OracleConnection connect = new OracleConnection();

        try
        {
            DBLogger.Debug("Пользователь начал читать из базы информацию о клиенте с регистрационным номером rnk=" + this.ID.ToString(),
                "deposit");

            // Создаем соединение
            IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            // Открываем соединение с БД


            // Устанавливаем роль
            OracleCommand cmdSetRole = new OracleCommand();
            cmdSetRole.Connection = connect;
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            // Очищаем параметры клиента
            Clear();

            // Формируем запрос
            OracleCommand cmdReadClientData = new OracleCommand();

            cmdReadClientData.Connection = connect;
            cmdReadClientData.CommandText = "select name, tgr, okpo, country, address, " + //  0 -  4
                " doctype, doctypename, docserial, docnum, docdate, docorg, " +            //  5 - 10
                " bdate, bplace, sex, phoneh, phonew, resident, " +                        // 11 - 16
                " u_idx, u_region, u_district, u_settlement, u_address, territory, " +     // 17 - 22
                " f_idx, f_region, f_district, f_settlement, f_address, " +                // 23 - 27
                " photodate, c_reg, c_dst " +                                              // 28 - 30
                " from V_DPT_CUSTOMER where rnk = :rnk";

            cmdReadClientData.Parameters.Add("rnk", OracleDbType.Decimal, ClientID, ParameterDirection.Input);

            // Читаем результаты запроса
            OracleDataReader rdr = cmdReadClientData.ExecuteReader();

            while (rdr.Read())
            {
                // Идентификатор
                this.ID = ClientID;

                // Наименование или ФИО
                if (!rdr.IsDBNull(0))
                    this.Name = rdr.GetOracleString(0).Value;

                // Тип госреестра (идентификационного кода)
                if (!rdr.IsDBNull(1))
                    this.CodeType = rdr.GetOracleDecimal(1).Value;

                // Идентификационный код
                if (!rdr.IsDBNull(2))
                    this.Code = rdr.GetOracleString(2).Value;

                // Цифровой код страны
                if (!rdr.IsDBNull(3))
                    this.CountryCode = rdr.GetOracleDecimal(3).Value;

                // Адрес
                if (!rdr.IsDBNull(4))
                    this.Address = rdr.GetOracleString(4).Value;

                // Вид документа (цифровой)
                if (!rdr.IsDBNull(5))
                    this.DocType = rdr.GetOracleDecimal(5).Value;

                // Вид документа
                if (!rdr.IsDBNull(6))
                    this.DocTypeName = rdr.GetOracleString(6).Value;

                // Серия
                if (!rdr.IsDBNull(7))
                    this.DocSerial = rdr.GetOracleString(7).Value;

                // Номер
                if (!rdr.IsDBNull(8))
                    this.DocNumber = rdr.GetOracleString(8).Value;

                // Дата документа
                if (!rdr.IsDBNull(9))
                    this.DocDate = rdr.GetOracleDate(9).Value;

                // Кем выдан
                if (!rdr.IsDBNull(10))
                    this.DocOrg = rdr.GetOracleString(10).Value;

                // Дата рождения
                if (!rdr.IsDBNull(11))
                    this.BirthDate = rdr.GetOracleDate(11).Value;

                // Место рождения
                if (!rdr.IsDBNull(12))
                    this.BirthPlace = rdr.GetOracleString(12).Value;

                // Пол
                if (!rdr.IsDBNull(13))
                    this.Sex = Convert.ToDecimal(rdr.GetOracleString(13).Value);

                // Домашний телефон
                if (!rdr.IsDBNull(14))
                    this.HomePhone = rdr.GetOracleString(14).Value;

                // Рабочий телефон
                if (!rdr.IsDBNull(15))
                    this.WorkPhone = rdr.GetOracleString(15).Value;

                // Резидент
                if (!rdr.IsDBNull(16))
                    this.isResident = (rdr.GetOracleDecimal(16).Value == 1 ? true : false);

                // *******************
                // * ЮРИДИЧНА АДРЕСА *
                // *******************
                // поштовий індекс
                if (!rdr.IsDBNull(17))
                    this.Index = rdr.GetOracleString(17).Value;

                // область
                if (!rdr.IsDBNull(18))
                    this.Region = rdr.GetOracleString(18).Value;

                // район
                if (!rdr.IsDBNull(19))
                    this.District = rdr.GetOracleString(19).Value;

                // населений пункт
                if (!rdr.IsDBNull(20))
                    this.Settlement = rdr.GetOracleString(20).Value;

                // вулиця, будинок
                if (!rdr.IsDBNull(21))
                    this.Location = rdr.GetOracleString(21).Value;

                // код території
                if (!rdr.IsDBNull(22))
                    this.Territory = rdr.GetOracleDecimal(22).Value;

                // *******************
                // * ФАКТИЧНА АДРЕСА *
                // *******************
                // поштовий індекс
                if (!rdr.IsDBNull(23))
                    this.fact_index = rdr.GetOracleString(23).Value;

                // область
                if (!rdr.IsDBNull(24))
                    this.fact_region = rdr.GetOracleString(24).Value;

                // район
                if (!rdr.IsDBNull(25))
                    this.fact_district = rdr.GetOracleString(25).Value;

                // населений пункт
                if (!rdr.IsDBNull(26))
                    this.fact_settlement = rdr.GetOracleString(26).Value;

                // вулиця, будинок
                if (!rdr.IsDBNull(27))
                    this.fact_location = rdr.GetOracleString(27).Value;

                // Дата вклеювання фотокартки в паспорт
                if ( !rdr.IsDBNull(28) && this.DocType == 1 )
                    this.PhotoDate = rdr.GetOracleDate(28).Value;

                // c_reg
                if (!rdr.IsDBNull(29))
                    this.TaxAgencyCode = rdr.GetOracleDecimal(29).Value;

                // c_dst
                if (!rdr.IsDBNull(30))
                    this.RegAgencyCode = rdr.GetOracleDecimal(30).Value;
            }

            // Формируем запросы на дополнительные параметры
            cmdReadClientData = new OracleCommand();
            cmdReadClientData.Connection = connect;
            cmdReadClientData.CommandText = @"select value, tag from customerw where rnk = :rnk
                and tag in ('SN_FN','SN_LN','SN_MN','SN_GC','MPNO','SAMZ','SPMRK')";

            cmdReadClientData.Parameters.Add("rnk", OracleDbType.Decimal, ClientID, ParameterDirection.Input);

            if (!rdr.IsClosed) rdr.Close();
            rdr.Dispose();

            // Читаем результаты запроса
            rdr = cmdReadClientData.ExecuteReader();

            string TAG = string.Empty;

            while (rdr.Read())
            {
                if (!rdr.IsDBNull(1))
                    TAG = rdr.GetOracleString(1).Value;

                switch (TAG)
                {
                    case "SN_FN":
                        {
                            if (!rdr.IsDBNull(0))
                                this.FirstName = rdr.GetOracleString(0).Value;
                            break;
                        }

                    case "SN_LN":
                        {
                            if (!rdr.IsDBNull(0))
                                this.LastName = rdr.GetOracleString(0).Value;
                            break;
                        }

                    case "SN_MN":
                        {
                            if (!rdr.IsDBNull(0))
                                this.Patronymic = rdr.GetOracleString(0).Value;
                            break;
                        }

                    case "SN_GC":
                        {
                            if (!rdr.IsDBNull(0))
                                this.NameGenitive = rdr.GetOracleString(0).Value;
                            break;
                        }

                    case "MPNO ":
                        {
                            if (!rdr.IsDBNull(0))
                                this.CellPhone = rdr.GetOracleString(0).Value;
                            break;
                        }

                    case "SAMZ ":  // Ознака самозайнятої особи
                        {
                            if (!rdr.IsDBNull(0))
                                this.isSelfEmployer = (rdr.GetOracleString(0).Value == "1" ? true : false);
                            break;
                        }

                    case "SPMRK":  // "Особлива відмітка" нестандартного клієнта
                        {
                            if (!rdr.IsDBNull(0))
                                this.SpecialMarks = Convert.ToDecimal(rdr.GetOracleString(0).Value);
                            break;
                        }
                    default:
                        {
                            break;
                        }
                }
            }
            if (!rdr.IsClosed) rdr.Close();
            rdr.Dispose();

            //TruncateAddress();

            if (this.FirstName == String.Empty && this.LastName == String.Empty && this.Patronymic == String.Empty)
            {
                OracleCommand cmdGetFio = connect.CreateCommand();

                cmdGetFio.CommandText = "select FIO(:nmk,1) from dual";
                cmdGetFio.Parameters.Add("nmk", OracleDbType.Varchar2, this.Name, ParameterDirection.Input);
                this.LastName = Convert.ToString(cmdGetFio.ExecuteScalar());

                cmdGetFio.CommandText = "select FIO(:nmk,2) from dual";
                this.FirstName = Convert.ToString(cmdGetFio.ExecuteScalar());

                cmdGetFio.CommandText = "select FIO(:nmk,3) from dual";
                this.Patronymic = Convert.ToString(cmdGetFio.ExecuteScalar());

                cmdGetFio.Dispose();
            }

            OracleCommand cmdGetCountryName = new OracleCommand();
            cmdGetCountryName.Connection = connect;
            cmdGetCountryName.CommandText = "select name from country where country=:par";

            cmdGetCountryName.Parameters.Add("par", OracleDbType.Decimal, this.CountryCode, ParameterDirection.Input);

            this.Country = Convert.ToString(cmdGetCountryName.ExecuteScalar());

            DBLogger.Debug("Користувач отримав з БД дані клієнта з РНК=" + this.ID.ToString(), "deposit");
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
    public void TruncateAddress()
    {
        /// Для перереєстрації не потрібно обрізати адреси
        if (this.short_registered()) return;

        /// Додано для коректної вичитки існуючих клієнтів
        if (Region == Resources.Deposit.GlobalResources.client_region) Region = String.Empty;
        if (District == Resources.Deposit.GlobalResources.client_district) District = String.Empty;
        if (Settlement == Resources.Deposit.GlobalResources.client_city) Settlement = String.Empty;
        if (Location == Resources.Deposit.GlobalResources.client_address) Location = String.Empty;
        if (fact_region == Resources.Deposit.GlobalResources.client_region) fact_region = String.Empty;
        if (fact_district == Resources.Deposit.GlobalResources.client_district) fact_district = String.Empty;
        if (fact_settlement == Resources.Deposit.GlobalResources.client_city) fact_settlement = String.Empty;
        if (fact_location == Resources.Deposit.GlobalResources.client_address) fact_location = String.Empty;

        Address = Index + " " + Region + " " + District + " " + Settlement + " " + Location;
        Address = Address.Trim();
    }
    /// <summary>
    /// Процедура создания нового или обновления параметров существующего клиента
    /// </summary>
    /// 
    // ing 21/05/2014
    public decimal CheckBeforeWriteToDatabase()
    {
        HttpContext ctx = HttpContext.Current;
        OracleConnection connect_chk = new OracleConnection();
        try
        {
            DBLogger.Debug("Ищем существующего клиента по ОКПО, серии и номеру паспорта (ОКПО ="
               + this.Code, "deposit");

            // Создаем соединение
            IOraConnection conn_chk = (IOraConnection)ctx.Application["OracleConnectClass"];
            connect_chk = conn_chk.GetUserConnection();

            // Открываем соединение с БД


            // Установка роли
            OracleCommand cmdSetRole_chk = new OracleCommand();
            cmdSetRole_chk.Connection = connect_chk;
            cmdSetRole_chk.CommandText = conn_chk.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole_chk.ExecuteNonQuery();

            OracleCommand cmdSearchCustomer_chk = new OracleCommand();
            cmdSearchCustomer_chk.Connection = connect_chk;

            DBLogger.Info(Convert.ToString(this.ID));
            cmdSearchCustomer_chk.CommandText = "select DPT_WEB.IS_ALREADY_CLIENT(:P_OKPO, :P_NMK, :P_SER, :P_NUMDOC) from dual";
           
            cmdSearchCustomer_chk.Parameters.Add("P_OKPO", OracleDbType.Varchar2, this.Code, ParameterDirection.Input);
            cmdSearchCustomer_chk.Parameters.Add("P_NMK", OracleDbType.Varchar2, null, ParameterDirection.Input);
            cmdSearchCustomer_chk.Parameters.Add("P_SER", OracleDbType.Varchar2, this.DocSerial, ParameterDirection.Input);
            cmdSearchCustomer_chk.Parameters.Add("P_NUMDOC", OracleDbType.Varchar2, this.DocNumber, ParameterDirection.Input);

            this.ID = Convert.ToDecimal(cmdSearchCustomer_chk.ExecuteScalar());

            DBLogger.Debug("Клиент с ОКПО = " + this.Code + " уже существует. Регистрационный номер клиента rnk=" + this.ID.ToString(), "deposit");
            return this.ID;
        }
        finally
        {
            if (connect_chk.State != ConnectionState.Closed)
            { connect_chk.Close(); connect_chk.Dispose(); }
        }
    }
    // !ing 27/05/2014

    public void WriteToDatabase()
    {
        HttpContext ctx = HttpContext.Current;

        OracleConnection connect = new OracleConnection();      
        try
        {
            DBLogger.Debug("!-!Пользователь начал запись в базу информацию о клиенте с ОКПО ="
                + this.Code, "deposit");

            // Создаем соединение
            IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();

            // Открываем соединение с БД


            // Установка роли
            OracleCommand cmdSetRole = new OracleCommand();
            cmdSetRole.Connection = connect;
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            //if (this.ID != Decimal.MinValue && BankType.GetCurrentBank() == BANKTYPE.UPB)
            //{
            //    OracleCommand cmdUpdateCustomer = connect.CreateCommand();
            //    cmdUpdateCustomer.CommandText = "update customer set date_off = null where rnk=:rnk";
            //    cmdUpdateCustomer.Parameters.Add("rnk", OracleDbType.Decimal, this.ID, ParameterDirection.Input);
            //    cmdUpdateCustomer.ExecuteScalar();
            //    cmdUpdateCustomer.Dispose();
            //}

            OracleCommand cmdSearchCustomer = new OracleCommand();
            cmdSearchCustomer.Connection = connect;
            
            cmdSearchCustomer.CommandType = CommandType.StoredProcedure;
            cmdSearchCustomer.CommandText = "dpt_web.p_open_vklad_rnk";
            cmdSearchCustomer.BindByName = true;

            TruncateAddress();
            
            Decimal par_is_resident = (this.isResident == true ? 1 : 0);
            Decimal par_SelfEmployer = (this.isSelfEmployer == true ? 1 : 0);

            cmdSearchCustomer.Parameters.Add("p_clientname", OracleDbType.Varchar2, this.Name.ToUpper(), ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_client_name", OracleDbType.Varchar2, this.FirstName.ToUpper(), ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_client_surname", OracleDbType.Varchar2, this.LastName.ToUpper(), ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_client_patr", OracleDbType.Varchar2, this.Patronymic.ToUpper(), ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_country", OracleDbType.Decimal, this.CountryCode, ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_index", OracleDbType.Varchar2, this.Index, ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_obl", OracleDbType.Varchar2, this.Region.Trim(), ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_district", OracleDbType.Varchar2, this.District.Trim(), ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_settlement", OracleDbType.Varchar2, this.Settlement.Trim(), ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_adress", OracleDbType.Varchar2, this.Location.Trim(), ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_fulladdress", OracleDbType.Varchar2, this.Address.Trim(), ParameterDirection.Input);
            
            if (Territory != decimal.MinValue)
                cmdSearchCustomer.Parameters.Add("p_territory", OracleDbType.Decimal, this.Territory, ParameterDirection.Input);
            else
                cmdSearchCustomer.Parameters.Add("p_territory", OracleDbType.Decimal, null, ParameterDirection.Input);

            cmdSearchCustomer.Parameters.Add("p_clientcodetype", OracleDbType.Decimal, this.CodeType, ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_clientcode", OracleDbType.Varchar2, this.Code, ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_doctype", OracleDbType.Decimal, this.DocType, ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_docserial", OracleDbType.Varchar2, this.DocSerial, ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_docnumber", OracleDbType.Varchar2, this.DocNumber, ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_docorg", OracleDbType.Varchar2, this.DocOrg, ParameterDirection.Input);
            
            if (DocDate != DateTime.MinValue)
                cmdSearchCustomer.Parameters.Add("p_docdate", OracleDbType.Date, this.DocDate, ParameterDirection.Input);
            else
                cmdSearchCustomer.Parameters.Add("p_docdate", OracleDbType.Date, null, ParameterDirection.Input);

            if (PhotoDate != DateTime.MinValue)
                cmdSearchCustomer.Parameters.Add("p_photodate", OracleDbType.Date, this.PhotoDate, ParameterDirection.Input);
            else
                cmdSearchCustomer.Parameters.Add("p_photodate", OracleDbType.Date, null, ParameterDirection.Input);

            if (BirthDate != DateTime.MinValue)
                cmdSearchCustomer.Parameters.Add("p_clientbdate", OracleDbType.Date, this.BirthDate, ParameterDirection.Input);
            else
                cmdSearchCustomer.Parameters.Add("p_clientbdate", OracleDbType.Date, null, ParameterDirection.Input);

            cmdSearchCustomer.Parameters.Add("p_clientbplace", OracleDbType.Varchar2, this.BirthPlace, ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_clientsex", OracleDbType.Decimal, this.Sex, ParameterDirection.Input);
            
            cmdSearchCustomer.Parameters.Add("p_clientcellphone", OracleDbType.Varchar2, this.CellPhone.Trim(), ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_clienthomeph", OracleDbType.Varchar2, this.HomePhone.Trim(), ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_clientworkph", OracleDbType.Varchar2, this.WorkPhone.Trim(), ParameterDirection.Input);

            cmdSearchCustomer.Parameters.Add("p_special_marks", OracleDbType.Decimal, this.SpecialMarks, ParameterDirection.Input);

            cmdSearchCustomer.Parameters.Add("p_clientname_gc", OracleDbType.Varchar2, this.NameGenitive.ToUpper(), ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_resid_code", OracleDbType.Decimal, par_is_resident, ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_resid_index", OracleDbType.Varchar2, this.fact_index, ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_resid_obl", OracleDbType.Varchar2, this.fact_region, ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_resid_district", OracleDbType.Varchar2, this.fact_district, ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_resid_settlement", OracleDbType.Varchar2, this.fact_settlement, ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_resid_adress", OracleDbType.Varchar2, this.fact_location, ParameterDirection.Input);

            cmdSearchCustomer.Parameters.Add("p_selfemployer", OracleDbType.Decimal, par_SelfEmployer, ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_TaxAgencyCode", OracleDbType.Decimal, this.TaxAgencyCode, ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_RegAgencyCode", OracleDbType.Decimal, this.RegAgencyCode, ParameterDirection.Input);

            cmdSearchCustomer.Parameters.Add("p_clientid", OracleDbType.Decimal, this.ID, ParameterDirection.InputOutput);               

            cmdSearchCustomer.ExecuteNonQuery();

            this.ID = ((OracleDecimal)cmdSearchCustomer.Parameters["p_clientid"].Value).Value;

            DBLogger.Debug("Пользователь успешно записал в базу информацию о клиенте с ОКПО = " + this.Code
                + ". Регистрационный номер клиента rnk=" + this.ID.ToString(), "deposit");
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// для резидента (10 нулів)
    /// </summary>
    /// <returns></returns>
    public static String DefaultOKPO()
    {
        return "0000000000";
    }
    /// <summary>
    /// для нерезидента (9 нулів)
    /// </summary>
    /// <returns></returns>
    public static String NonResidentOKPO()
    {
        return "000000000";
    }

    /// <summary>
    /// 
    /// </summary>
    /// <returns></returns>
    public static Boolean Allowed2Oopen(Decimal CustomerID)
    {
        Boolean allowed = false;

        DateTime BirthDate;

        OracleConnection connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

        try
        {
            OracleCommand cmd = connect.CreateCommand();

            cmd.CommandText = @"select p.bday, 
                                       (select VALUE from customerW where rnk = p.rnk and tag = 'SPMRK') as SPMRK  
                                  from person p
                                 where p.rnk = :p_rnk";

            cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, CustomerID, ParameterDirection.Input);

            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                if (!rdr.IsDBNull(0))
                {
                    BirthDate = rdr.GetOracleDate(0).Value;

                    if (DateTime.Now.Date >= BirthDate.AddYears(14))
                    {
                        allowed = true;
                    }
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

        return allowed;
    }
}

/// <summary>
/// Доступи операціоніста до здійснення операцій
/// </summary>
public class ClientAccessRights
{
    /// <summary>
    /// Реєстраційний Номер Клієнта
    /// </summary>
    public Int64 Cust_ID;

    /// <summary>
    /// Рівень доступу клієнта
    /// </summary>
    public SByte AccessLevel;

    /// <summary>
    /// Час закінчення доступу до КК з рівнем доступу = 1 
    /// (час авторизації клієнта по БПК + 30 хв.)
    /// </summary>
    public DateTime EndTimeAccess;

    /// <summary>
    /// Конструктор
    /// </summary>
    /// <param name="CustID">РНК</param>
    /// <param name="LevelID">Рівень доступу</param>
    /// <param name="DocVerified">Ознака актуальності ідент.документів</param>
    public ClientAccessRights(Int64 CustID, SByte LevelID, Boolean DocVerified)
    {
        // якщо   this.Cust_ID пустий або this.Cust_ID != CustID
        this.Cust_ID = CustID;

        if (LevelID == (SByte)LevelState.Complete)
        {   // Ідентифікація по БПК
            this.AccessLevel = LevelID;
            this.EndTimeAccess = DateTime.Now.AddMinutes(30);
        }
        else
        {   // Пошук по реквізитам
            this.AccessLevel = (SByte)LevelState.Limited;
            this.EndTimeAccess = DateTime.Today;
        }
    }

    /// <summary>
    /// Рівень доступу до даних клієнта
    /// </summary>
    /// <param name="CustID">РНК</param>
    /// <returns></returns>
    public static LevelState Get_AccessLevel(Int64 CustID)
    {
        if (HttpContext.Current.Session["AccessRights"] == null)
        {
            return LevelState.Limited;
        }
        else
        {
            ClientAccessRights Rights = HttpContext.Current.Session["AccessRights"] as ClientAccessRights;

            // Якщо РНК запитуємого = РНК в що є у сесії 
            // Якщо рівень доступу = 1 
            // Якщо не вичерпався ліміт часу з ост. ідентифік по БПК
            if ((Rights.Cust_ID == CustID) && (Rights.AccessLevel == 1))
            {
                if (Rights.EndTimeAccess > DateTime.Now)
                    return LevelState.Complete;
                else
                {
                    System.Web.UI.Page pg = HttpContext.Current.Handler as System.Web.UI.Page;
                    
                    if (pg != null)
                    {
                        pg.ClientScript.RegisterStartupScript(pg.GetType(), "alert", "alert('Роботу з клієнтом завершено'); ", true);
                    }
                    
                    return LevelState.Limited;    
                }
            }
            else
                return LevelState.Limited;
        }
    }

    /// <summary>
    /// Статус актульності ідентифікуючого документу клієнта
    /// </summary>
    /// <param name="CustID"></param>
    /// <returns></returns>
    //public static DocumentState Get_DocumentState(Int64 CustID)
    //{
    //    if (HttpContext.Current.Session["AccessRights"] == null)
    //    {
    //        return DocumentState.NotVerified;
    //    }
    //    else
    //    {
    //        ClientAccessRights State = HttpContext.Current.Session["AccessRights"] as ClientAccessRights;

    //        if ((State.Cust_ID == CustID) && (State.DocumetVerified == true))
    //            return DocumentState.Verified;
    //        else
    //            return DocumentState.NotVerified;
    //    }
    //}
}

/// <summary>
/// Стауси актуальності ідентифікуючих документів клієнта
/// </summary>
public enum DocumentState
{
    /// <summary>
    /// Документ не перевірений (не актуальний)
    /// </summary>
    NotVerified = 0,
    /// <summary>
    /// Документ перевірений (актуальний)
    /// </summary>
    Verified = 1
}

/// <summary>
/// Статуси рівнів доступу операціоніста (ЕБП Ощадбанку)
/// </summary>
public enum LevelState
{
    /// <summary>
    /// Обмежений доступ
    /// </summary>
    Limited = 0,
    /// <summary>
    /// Повний доступ (ідентифікація по БПК)
    /// </summary>
    Complete = 1
}