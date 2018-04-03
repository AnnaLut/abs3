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
    /// Идентификатор
    public decimal ID;
    /// Полное наименование клиента
    public string Name;
    /// Повне імя в родовому відмінку
    public string NameGenitive;
    /// Имя
    public string FirstName;
    /// Фамилия
    public string LastName;
    /// Отчество
    public string Patronymic;
    /// Тип идентификационного кода
    public decimal CodeType;
    /// Типа идентификационного кода
    public string textCodeType;
    /// Идинтификационный код
    public string Code;
    /// Цифровой код страны
    public decimal CountryCode;
    /// Страна
    public string Country;
    /// Резидент
    public bool isResident;
    /// Полный адрес
    public string Address;
    /// Код території (для УПБ)
    public decimal Territory;
    ///
    /// Юридична адреса
    /// 
    /// Юридична адреса: індекс
    public string Index;
    /// Область
    public string Region;
    /// Район 
    public string District;
    /// Юридична адреса: населений пункт
    public string Settlement;
    /// Юридична адреса: вулиця, будинок, квартира
    public string Location;
    /// 
    /// Фактична адреса
    /// 
    /// Фактична адреса: індекс
    public string fact_index;
    /// Фактична адреса: область
    public string fact_region;
    /// Фактична адреса: район
    public string fact_district;
    /// Фактична адреса: населений пункт
    public string fact_settlement;
    /// Фактична адреса: вулиця, будинок, квартира
    public string fact_location;
    ///
    /// Тип документа (цифровой)
    public decimal DocType;
    /// Тип документа
    public string DocTypeName;
    /// Серия документа
    public string DocSerial;
    /// Номер документа
    public string DocNumber;
    /// Дата выдачи документа
    public DateTime DocDate;
    /// Кем выдан документ
    public string DocOrg;
    /// Дата рождения
    public DateTime BirthDate;
    /// Место рождения
    public string BirthPlace;
    /// Пол
    public decimal Sex;
    /// Пол
    public string textSex;
    /// Домашний телефон
    public string HomePhone;
    /// Рабочий телефон
    public string WorkPhone;
    /// Чи є клієнт інсайдером
    public bool isInsider;

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
        ID              = decimal.MinValue;
        Name            = string.Empty;
        NameGenitive    = string.Empty;
        FirstName       = string.Empty;
        LastName        = string.Empty;
        Patronymic      = string.Empty;
        CodeType        = decimal.MinValue;
        textCodeType    = string.Empty;
        Code            = string.Empty;
        CountryCode     = decimal.MinValue;
        isResident      = true;
        Address         = string.Empty;
        Country         = string.Empty;
        Index           = string.Empty;
        Region          = String.Empty; //Resources.Deposit.GlobalResources.client_region;
        District        = String.Empty; //Resources.Deposit.GlobalResources.client_district;
        Settlement      = String.Empty; //Resources.Deposit.GlobalResources.client_city;
        Location        = String.Empty; //Resources.Deposit.GlobalResources.client_address;
        fact_index      = Index; ;
        fact_region     = Region ;
        fact_district   = District;
        fact_settlement = Settlement;
        fact_location   = Location;
        DocType         = decimal.MinValue;
        DocTypeName     = string.Empty;
        DocSerial       = string.Empty;
        DocNumber       = string.Empty;
        DocDate         = DateTime.MinValue;
        DocOrg          = string.Empty;
        BirthDate       = DateTime.MinValue;
        BirthPlace      = string.Empty;
        Sex             = decimal.MinValue;
        textSex         = string.Empty;
        WorkPhone       = string.Empty;
        HomePhone       = string.Empty;
        isInsider       = false;
        Territory       = decimal.MinValue;
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
            this.BirthDate == ((Client)obj).BirthDate &&
            this.BirthPlace == ((Client)obj).BirthPlace &&
            this.Sex == ((Client)obj).Sex &&
            this.WorkPhone == ((Client)obj).WorkPhone &&
            this.HomePhone == ((Client)obj).HomePhone &&
            this.Territory == ((Client)obj).Territory);
    }
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
            cmdReadClientData.CommandText = "select name, tgr, okpo, country, address, doctype, doctypename, " +
                " docserial, docnum, docdate, docorg, bdate, bplace, sex, phoneh, phonew, resident, " +
                " u_idx, u_region, u_district, u_settlement, u_address, territory, " +
                " f_idx, f_region, f_district, f_settlement, f_address " +
                " from v_dpt_customer where rnk = :rnk";
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
 
               // код території (тільки для УПБ)
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

            }

            // Формируем запросы на дополнительные параметры
            cmdReadClientData = new OracleCommand();
            cmdReadClientData.Connection = connect;
            cmdReadClientData.CommandText = @"select value, tag from customerw where rnk = :rnk
                and tag in ('SN_FN','SN_LN','SN_MN','SN_GC')";
            //  and tag in ('FGIDX','FGOBL','FGDST','FGTWN','FGADR','SN_FN','SN_LN','SN_MN','SN_GC')"
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
                
                if (TAG == "SN_FN")
                {
                    if (!rdr.IsDBNull(0))
                        this.FirstName = rdr.GetOracleString(0).Value;
                }
                else if (TAG == "SN_LN")
                {
                    if (!rdr.IsDBNull(0))
                        this.LastName = rdr.GetOracleString(0).Value;
                }
                else if (TAG == "SN_MN")
                {
                    if (!rdr.IsDBNull(0))
                        this.Patronymic = rdr.GetOracleString(0).Value;
                }
                else if (TAG == "SN_GC")
                {
                    if (!rdr.IsDBNull(0))
                        this.NameGenitive = rdr.GetOracleString(0).Value;
                }
                //else if (TAG == "FGIDX")
                //{
                //    if (!rdr.IsDBNull(0))
                //        this.Index = rdr.GetOracleString(0).Value;
                //}
                //else if (TAG == "FGOBL")
                //{
                //    if (!rdr.IsDBNull(0))
                //        this.Region = rdr.GetOracleString(0).Value;
                //    else
                //        Region = String.Empty;
                //}
                //else if (TAG == "FGDST")
                //{
                //    if (!rdr.IsDBNull(0))
                //        this.District = rdr.GetOracleString(0).Value;
                //    else
                //        District = String.Empty;
                //}
                //else if (TAG == "FGTWN")
                //{
                //    if (!rdr.IsDBNull(0))
                //        this.Settlement = rdr.GetOracleString(0).Value;
                //    else
                //        Settlement = String.Empty;
                //}
                //else if (TAG == "FGADR")
                //{
                //    if (!rdr.IsDBNull(0))
                //        this.Location = rdr.GetOracleString(0).Value;
                //    else
                //        Location = String.Empty;
                //}
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

            DBLogger.Debug("Пользователь успешно прочитал из базы информацию о клиенте с регистрационным номером rnk="
                + this.ID.ToString(), "deposit");
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
    public void WriteToDatabase()
    {
        HttpContext ctx = HttpContext.Current;

        OracleConnection connect = new OracleConnection();

        try
        {
            DBLogger.Debug("Пользователь начал запись в базу информацию о клиенте с ОКПО ="
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

            // Формируем запрос на поиск
            OracleCommand cmdSearchCustomer = new OracleCommand();
            cmdSearchCustomer.Connection = connect;
            cmdSearchCustomer.CommandText =
                "begin dpt_web.p_open_vklad_rnk(" +
                ":m_clientname, :m_client_fn, :m_client_ln, :m_client_mn, " +
                ":m_country, :m_index, :m_obl, :m_district, :m_settlement, :m_adress, :m_fulladdress, " +
                ((BankType.GetDptBankType() == BANKTYPE.UPB) ? ":territory, " : "") +
                ":m_clientcodetype, :m_clientcode, :m_doctype, :m_docserial, :m_docnumber, :m_docorg, :m_docdate, " +
                ":m_clientbdate, :m_clientbplace, :m_clientsex, :m_clienthomeph, :m_clientworkph, " +
                ":p_clientname_gc, :p_resid_code, :p_resid_index, :p_resid_obl, :p_resid_district, :p_resid_settlement, :p_resid_adress,  " +
                ":m_clientid); " +
                "end;";

            TruncateAddress();
            Decimal par_is_resident = (this.isResident == true ? 1 : 0);

            cmdSearchCustomer.Parameters.Add("m_clientname",        OracleDbType.Varchar2,  this.Name.ToUpper(),            ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("m_client_fn",         OracleDbType.Varchar2,  this.FirstName.ToUpper(),       ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("m_client_ln",         OracleDbType.Varchar2,  this.LastName.ToUpper(),        ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("m_client_mn",         OracleDbType.Varchar2,  this.Patronymic.ToUpper(),      ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("m_country",           OracleDbType.Decimal,   this.CountryCode,               ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("m_index",             OracleDbType.Varchar2,  this.Index,                     ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("m_obl",               OracleDbType.Varchar2,  this.Region.Trim(),             ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("m_district",          OracleDbType.Varchar2,  this.District.Trim(),           ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("m_settlement",        OracleDbType.Varchar2,  this.Settlement.Trim(),         ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("m_adress",            OracleDbType.Varchar2,  this.Location.Trim(),           ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("m_fulladdress",       OracleDbType.Varchar2,  this.Address.Trim(),            ParameterDirection.Input);
            if (BankType.GetDptBankType() == BANKTYPE.UPB)
            {
                cmdSearchCustomer.Parameters.Add("territory", OracleDbType.Decimal, this.Territory, ParameterDirection.Input);
            }
            cmdSearchCustomer.Parameters.Add("m_clientcodetype",    OracleDbType.Decimal,   this.CodeType,                  ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("m_clientcode",        OracleDbType.Varchar2,  this.Code,                      ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("m_doctype",           OracleDbType.Decimal,   this.DocType,                   ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("m_docserial",         OracleDbType.Varchar2,  this.DocSerial,                 ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("m_docnumber",         OracleDbType.Varchar2,  this.DocNumber,                 ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("m_docorg",            OracleDbType.Varchar2,  this.DocOrg,                    ParameterDirection.Input);
            if (DocDate != DateTime.MinValue)
                cmdSearchCustomer.Parameters.Add("m_docdate",       OracleDbType.Date,      this.DocDate,                   ParameterDirection.Input);
            else
                cmdSearchCustomer.Parameters.Add("m_docdate",       OracleDbType.Date,      null,                           ParameterDirection.Input);
            if (BirthDate != DateTime.MinValue)
                cmdSearchCustomer.Parameters.Add("m_clientbdate",   OracleDbType.Date,      this.BirthDate,                 ParameterDirection.Input);
            else
                cmdSearchCustomer.Parameters.Add("m_clientbdate",   OracleDbType.Date,      null,                           ParameterDirection.Input);
            
            cmdSearchCustomer.Parameters.Add("m_clientbplace",      OracleDbType.Varchar2,  this.BirthPlace,                ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("m_clientsex",         OracleDbType.Decimal,   this.Sex,                       ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("m_clienthomeph",      OracleDbType.Varchar2,  this.HomePhone.Trim(),          ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("m_clientworkph",      OracleDbType.Varchar2,  this.WorkPhone.Trim(),          ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_clientname_gc",     OracleDbType.Varchar2,  this.NameGenitive.ToUpper(),    ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_resid_code",        OracleDbType.Decimal,   par_is_resident,                ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_resid_index",       OracleDbType.Varchar2,  this.fact_index,                ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_resid_obl",         OracleDbType.Varchar2,  this.fact_region,               ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_resid_district",    OracleDbType.Varchar2,  this.fact_district,             ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_resid_settlement",  OracleDbType.Varchar2,  this.fact_settlement,           ParameterDirection.Input);
            cmdSearchCustomer.Parameters.Add("p_resid_adress",      OracleDbType.Varchar2,  this.fact_location,             ParameterDirection.Input);
            
            cmdSearchCustomer.Parameters.Add("m_clientid", OracleDbType.Decimal, this.ID, ParameterDirection.InputOutput);

            cmdSearchCustomer.ExecuteNonQuery();

            this.ID = Convert.ToDecimal(Convert.ToString(cmdSearchCustomer.Parameters["m_clientid"].Value));

            DBLogger.Debug("Пользователь успешно записал в базу информацию о клиенте с ОКПО = " + this.Code
                + ". Регистрационный номер клиента rnk=" + this.ID.ToString(),
                "deposit");
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    ///
    public static String DefaultOKPO()
    {
        return "000000000";
    }
}

