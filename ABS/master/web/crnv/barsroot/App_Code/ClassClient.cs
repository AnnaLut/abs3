using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;
using System.Collections;
using System.Globalization;
using Bars.Exception;
using Bars.Logger;

/// <summary>
/// Класс клиента банка
/// </summary>
public class ClassClient
{
    //=========================================================
    # region Типы данных
    /// <summary>
    /// Структура для хранения списка и выбраного в нем индекса
    /// </summary>
    public struct ListAndIndex
    {
        public ListItemCollection List;
        public int SelectedIndex;
    }
    # endregion
    //=========================================================
    # region Конструкторы класса
    private void constrClassClient(int CUSTTYPE)
    {
        // Форматирование даты
        dtf.ShortDatePattern = "dd/MM/yyyy";
        dtf.DateSeparator = "/";
        
        // Форматирование чисел
        nf.NumberDecimalSeparator = ".";
        nf.NumberDecimalDigits = 2;
        nf.NumberGroupSeparator = " ";
        nf.NumberGroupSizes = new int[] {3,3,3,3,3,3,3,3,3,3,3};

        con = Bars.Classes.OraConnector.Handler.UserConnection;
        com.Connection = con;
        adp.SelectCommand = com;
    }
    /// <summary>
    /// Инициализация класса клиента банка (новый клиент)
    /// </summary>
    /// <param name="CUSTTYPE">Тип клиента "bank", "corp", "person"</param>
	public ClassClient(string CUSTTYPE)
	{
        int nCUSTTYPE = 0;
        switch (CUSTTYPE)
        {
            case "bank": nCUSTTYPE = 1; break;
            case "corp": nCUSTTYPE = 2; break;
            case "person": nCUSTTYPE = 3; break;
            default: throw new Exception("Неверный тип клиента");
        }

        constrClassClient(nCUSTTYPE);
    }
    private void constrClassClient(decimal RNK, bool EDITABLE)
    {
        // Форматирование даты
        dtf.ShortDatePattern = "dd/MM/yyyy";
        dtf.DateSeparator = "/";

        // Форматирование чисел
        nf.NumberDecimalSeparator = ".";
        nf.NumberDecimalDigits = 2;
        nf.NumberGroupSeparator = " ";
        nf.NumberGroupSizes = new int[] { 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 };

        _RNK = RNK;

        con = Bars.Classes.OraConnector.Handler.UserConnection;
        com.Connection = con;
        adp.SelectCommand = com;

        this.ReadClient();
    }
    /// <summary>
    /// Инициализация класса клиента банка (существующий клиент)
    /// </summary>
    /// <param name="RNK">РНК клиента</param>
    /// <param name="EDITABLE">Возможность редактировать true/false</param>
    public ClassClient(decimal RNK, bool EDITABLE)
    {
        constrClassClient(RNK, EDITABLE);
    }
    /// <summary>
    /// Инициализация класса клиента банка (существующий клиент, с возможностью редактировать)
    /// </summary>
    /// <param name="RNK">РНК клиента</param>
    public ClassClient(decimal RNK)
    {
        constrClassClient(RNK, true);
    }
    # endregion
    //=========================================================
    # region Переменные для работы класса
    /// <summary>
    /// Конект к базе
    /// </summary>
    OracleConnection con = new OracleConnection();
    /// <summary>
    /// Комманда для работы с базой
    /// </summary>
    OracleCommand com = new OracleCommand();
    /// <summary>
    /// Ридер для чтения дпнных
    /// </summary>
    OracleDataReader rdr;
    /// <summary>
    /// Адаптер для вычитки табличных данных
    /// </summary>
    OracleDataAdapter adp = new OracleDataAdapter();
    DataTable dt = new DataTable();
    /// <summary>
    /// Роль класса
    /// </summary>
    string sClassRole = "WR_CUSTREG";
    /// <summary>
    /// Флаг были ли изменения после последней загрузки
    /// </summary>
    bool bHasChanges = false;
    /// <summary>
    /// Форматирование даты
    /// </summary>
    public DateTimeFormatInfo dtf = new DateTimeFormatInfo();
    /// <summary>
    /// Форматирование чисел
    /// </summary>
    public NumberFormatInfo nf = new NumberFormatInfo();
    # endregion
    //=========================================================
    # region Данные класса
    /// <summary>
    /// Заполнять или нет реквизиты налогоплательщика
    /// </summary>
    public bool bFillRekvNalogoplat = true;
    /// <summary>
    /// Заполнять или нет Экономические нормативы
    /// </summary>
    public bool bFillEconomNorm = true;
    /// <summary>
    /// Заполнять Персональные реквизиты
    /// </summary>
    public bool bFillClientRekv = true;

    /// <summary>
    /// Регистрационный номер клиента банка
    /// </summary>
    private decimal _RNK = decimal.MinValue;
    /// <summary>
    /// Регистрационный номер клиента банка
    /// </summary>
    public decimal RNK
    {
        get
        {
            return _RNK;
        }
    }
    /// <summary>
    /// Тип гос реестра 1 - ЄДР, 2 - ДРФ, 3 - тимчас
    /// </summary>
    private int _TGR = int.MinValue;
    /// <summary>
    /// Тип гос реестра 1 - ЄДР, 2 - ДРФ, 3 - тимчас
    /// </summary>
    public Pair TGR
    {
        get
        {
            string sRes;
            
            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
                com.ExecuteNonQuery();

                com.Parameters.Clear();
                com.Parameters.Add("pTGR", OracleDbType.Decimal, _COUNTRY, ParameterDirection.Input);
                com.CommandText = "select NAME from TGR where TGR = :ppTGR";
                sRes = Convert.ToString(com.ExecuteScalar());
            }
            finally
            {
                con.Close();
            }
            
            return new Pair(_TGR, sRes);
        }
        set
        {
            _TGR = (int)value.First;
        }
    }
    /// <summary>
    /// Тип клиента 1 - bank, 2 - corp, 3 - person
    /// </summary>
    private int _CUSTTYPE = int.MinValue;
    /// <summary>
    /// Тип клиента 1 - bank, 2 - corp, 3 - person
    /// </summary>
    public int CUSTTYPE
    {
        get
        {
            return _CUSTTYPE;
        }           
    }
    /// <summary>
    /// Страна клиента
    /// </summary>
    private int _COUNTRY = int.MinValue;
    /// <summary>
    /// Страна клиента
    /// </summary>
    public Pair COUNTRY
    {
        get
        {
            string sRes;

            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
                com.ExecuteNonQuery();

                com.Parameters.Clear();
                com.Parameters.Add("pCID", OracleDbType.Decimal, _COUNTRY, ParameterDirection.Input);
                com.CommandText = "select NAME from COUNTRY where COUNTRY = :pCID";
                sRes = Convert.ToString(com.ExecuteScalar());
            }
            finally
            {
                con.Close();
            }
            
            return new Pair(_COUNTRY, sRes);
        }
        set
        {
            _COUNTRY = (int)value.First;
        }
    }
    /// <summary>
    /// Полное Наименование контрагента
    /// </summary>
    private string _NMK = string.Empty;
    /// <summary>
    /// Полное Наименование контрагента
    /// </summary>
    public string NMK
    {
        get
        {
            return _NMK;
        }
        set
        {
            string val = value.Trim().ToUpper();

            if (val == string.Empty) throw new ClientRegisterException("Не заполнен реквизит 'Полное Наименование контрагента'", "edNMK");

            _NMK = ((val.Length > 70) ? (val.Substring(70)) : (val));
            if (_NMKV == string.Empty) _NMKV = _NMK;
            if (_NMKK == string.Empty) _NMKK = _NMK;
        }
    }
    /// <summary>
    /// Краткое Наименование контрагента
    /// </summary>
    private string _NMKV = string.Empty;
    /// <summary>
    /// Краткое Наименование контрагента
    /// </summary>
    public string NMKV
    {
        get
        {
            return _NMKV;
        }
        set
        {
            string val = value.Trim().ToUpper();
            _NMKV = ((val.Length > 70) ? (val.Substring(70)) : (val));
        }
    }
    /// <summary>
    /// Наименование
    /// </summary>
    private string _NMKK = string.Empty;
    /// <summary>
    /// Наименование
    /// </summary>
    public string NMKK
    {
        get
        {
            return _NMKK;
        }
        set
        {
            string val = value.Trim().ToUpper();
            _NMKK = ((val.Length > 35) ? (val.Substring(35)) : (val));
        }
    }
    /// <summary>
    /// Характеристика
    /// </summary>
    private int _CODCAGENT = int.MinValue;
    /// <summary>
    /// Характеристика
    /// </summary>
    public Triplet CODCAGENT
    {
        get
        {
            string sRes1;
            int nRes2;

            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
                com.ExecuteNonQuery();

                com.Parameters.Clear();
                com.Parameters.Add("pCCA", OracleDbType.Decimal, _CODCAGENT, ParameterDirection.Input);
                com.CommandText = "select NAME, REZID from CODCAGENT where CODCAGENT = :pCCA";

                rdr = com.ExecuteReader();
                rdr.Read();

                sRes1 = rdr.GetString(0);
                nRes2 = rdr.GetInt32(1);

                rdr.Close();
                rdr.Dispose();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }

            return new Triplet(_CODCAGENT, sRes1, nRes2);
        }
        set
        {
            _CODCAGENT = (int)value.First;
        }
    }
    /// <summary>
    /// Код инсайдера
    /// </summary>
    private decimal _PRINSIDER = decimal.MinValue;
    /// <summary>
    /// Код инсайдера
    /// </summary>
    public Pair PRINSIDER
    {
        get
        {
            string sRes;

            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
                com.ExecuteNonQuery();

                com.Parameters.Clear();
                com.Parameters.Add("pPI", OracleDbType.Decimal, _PRINSIDER, ParameterDirection.Input);
                com.CommandText = "select NAME from PRINSIDER where PRINSIDER = :pPI";
                sRes = Convert.ToString(com.ExecuteScalar());
            }
            finally
            {
                con.Close();
            }

            return new Pair(_PRINSIDER, sRes);
        }
        set
        {
            _PRINSIDER = (decimal)value.First;
        }

    }
    /// <summary>
    /// Идентификационный код клиента
    /// </summary>
    private string _OKPO = string.Empty;
    /// <summary>
    /// Идентификационный код клиента
    /// </summary>
    public string OKPO
    {
        get
        {
            return _OKPO;
        }
        set
        {
            string strOKPO = value, strOKPONew, m7_, c1_, c2_;
            decimal kc_ = 0, sum_ = 0;
            
            // ОКПО 99999 и 000000000 пропускаем как валидные
            if (strOKPO == "99999" || strOKPO == "000000000")
            {
                _OKPO = strOKPO;
            }
            else
            {
                // дополняем нулями слева до восьми символов
                if (strOKPO.Length < 8) strOKPO.PadLeft(8, '0');

                // в зависимости от типа реестра проверяем количество символов
                switch (_TGR)
                {
                    case 2:
                        // ДРФО  проверяется
                        if (strOKPO.Length != 10) throw new ClientRegisterException("Неверный идентификационный код", "edOKPO");

                        if (this._BDAY == null || this._BDAY == DateTime.MinValue) throw new ClientRegisterException("Не заполнена дата рождения", "edBDAY");

                        DateTime firstDay = new DateTime(1899, 12, 31);
                        TimeSpan diffTS = this._BDAY - firstDay;
                        string differ = diffTS.Days.ToString();

                        if (strOKPO.Substring(0, 5) != differ) throw new ClientRegisterException("Неверный идентификационный код", "edOKPO");
                        else _OKPO = strOKPO;

                        break;
                    case 1:
                        // ЄДРПОУ проверяется
                        if (strOKPO.Length != 8) throw new ClientRegisterException("Неверный идентификационный код", "edOKPO");

                        if (string.Compare(strOKPO, "30000000") < 0 || string.Compare(strOKPO, "60000000") > 0) m7_ = "1234567";
                        else m7_ = "7123456";

                        for (int i = 0; i < 7; i++)
                        {
                            c1_ = strOKPO.Substring(i, 1);
                            c2_ = m7_.Substring(i, 1);

                            sum_ += Convert.ToDecimal(c1_) * Convert.ToDecimal(c2_);
                        }

                        kc_ = sum_ % 11;

                        if (kc_ == 10)
                        {
                            if (string.Compare(strOKPO, "30000000") < 0 || string.Compare(strOKPO, "60000000") > 0) m7_ = "3456789";
                            else m7_ = "9345678";

                            sum_ = 0;

                            for (int i = 0; i < 7; i++)
                            {
                                c1_ = strOKPO.Substring(i, 1);
                                c2_ = m7_.Substring(i, 1);

                                sum_ += Convert.ToDecimal(c1_) * Convert.ToDecimal(c2_);
                            }

                            kc_ = sum_ % 11;

                            if (kc_ == 10) kc_ = 0;
                        }

                        strOKPONew = strOKPO.Substring(0, 7) + kc_;

                        if (strOKPONew == strOKPO) _OKPO = strOKPO;
                        else throw new ClientRegisterException("Неверный идентификационный код", "edOKPO");

                        break;
                    case 3:
                        // ДПА не проверяется

                        _OKPO = strOKPO;

                        break;
                }
            }
        }
    }
    /// <summary>
    /// Адрес клиента
    /// </summary>
    private DataTable _ADR = new DataTable();
    /// <summary>
    /// Адрес клиента
    /// </summary>
    public string[] ADR
    {
        get
        {
            string[] pRes = new string[6];

            int idx = -1;
            for (int i = 0; i < _ADR.Rows.Count; i++)
                if (_ADR.Rows[i]["TYPE_ID"].ToString() == "1")
                    idx = i;

            if (idx != -1)
            {
                DataRow row = _ADR.Rows[idx];
                pRes[0] = row["ZIP"].ToString();        // Индекс
                pRes[1] = row["DOMAIN"].ToString();     // Область
                pRes[2] = row["REGION"].ToString();     // Регион
                pRes[3] = row["LOCALITY"].ToString();   // Населенный пукт
                pRes[4] = row["ADDRESS"].ToString();    // Адрес (улица, дом, квартира)
                pRes[5] = row["TERRITORY_ID"].ToString();    // Код территории
            }
            
            return pRes;
        }
        set
        {
            object[] row = new object[9];
            row[0] = this._RNK;             // РНК "RNK"
            row[1] = 1;                     // Тип адреса "TYPE_ID"
            row[2] = this._COUNTRY;         // Страна "COUNTRY"
            row[3] = value[0];              // Индекс "ZIP"
            row[4] = value[1];              // Область "DOMAIN"
            row[5] = value[2];              // Регион "REGION"
            row[6] = value[3];              // Населенный пукт "LOCALITY"
            row[7] = value[4];              // Адрес (улица, дом, квартира) "ADDRESS"
            row[8] = value[5];              // "TERRITORY_ID"

            int idx = -1;
            for (int i = 0; i < this._ADR.Rows.Count; i++)
                if (this._ADR.Rows[i]["TYPE_ID"].ToString() == "1")
                    idx = i;

            if (idx == -1) this.CORPS_ADR_ADDROW(1); // новый рядок
            this.CORPS_ADR_MODROW(1, row);
        }
    }
    /// <summary>
    /// Адрес в одну строку
    /// </summary>
    public string ADR_Short
    {
        get
        {
            int idx = -1;
            string sRes = "";
            for (int i = 0; i < _ADR.Rows.Count; i++)
                if (_ADR.Rows[i]["TYPE_ID"].ToString() == "1")
                    idx = i;
            if (idx != -1)
            {
                DataRow row = _ADR.Rows[idx];

                sRes = row["ZIP"].ToString();
                sRes += ((!string.IsNullOrEmpty(sRes)) ? (", ") : ("")) + row["DOMAIN"].ToString();
                sRes += ((!string.IsNullOrEmpty(sRes)) ? (", ") : ("")) + row["REGION"].ToString();
                sRes += ((!string.IsNullOrEmpty(sRes)) ? (", ") : ("")) + row["LOCALITY"].ToString();
                sRes += ((!string.IsNullOrEmpty(sRes)) ? (", ") : ("")) + row["ADDRESS"].ToString();
            }

            return sRes;
        }
    }
    /// <summary>
    /// Эл.код
    /// </summary>
    private string _SAB = string.Empty;
    /// <summary>
    /// Эл.код
    /// </summary>
    public string SAB
    {
        get
        {
            return _SAB;
        }
        set
        {
            string val = value.Trim();
            if (val.Length > 6) _SAB = val.Substring(0, 6);
            else _SAB = val;
        }
    }
    /// <summary>
    /// Код обл.НИ
    /// </summary>
    private int _C_REG = int.MinValue;
    /// <summary>
    /// Код обл.НИ
    /// </summary>
    public Pair C_REG
    {
        get
        {
            string sRes;
            
            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
                com.ExecuteNonQuery();

                com.Parameters.Clear();
                com.Parameters.Add("pCReg", OracleDbType.Decimal, _C_REG, ParameterDirection.Input);
                com.CommandText = "select trim(NAME_REG) from SPR_OBL where C_REG = :pCReg";
                sRes = Convert.ToString(com.ExecuteScalar());
            }
            finally
            {
                con.Close();
            }

            return new Pair(_C_REG, sRes);
        }
        set
        {
            _C_REG = (int)value.First;
        }
    }
    /// <summary>
    /// Код район.НИ
    /// </summary>
    private int _C_DST = int.MinValue;
    /// <summary>
    /// Код район.НИ
    /// </summary>
    public Pair C_DST
    {
        get
        {
            string sRes;
            
            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
                com.ExecuteNonQuery();

                com.Parameters.Clear();
                com.Parameters.Add("pCReg", OracleDbType.Decimal, _C_REG, ParameterDirection.Input);
                com.Parameters.Add("pCDst", OracleDbType.Decimal, _C_DST, ParameterDirection.Input);
                com.CommandText = "select trim(NAME_STI) from SPR_REG where C_REG = :pCReg and C_DST = :pCDst";

                sRes = Convert.ToString(com.ExecuteScalar());
            }
            finally
            {
                con.Close();
            }

            return new Pair(_C_DST, sRes);
        }
        set
        {
            _C_DST = (int)value.First;
        }
    }
    /// <summary>
    /// Рег. номер в НИ
    /// </summary>    
    private string _RGTAX = string.Empty;
    /// <summary>
    /// Рег. номер в НИ
    /// </summary>    
    public string RGTAX
    {
        get
        {
            return _RGTAX;
        }
        set
        {
            if (value.Length > 30) _RGTAX = value.Substring(0, 30);
            else _RGTAX = value;
        }
    }
    /// <summary>
    /// Дата рег. в НИ
    /// </summary>
    private DateTime _DATET = DateTime.MinValue;
    /// <summary>
    /// Дата рег. в НИ
    /// </summary>
    public DateTime DATET
    {
        get
        {
            return _DATET;
        }
        set
        {
            if (value > DateTime.Now || value < DateTime.Now.AddYears(-100)) throw new ClientRegisterException("Неверная дата регистрации в НИ", "edDATET");
            else _DATET = value;
        }
    }
    /// <summary>
    /// Админ.орган
    /// </summary>
    private string _ADM = string.Empty;
    /// <summary>
    /// Админ.орган
    /// </summary>
    public string ADM
    {
        get
        {
            return _ADM;
        }
        set
        {
            if (value.Length > 70) _ADM = value.Substring(0, 70);
            else _ADM = value;
        }
    }
    /// <summary>
    /// Дата рег. в Адм.
    /// </summary>
    private DateTime _DATEA = DateTime.MinValue;
    /// <summary>
    /// Дата рег. в Адм.
    /// </summary>
    public DateTime DATEA
    {
        get
        {
            return _DATEA;
        }
        set
        {
            if (value > DateTime.Now || value < DateTime.Now.AddYears(-100)) throw new ClientRegisterException("Неверная дата регистрации в НИ", "edDATEA");
            else _DATEA = value;
        }
    }
    /// <summary>
    /// Формат выписки
    /// </summary>    
    private int _STMT = int.MinValue;
    /// <summary>
    /// Формат выписки
    /// </summary>    
    public Pair STMT
    {
        get
        {
            string sRes;

            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
                com.ExecuteNonQuery();

                com.Parameters.Clear();
                com.Parameters.Add("pStmt", OracleDbType.Decimal, _C_REG, ParameterDirection.Input);
                com.CommandText = "select NAME from STMT where STMT = :pStmt";
                sRes = Convert.ToString(com.ExecuteScalar());
            }
            finally
            {
                con.Close();
            }

            return new Pair(_STMT, sRes);
        }
        set
        {
            _STMT = (int)value.First;
        }
    }
    /// <summary>
    /// Дата открытия
    /// </summary>    
    private DateTime _DATE_ON = DateTime.MinValue;
    /// <summary>
    /// Дата открытия
    /// </summary>    
    public DateTime DATE_ON
    {
        get
        {
            return _DATE_ON;
        }
    }
    /// <summary>
    /// Дата закрытия
    /// </summary>    
    private DateTime _DATE_OFF = DateTime.MinValue;
    /// <summary>
    /// Дата закрытия
    /// </summary>    
    public DateTime DATE_OFF
    {
        get
        {
            return _DATE_OFF;
        }
    }
    /// <summary>
    /// Комментарий
    /// </summary>
    private string _NOTES = string.Empty;
    /// <summary>
    /// Комментарий
    /// </summary>
    public string NOTES
    {
        get
        {
            return _NOTES;
        }
        set
        {
            string val = value.Trim();
            if (val.Length > 140) _NOTES = val.Substring(0, 140);
            else _NOTES = val;
        }
    }
    /// <summary>
    /// Комментарий службы безопастности
    /// </summary>
    private string _NOTESEC = string.Empty;
    /// <summary>
    /// Комментарий службы безопастности
    /// </summary>
    public string NOTESEC
    {
        get
        {
            return _NOTESEC;
        }
        set
        {
            string val = value.Trim();
            if (val.Length > 256) _NOTESEC = val.Substring(0, 256);
            else _NOTESEC = val;
        }
    }
    /// <summary>
    /// Категория риска
    /// </summary>    
    private decimal _CRISK = decimal.MinValue;
    /// <summary>
    /// Категория риска
    /// </summary>    
    public Pair CRISK
    {
        get
        {
            string sRes;
            
            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
                com.ExecuteNonQuery();

                com.Parameters.Clear();
                com.Parameters.Add("pCrisk", OracleDbType.Decimal, _CRISK, ParameterDirection.Input);
                com.CommandText = "select NAME from STAN_FIN where FIN = :pCrisk";
                sRes = Convert.ToString(com.ExecuteScalar());
            }
            finally
            {
                con.Close();
            }

            return new Pair(_CRISK, sRes);
        }
        set
        {
            decimal val = (decimal)(value.First);
            if (val == 0) val = decimal.MinValue;

            _CRISK = val;
        }
    }
    /// <summary>
    /// Цвет соответствующий категории риска
    /// </summary>
    public string CRISK_COLOR
    {
        get
        {
	        string sRes = "white";
            int nCRISK = (_CRISK == decimal.MinValue) ? (0) : (Convert.ToInt32(_CRISK));
            switch (nCRISK)
            {
                case 1 : sRes = "lime"; break;
                case 2 : sRes = "green"; break;
                case 3 : sRes = "yellow"; break;
                case 4 : sRes = "maroon"; break;
                case 5 : sRes = "red"; break;
            }

            return sRes;
        }
    }
    /// <summary>
    /// Пинкод (неисп.)
    /// </summary>
    private string _PINCODE = string.Empty;
    /// <summary>
    /// Пинкод (неисп.)
    /// </summary>
    public string PINCODE
    {
        get
        {
            return _PINCODE;
        }
        set
        {
            if (value.Length > 10) _PINCODE = value.Substring(0, 10);
            else _PINCODE = value;
        }
    }
    /// <summary>
    /// № дог
    /// </summary>
    private string _ND = string.Empty;
    /// <summary>
    /// № дог
    /// </summary>
    public string ND
    {
        get
        {
            return _ND;
        }
        set
        {
            string val = value.Trim();
            if (val.Length > 10) _ND = val.Substring(0, 10);
            else _ND = val;
        }
    }
    /// <summary>
    /// Регистрационный № холдинга
    /// </summary>
    private decimal _RNKP = decimal.MinValue;
    /// <summary>
    /// Регистрационный № холдинга
    /// </summary>
    public decimal RNKP
    {
        get
        {
            return _RNKP;
        }
        set
        {
            _RNKP = value;
        }
    }
    /// <summary>
    /// Код сектора экономики
    /// </summary>
    private string _ISE = string.Empty;
    /// <summary>
    /// Код сектора экономики
    /// </summary>
    public Pair ISE
    {
        get
        {
            string sRes;
            object oTmp;
            
            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
                com.ExecuteNonQuery();

                com.Parameters.Clear();
                com.Parameters.Add("pIse", OracleDbType.Varchar2, _ISE, ParameterDirection.Input);
                com.CommandText = "select NAME from ISE where ISE = :pIse and D_CLOSE is null";
                oTmp = com.ExecuteScalar();
                if (oTmp != null) sRes = Convert.ToString(oTmp);
                else sRes = null;
            }
            finally
            {
                con.Close();
            }

            if (sRes != null) return new Pair(_ISE, sRes);
            else return new Pair(null, sRes);
        }
        set
        {
            _ISE = ((string)value.First).Trim();
        }
    }
    /// <summary>
    /// Форма собственности
    /// </summary>
    private string _FS = string.Empty;
    /// <summary>
    /// Форма собственности
    /// </summary>
    public Pair FS
    {
        get
        {
            string sRes;
            object oTmp;

            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
                com.ExecuteNonQuery();

                com.Parameters.Clear();
                com.Parameters.Add("pFs", OracleDbType.Varchar2, _FS, ParameterDirection.Input);
                com.CommandText = "select NAME from FS where FS = :pFs and D_CLOSE is null";
                oTmp = com.ExecuteScalar();
                if (oTmp != null) sRes = Convert.ToString(oTmp);
                else sRes = null;
            }
            finally
            {
                con.Close();
            }

            if (sRes != null) return new Pair(_FS, sRes);
            else return new Pair(null, sRes);            
        }
        set
        {
            _FS = ((string)value.First).Trim();
        }
    }
    /// <summary>
    /// Отрасли экономики
    /// </summary>
    private string _OE = string.Empty;
    /// <summary>
    /// Отрасли экономики
    /// </summary>
    public Pair OE
    {
        get
        {
            string sRes;
            object oTmp;
            
            if (con.State != ConnectionState.Open) con.Open();            
            try
            {
                com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
                com.ExecuteNonQuery();

                com.Parameters.Clear();
                com.Parameters.Add("pOe", OracleDbType.Varchar2, _OE, ParameterDirection.Input);
                com.CommandText = "select NAME from OE where OE = :pOe and D_CLOSE is null";
                oTmp = com.ExecuteScalar();
                if (oTmp != null) sRes = Convert.ToString(oTmp);
                else sRes = null;
            }
            finally
            {
                con.Close();
            }

            if (sRes != null) return new Pair(_OE, sRes);
            else return new Pair(null, sRes);            
        }
        set
        {
            _OE = ((string)value.First).Trim();
        }
    }
    /// <summary>
    /// Вид экономичческой деятельности
    /// </summary>
    private string _VED = string.Empty;
    /// <summary>
    /// Вид экономичческой деятельности
    /// </summary>
    public Triplet VED
    {
        get
        {
            string sName = "", sOEList = "";

            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
                com.ExecuteNonQuery();

                com.Parameters.Clear();
                com.Parameters.Add("pVed", OracleDbType.Varchar2, _VED, ParameterDirection.Input);
                com.CommandText = "select NAME, OELIST from VED where VED = :pVed and D_CLOSE is null";

                rdr = com.ExecuteReader();
                while (rdr.Read())
                {
                    sName = rdr.GetString(0);
                    sOEList = (rdr.IsDBNull(1))?(""):(rdr.GetString(1));
                }
                rdr.Close();
                rdr.Dispose();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }

            ArrayList oOeList = new ArrayList();
            string[] OEComma = sOEList.Split(',');
            for (int i = 0; i < OEComma.Length; i++)
            {
                string[] OEInterval = OEComma[i].Split(':');
                if (OEInterval.Length == 1) oOeList.Add(OEInterval[0]);
                else
                    for (int j = Convert.ToInt32(OEInterval[0]); j <= Convert.ToInt32(OEInterval[1]); j++)
                        oOeList.Add(j.ToString());
            }
            if (sOEList == "") oOeList = null;

            if(sName != "") return new Triplet(_VED, sName, oOeList);
            else return new Triplet(null, sName, oOeList);
        }
        set
        {
            _VED = ((string)value.First).Trim();
        }
    }
    /// <summary>
    /// Код отрасли экономики
    /// </summary>
    private string _SED = string.Empty;
    /// <summary>
    /// Код отрасли экономики
    /// </summary>
    public Pair SED
    {
        get
        {
            string sRes;
            object oTmp;
            
            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
                com.ExecuteNonQuery();

                com.Parameters.Clear();
                com.Parameters.Add("pSed", OracleDbType.Varchar2, _SED.Trim(), ParameterDirection.Input);
                com.CommandText = "select NAME from SED where trim(SED) = :pSed and D_CLOSE is null";
                oTmp = com.ExecuteScalar();
                if (oTmp != null) sRes = Convert.ToString(oTmp);
                else sRes = null;
            }
            finally
            {
                con.Close();
            }

            if (sRes != null) return new Pair(_SED, sRes);
            else return new Pair(null, sRes);            
        }
        set
        {
            _SED = ((string)value.First).Trim();
        }
    }
    /// <summary>
    /// Лимит
    /// </summary>
    private decimal _LIM = decimal.MinValue;
    /// <summary>
    /// Лимит
    /// </summary>
    public decimal LIM
    {
        get
        {
            return _LIM;
        }
        set
        {
            if (value >= 0 || value == decimal.MinValue) _LIM = value;
            else throw new ClientRegisterException("Неверный лимит", "edLIM");
        }
    }
    /// <summary>
    /// Принадлежность к малому бизнесу
    /// </summary>
    private string _MB = string.Empty;
    /// <summary>
    /// Принадлежность к малому бизнесу
    /// </summary>
    public string MB
    {
        get
        {
            return _MB;
        }
        set
        {
            string val = value.Trim();
            if (val.Length > 1) _MB = val.Substring(0, 1);
            else _MB = val;
        }
    }
    /// <summary>
    /// Рег.номер в Администрации
    /// </summary>
    private string _RGADM = string.Empty;
    /// <summary>
    /// Рег.номер в Администрации
    /// </summary>
    public string RGADM
    {
        get
        {
            return _RGADM;
        }
        set
        {
            string val = value.Trim();
            if (val.Length > 20) _RGADM = val.Substring(0, 20);
            else _RGADM = val;
        }
    }
    /// <summary>
    /// Признак НЕклиента банка (1)
    /// </summary>
    private int _BC = 1;
    /// <summary>
    /// Признак НЕклиента банка (1)
    /// </summary>
    public int BC
    {
        get
        {
            return _BC;
        }
        set
        {
            if (value != 0 && value != 1) throw new ClientRegisterException("Не верный признак НЕклиента банка", "cbBC");
            else _BC = value;
        }
    }
    /// <summary>
    /// Код отделенния
    /// </summary>
    private string _TOBO = string.Empty;
    /// <summary>
    /// Код отделенния
    /// </summary>
    public Pair TOBO
    {
        get
        {
            string sRes;
            
            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
                com.ExecuteNonQuery();

                com.Parameters.Clear();
                com.Parameters.Add("pTobo", OracleDbType.Decimal, _TOBO, ParameterDirection.Input);
                com.CommandText = "select NAME from TOBO where TOBO = :pTobo and DATE_CLOSED is null";
                sRes = Convert.ToString(com.ExecuteScalar());
            }
            finally
            {
                con.Close();
            }

            return new Pair(_TOBO, sRes);
        }
        set
        {
            int nRes;
            
            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
                com.ExecuteNonQuery();

                com.Parameters.Clear();
                com.Parameters.Add("pTobo", OracleDbType.Varchar2, (string)value.First, ParameterDirection.Input);
                com.CommandText = "select count(*) from TOBO where TOBO = :pTobo and DATE_CLOSED is null";
                nRes = Convert.ToInt32(com.ExecuteScalar());
            }
            finally
            {
                con.Close();
            }

            if(nRes != 0) _TOBO = (string)value.First;
            else throw new ClientRegisterException("Недопустимый код отделения", "ddlTOBO");
        }
    }
    /// <summary>
    /// Менеджер клиента (ответ. исполнитель)
    /// </summary>
    private int _ISP = int.MinValue;
    /// <summary>
    /// Менеджер клиента (ответ. исполнитель)
    /// </summary>
    public Pair ISP
    {
        get
        {
            string sRes;
            
            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
                com.ExecuteNonQuery();

                com.Parameters.Clear();
                com.Parameters.Add("pIsp", OracleDbType.Decimal, _ISP, ParameterDirection.Input);
                com.CommandText = "select FIO from STAFF where ID = :pIsp and APPROVE = 1";
                sRes = Convert.ToString(com.ExecuteScalar());
            }
            finally
            {
                con.Close();
            }

            return new Pair(_ISP, sRes);
        }
        set
        {
            if ((decimal)value.First != decimal.MinValue)
            {
                int nRes;

                if (con.State != ConnectionState.Open) con.Open();
                try
                {
                    com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
                    com.ExecuteNonQuery();

                    com.Parameters.Clear();
                    com.Parameters.Add("pIsp", OracleDbType.Decimal, (decimal)value.First, ParameterDirection.Input);
                    com.CommandText = "select FIO from STAFF where ID = :pIsp and APPROVE = 1";
                    nRes = Convert.ToInt32(com.ExecuteScalar());
                }
                finally
                {
                    con.Close();
                }

                if (nRes != 0) _ISP = (int)value.First;
                else throw new ClientRegisterException("Недопустимый код исполнителя", "hISP");
            }
        }
    }
    /// <summary>
    /// Код филиала
    /// </summary>
    private string _KF = string.Empty;
    /// <summary>
    /// Код филиала
    /// </summary>
    public string KF
    {
        get
        {
            return _KF;
        }
        set
        {
            if (value.Length > 6) _KF = value.Substring(0, 6);
            else _KF = value;
        }
    }
    /// <summary>
    /// Налоговый код (К050)
    /// </summary>
    private string _TAXF = string.Empty;
    /// <summary>
    /// Налоговый код (К050)
    /// </summary>
    public string TAXF
    {
        get
        {
            return _TAXF;
        }
        set
        {
            if (value.Length > 12) _TAXF = value.Substring(0, 12);
            else _TAXF = value;
        }
    }
    /// <summary>
    /// № в реестре плательщиков ПДВ
    /// </summary>
    private string _NOMPDV = string.Empty;
    /// <summary>
    /// № в реестре плательщиков ПДВ
    /// </summary>
    public string NOMPDV
    {
        get
        {
            return _NOMPDV;
        }
        set
        {
            string val = value.Trim();
            if (val.Length > 8) _NOMPDV = val.Substring(0, 8);
            else _NOMPDV = val;
        }
    }
    /// <summary>
    /// Лимит кассы
    /// </summary>
    private decimal _LIM_KASS = decimal.MinValue;
    /// <summary>
    /// Лимит кассы
    /// </summary>
    public decimal LIM_KASS
    {
        get 
        {
            return _LIM_KASS;
        }
        set
        {
            _LIM_KASS = value;
        }
    }
    /// <summary>
    /// Номер договора
    /// </summary>
    private string _NOM_DOG = string.Empty;
    /// <summary>
    /// Номер договора
    /// </summary>
    public string NOM_DOG
    {
        get
        {
            return _NOM_DOG;
        }
        set
        {
            string val = value.Trim();
            if (val.Length > 10) _NOM_DOG = val.Substring(0, 10);
            else _NOM_DOG = val;
        }
    }

    /// <summary>
    /// Код МФО банка
    /// </summary>
    private string _MFO = string.Empty;
    /// <summary>
    /// Код МФО банка
    /// </summary>
    public Pair PersonalRekvBank_MFO
    {
        get
        {
            string sRes;
            object oTmp;

            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
                com.ExecuteNonQuery();

                com.Parameters.Clear();
                com.Parameters.Add("pMfo", OracleDbType.Varchar2, _MFO.Trim(), ParameterDirection.Input);
                com.CommandText = "select NB from BANKS where trim(MFO) = :pMfo";
                oTmp = com.ExecuteScalar();
                if (oTmp != null) sRes = Convert.ToString(oTmp);
                else sRes = null;
            }
            finally
            {
                con.Close();
            }

            if (sRes != null) return new Pair(_MFO, sRes);
            else return new Pair(null, sRes);
        }
        set
        {
            string val = (string)value.First;
            if (val.Length > 12) _MFO = val.Substring(0, 12);
            else _MFO = val;
        }
    }
    /// <summary>
    /// Альтернативный BIC-код
    /// </summary>
    private string _ALT_BIC = string.Empty;
    /// <summary>
    /// Альтернативный BIC-код
    /// </summary>
    public string PersonalRekvBank_ALT_BIC
    {
        get
        {
            return _ALT_BIC;
        }
        set
        {
            string val = value.Trim();
            if (val.Length > 11) _ALT_BIC = val.Substring(0, 11);
            else _ALT_BIC = val;
        }
    }
    /// <summary>
    /// BIC-код банка
    /// </summary>
    private string _BIC = string.Empty;
    /// <summary>
    /// BIC-код банка
    /// </summary>
    public Pair PersonalRekvBank_BIC
    {
        get
        {
            string sRes;
            object oTmp;

            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
                com.ExecuteNonQuery();

                com.Parameters.Clear();
                com.Parameters.Add("pBic", OracleDbType.Varchar2, _BIC.Trim(), ParameterDirection.Input);
                com.CommandText = "select NAME from SW_BANKS where trim(BIC) = :pBic";
                oTmp = com.ExecuteScalar();
                if (oTmp != null) sRes = Convert.ToString(oTmp);
                else sRes = null;
            }
            finally
            {
                con.Close();
            }

            if (sRes != null) return new Pair(_BIC, sRes);
            else return new Pair(null, sRes);
        }
        set
        {
            string val = (string)value.First;
            if (val.Length > 11) _BIC = val.Substring(0, 11);
            else _BIC = val;
        }
    }
    /// <summary>
    /// Рейтинг
    /// </summary>
    private string _RATING = string.Empty;
    /// <summary>
    /// Рейтинг
    /// </summary>
    public string PersonalRekvBank_RATING
    {
        get
        {
            return _RATING;
        }
        set
        {
            string val = value.Trim();
            if (val.Length > 5) _RATING = val.Substring(0, 5);
            else _RATING = val;
        }
    }
    /// <summary>
    /// Код банка
    /// </summary>
    private decimal _KOD_B = decimal.MinValue;
    /// <summary>
    /// Код банка
    /// </summary>
    public decimal PersonalRekvBank_KOD_B
    {
        get
        {
            return _KOD_B;
        }
        set
        {
            _KOD_B = value;
        }
    }
    /// <summary>
    /// ФИО руководителя
    /// </summary>
    private string _RUK = string.Empty;
    /// <summary>
    /// ФИО руководителя
    /// </summary>
    public string PersonalRekvBank_RUK
    {
        get
        {
            return _RUK;
        }
        set
        {
            string val = value.Trim();
            if (val.Length > 70) _RUK = val.Substring(0, 70);
            else _RUK = val;
        }
    }
    /// <summary>
    /// Тел. руководителя
    /// </summary>
    private string _TELR = string.Empty;
    /// <summary>
    /// Тел. руководителя
    /// </summary>
    public string PersonalRekvBank_TELR
    {
        get
        {
            return _TELR;
        }
        set
        {
            string val = value.Trim();
            if (val.Length > 20) _TELR = val.Substring(0, 20);
            else _TELR = val;
        }
    }
    /// <summary>
    /// ФИО гл. бухгалтера
    /// </summary>
    private string _BUH = string.Empty;
    /// <summary>
    /// ФИО гл. бухгалтера
    /// </summary>
    public string PersonalRekvBank_BUH
    {
        get
        {
            return _BUH;
        }
        set
        {
            string val = value.Trim();
            if (val.Length > 70) _BUH = val.Substring(0, 70);
            else _BUH = val;
        }
    }
    /// <summary>
    /// Тел .гл. бухгалтера
    /// </summary>
    private string _TELB = string.Empty;
    /// <summary>
    /// Тел .гл. бухгалтера
    /// </summary>
    public string PersonalRekvBank_TELB
    {
        get
        {
            return _TELB;
        }
        set
        {
            string val = value.Trim();
            if (val.Length > 20) _TELB = val.Substring(0, 20);
            else _TELB = val;
        }
    }

    /// <summary>
    /// Наименование по Уставу (полное)
    /// </summary>
    private string _NMKU = string.Empty;
    /// <summary>
    /// Наименование по Уставу (полное)
    /// </summary>
    public string PersonalRekvCorp_NMKU
    {
        get
        {
            return _NMKU;
        }
        set
        {
            string val = value.Trim();
            if (val.Length > 250) _NMKU = val.Substring(0, 250);
            else _NMKU = val;
        }
    }
    /// <summary>
    /// ФИО руководителя
    /// </summary>
    public string PersonalRekvCorp_RUK
    {
        get
        {
            return _RUK;
        }
        set
        {
            string val = value.Trim(); 
            if (val.Length > 70) _RUK = val.Substring(0, 70);
            else _RUK = val;
        }
    }
    /// <summary>
    /// Тел. руководителя
    /// </summary>
    public string PersonalRekvCorp_TELR
    {
        get
        {
            return _TELR;
        }
        set
        {
            string val = value.Trim();
            if (val.Length > 20) _TELR = val.Substring(0, 20);
            else _TELR = val;
        }
    }
    /// <summary>
    /// ФИО гл. бухгалтера
    /// </summary>
    public string PersonalRekvCorp_BUH
    {
        get
        {
            return _BUH;
        }
        set
        {
            string val = value.Trim();
            if (val.Length > 70) _BUH = val.Substring(0, 70);
            else _BUH = val;
        }
    }
    /// <summary>
    /// Тел. гл. бухгалтера
    /// </summary>
    public string PersonalRekvCorp_TELB
    {
        get
        {
            return _TELB;
        }
        set
        {
            string val = value.Trim();
            if (val.Length > 20) _TELB = val.Substring(0, 20);
            else _TELB = val;
        }
    }
    /// <summary>
    /// Факс
    /// </summary>
    private string _TEL_FAX = string.Empty;
    /// <summary>
    /// Факс
    /// </summary>
    public string PersonalRekvCorp_TEL_FAX
    {
        get
        {
            return _TEL_FAX;
        }
        set
        {
            string val = value.Trim();
            if (val.Length > 20) _TEL_FAX = val.Substring(0, 20);
            else _TEL_FAX = val;
        }
    }
    /// <summary>
    /// Адрес электронной почты
    /// </summary>
    private string _E_MAIL = string.Empty;
    /// <summary>
    /// Адрес электронной почты
    /// </summary>
    public string PersonalRekvCorp_E_MAIL
    {
        get
        {
            return _E_MAIL;
        }
        set
        {
            string val = value.Trim();
            if (val.Length > 100) _E_MAIL = val.Substring(0, 100);
            else _E_MAIL = val;
        }
    }
    /// <summary>
    /// Идентификатор графического представления печати юридического лица
    /// </summary>
    private decimal _SEAL_ID = decimal.MinValue;
    /// <summary>
    /// Идентификатор графического представления печати юридического лица
    /// </summary>
    public decimal PersonalRekvCorp_SEAL_ID
    {
        get
        {
            return _SEAL_ID;
        }
        set
        {
            decimal val = value;
            if (val == 0) val = decimal.MinValue;

            _SEAL_ID = val;
        }
    }

    /// <summary>
    /// Текушие счета клиента
    /// </summary>
    private DataTable _CORPS_ACC_FILLED = new DataTable();
    /// <summary>
    /// Текушие счета клиента
    /// </summary>
    public DataTable CORPS_ACC_FILLED
    {
        get
        {
            if (this._CORPS_ACC_FILLED.Rows.Count == 0)
            {
                DataTable tmp = this._CORPS_ACC_FILLED.Copy();
                tmp.Rows.Add(tmp.NewRow());
                tmp.Rows[0]["ID"] = "-1"; // пустой рядок с рапретом на редактирование

                return tmp;
            }
            else
            {
                return this._CORPS_ACC_FILLED;
            }
        }
    }
    /// <summary>
    /// Текушие счета клиента удаленные
    /// </summary>
    private ArrayList _CORPS_ACC_DELETED = new ArrayList();
    /// <summary>
    /// Добавляет рядок в таблицу Текушие счета клиентов
    /// </summary>
    /// <param name="row">Ряд</param>
    public void CORPS_ACC_ADDROW()
    {
        decimal nMaxId = 0;
        for (int i = 0; i < this._CORPS_ACC_FILLED.Rows.Count; i++)
            if (Convert.ToDecimal(_CORPS_ACC_FILLED.Rows[i]["ID"]) > nMaxId)
                nMaxId = Convert.ToDecimal(_CORPS_ACC_FILLED.Rows[i]["ID"]);

        DataRow row = this._CORPS_ACC_FILLED.NewRow();
        row["STATUS"] = "2";
        row["ID"] = nMaxId + 1;

        this._CORPS_ACC_FILLED.Rows.Add(row);
    }
    /// <summary>
    /// Удаляет рядок из таблицы Текушие счета клиентов
    /// </summary>
    /// <param name="nID">Идентификатор рядка</param>
    public void CORPS_ACC_DELROW(decimal nID)
    {
        int idx = -1;
        for (int i = 0; i < this._CORPS_ACC_FILLED.Rows.Count; i++)
            if (this._CORPS_ACC_FILLED.Rows[i]["ID"].ToString() == nID.ToString())
                idx = i;

        if (idx != -1)
        {
            this._CORPS_ACC_DELETED.Add(nID);
            this._CORPS_ACC_FILLED.Rows.RemoveAt(idx);
        }
    }
    /// <summary>
    /// Модификация рядка
    /// </summary>
    /// <param name="nID">Идентификатор рядка</param>
    /// <param name="row">Ряд</param>
    public void CORPS_ACC_MODROW(decimal nID, object[] row)
    {
        int idx = -1;
        for (int i = 0; i < this._CORPS_ACC_FILLED.Rows.Count; i++)
            if (this._CORPS_ACC_FILLED.Rows[i]["ID"].ToString() == nID.ToString())
                idx = i;

        if (idx != -1)
        {
            this._CORPS_ACC_FILLED.Rows[idx]["STATUS"] = "1"; // модифицированый
            for (int i = 0; i < row.Length; i++) this._CORPS_ACC_FILLED.Rows[idx][i + 1] = row[i];
        }
    }

    /// <summary>
    /// Текушие адреса клиента
    /// </summary>
    public DataTable CORPS_ADR_FILLED
    {
        get
        {
            DataTable tmp = this._ADR.Copy();
            int idx = -1;
            for (int i = 0; i < tmp.Rows.Count; i++)
                if (tmp.Rows[i]["TYPE_ID"].ToString() == "1")
                    idx = i;

            if (idx != -1) tmp.Rows.RemoveAt(idx);
            if (tmp.Rows.Count == 0)
            {
                tmp.Rows.Add(tmp.NewRow());
                tmp.Rows[0]["TYPE_ID"] = "-1"; // пустой рядок с рапретом на редактирование
            }

            return tmp;
        }
    }
    /// <summary>
    /// Текушие адреса клиента удаленные
    /// </summary>
    private ArrayList _CORPS_ADR_DELETED = new ArrayList();
    /// <summary>
    /// Добавляет рядок в таблицу Текушие адреса клиента
    /// </summary>
    /// <param name="nTYPE_ID">Тип адреса</param>
    public void CORPS_ADR_ADDROW(decimal nTYPE_ID)
    {
        DataRow row = this._ADR.NewRow();
        row["STATUS"] = "2";
        row["RNK"] = this._RNK;
        row["TYPE_ID"] = nTYPE_ID;
        row["COUNTRY"] = this._COUNTRY;

        this._ADR.Rows.Add(row);
    }
    /// <summary>
    /// Удаляет рядок из таблицы Текушие счета клиентов
    /// </summary>
    /// <param name="nTYPE_ID">Тип адреса</param>
    public void CORPS_ADR_DELROW(decimal nTYPE_ID)
    {
        int idx = -1;
        for (int i = 0; i < this._ADR.Rows.Count; i++)
            if (this._ADR.Rows[i]["TYPE_ID"].ToString() == nTYPE_ID.ToString())
                idx = i;

        if (idx != -1)
        {
            this._CORPS_ADR_DELETED.Add(nTYPE_ID);
            this._ADR.Rows.RemoveAt(idx);
        }
    }
    /// <summary>
    /// Модификация рядка
    /// </summary>
    /// <param name="nTYPE_ID">Тип адреса</param>
    /// <param name="row">Ряд</param>
    public void CORPS_ADR_MODROW(decimal nTYPE_ID, object[] row)
    {
        int idx = -1;
        for (int i = 0; i < this._ADR.Rows.Count; i++)
            if (this._ADR.Rows[i]["TYPE_ID"].ToString() == nTYPE_ID.ToString())
                idx = i;

        if (idx != -1)
        {
            this._ADR.Rows[idx]["STATUS"] = "1"; // модифицированый
            for (int i = 0; i < row.Length; i++) this._ADR.Rows[idx][i + 1] = row[i];
        }
    }
    /// <summary>
    /// Список типов адресов для ревизитов юр. лиц
    /// </summary>
    private ListItemCollection _CORPS_ADR_TYPE_ID_List = new ListItemCollection();
    /// <summary>
    /// Список типов адресов для ревизитов юр. лиц
    /// </summary>
    public ListItemCollection CORPS_ADR_TYPE_ID_List
    {
        get
        {
            this._CORPS_ADR_TYPE_ID_List.Clear();

            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
                com.ExecuteNonQuery();

                com.Parameters.Clear();
                com.CommandText = "select ID, NAME from CUSTOMER_ADDRESS_TYPE order by ID";
                
                rdr = com.ExecuteReader();
                while (rdr.Read()) this._CORPS_ADR_TYPE_ID_List.Add(new ListItem(rdr.GetString(1), rdr.GetDecimal(0).ToString()));
                rdr.Close();
                rdr.Dispose();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }

            // удаляем из списка юридический адрес
            for (int i = 0; i < this._CORPS_ADR_TYPE_ID_List.Count; i++)
                if (this._CORPS_ADR_TYPE_ID_List[i].Value == "1")
                {
                    this._CORPS_ADR_TYPE_ID_List.RemoveAt(i);
                    break;
                }

            // удаляем из списка уже выбраные типы адресов
            for (int i = 0; i < this.CORPS_ADR_FILLED.Rows.Count; i++)
            {
                string sTYPE_ID = this.CORPS_ADR_FILLED.Rows[i]["TYPE_ID"].ToString();

                for (int j = 0; j < this._CORPS_ADR_TYPE_ID_List.Count; j++)
                    if (this._CORPS_ADR_TYPE_ID_List[j].Value == sTYPE_ID)
                    {
                        this._CORPS_ADR_TYPE_ID_List.RemoveAt(j);
                        break;
                    }
            }

            if (this._CORPS_ADR_TYPE_ID_List.Count == 0)
                this._CORPS_ADR_TYPE_ID_List.Add(new ListItem("Пусто", "-1"));

            return this._CORPS_ADR_TYPE_ID_List;
        }
    }
    /// <summary>
    /// Тип адреса по заданому идентификатору
    /// </summary>
    /// <param name="sTYPE_ID">Идентификатор</param>
    /// <returns>Наименование</returns>
    public string CORPS_ADR_TYPE_ID_ItemName(string sTYPE_ID)
    {
        ListItemCollection licTmp = new ListItemCollection();
        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.Parameters.Clear();
            com.CommandText = "select ID, NAME from CUSTOMER_ADDRESS_TYPE order by ID";
            
            rdr = com.ExecuteReader();
            while (rdr.Read()) licTmp.Add(new ListItem(rdr.GetString(1), rdr.GetDecimal(0).ToString()));
            rdr.Close();
            rdr.Dispose();
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        for (int i = 0; i < licTmp.Count; i++)
            if (licTmp[i].Value == sTYPE_ID)
                return licTmp[i].Text;

        return string.Empty;
    }

    /// <summary>
    /// Пол
    /// </summary>
    private string _SEX = string.Empty;
    /// <summary>
    /// Пол
    /// </summary>
    public Pair PersonalRekvPerson_SEX
    {
        get
        {
            string sRes;

            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
                com.ExecuteNonQuery();

                com.Parameters.Clear();
                com.Parameters.Add("pID", OracleDbType.Char, _SEX, ParameterDirection.Input);
                com.CommandText = "select NAME from SEX where ID = :pID";
                sRes = Convert.ToString(com.ExecuteScalar());
            }
            finally
            {
                con.Close();
            }
            
            return new Pair(_SEX, sRes);
        }
        set
        {
            _SEX = (string)value.First;
        }
    }
    /// <summary>
    /// Тип удостоверяющего документа
    /// </summary>
    private int _PASSP = int.MinValue;
    /// <summary>
    /// Тип удостоверяющего документа
    /// </summary>
    public Pair PersonalRekvPerson_PASSP
    {
        get
        {
            string sRes;

            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
                com.ExecuteNonQuery();

                com.Parameters.Clear();
                com.Parameters.Add("pPASSP", OracleDbType.Int32, _PASSP, ParameterDirection.Input);
                com.CommandText = "select NAME from PASSP where PASSP = :pPASSP";
                sRes = Convert.ToString(com.ExecuteScalar());
            }
            finally
            {
                con.Close();
            }
            
            return new Pair(_PASSP, sRes);
        }
        set
        {
            _PASSP = (int)value.First;
        }
    }
    /// <summary>
    /// Серия док
    /// </summary>
    private string _SER = string.Empty;
    /// <summary>
    /// Серия док
    /// </summary>
    public string PersonalRekvPerson_SER
    {
        get
        {
            return _SER;
        }
        set
        {
            string val = value.Trim();
            if(val.Length > 10) _SER = val.Substring(0, 10);
            else _SER = val;
        }
    }
    /// <summary>
    /// № док
    /// </summary>
    private string _NUMDOC = string.Empty;
    /// <summary>
    /// № док
    /// </summary>
    public string PersonalRekvPerson_NUMDOC
    {
        get
        {
            return _NUMDOC;
        }
        set
        {
            string val = value.Trim();
            if(val.Length > 20) _NUMDOC = val.Substring(0, 20);
            else _NUMDOC = val;
        }
    }
    /// <summary>
    /// Даты выдачи док
    /// </summary>
    private DateTime _PDATE = DateTime.MinValue;
    /// <summary>
    /// Даты выдачи док
    /// </summary>
    public DateTime PersonalRekvPerson_PDATE
    {
        get
        {
            return _PDATE;
        }
        set
        {
            if(this._BDAY == DateTime.MinValue)
                _PDATE = value;
            else
            {
                if (this._BDAY.AddYears(16) > value)
                    throw new ClientRegisterException("Неверная дата выдачи паспорта", "edPDATE");
                else _PDATE = value;
            }
        }
    }
    /// <summary>
    /// Организация, выдавшая удостоверяющий документ
    /// </summary>
    private string _ORGAN = string.Empty;
    /// <summary>
    /// Организация, выдавшая удостоверяющий документ
    /// </summary>
    public string PersonalRekvPerson_ORGAN
    {
        get
        {
            return _ORGAN;
        }
        set
        {
            string val = value.Trim();
            if(val.Length > 50) _ORGAN = val.Substring(0, 50);
            else _ORGAN = val;
        }
    }
    /// <summary>
    /// Дата рождения
    /// </summary>
    private DateTime _BDAY = DateTime.MinValue;
    /// <summary>
    /// Дата рождения
    /// </summary>
    public DateTime PersonalRekvPerson_BDAY
    {
        get
        {
            return _BDAY;
        }
        set
        {
            DateTime dMinDate = new DateTime(1899, 12, 31);
            if(value < dMinDate)
            {
                throw new ClientRegisterException("Неверная дата рождения", "edBDAY");
            }
            else
            {
                _BDAY = value;
            }
        }
    }
    /// <summary>
    /// Место рождения
    /// </summary>
    private string _BPLACE = string.Empty;
    /// <summary>
    /// Место рождения
    /// </summary>
    public string PersonalRekvPerson_BPLACE
    {
        get
        {
            return _BPLACE;
        }
        set
        {
            string val = value.Trim();
            if(val.Length > 70) _BPLACE = val.Substring(0, 70);
            else _BPLACE = val;
        }
    }
    /// <summary>
    /// Домашний телефон
    /// </summary>
    public string PersonalRekvPerson_TELD
    {
        get
        {
            return _TELR;
        }
        set
        {
            string val = value.Trim();
            if(val.Length > 20) _TELR = val.Substring(0, 20);
            else _TELR = val;
        }
    }
    /// <summary>
    /// Рабочий телефон
    /// </summary>
    public string PersonalRekvPerson_TELW
    {
        get
        {
            return _TELB;
        }
        set
        {
            string val = value.Trim();
            if(val.Length > 20) _TELB = val.Substring(0, 20);
            else _TELB = val;
        }
    }
    
    /// <summary>
    /// Дополнительные реквизиты заполненые
    /// </summary>
    private DataTable _DOPREKV_FILLED = new DataTable();
    /// <summary>
    /// Дополнительные реквизиты заполненые
    /// </summary>
    public DataTable DOPREKV_FILLED
    {
        get
        {
            if (this._DOPREKV_FILLED.Rows.Count == 0)
            {
                DataTable tmp = this._DOPREKV_FILLED.Copy();
                tmp.Rows.Add(tmp.NewRow());
                tmp.Rows[0]["TAG"] = "-1"; // пустой рядок с рапретом на редактирование

                return tmp;
            }
            else
            {
                return this._DOPREKV_FILLED;
            }
        }
    }
    /// <summary>
    /// Дополнительные реквизиты доступные для заполнения
    /// </summary>
    private DataTable _DOPREKV_AVAILABLE = new DataTable();
    /// <summary>
    /// Дополнительные реквизиты доступные для заполнения
    /// </summary>
    public DataTable DOPREKV_AVAILABLE
    {
        get
        {
            DataTable dtTmp = new DataTable();

            dtTmp.Columns.Add("TAG", typeof(string));
            dtTmp.Columns.Add("NAME", typeof(string));

            for (int i = 0; i < this._DOPREKV_AVAILABLE.Rows.Count; i++)
            {
                DataRow row = dtTmp.NewRow();
                row["TAG"] = Convert.ToString(this._DOPREKV_AVAILABLE.Rows[i]["TAG"]);
                row["NAME"] = Convert.ToString(this._DOPREKV_AVAILABLE.Rows[i]["NAME"]);
                dtTmp.Rows.Add(row);
            }

            for (int i = 0; i < this._DOPREKV_FILLED.Rows.Count; i++)
            {
                string sTAG = Convert.ToString(this._DOPREKV_FILLED.Rows[i]["TAG"]);
                for (int j = 0; j < dtTmp.Rows.Count; j++)
                    if (Convert.ToString(dtTmp.Rows[j]["TAG"]) == sTAG)
                        dtTmp.Rows.RemoveAt(j);
            }

            return dtTmp;
        }
    }
    /// <summary>
    /// Возвращает признак "по исполнителю" для заданого тега
    /// </summary>
    /// <param name="sTag">Тег</param>
    /// <returns>Признак "по исполнителю"</returns>
    private decimal GetIspByTag(string sTag)
    {
        for (int i = 0; i < this._DOPREKV_AVAILABLE.Rows.Count; i++)
            if (Convert.ToString(this._DOPREKV_AVAILABLE.Rows[i]["TAG"]).ToUpper() == sTag.ToUpper())
                return Convert.ToDecimal(this._DOPREKV_AVAILABLE.Rows[i]["BYISP"]);

        return 0;
    }
    /// <summary>
    /// Дополнительные реквизиты удаленные
    /// </summary>
    private ArrayList _DOPREKV_DELETED = new ArrayList();
    /// <summary>
    /// Добавляет рядок в таблицу Дополнительные реквизиты
    /// </summary>
    /// <param name="row">Ряд</param>
    public void DOPREKV_ADDROW(string sTAG)
    {
        DataRow row = this._DOPREKV_FILLED.NewRow();
        
        string sNAME = "";
        string sTABNAME = "";
        int nBYISP = 0;

        for(int i=0; i<this._DOPREKV_AVAILABLE.Rows.Count; i++)
            if(sTAG == Convert.ToString(this._DOPREKV_AVAILABLE.Rows[i]["TAG"]))
            {
                sNAME = Convert.ToString(this._DOPREKV_AVAILABLE.Rows[i]["NAME"]);
                sTABNAME = Convert.ToString(this._DOPREKV_AVAILABLE.Rows[i]["TABNAME"]);
                nBYISP = Convert.ToInt32(this._DOPREKV_AVAILABLE.Rows[i]["BYISP"]);                
            }        
        
        row["STATUS"] = 2; // новый
        row["TAG"] = sTAG;
        row["NAME"] = sNAME;
        row["TABNAME"] = sTABNAME;
        row["VAL"] = "";
        row["BYISP"] = nBYISP;

        this._DOPREKV_FILLED.Rows.Add(row);
    }
    /// <summary>
    /// Удаляет рядок из таблицы Дополнительные реквизиты
    /// </summary>
    /// <param name="nId">Модификация рядка</param>
    public void DOPREKV_DELROW(string sTAG)
    {
        int idx = -1;
        for (int i = 0; i < _DOPREKV_FILLED.Rows.Count; i++)
            if (_DOPREKV_FILLED.Rows[i]["TAG"].ToString() == sTAG)
                idx = i;

        if (idx != -1)
        {
            _DOPREKV_DELETED.Add(sTAG);
            _DOPREKV_FILLED.Rows.RemoveAt(idx);
        }
    }
    /// <summary>
    /// Модификация рядка
    /// </summary>
    /// <param name="nId">Идентификатор рядка</param>
    /// <param name="row">Ряд</param>
    public void DOPREKV_MODROW(string sTAG, string sVAL)
    {
        int idx = -1;
        for (int i = 0; i < this._DOPREKV_FILLED.Rows.Count; i++)
            if (this._DOPREKV_FILLED.Rows[i]["TAG"].ToString() == sTAG)
                idx = i;

        if (idx != -1)
        {
            this._DOPREKV_FILLED.Rows[idx]["VAL"] = sVAL;
            this._DOPREKV_FILLED.Rows[idx]["STATUS"] = "1"; // модифицированый
        }
    }

    /// <summary>
    /// Довереные лица заполненые
    /// </summary>
    private DataTable _DovLica_FILLED = new DataTable();
    /// <summary>
    /// Довереные лица заполненые
    /// </summary>
    public DataTable DovLica_FILLED
    {
        get
        {
            if (this._DovLica_FILLED.Rows.Count == 0)
            {
                DataTable tmp = this._DovLica_FILLED.Copy();
                tmp.Rows.Add(tmp.NewRow());
                tmp.Rows[0]["ID"] = "-1"; // пустой рядок с рапретом на редактирование

                return tmp;
            }
            else
            {
                return this._DovLica_FILLED;
            }
        }
    }
    /// <summary>
    /// Довереные лица удаленные
    /// </summary>
    private ArrayList _DovLica_DELETED = new ArrayList();
    /// <summary>
    /// Добавляет рядок в таблицу Довереные лица
    /// </summary>
    /// <param name="row">Ряд</param>
    public void DovLica_ADDROW()
    {
        decimal nMaxId = 0;
        for (int i = 0; i < this._DovLica_FILLED.Rows.Count; i++)
            if (Convert.ToDecimal(this._DovLica_FILLED.Rows[i]["ID"]) > nMaxId)
                nMaxId = Convert.ToDecimal(this._DovLica_FILLED.Rows[i]["ID"]);

        DataRow row = this._DovLica_FILLED.NewRow();
        row["STATUS"] = "2";
        row["ID"] = nMaxId + 1;
        row["BDATE"] = DateTime.MinValue;
        row["EDATE"] = DateTime.MinValue;
        row["TRUST_REGDAT"] = DateTime.MinValue;
        row["DOC_DATE"] = DateTime.MinValue;
        row["BIRTHDAY"] = DateTime.MinValue;

        this._DovLica_FILLED.Rows.Add(row);
    }
    /// <summary>
    /// Удаляет рядок из таблицы Довереные лица
    /// </summary>
    /// <param name="nID">Номер рядка</param>
    public void DovLica_DELROW(decimal nID)
    {
        int idx = -1;
        for (int i = 0; i < _DovLica_FILLED.Rows.Count; i++)
            if (_DovLica_FILLED.Rows[i]["ID"].ToString() == nID.ToString())
                idx = i;

        if (idx != -1)
        {
            _DovLica_DELETED.Add(nID);
            _DovLica_FILLED.Rows.RemoveAt(idx);
        }
    }
    /// <summary>
    /// Модификация рядка
    /// </summary>
    /// <param name="nID">Идентификатор рядка</param>
    /// <param name="row">Ряд</param>
    public void DovLica_MODROW(decimal nID, object[] row)
    {
        // DOC_TYPE
        if (Convert.ToDecimal(row[11]) == -10) throw new ClientRegisterException("Не заполнен реквизит Вид док. дов. лица", string.Empty);
        // TYPE_ID
        if (Convert.ToDecimal(row[18]) == -10) throw new ClientRegisterException("Не заполнен реквизит Тип Дов. Лиц.", string.Empty);
        // DOCUMENT_TYPE_ID
        if (Convert.ToDecimal(row[19]) == -10) throw new ClientRegisterException("Не заполнен реквизит Тип Док.", string.Empty);
        // SEX
        if (Convert.ToDecimal(row[24]) == -10) throw new ClientRegisterException("Не заполнен реквизит Пол", string.Empty);
        // SIGN_PRIVS
        if (Convert.ToDecimal(row[26]) == -10) throw new ClientRegisterException("Не заполнен реквизит Право подп.", string.Empty);
        
        int idx = -1;
        for (int i = 0; i < this._DovLica_FILLED.Rows.Count; i++)
            if (this._DovLica_FILLED.Rows[i]["ID"].ToString() == nID.ToString())
                idx = i;

        if (idx != -1)
        {
            this._DovLica_FILLED.Rows[idx]["STATUS"] = "1"; // модифицированый
            for (int i = 0; i < row.Length; i++) this._DovLica_FILLED.Rows[idx][i] = row[i];
        }
    }
    /// <summary>
    /// Удостоверения физических лиц
    /// </summary>
    private ListItemCollection _DovLica_PASSP_List = new ListItemCollection();
    /// <summary>
    /// Удостоверения физических лиц
    /// </summary>
    public ListItemCollection DovLica_PASSP_List
    {
        get
        {
            if (this._DovLica_PASSP_List.Count == 0)
            {
                if (con.State != ConnectionState.Open) con.Open();
                try
                {
                    com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
                    com.ExecuteNonQuery();

                    com.Parameters.Clear();
                    com.CommandText = "select PASSP, NAME from PASSP order by PASSP";
                    
                    rdr = com.ExecuteReader();
                    while (rdr.Read()) this._DovLica_PASSP_List.Add(new ListItem(rdr.GetString(1), rdr.GetInt32(0).ToString()));
                    rdr.Close();
                    rdr.Dispose();
                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
                this._DovLica_PASSP_List.Insert(0, new ListItem("Пусто", "-10"));
            }

            return this._DovLica_PASSP_List;
        }
    }
    /// <summary>
    /// Наименование удостоверения физического лица по заданому идентификатору
    /// </summary>
    /// <param name="sPASSP">Идентификатор</param>
    /// <returns>Наименование</returns>
    public string DovLica_PASSP_ItemName(string sPASSP)
    {
        for (int i = 0; i < this.DovLica_PASSP_List.Count; i++)
            if (this.DovLica_PASSP_List[i].Value == sPASSP)
                return this.DovLica_PASSP_List[i].Text;

        return string.Empty;
    }
    /// <summary>
    /// Типы довереных лиц
    /// </summary>
    private ListItemCollection _DovLica_TYPE_ID_List = new ListItemCollection();
    /// <summary>
    /// Типы довереных лиц
    /// </summary>
    public ListItemCollection DovLica_TYPE_ID_List
    {
        get
        {
            if (this._DovLica_TYPE_ID_List.Count == 0)
            {
                if (con.State != ConnectionState.Open) con.Open();
                try
                {
                    com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
                    com.ExecuteNonQuery();

                    com.Parameters.Clear();
                    com.CommandText = "select ID, NAME from TRUSTEE_TYPE order by ID";
                    
                    rdr = com.ExecuteReader();
                    while (rdr.Read()) this._DovLica_TYPE_ID_List.Add(new ListItem(rdr.GetString(1), rdr.GetDecimal(0).ToString()));
                    rdr.Close();
                    rdr.Dispose();
                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
                this._DovLica_TYPE_ID_List.Insert(0, new ListItem("Пусто", "-10"));
            }

            return this._DovLica_TYPE_ID_List;
        }
    }
    /// <summary>
    /// Тип довереного лица по заданому идентификатору
    /// </summary>
    /// <param name="sTYPE_ID">Идентификатор</param>
    /// <returns>Наименование</returns>
    public string DovLica_TYPE_ID_ItemName(string sTYPE_ID)
    {
        for (int i = 0; i < this.DovLica_TYPE_ID_List.Count; i++)
            if (this.DovLica_TYPE_ID_List[i].Value == sTYPE_ID)
                return this.DovLica_TYPE_ID_List[i].Text;

        return string.Empty;
    }
    /// <summary>
    /// Тип документа
    /// </summary>
    private ListItemCollection _DovLica_DOCUMENT_TYPE_ID_List = new ListItemCollection();
    /// <summary>
    /// Тип документа
    /// </summary>
    public ListItemCollection DovLica_DOCUMENT_TYPE_ID_List
    {
        get
        {
            if (this._DovLica_DOCUMENT_TYPE_ID_List.Count == 0)
            {
                if (con.State != ConnectionState.Open) con.Open();
                try
                {
                    com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
                    com.ExecuteNonQuery();

                    com.Parameters.Clear();
                    com.CommandText = "select ID, NAME from TRUSTEE_DOCUMENT_TYPE order by ID";

                    rdr = com.ExecuteReader();
                    while (rdr.Read()) this._DovLica_DOCUMENT_TYPE_ID_List.Add(new ListItem(rdr.GetString(1), rdr.GetDecimal(0).ToString()));
                    rdr.Close();
                    rdr.Dispose();
                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
                this._DovLica_DOCUMENT_TYPE_ID_List.Insert(0, new ListItem("Пусто", "-10"));
            }

            return this._DovLica_DOCUMENT_TYPE_ID_List;
        }
    }
    /// <summary>
    /// Тип документа по заданому идентификатору
    /// </summary>
    /// <param name="sDOCUMENT_TYPE_ID">Идентификатор</param>
    /// <returns>Наименование</returns>
    public string DovLica_DOCUMENT_TYPE_ID_ItemName(string sDOCUMENT_TYPE_ID)
    {
        for (int i = 0; i < this.DovLica_DOCUMENT_TYPE_ID_List.Count; i++)
            if (this.DovLica_DOCUMENT_TYPE_ID_List[i].Value == sDOCUMENT_TYPE_ID)
                return this.DovLica_DOCUMENT_TYPE_ID_List[i].Text;

        return string.Empty;
    }
    /// <summary>
    /// Пол
    /// </summary>
    private ListItemCollection _DovLica_SEX_ID_List = new ListItemCollection();
    /// <summary>
    /// Пол
    /// </summary>
    public ListItemCollection DovLica_SEX_ID_List
    {
        get
        {
            if (this._DovLica_SEX_ID_List.Count == 0)
            {
                if (con.State != ConnectionState.Open) con.Open();
                try
                {
                    com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
                    com.ExecuteNonQuery();

                    com.Parameters.Clear();
                    com.CommandText = "select ID, NAME from SEX order by ID";

                    rdr = com.ExecuteReader();
                    while (rdr.Read()) this._DovLica_SEX_ID_List.Add(new ListItem(rdr.GetString(1), rdr.GetString(0)));
                    rdr.Close();
                    rdr.Dispose();
                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
                this._DovLica_SEX_ID_List.Insert(0, new ListItem("Пусто", "-10"));
            }

            return this._DovLica_SEX_ID_List;
        }
    }
    /// <summary>
    /// Пол по заданому идентификатору
    /// </summary>
    /// <param name="sSEX_ID">Идентификатор</param>
    /// <returns>Наименование</returns>
    public string DovLica_SEX_ID_ItemName(string sSEX_ID)
    {
        for (int i = 0; i < this.DovLica_SEX_ID_List.Count; i++)
            if (this.DovLica_SEX_ID_List[i].Value == sSEX_ID)
                return this.DovLica_SEX_ID_List[i].Text;

        return string.Empty;
    }
    /// <summary>
    /// Право подписи
    /// </summary>
    private ListItemCollection _DovLica_SIGN_PRIVS_List = new ListItemCollection();
    /// <summary>
    /// Право подписи
    /// </summary>
    public ListItemCollection DovLica_SIGN_PRIVS_List
    {
        get
        {
            if (this._DovLica_SIGN_PRIVS_List.Count == 0)
            {
                this._DovLica_SIGN_PRIVS_List.Add(new ListItem("Нет", "0"));
                this._DovLica_SIGN_PRIVS_List.Add(new ListItem("Да", "1"));

                this._DovLica_SIGN_PRIVS_List.Insert(0, new ListItem("Пусто", "-10"));
            }

            return this._DovLica_SIGN_PRIVS_List;
        }
    }
    /// <summary>
    /// Право подписи по заданому идентификатору
    /// </summary>
    /// <param name="sSIGN_PRIVS">Идентификатор</param>
    /// <returns>Наименование</returns>
    public string DovLica_SIGN_PRIVS_ItemName(string sSIGN_PRIVS)
    {
        for (int i = 0; i < this.DovLica_SIGN_PRIVS_List.Count; i++)
            if (this.DovLica_SIGN_PRIVS_List[i].Value == sSIGN_PRIVS)
                return this.DovLica_SIGN_PRIVS_List[i].Text;

        return string.Empty;
    }
    # endregion
    //=========================================================
    # region Вычитка данных о клиенте из базы
    private void ReadClient()
    {
        ReadClientCustomer();
        ReadClientAdress();
        switch (this.CUSTTYPE)
        {
            case 1:
                // банк
                ReadClientRekvBank();
                break;
            case 2:
                // юр лицо
                ReadClientRekvCorp();
                break;
            case 3:
                // физ лицо
                ReadClientRekvPerson();
                break;
        }

        ReadRnkRekv();
        ReadDopRekv();
        ReadDovLica();
    }
    private void ReadClientCustomer()
    {
        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.Parameters.Clear();
            com.Parameters.Add("pRnk", OracleDbType.Decimal, _RNK, ParameterDirection.Input);
            com.CommandText = "select * from CUSTOMER where RNK = :pRnk";

            dt.Rows.Clear();
            adp.Fill(dt);
            DataRow row = dt.Rows[0];

            // Тип клиента 1 - bank, 2 - corp, 3 - person
            this._CUSTTYPE = Convert.ToInt32(row["CUSTTYPE"]);

            // Тип гос реестра 1 - ЄДР, 2 - ДРФ, 3 - тимчас
            if (row["TGR"] == DBNull.Value) this._TGR = (int)GetDB_TGR_Default().First;
            else this._TGR = Convert.ToInt32(row["TGR"]);

            // Код инсайдера
            if (row["PRINSIDER"] == DBNull.Value) this._PRINSIDER = (decimal)GetDB_PRINSIDER_Default().First;
            else this._PRINSIDER = Convert.ToInt32(row["PRINSIDER"]);

            // Страна клиента
            if (row["COUNTRY"] == DBNull.Value) this._COUNTRY = (int)GetDB_COUNTRY_Default().First;
            else this._COUNTRY = Convert.ToInt32(row["COUNTRY"]);

            // Краткое Наименование контрагента
            this._NMKV = Convert.ToString(row["NMKV"]);

            // Наименование
            this._NMKK = Convert.ToString(row["NMKK"]);

            // Полное Наименование контрагента
            this.NMK = Convert.ToString(row["NMK"]);

            // Характеристика
            if (row["CODCAGENT"] == DBNull.Value) this._CODCAGENT = (int)GetDB_CODCAGENT_Default().First;
            else this._CODCAGENT = Convert.ToInt32(row["CODCAGENT"]);

            // Идентификационный код клиента
            this._OKPO = Convert.ToString(row["OKPO"]);

            // Эл.код
            this._SAB = Convert.ToString(row["SAB"]);
            
            // определяем заполнять или нет "Реквизиты налогоплательщика"
            this.bFillRekvNalogoplat = false;

            // Код обл.НИ
            if (row["C_REG"] == DBNull.Value) this._C_REG = (int)GetDB_C_REG_Default().First;
            else            
            {
                this.bFillRekvNalogoplat = true;
                this._C_REG = Convert.ToInt32(row["C_REG"]);
            }

            // Код район.НИ
            if (row["C_DST"] == DBNull.Value) this._C_DST = (int)GetDB_C_DST_Default().First;
            else
            {
                this.bFillRekvNalogoplat = true;
                this._C_DST = Convert.ToInt32(row["C_DST"]);
            }

            // Рег. номер в НИ
            if (row["RGTAX"] == DBNull.Value) this._RGTAX = string.Empty;
            else
            {
                this.bFillRekvNalogoplat = true;
                this._RGTAX = Convert.ToString(row["RGTAX"]);
            }             

            // Дата рег. в НИ
            if (row["DATET"] == DBNull.Value) this._DATET = DateTime.MinValue;
            else
            {
                this.bFillRekvNalogoplat = true;
                this._DATET = Convert.ToDateTime(row["DATET"]);
            }

            // Админ.орган
            if (row["ADM"] == DBNull.Value) this._ADM = string.Empty;
            else
            {
                this.bFillRekvNalogoplat = true;
                this._ADM = Convert.ToString(row["ADM"]);
            }

            // Дата рег. в Адм.
            if (row["DATEA"] == DBNull.Value) this._DATEA = DateTime.MinValue;
            else
            {
                this.bFillRekvNalogoplat = true;
                this._DATEA = Convert.ToDateTime(row["DATEA"]);
            }

            // Налоговый код (К050)
            if (row["TAXF"] == DBNull.Value) this._TAXF = string.Empty;
            else
            {
                this.bFillRekvNalogoplat = true;
                this._TAXF = Convert.ToString(row["TAXF"]);
            }

            // Формат выписки
            this._STMT = (row["STMT"] == DBNull.Value) ? (0) : (Convert.ToInt32(row["STMT"]));

            // Дата открытия
            this._DATE_ON = (row["DATE_ON"] == DBNull.Value) ? (DateTime.MinValue) : (Convert.ToDateTime(row["DATE_ON"]));

            // Дата закрытия
            this._DATE_OFF = (row["DATE_OFF"] == DBNull.Value) ? (DateTime.MinValue) : (Convert.ToDateTime(row["DATE_OFF"]));

            // Комментарий
            this._NOTES = Convert.ToString(row["NOTES"]);

            // Комментарий службы безопастности
            this._NOTESEC = Convert.ToString(row["NOTESEC"]);

            // Категория риска
            if (row["CRISK"] != DBNull.Value) this._CRISK = Convert.ToInt32(row["CRISK"]);

            // Пинкод (неисп.)
            this._PINCODE = Convert.ToString(row["PINCODE"]);

            // № дог
            this._ND = Convert.ToString(row["ND"]);

            // Регистрационный № холдинга
            if (row["RNKP"] != DBNull.Value) this._RNKP = Convert.ToDecimal(row["RNKP"]);

            // определяем заполнять или нет "Экономические нормативы"
            this.bFillEconomNorm = false;

            // Код сектора экономики
            if (row["ISE"] == DBNull.Value) this._ISE = string.Empty;
            else
            {
                this.bFillEconomNorm = true;
                this._ISE = Convert.ToString(row["ISE"]);
            }

            // Форма собственности
            if (row["FS"] == DBNull.Value) this._FS = string.Empty;
            else
            {
                this.bFillEconomNorm = true;
                this._FS = Convert.ToString(row["FS"]);
            }

            // Отрасли экономики
            if (row["OE"] == DBNull.Value) this._OE = string.Empty;
            else
            {
                this.bFillEconomNorm = true;
                this._OE = Convert.ToString(row["OE"]);
            }

            // Вид экономичческой деятельности
            if (row["VED"] == DBNull.Value) this._VED = string.Empty;
            else
            {
                this.bFillEconomNorm = true;
                this._VED = Convert.ToString(row["VED"]);
            }

            // Код отрасли экономики
            if (row["SED"] == DBNull.Value) this._SED = string.Empty;
            else
            {
                this.bFillEconomNorm = true;
                this._SED = Convert.ToString(row["SED"]);
            }

            // Лимит
            if (row["LIM"] != DBNull.Value) this._LIM = Convert.ToDecimal(row["LIM"]);

            // Принадлежность к малому бизнесу
            this._MB = Convert.ToString(row["MB"]);

            // Рег.номер в Администрации
            this._RGADM = Convert.ToString(row["RGADM"]);

            // Признак НЕклиента банка (1)
            this._BC = (row["BC"] == DBNull.Value) ? (0) : (Convert.ToInt32(row["BC"]));

            // Код отделенния
            this._TOBO = Convert.ToString(row["TOBO"]);

            // Менеджер клиента (ответ. исполнитель)
            if (row["ISP"] != DBNull.Value) this._ISP = Convert.ToInt32(row["ISP"]);

            // Код филиала
            this._KF = Convert.ToString(row["KF"]);

            // № в реестре плательщиков ПДВ
            this._NOMPDV = Convert.ToString(row["NOMPDV"]);
        }
        finally
        {
            con.Close();
        }
    }
    private void ReadClientAdress()
    {
        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.Parameters.Clear();
            com.Parameters.Add("pRnk", OracleDbType.Decimal, _RNK, ParameterDirection.Input);
            com.CommandText = "select '0' as STATUS, RNK, TYPE_ID, COUNTRY, ZIP, DOMAIN, REGION, LOCALITY, ADDRESS, TERRITORY_ID from CUSTOMER_ADDRESS where RNK = :pRnk order by TYPE_ID";

            dt.Rows.Clear();
            adp.Fill(this._ADR);
        }
        finally
        {
            con.Close();
        }
    }
    private void ReadClientRekvBank()
    {
        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.Parameters.Clear();
            com.Parameters.Add("pRnk", OracleDbType.Decimal, _RNK, ParameterDirection.Input);
            com.CommandText = "select * from CUSTBANK where RNK = :pRnk";

            dt.Rows.Clear();
            adp.Fill(dt);
            DataRow row = dt.Rows[0];

            // Код МФО банка
            this._MFO = Convert.ToString(row["MFO"]);
            // Альтернативный BIC-код
            this._ALT_BIC = Convert.ToString(row["ALT_BIC"]);
            // BIC-код банка
            this._BIC = Convert.ToString(row["ALT_BIC"]);
            // Рейтинг
            this._RATING = Convert.ToString(row["RATING"]);
            // Код банка
            if (row["KOD_B"] != DBNull.Value) this._KOD_B = Convert.ToDecimal(row["KOD_B"]);
            // ФИО руководителя
            this._RUK = Convert.ToString(row["RUK"]);
            // Тел. руководителя
            this._TELR = Convert.ToString(row["TELR"]);
            // ФИО гл. бухгалтера
            this._BUH = Convert.ToString(row["BUH"]);
            // Тел .гл. бухгалтера
            this._TELB = Convert.ToString(row["TELB"]);
        }
        finally
        {
            con.Close();
        }
    }
    private void ReadClientRekvCorp()
    {
        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.Parameters.Clear();
            com.Parameters.Add("pRnk", OracleDbType.Decimal, _RNK, ParameterDirection.Input);
            com.CommandText = "select * from CORPS where RNK = :pRnk";

            dt.Rows.Clear();
            adp.Fill(dt);
            DataRow row = dt.Rows[0];

            // Наименование по Уставу (полное)
            _NMKU = Convert.ToString(row["NMKU"]);
            // ФИО руководителя
            _RUK = Convert.ToString(row["RUK"]);
            // Тел. руководителя
            _TELR = Convert.ToString(row["TELR"]);
            // ФИО гл. бухгалтера
            _BUH = Convert.ToString(row["BUH"]);
            // Тел. гл. бухгалтера
            _TELB = Convert.ToString(row["TELB"]);
            // Факс
            _TEL_FAX = Convert.ToString(row["TEL_FAX"]);
            // Адрес электронной почты
            _E_MAIL = Convert.ToString(row["E_MAIL"]);
            // Идентификатор графического представления печати юридического лица
            _SEAL_ID = (row["SEAL_ID"] == DBNull.Value) ? (0) : (Convert.ToDecimal(row["SEAL_ID"]));

            // Текушие счета клиента
            com.Parameters.Clear();
            com.Parameters.Add("pRnk", OracleDbType.Decimal, _RNK, ParameterDirection.Input);
            com.CommandText = "SELECT '0' as STATUS, ID, MFO, NLS, KV, COMMENTS FROM CORPS_ACC where RNK = :pRnk";

            dt.Rows.Clear();
            adp.Fill(this._CORPS_ACC_FILLED);

            // Адреса наполняються в ReadClient() функцией ReadClientAdress()
        }
        finally
        {
            con.Close();
        }
    }
    private void ReadClientRekvPerson()
    {
        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.Parameters.Clear();
            com.Parameters.Add("pRnk", OracleDbType.Decimal, _RNK, ParameterDirection.Input);
            com.CommandText = "select * from PERSON where RNK = :pRnk";

            dt.Rows.Clear();
            adp.Fill(dt);
            DataRow row = dt.Rows[0];

            // Определяем заполнять или нет Персональные реквизиты
            this.bFillClientRekv = false;

            // Пол
            if (row["SEX"] == DBNull.Value) _SEX = string.Empty;
            else
            {
                this.bFillClientRekv = true;
                _SEX = Convert.ToString(row["SEX"]);
            }

            // Тип удостоверяющего документа
            if (row["PASSP"] == DBNull.Value) _PASSP = int.MinValue;
            else
            {
                this.bFillClientRekv = true;
                _PASSP = Convert.ToInt32(row["PASSP"]);
            }

            // Серия док
            if (row["SER"] == DBNull.Value) _SER = string.Empty;
            else
            {
                this.bFillClientRekv = true;
                _SER = Convert.ToString(row["SER"]);
            }

            // № док
            if (row["NUMDOC"] == DBNull.Value) _NUMDOC = string.Empty;
            else
            {
                this.bFillClientRekv = true;
                _NUMDOC = Convert.ToString(row["NUMDOC"]);
            }

            // Даты выдачи док
            if (row["PDATE"] == DBNull.Value) _PDATE = DateTime.MinValue;
            else
            {
                this.bFillClientRekv = true;
                _PDATE = Convert.ToDateTime(row["PDATE"]);
            }

            // Организация, выдавшая удостоверяющий документ
            if (row["ORGAN"] == DBNull.Value) _ORGAN = string.Empty;
            else
            {
                this.bFillClientRekv = true;
                _ORGAN = Convert.ToString(row["ORGAN"]);
            }

            // Дата рождения
            if (row["BDAY"] == DBNull.Value) _BDAY = DateTime.MinValue;
            else
            {
                this.bFillClientRekv = true;
                _BDAY = Convert.ToDateTime(row["BDAY"]);
            }

            // Место рождения
            if (row["BPLACE"] == DBNull.Value) _BPLACE = string.Empty;
            else
            {
                this.bFillClientRekv = true;
                _BPLACE = Convert.ToString(row["BPLACE"]);
            }

            // Домашний телефон
            if (row["TELD"] == DBNull.Value) PersonalRekvPerson_TELD = string.Empty;
            else
            {
                this.bFillClientRekv = true;
                PersonalRekvPerson_TELD = Convert.ToString(row["TELD"]);
            }

            // Рабочий телефон
            if (row["TELW"] == DBNull.Value) PersonalRekvPerson_TELW = string.Empty;
            else
            {
                this.bFillClientRekv = true;
                PersonalRekvPerson_TELW = Convert.ToString(row["TELW"]);
            }
        }
        finally
        {
            con.Close();
        }
    }
    private void ReadRnkRekv()
    {
        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.Parameters.Clear();
            com.Parameters.Add("pRnk", OracleDbType.Decimal, _RNK, ParameterDirection.Input);
            com.CommandText = "select * from RNK_REKV where RNK = :prnk";

            dt.Rows.Clear();
            adp.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];

                // Лимит кассы
                if (row["LIM_KASS"] == DBNull.Value) this._LIM_KASS = decimal.MinValue;
                else this._LIM_KASS = Convert.ToDecimal(row["LIM_KASS"]);
                // Тип удостоверяющего документа
                this._NOM_DOG = Convert.ToString(row["NOM_DOG"]);
            }
        }
        finally
        {
            con.Close();
        }
    }
    private void ReadDopRekv()
    {
        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.Parameters.Clear();
            com.CommandText = @"select OTD from OTD_USER where USERID = getcurrentuserid and PR = 1 and ROWNUM = 1 
                                    union
                                select OTD from OTD_USER where USERID = getcurrentuserid and rownum = 1 and not exists (select OTD
                                                                                                                        from OTD_USER
                                                                                                                        where USERID = getcurrentuserid and PR = 1 and ROWNUM = 1)";
            decimal nOTD = Convert.ToDecimal(com.ExecuteScalar());

            string sCustTypeLetter = "F";
            switch (_CUSTTYPE)
            {
                case 1: sCustTypeLetter = "B"; break;
                case 2: sCustTypeLetter = "U"; break;
                case 3: sCustTypeLetter = "F"; break;
            }

            com.Parameters.Clear();
            com.Parameters.Add("pOtd", OracleDbType.Decimal, nOTD, ParameterDirection.Input);
            com.Parameters.Add("pRnk", OracleDbType.Decimal, _RNK, ParameterDirection.Input);
            com.CommandText = @"select '0' as STATUS, C.TAG AS TAG, C.NAME as NAME, C.TABNAME as TABNAME, W.VALUE AS VAL, decode(BYISP, 1, :nOTD, 0) as BYISP 
                                from (select * from CUSTOMER_FIELD where " + sCustTypeLetter + @" = 1) C, 
                                     (select * from CUSTOMERW where RNK = :pRnk and (ISP = 0 or (ISP in (select OTD from OTD_USER where USERID = getcurrentuserid )))) W  
                                where C.TAG = W.TAG(+) and W.VALUE is not null 
                                order by NAME";
            dt.Rows.Clear();
            adp.Fill(_DOPREKV_FILLED);

            com.Parameters.Clear();
            com.Parameters.Add("pOtd", OracleDbType.Decimal, nOTD, ParameterDirection.Input);
            com.CommandText = @"select TAG, NAME, TABNAME, decode(BYISP, 1, :nOTD, 0) as BYISP, OPT
                                from CUSTOMER_FIELD 
                                where " + sCustTypeLetter + @" = 1 
                                order by NAME";
            dt.Rows.Clear();
            adp.Fill(_DOPREKV_AVAILABLE);
        }
        finally
        {
            con.Close();
        }
    }
    private void ReadDovLica()
    {
        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.Parameters.Clear();
            com.Parameters.Add("pRnk", OracleDbType.Decimal, _RNK, ParameterDirection.Input);
            com.CommandText = @"select '0' as STATUS, ID, FIO, nvl(BDATE, to_date('01/01/0001','dd/mm/yyyy')) as BDATE, 
                                       nvl(EDATE, to_date('01/01/0001','dd/mm/yyyy')) as EDATE, DOCUMENT, 
                                       NOTARY_NAME, NOTARY_REGION, TRUST_REGNUM, nvl(TRUST_REGDAT, to_date('01/01/0001','dd/mm/yyyy')) as TRUST_REGDAT, 
                                       OKPO, DOC_TYPE, DOC_SERIAL, DOC_NUMBER, nvl(DOC_DATE, to_date('01/01/0001','dd/mm/yyyy')) as DOC_DATE, 
                                       DOC_ISSUER, nvl(BIRTHDAY, to_date('01/01/0001','dd/mm/yyyy')) as BIRTHDAY, BIRTHPLACE,
                                       TYPE_ID, DOCUMENT_TYPE_ID, POSITION, FIRST_NAME, MIDDLE_NAME, LAST_NAME, SEX as SEX_ID, 
                                       TEL, SIGN_PRIVS, NAME_R, SIGN_ID
								from TRUSTEE 
								where rnk = :pRnk";
            dt.Rows.Clear();
            adp.Fill(this._DovLica_FILLED);
        }
        finally
        {
            con.Close();
        }
    }
    # endregion
    //=========================================================
    # region Запись данных о клиенте в базу
    /// <summary>
    /// Возвращает значение переменной, заменяет минимальные значения на null
    /// </summary>
    private object GetParamVal(object par)
    {
        Type tParType = par.GetType();

        switch (tParType.Name)
        {
            case "DateTime" :
                DateTime oD = (DateTime)par;
                if (oD == DateTime.MinValue || oD == new DateTime(1,1,1)) return null;
                else return oD;

            case "String":
                string oS = (string)par;
                if (oS == string.Empty) return null;
                else return oS;

            case "Int32":
                int oI = (int)par;
                if (oI == int.MinValue) return null;
                else return oI;

            case "Decimal":
                decimal oDec = (decimal)par;
                if (oDec == decimal.MinValue) return null;
                else return oDec;
        }

        return null;
    }
    /// <summary>
    /// Запись данных в базу
    /// </summary>
    public void WriteClient()
    {
        // Валидация полей
        this.CheckObligatoryFields();

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            OracleTransaction tx = con.BeginTransaction();
            bool txCommited = false;
            
            try
            {
                WriteClientCustomer();
                WriteClientAdress();
                switch (this.CUSTTYPE)
                {
                    case 1:
                        // банк
                        WriteClientRekvBank();
                        break;
                    case 2:
                        // юр лицо
                        WriteClientRekvCorp();
                        break;
                    case 3:
                        // физ лицо
                        WriteClientRekvPerson();
                        break;
                }

                WriteRnkRekv();
                WriteDopRekv();
                WriteDovLica();
                
                tx.Commit();
                txCommited = true;
            }        
            finally
            {
                if (!txCommited) tx.Rollback();
            }

            DBLogger.Info("ClientRegister: Клиент успешно зарегистрирован/перерегестрирован. РНК : " + this._RNK.ToString());
        }
        finally
        {
            con.Close();
        }
    }
    private void WriteClientCustomer()
    {
        com.Parameters.Clear();
        com.Parameters.Add("pRnk_", OracleDbType.Decimal, GetParamVal(this._RNK), ParameterDirection.InputOutput);
        com.Parameters.Add("pCusttype_", OracleDbType.Int32, this._CUSTTYPE, ParameterDirection.Input);
        com.Parameters.Add("pNd_", OracleDbType.Varchar2, GetParamVal(this._ND), ParameterDirection.Input);
        com.Parameters.Add("pNmk_", OracleDbType.Varchar2, GetParamVal(this._NMK), ParameterDirection.Input);
        com.Parameters.Add("pNmkv_", OracleDbType.Varchar2, GetParamVal(this._NMKV), ParameterDirection.Input);
        com.Parameters.Add("pNmkk_", OracleDbType.Varchar2, GetParamVal(this._NMKK), ParameterDirection.Input);
        com.Parameters.Add("pAdr_", OracleDbType.Varchar2, GetParamVal(this.ADR_Short), ParameterDirection.Input);
        com.Parameters.Add("pCodcagent_", OracleDbType.Int32, GetParamVal(this._CODCAGENT), ParameterDirection.Input);
        com.Parameters.Add("pCountry_", OracleDbType.Int32, GetParamVal(this._COUNTRY), ParameterDirection.Input);
        com.Parameters.Add("pPrinsider_", OracleDbType.Decimal, GetParamVal(this._PRINSIDER), ParameterDirection.Input);
        com.Parameters.Add("pTgr_", OracleDbType.Int32, GetParamVal(this._TGR), ParameterDirection.Input);
        com.Parameters.Add("pOkpo_", OracleDbType.Varchar2, GetParamVal(this._OKPO), ParameterDirection.Input);
        com.Parameters.Add("pStmt_", OracleDbType.Int32, GetParamVal(this._STMT), ParameterDirection.Input);
        com.Parameters.Add("pSab_", OracleDbType.Varchar2, GetParamVal(this._SAB), ParameterDirection.Input);
        com.Parameters.Add("pDateOn_", OracleDbType.Date, GetParamVal(this._DATE_ON), ParameterDirection.Input);
        com.Parameters.Add("pTaxf_", OracleDbType.Varchar2, GetParamVal(this._TAXF), ParameterDirection.Input);
        com.Parameters.Add("pCReg_", OracleDbType.Int32, GetParamVal(this._C_REG), ParameterDirection.Input);
        com.Parameters.Add("pCDst_", OracleDbType.Int32, GetParamVal(this._C_DST), ParameterDirection.Input);
        com.Parameters.Add("pAdm_", OracleDbType.Varchar2, GetParamVal(this._ADM), ParameterDirection.Input);
        com.Parameters.Add("pRgTax_", OracleDbType.Varchar2, GetParamVal(this._RGTAX), ParameterDirection.Input);
        com.Parameters.Add("pRgAdm_", OracleDbType.Varchar2, GetParamVal(this._RGADM), ParameterDirection.Input);
        com.Parameters.Add("pDateT_", OracleDbType.Date, GetParamVal(this._DATET), ParameterDirection.Input);
        com.Parameters.Add("pDateA_", OracleDbType.Date, GetParamVal(this._DATEA), ParameterDirection.Input);
        com.Parameters.Add("pIse_", OracleDbType.Varchar2, GetParamVal(this._ISE), ParameterDirection.Input);
        com.Parameters.Add("pFs_", OracleDbType.Varchar2, GetParamVal(this._FS), ParameterDirection.Input);
        com.Parameters.Add("pOe_", OracleDbType.Varchar2, GetParamVal(this._OE), ParameterDirection.Input);
        com.Parameters.Add("pVed_", OracleDbType.Varchar2, GetParamVal(this._VED), ParameterDirection.Input);
        com.Parameters.Add("pSed_", OracleDbType.Varchar2, GetParamVal(this._SED), ParameterDirection.Input);
        com.Parameters.Add("pNotes_", OracleDbType.Varchar2, GetParamVal(this._NOTES), ParameterDirection.Input);
        com.Parameters.Add("pNotesec_", OracleDbType.Varchar2, GetParamVal(this._NOTESEC), ParameterDirection.Input);
        com.Parameters.Add("pCRisk_", OracleDbType.Decimal, GetParamVal(this._CRISK), ParameterDirection.Input);
        com.Parameters.Add("pPincode_", OracleDbType.Varchar2, GetParamVal(this._PINCODE), ParameterDirection.Input);
        com.Parameters.Add("pRnkP_", OracleDbType.Decimal, GetParamVal(this._RNKP), ParameterDirection.Input);
        com.Parameters.Add("pLim_", OracleDbType.Decimal, GetParamVal(this._LIM), ParameterDirection.Input);
        com.Parameters.Add("pNomPDV_", OracleDbType.Varchar2, GetParamVal(this._NOMPDV), ParameterDirection.Input);
        com.Parameters.Add("pMB_", OracleDbType.Varchar2, GetParamVal(this._MB), ParameterDirection.Input);
        com.Parameters.Add("pBC_", OracleDbType.Varchar2, GetParamVal(this._BC), ParameterDirection.Input);
        com.Parameters.Add("pTobo_", OracleDbType.Varchar2, GetParamVal(this._TOBO), ParameterDirection.Input);
        com.Parameters.Add("pIsp_", OracleDbType.Int32, GetParamVal(this._ISP), ParameterDirection.Input);

        com.CommandText = @"begin KL.setCustomerAttr(:pRnk_, :pCusttype_, :pNd_, :pNmk_, :pNmkv_, :pNmkk_, :pAdr_, :pCodcagent_, :pCountry_, :pPrinsider_, :pTgr_, :pOkpo_, :pStmt_, :pSab_, :pDateOn_, :pTaxf_, :pCReg_, :pCDst_, :pAdm_, :pRgTax_, :pRgAdm_, :pDateT_, :pDateA_, :pIse_, :pFs_, :pOe_, :pVed_, :pSed_, :pNotes_, :pNotesec_, :pCRisk_, :pPincode_, :pRnkP_, :pLim_, :pNomPDV_, :pMB_, :pBC_, :pTobo_, :pIsp_); end;";
        com.ExecuteNonQuery();

        this._RNK = ((OracleDecimal)com.Parameters["pRnk_"].Value).Value;
    }
    private void WriteClientAdress()
    {
        // удаляем удаленные
        for (int i = 0; i < this._CORPS_ADR_DELETED.Count; i++)
        {
            com.Parameters.Clear();
            com.Parameters.Add("pRnk_", OracleDbType.Decimal, this._RNK, ParameterDirection.Input);
            com.Parameters.Add("pTypeId_", OracleDbType.Decimal, Convert.ToDecimal(this._CORPS_ADR_DELETED[i]), ParameterDirection.Input);
            com.CommandText = "delete from CUSTOMER_ADDRESS where RNK = :pRnk_ and TYPE_ID = :pTypeId_";
            com.ExecuteNonQuery();
        }
        
        // удаляем обновленные
        for (int i = 0; i < this._ADR.Rows.Count; i++)
            if (this._ADR.Rows[i]["STATUS"].ToString() == "1")
            {
                com.Parameters.Clear();
                com.Parameters.Add("pRnk_", OracleDbType.Decimal, this._RNK, ParameterDirection.Input);
                com.Parameters.Add("pTypeId_", OracleDbType.Decimal, Convert.ToDecimal(this._ADR.Rows[i]["TYPE_ID"]), ParameterDirection.Input);
                com.CommandText = "delete from CUSTOMER_ADDRESS where RNK = :pRnk_ and TYPE_ID = :pTypeId_";
                com.ExecuteNonQuery();
            }
        
        
        // добавляем новые и обновленные записи
        for (int i = 0; i < this._ADR.Rows.Count; i++)
            if (this._ADR.Rows[i]["STATUS"].ToString() == "1" || this._ADR.Rows[i]["STATUS"].ToString() == "2")
            {
                com.Parameters.Clear();
                com.Parameters.Add("pRnk_", OracleDbType.Decimal, this._RNK, ParameterDirection.Input);
                com.Parameters.Add("pTypeId_", OracleDbType.Decimal, Convert.ToDecimal(this._ADR.Rows[i]["TYPE_ID"]), ParameterDirection.Input);
                com.Parameters.Add("pCountry_", OracleDbType.Decimal, GetParamVal(Convert.ToDecimal(this._ADR.Rows[i]["COUNTRY"])), ParameterDirection.Input);
                com.Parameters.Add("pZip_", OracleDbType.Varchar2, GetParamVal(this._ADR.Rows[i]["ZIP"].ToString()), ParameterDirection.Input);
                com.Parameters.Add("pDomain_", OracleDbType.Varchar2, GetParamVal(this._ADR.Rows[i]["DOMAIN"].ToString()), ParameterDirection.Input);
                com.Parameters.Add("pRegion_", OracleDbType.Varchar2, GetParamVal(this._ADR.Rows[i]["REGION"].ToString()), ParameterDirection.Input);
                com.Parameters.Add("pLocality_", OracleDbType.Varchar2, GetParamVal(this._ADR.Rows[i]["LOCALITY"].ToString()), ParameterDirection.Input);
                com.Parameters.Add("pAddress_", OracleDbType.Varchar2, GetParamVal(this._ADR.Rows[i]["ADDRESS"].ToString()), ParameterDirection.Input);
                com.Parameters.Add("pTerritoryId_", OracleDbType.Decimal, null/*GetParamVal(Convert.ToDecimal(this._ADR.Rows[i]["TERRITORY_ID"]))*/, ParameterDirection.Input);
                com.CommandText = "begin KL.setCustomerAddressByTerritory(:pRnk_, :pTypeId_, :pCountry_, :pZip_, :pDomain_, :pRegion_, :pLocality_, :pAddress_, :pTerritoryId_); end;";
                com.ExecuteNonQuery();
            }
    }
    private void WriteClientRekvBank()
    {
        com.Parameters.Clear();
        com.Parameters.Add("pRnk_", OracleDbType.Decimal, this._RNK, ParameterDirection.Input);
        com.Parameters.Add("pMfo_", OracleDbType.Varchar2, GetParamVal(this._MFO), ParameterDirection.Input);
        com.Parameters.Add("pBic_", OracleDbType.Varchar2, GetParamVal(this._BIC), ParameterDirection.Input);
        com.Parameters.Add("pBicAlt_", OracleDbType.Varchar2, GetParamVal(this._ALT_BIC), ParameterDirection.Input);
        com.Parameters.Add("pRating_", OracleDbType.Varchar2, GetParamVal(this._RATING), ParameterDirection.Input);
        com.Parameters.Add("pKod_b_", OracleDbType.Decimal, GetParamVal(this._KOD_B), ParameterDirection.Input);
        com.Parameters.Add("pRuk_", OracleDbType.Varchar2, GetParamVal(this.PersonalRekvBank_RUK), ParameterDirection.Input);
        com.Parameters.Add("pTelr_", OracleDbType.Varchar2, GetParamVal(this.PersonalRekvBank_TELR), ParameterDirection.Input);
        com.Parameters.Add("pBuh_", OracleDbType.Varchar2, GetParamVal(this.PersonalRekvBank_BUH), ParameterDirection.Input);
        com.Parameters.Add("pTelb_", OracleDbType.Varchar2, GetParamVal(this.PersonalRekvBank_TELB), ParameterDirection.Input);
        com.CommandText = "begin KL.setBankAttr(:pRnk_, :pMfo_, :pBic_, :pBicAlt_, :pRating_, :pKod_b_, :pRuk_, :Telr_, :pBuh_, :pTelb_); end;";
        com.ExecuteNonQuery();
    }
    private void WriteClientRekvCorp()
    {
        com.Parameters.Clear();
        com.Parameters.Add("pRnk_", OracleDbType.Decimal, this._RNK, ParameterDirection.Input);
        com.Parameters.Add("pNmku_", OracleDbType.Varchar2, GetParamVal(this._NMKU), ParameterDirection.Input);
        com.Parameters.Add("pRuk_", OracleDbType.Varchar2, GetParamVal(this.PersonalRekvCorp_RUK), ParameterDirection.Input);
        com.Parameters.Add("pTelR_", OracleDbType.Varchar2, GetParamVal(this.PersonalRekvCorp_TELR), ParameterDirection.Input);
        com.Parameters.Add("pBuh_", OracleDbType.Varchar2, GetParamVal(this.PersonalRekvCorp_BUH), ParameterDirection.Input);
        com.Parameters.Add("pTelB_", OracleDbType.Varchar2, GetParamVal(this.PersonalRekvBank_TELB), ParameterDirection.Input);
        com.Parameters.Add("pTelFax_", OracleDbType.Varchar2, GetParamVal(this._TEL_FAX), ParameterDirection.Input);
        com.Parameters.Add("pEMail_", OracleDbType.Varchar2, GetParamVal(this._E_MAIL), ParameterDirection.Input);
        com.Parameters.Add("pSealId_", OracleDbType.Varchar2, GetParamVal(this._SEAL_ID), ParameterDirection.Input);
        com.CommandText = "begin KL.setCorpAttr(:pRnk_, :pNmku_, :pRuk_, :pTelR_, :pBuh_, :pTelB_, :pTelFax_, :pEMail_, :pSealId_); end;";
        com.ExecuteNonQuery();

        // Текушие счета клиента
        // удаляем удаленные
        for (int i = 0; i < this._CORPS_ACC_DELETED.Count; i++)
        {
            com.Parameters.Clear();
            com.Parameters.Add("pId_", OracleDbType.Decimal, this._CORPS_ACC_DELETED[i], ParameterDirection.Input);
            com.CommandText = "begin KL.delCorpAcc(:pId_); end;";
            com.ExecuteNonQuery();
        }

        // удаляем обновленные
        for (int i = 0; i < this._CORPS_ACC_FILLED.Rows.Count; i++)
            if (this._CORPS_ACC_FILLED.Rows[i]["STATUS"].ToString() == "1")
            {
                com.Parameters.Clear();
                com.Parameters.Add("pId_", OracleDbType.Decimal, this._CORPS_ACC_FILLED.Rows[i]["ID"], ParameterDirection.Input);
                com.CommandText = "begin KL.delCorpAcc(:pId_); end;";
                com.ExecuteNonQuery();
            }
        
        // добавляем новые и обновленные записи
        for (int i = 0; i < this._CORPS_ACC_FILLED.Rows.Count; i++)
            if (this._CORPS_ACC_FILLED.Rows[i]["STATUS"].ToString() == "1" || this._CORPS_ACC_FILLED.Rows[i]["STATUS"].ToString() == "2")
            {
                com.Parameters.Clear();
                com.Parameters.Add("pRnk_", OracleDbType.Decimal, this._RNK, ParameterDirection.Input);
                com.Parameters.Add("pMfo_", OracleDbType.Varchar2, GetParamVal(this._CORPS_ACC_FILLED.Rows[i]["MFO"].ToString()), ParameterDirection.Input);
                com.Parameters.Add("pNls_", OracleDbType.Varchar2, GetParamVal(this._CORPS_ACC_FILLED.Rows[i]["NLS"].ToString()), ParameterDirection.Input);
                com.Parameters.Add("pKv_", OracleDbType.Decimal, GetParamVal(Convert.ToDecimal(this._CORPS_ACC_FILLED.Rows[i]["KV"])), ParameterDirection.Input);
                com.Parameters.Add("pComm_", OracleDbType.Varchar2, GetParamVal(this._CORPS_ACC_FILLED.Rows[i]["COMMENTS"].ToString()), ParameterDirection.Input);
                com.CommandText = "begin KL.setCorpAcc( :pRnk_, null, :pMfo_, :pNls_, :pKv_, :pComm_); end;";
                com.ExecuteNonQuery();
            }
    }
    private void WriteClientRekvPerson()
    {
        com.Parameters.Clear();
        com.Parameters.Add("pRnk_", OracleDbType.Decimal, this._RNK, ParameterDirection.Input);
        com.Parameters.Add("pSex_", OracleDbType.Varchar2, GetParamVal(this._SEX), ParameterDirection.Input);
        com.Parameters.Add("pPassp_", OracleDbType.Varchar2, GetParamVal(this._PASSP), ParameterDirection.Input);
        com.Parameters.Add("pSer_", OracleDbType.Varchar2, GetParamVal(this._SER), ParameterDirection.Input);
        com.Parameters.Add("pNumdoc_", OracleDbType.Varchar2, GetParamVal(this._NUMDOC), ParameterDirection.Input);
        com.Parameters.Add("pPDate_", OracleDbType.Date, GetParamVal(this._PDATE), ParameterDirection.Input);
        com.Parameters.Add("pOrgan_", OracleDbType.Varchar2, GetParamVal(this._ORGAN), ParameterDirection.Input);
        com.Parameters.Add("pBDay_", OracleDbType.Date, GetParamVal(this._BDAY), ParameterDirection.Input);
        com.Parameters.Add("pBPlace_", OracleDbType.Varchar2, GetParamVal(this._BPLACE), ParameterDirection.Input);
        com.Parameters.Add("pTelD_", OracleDbType.Varchar2, GetParamVal(this.PersonalRekvPerson_TELD), ParameterDirection.Input);
        com.Parameters.Add("pTelW_", OracleDbType.Varchar2, GetParamVal(this.PersonalRekvPerson_TELW), ParameterDirection.Input);
        com.CommandText = "begin KL.setPersonAttr(:pRnk_, :pSex_, :pPassp_, :pSer_, :pNumdoc_, :pPDate_, :pOrgan_, :pBDay_, :pBPlace_, :pTelD_, :pTelW_); end;";
        com.ExecuteNonQuery();
    }
    private void WriteRnkRekv()
    {
        com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
        com.ExecuteNonQuery();

        com.Parameters.Clear();
        com.Parameters.Add("pRnk_", OracleDbType.Decimal, this._RNK, ParameterDirection.Input);
        com.Parameters.Add("pLimKass_", OracleDbType.Decimal, GetParamVal(this._LIM_KASS), ParameterDirection.Input);
        com.Parameters.Add("pNomDog_", OracleDbType.Varchar2, GetParamVal(this._NOM_DOG), ParameterDirection.Input);
        com.CommandText = "begin KL.setCustomerRekv(:pRnk_, :pLimKass_, null, :pNomDog_); end;";
        com.ExecuteNonQuery();
    }
    private void WriteDopRekv()
    {
        // удаляем удаленные
        for (int i = 0; i < this._DOPREKV_DELETED.Count; i++)
        {
            com.Parameters.Clear();
            com.Parameters.Add("pRnk_", OracleDbType.Decimal, this._RNK, ParameterDirection.Input);
            com.Parameters.Add("pTag_", OracleDbType.Varchar2, this._DOPREKV_DELETED[i].ToString(), ParameterDirection.Input);
            com.Parameters.Add("pOtd_", OracleDbType.Decimal, this.GetIspByTag(this._DOPREKV_DELETED[i].ToString()), ParameterDirection.Input);
            com.CommandText = "delete from CUSTOMERW where RNK = :pRnk_ and TAG = :pTag_ and ISP = :pOtd_";
            com.ExecuteNonQuery();
        }

        // удаляем обновленные
        for (int i = 0; i < this._DOPREKV_FILLED.Rows.Count; i++)
            if (this._DOPREKV_FILLED.Rows[i]["STATUS"].ToString() == "1")
            {
                com.Parameters.Clear();
                com.Parameters.Add("pRnk_", OracleDbType.Decimal, this._RNK, ParameterDirection.Input);
                com.Parameters.Add("pTag_", OracleDbType.Varchar2, this._DOPREKV_FILLED.Rows[i]["TAG"].ToString(), ParameterDirection.Input);
                com.Parameters.Add("pOtd_", OracleDbType.Decimal, this.GetIspByTag(this._DOPREKV_FILLED.Rows[i]["BYISP"].ToString()), ParameterDirection.Input);
                com.CommandText = "delete from CUSTOMERW where RNK = :pRnk_ and TAG = :pTag_ and ISP = :pOtd_";
                com.ExecuteNonQuery();
            }

        // добавляем новые и обновленные записи
        for (int i = 0; i < this._DOPREKV_FILLED.Rows.Count; i++)
            if (this._DOPREKV_FILLED.Rows[i]["STATUS"].ToString() == "1" || this._DOPREKV_FILLED.Rows[i]["STATUS"].ToString() == "2")
            {
                com.Parameters.Clear();
                com.Parameters.Add("pRnk_", OracleDbType.Decimal, this._RNK, ParameterDirection.Input);
                com.Parameters.Add("pTag_", OracleDbType.Varchar2, this._DOPREKV_FILLED.Rows[i]["TAG"].ToString(), ParameterDirection.Input);
                com.Parameters.Add("pVal_", OracleDbType.Varchar2, this._DOPREKV_FILLED.Rows[i]["VAL"].ToString(), ParameterDirection.Input);
                com.Parameters.Add("pOtd_", OracleDbType.Decimal, this.GetIspByTag(this._DOPREKV_FILLED.Rows[i]["BYISP"].ToString()), ParameterDirection.Input);
                com.CommandText = "begin KL.setCustomerElement( :pRnk_, :pTag_, :pVal_, :pOtd_); end;";
                com.ExecuteNonQuery();
            }
    }
    private void WriteDovLica()
    {
        // удаляем удаленные
        for (int i = 0; i < this._DovLica_DELETED.Count; i++)
        {
            com.Parameters.Clear();
            com.Parameters.Add("pId_", OracleDbType.Decimal, Convert.ToDecimal(this._DovLica_DELETED[i]), ParameterDirection.Input);
            com.CommandText = "begin KL.delCustomerTrustee(:pId_); end;";
            com.ExecuteNonQuery();
        }

        // удаляем обновленные
        for (int i = 0; i < this._DovLica_FILLED.Rows.Count; i++)
            if (this._DovLica_FILLED.Rows[i]["STATUS"].ToString() == "1")
            {
                com.Parameters.Clear();
                com.Parameters.Add("pId_", OracleDbType.Decimal, Convert.ToDecimal(this._DovLica_FILLED.Rows[i]["ID"]), ParameterDirection.Input);
                com.CommandText = "begin KL.delCustomerTrustee(:pId_); end;";
                com.ExecuteNonQuery();
            }

        // добавляем новые и обновленные записи
        for (int i = 0; i < this._DovLica_FILLED.Rows.Count; i++)
            if (this._DovLica_FILLED.Rows[i]["STATUS"].ToString() == "1" || this._DovLica_FILLED.Rows[i]["STATUS"].ToString() == "2")
            {
                com.Parameters.Clear();

                com.Parameters.Add("pRnk_", OracleDbType.Int32, Convert.ToInt32(this._RNK), ParameterDirection.Input);
                com.Parameters.Add("pFio_", OracleDbType.Varchar2, GetParamVal(Convert.ToString(this._DovLica_FILLED.Rows[i]["FIO"])), ParameterDirection.Input);
                com.Parameters.Add("pPasport_", OracleDbType.Varchar2, null, ParameterDirection.Input);
                com.Parameters.Add("pBDate_", OracleDbType.Date, GetParamVal(Convert.ToDateTime(this._DovLica_FILLED.Rows[i]["BDATE"])), ParameterDirection.Input);
                com.Parameters.Add("pEDate_", OracleDbType.Date, GetParamVal(Convert.ToDateTime(this._DovLica_FILLED.Rows[i]["EDATE"])), ParameterDirection.Input);
                com.Parameters.Add("pDocument_", OracleDbType.Varchar2, GetParamVal(Convert.ToString(this._DovLica_FILLED.Rows[i]["DOCUMENT"])), ParameterDirection.Input);
                com.Parameters.Add("pNotary_name_", OracleDbType.Varchar2, GetParamVal(Convert.ToString(this._DovLica_FILLED.Rows[i]["NOTARY_NAME"])), ParameterDirection.Input);
                com.Parameters.Add("pNotary_region_", OracleDbType.Varchar2, GetParamVal(Convert.ToString(this._DovLica_FILLED.Rows[i]["NOTARY_REGION"])), ParameterDirection.Input);
                com.Parameters.Add("pTrust_regnum_", OracleDbType.Varchar2, GetParamVal(Convert.ToString(this._DovLica_FILLED.Rows[i]["TRUST_REGNUM"])), ParameterDirection.Input);
                com.Parameters.Add("pTrust_regdat_", OracleDbType.Date, GetParamVal(Convert.ToDateTime(this._DovLica_FILLED.Rows[i]["TRUST_REGDAT"])), ParameterDirection.Input);
                com.Parameters.Add("pOkpo_", OracleDbType.Varchar2, GetParamVal(Convert.ToString(this._DovLica_FILLED.Rows[i]["OKPO"])), ParameterDirection.Input);
                com.Parameters.Add("pDoc_type_", OracleDbType.Int32, GetParamVal(Convert.ToInt32(this._DovLica_FILLED.Rows[i]["DOC_TYPE"])), ParameterDirection.Input);
                com.Parameters.Add("pDoc_serial_", OracleDbType.Varchar2, GetParamVal(Convert.ToString(this._DovLica_FILLED.Rows[i]["DOC_SERIAL"])), ParameterDirection.Input);
                com.Parameters.Add("pDoc_number_", OracleDbType.Varchar2, GetParamVal(Convert.ToString(this._DovLica_FILLED.Rows[i]["DOC_NUMBER"])), ParameterDirection.Input);
                com.Parameters.Add("pDoc_date_", OracleDbType.Date, GetParamVal(Convert.ToDateTime(this._DovLica_FILLED.Rows[i]["DOC_DATE"])), ParameterDirection.Input);
                com.Parameters.Add("pDoc_issuer_", OracleDbType.Varchar2, GetParamVal(Convert.ToString(this._DovLica_FILLED.Rows[i]["DOC_ISSUER"])), ParameterDirection.Input);
                com.Parameters.Add("pBirthday_", OracleDbType.Date, GetParamVal(Convert.ToDateTime(this._DovLica_FILLED.Rows[i]["BIRTHDAY"])), ParameterDirection.Input);
                com.Parameters.Add("pBirthplace_", OracleDbType.Varchar2, GetParamVal(Convert.ToString(this._DovLica_FILLED.Rows[i]["BIRTHPLACE"])), ParameterDirection.Input);
                com.Parameters.Add("pTypeId_", OracleDbType.Decimal, GetParamVal(Convert.ToDecimal(this._DovLica_FILLED.Rows[i]["TYPE_ID"])), ParameterDirection.Input);
                com.Parameters.Add("pDocTypeId_", OracleDbType.Decimal, GetParamVal(Convert.ToDecimal(this._DovLica_FILLED.Rows[i]["DOCUMENT_TYPE_ID"])), ParameterDirection.Input);
                com.Parameters.Add("pPosition_", OracleDbType.Varchar2, GetParamVal(Convert.ToString(this._DovLica_FILLED.Rows[i]["POSITION"])), ParameterDirection.Input);
                com.Parameters.Add("pFirstName_", OracleDbType.Varchar2, GetParamVal(Convert.ToString(this._DovLica_FILLED.Rows[i]["FIRST_NAME"])), ParameterDirection.Input);
                com.Parameters.Add("pMiddleName_", OracleDbType.Varchar2, GetParamVal(Convert.ToString(this._DovLica_FILLED.Rows[i]["MIDDLE_NAME"])), ParameterDirection.Input);
                com.Parameters.Add("pLastName_", OracleDbType.Varchar2, GetParamVal(Convert.ToString(this._DovLica_FILLED.Rows[i]["LAST_NAME"])), ParameterDirection.Input);
                com.Parameters.Add("pSex_", OracleDbType.Char, GetParamVal(Convert.ToString(this._DovLica_FILLED.Rows[i]["SEX_ID"])), ParameterDirection.Input);
                com.Parameters.Add("pTel_", OracleDbType.Varchar2, GetParamVal(Convert.ToString(this._DovLica_FILLED.Rows[i]["TEL"])), ParameterDirection.Input);
                com.Parameters.Add("pSignPrivs_", OracleDbType.Decimal, GetParamVal(Convert.ToDecimal(this._DovLica_FILLED.Rows[i]["SIGN_PRIVS"])), ParameterDirection.Input);
                com.Parameters.Add("pNameR_", OracleDbType.Varchar2, GetParamVal(Convert.ToString(this._DovLica_FILLED.Rows[i]["NAME_R"])), ParameterDirection.Input);
                com.Parameters.Add("pSignId_", OracleDbType.Decimal, GetParamVal(Convert.ToDecimal(this._DovLica_FILLED.Rows[i]["SIGN_ID"])), ParameterDirection.Input);

                com.CommandText = "begin KL.setCustomerTrustee( null, :pRnk_, :pFio_, :pPasport_, :pBDate_, :pEDate_, :pDocument_, :pNotary_name_, :pNotary_region_, :pTrust_regnum_, :pTrust_regdat_, :pOkpo_, :pDoc_type_, :pDoc_serial_, :pDoc_number_, :pDoc_date_, :pDoc_issuer_, :pBirthday_, :pBirthplace_, :pTypeId_,  :pDocTypeId_, :pPosition_, :pFirstName_, :pMiddleName_, :pLastName_,  :pSex_, :pTel_, :pSignPrivs_, :pNameR_, :pSignId_); end;";
                com.ExecuteNonQuery();
            }
    }
    # endregion
    //=========================================================
    # region Вычитка списков, справочников и дефолтных значений
    /// <summary>
    /// Тип гос реестра 1 - ЄДР, 2 - ДРФ, 3 - тимчас
    /// </summary>
    public ListAndIndex GetDB_TGR_List()
    {
        ListAndIndex oRes = new ListAndIndex();
        oRes.List = new ListItemCollection();

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();
            
            if (this.CUSTTYPE == 3)
                com.CommandText = "select TGR, NAME from TGR where TGR in (2, 3) order by TGR";
            else
                com.CommandText = "select TGR, NAME from TGR where TGR in (1, 3) order by TGR";

            rdr = com.ExecuteReader();
            while (rdr.Read())
            {
                oRes.List.Add(new ListItem(rdr.GetInt32(0).ToString() + " - " + rdr.GetString(1), rdr.GetInt32(0).ToString()));
            }
        }
        finally
        {
            con.Close();
        }

        if (this._TGR != int.MinValue)
            oRes.SelectedIndex = oRes.List.IndexOf(oRes.List.FindByValue(this._TGR.ToString()));

        return oRes;
    }
    private Pair GetDB_TGR_Default()
    {
        Pair oRes = new Pair();

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            if (this._CUSTTYPE == 3)
                com.CommandText = "select TGR, NAME from TGR order by TGR";
            else
                com.CommandText = "select TGR, NAME from TGR where TGR = 1 OR TGR = 3 order by TGR";

            rdr = com.ExecuteReader();
            rdr.Read();
            
            oRes.First = rdr.GetInt32(0);
            oRes.Second = rdr.GetInt32(0).ToString() + " - " + rdr.GetString(1);
        }
        finally
        {
            con.Close();
        }

        return oRes;
    }
    /// <summary>
    ///Страна клиента
    /// </summary>
    public ListAndIndex GetDB_COUNTRY_List()
    {
        ListAndIndex oRes = new ListAndIndex();
        oRes.List = new ListItemCollection();
        int nRezId = (int)this.CODCAGENT.Third;

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            if (nRezId == 1)
            {
                com.CommandText = "select COUNTRY, NAME from COUNTRY where COUNTRY in (select to_number(NVL(min(to_char(val)),'840')) FROM PARAMS WHERE PAR = 'KOD_G')";
            }
            else com.CommandText = "select COUNTRY, NAME from COUNTRY order by NAME";

            rdr = com.ExecuteReader();
            while (rdr.Read())
            {
                oRes.List.Add(new ListItem(rdr.GetInt32(0).ToString() + " - " + rdr.GetString(1), rdr.GetInt32(0).ToString()));
            }
        }
        finally
        {
            con.Close();
        }

        if (this._COUNTRY != int.MinValue)
            oRes.SelectedIndex = oRes.List.IndexOf(oRes.List.FindByValue(this._COUNTRY.ToString()));

        return oRes;
    }
    private Pair GetDB_COUNTRY_Default()
    {
        Pair oRes = new Pair();

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            if ((int)this.CODCAGENT.Third == 1)
            {
                com.CommandText = "select COUNTRY, NAME from COUNTRY where COUNTRY in (select to_number(NVL(min(to_char(val)),'840')) FROM PARAMS WHERE PAR = 'KOD_G')";
            }
            else com.CommandText = "select COUNTRY, NAME from COUNTRY order by NAME";

            rdr = com.ExecuteReader();
            rdr.Read();

            oRes.First = rdr.GetInt32(0);
            oRes.Second = rdr.GetInt32(0).ToString() + " - " + rdr.GetString(1);
        }
        finally
        {
            con.Close();
        }

        return oRes;
    }
    /// <summary>
    /// Характеристика
    /// </summary>
    public ListAndIndex GetDB_CODCAGENT_List()
    {
        ListAndIndex oRes = new ListAndIndex();
        oRes.List = new ListItemCollection();

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.CommandText = "select CODCAGENT, NAME from CODCAGENT where ";
            if (this.CUSTTYPE == 3) com.CommandText += "CODCAGENT = 5 OR CODCAGENT = 6";
            if (this.CUSTTYPE == 2) com.CommandText += "CODCAGENT = 3 OR CODCAGENT = 4 OR CODCAGENT = 7";
            if (this.CUSTTYPE == 1) com.CommandText += "CODCAGENT = 1 OR CODCAGENT = 2 OR CODCAGENT = 9";
            com.CommandText += " order by CODCAGENT";

            rdr = com.ExecuteReader();
            while (rdr.Read())
            {
                oRes.List.Add(new ListItem(rdr.GetInt32(0).ToString() + " - " + rdr.GetString(1), rdr.GetInt32(0).ToString()));
            }
        }
        finally
        {
            con.Close();
        }

        if (this._CODCAGENT != int.MinValue)
            oRes.SelectedIndex = oRes.List.IndexOf(oRes.List.FindByValue(this._CODCAGENT.ToString()));

        return oRes;
    }
    private Pair GetDB_CODCAGENT_Default()
    {
        Pair oRes = new Pair();

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.CommandText = "SELECT CODCAGENT, NAME FROM CODCAGENT WHERE ";
            if (this.CUSTTYPE == 3) com.CommandText += "CODCAGENT = 5 OR CODCAGENT = 6";
            if (this.CUSTTYPE == 2) com.CommandText += "CODCAGENT = 3 OR CODCAGENT = 4 OR CODCAGENT = 7";
            if (this.CUSTTYPE == 1) com.CommandText += "CODCAGENT = 1 OR CODCAGENT = 2 OR CODCAGENT = 9";
            com.CommandText += " ORDER BY CODCAGENT";

            rdr = com.ExecuteReader();
            rdr.Read();

            oRes.First = rdr.GetInt32(0);
            oRes.Second = rdr.GetInt32(0).ToString() + " - " + rdr.GetString(1);
        }
        finally
        {
            con.Close();
        }

        return oRes;
    }
    /// <summary>
    /// Код инсайдера
    /// </summary>
    public ListAndIndex GetDB_PRINSIDER_List()
    {
        ListAndIndex oRes = new ListAndIndex();
        oRes.List = new ListItemCollection();
        int nCUSTTYPE = this.CUSTTYPE;

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            if (nCUSTTYPE == 1 || nCUSTTYPE == 2)
            {
                com.CommandText = "select PRINSIDER, NAME from PRINSIDER where PRINSIDER in (0, 99, 11, 12, 13, 14, 15, 16, 17, 18, 19)";
            }
            else if (nCUSTTYPE == 3)
            {
                com.CommandText = "select PRINSIDER, NAME from PRINSIDER where PRINSIDER in (0, 99, 1, 2, 3, 4, 5, 6, 7, 8, 9)";
            }

            rdr = com.ExecuteReader();
            while (rdr.Read())
            {
                oRes.List.Add(new ListItem(rdr.GetDecimal(0).ToString() + " - " + rdr.GetString(1), rdr.GetDecimal(0).ToString()));
            }
        }
        finally
        {
            con.Close();
        }

        if (this._PRINSIDER != decimal.MinValue)
            oRes.SelectedIndex = oRes.List.IndexOf(oRes.List.FindByValue(this._PRINSIDER.ToString()));

        return oRes;
    }
    private Pair GetDB_PRINSIDER_Default()
    {
        Pair oRes = new Pair();
        int nCUSTTYPE = this.CUSTTYPE;

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            if (nCUSTTYPE == 1 || nCUSTTYPE == 2)
            {
                com.CommandText = "select PRINSIDER, NAME from PRINSIDER where PRINSIDER in (0, 99, 11, 12, 13, 14, 15, 16, 17, 18, 19)";
            }
            else if (nCUSTTYPE == 3)
            {
                com.CommandText = "select PRINSIDER, NAME from PRINSIDER where PRINSIDER in (0, 99, 1, 2, 3, 4, 5, 6, 7, 8, 9)";
            }

            rdr = com.ExecuteReader();
            rdr.Read();

            oRes.First = rdr.GetDecimal(0);
            oRes.Second = rdr.GetDecimal(0).ToString() + " - " + rdr.GetString(1);
        }
        finally
        {
            con.Close();
        }

        return oRes;
    }
    /// <summary>
    /// Код обл.НИ
    /// </summary>    
    public ListAndIndex GetDB_C_REG_List()
    {
        ListAndIndex oRes = new ListAndIndex();
        oRes.List = new ListItemCollection();

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.CommandText = "select C_REG, NAME_REG from SPR_OBL order by C_REG";				

            rdr = com.ExecuteReader();
            while (rdr.Read())
            {
                oRes.List.Add(new ListItem(rdr.GetInt32(0).ToString() + " - " + rdr.GetString(1), rdr.GetInt32(0).ToString()));
            }
        }
        finally
        {
            con.Close();
        }

        if (this._C_REG != int.MinValue)
            oRes.SelectedIndex = oRes.List.IndexOf(oRes.List.FindByValue(this._C_REG.ToString()));

        return oRes;
    }
    private Pair GetDB_C_REG_Default()
    {
        Pair oRes = new Pair();

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.CommandText = "select C_REG, NAME_REG from SPR_OBL order by C_REG";				

            rdr = com.ExecuteReader();
            rdr.Read();

            oRes.First = rdr.GetInt32(0);
            oRes.Second = rdr.GetInt32(0).ToString() + " - " + rdr.GetString(1);
        }
        finally
        {
            con.Close();
        }

        return oRes;
    }
    /// <summary>
    /// Код район.НИ
    /// </summary>    
    public ListAndIndex GetDB_C_DST_List()
    {
        ListAndIndex oRes = new ListAndIndex();
        oRes.List = new ListItemCollection();

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.Parameters.Clear();
            com.Parameters.Add("pCReg", OracleDbType.Decimal, _C_REG, ParameterDirection.Input);
            com.CommandText = "select C_DST, NAME_STI from SPR_REG where C_REG = :pCReg order by C_DST";

            rdr = com.ExecuteReader();
            while (rdr.Read())
            {
                oRes.List.Add(new ListItem(rdr.GetInt32(0).ToString() + " - " + rdr.GetString(1), rdr.GetInt32(0).ToString()));
            }
        }
        finally
        {
            con.Close();
        }

        if (this._C_DST != int.MinValue)
            oRes.SelectedIndex = oRes.List.IndexOf(oRes.List.FindByValue(this._C_DST.ToString()));

        return oRes;
    }
    private Pair GetDB_C_DST_Default()
    {
        Pair oRes = new Pair();

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.Parameters.Clear();
            com.Parameters.Add("pCReg", OracleDbType.Decimal, _C_REG, ParameterDirection.Input);
            com.CommandText = "select C_DST, NAME_STI from SPR_REG where C_REG = :pCReg order by C_DST";

            rdr = com.ExecuteReader();
            rdr.Read();

            oRes.First = rdr.GetInt32(0);
            oRes.Second = rdr.GetInt32(0).ToString() + " - " + rdr.GetString(1);
        }
        finally
        {
            con.Close();
        }

        return oRes;
    }
    /// <summary>
    /// Вид выписки
    /// </summary>    
    public ListAndIndex GetDB_STMT_List()
    {
        ListAndIndex oRes = new ListAndIndex();
        oRes.List = new ListItemCollection();

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.CommandText = "select STMT, NAME from STMT order by STMT";

            rdr = com.ExecuteReader();
            while (rdr.Read())
            {
                oRes.List.Add(new ListItem(rdr.GetInt32(0).ToString() + " - " + rdr.GetString(1), rdr.GetInt32(0).ToString()));
            }
        }
        finally
        {
            con.Close();
        }

        if (this._STMT != int.MinValue)
            oRes.SelectedIndex = oRes.List.IndexOf(oRes.List.FindByValue(this._STMT.ToString()));

        return oRes;
    }
    private Pair GetDB_STMT_Default()
    {
        Pair oRes = new Pair();

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.CommandText = "select STMT, NAME from STMT order by STMT";

            rdr = com.ExecuteReader();
            rdr.Read();

            oRes.First = rdr.GetInt32(0);
            oRes.Second = rdr.GetInt32(0).ToString() + " - " + rdr.GetString(1);
        }
        finally
        {
            con.Close();
        }

        return oRes;
    }
    /// <summary>
    /// Код отделения
    /// </summary>    
    public ListAndIndex GetDB_TOBO_List()
    {
        ListAndIndex oRes = new ListAndIndex();
        oRes.List = new ListItemCollection();

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.CommandText = "select TOBO, NAME from TOBO order by TOBO";

            rdr = com.ExecuteReader();
            while (rdr.Read())
            {
                oRes.List.Add(new ListItem(rdr.GetString(0) + " - " + rdr.GetString(1), rdr.GetString(0)));
            }
        }
        finally
        {
            con.Close();
        }

        if (this._TOBO != string.Empty)
            oRes.SelectedIndex = oRes.List.IndexOf(oRes.List.FindByValue(this._TOBO));

        return oRes;
    }
    private Pair GetDB_TOBO_Default()
    {
        Pair oRes = new Pair();

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.CommandText = "select TOBO, NAME from TOBO where TOBO in (select min(TOBO) from TOBO)";

            rdr = com.ExecuteReader();
            rdr.Read();

            oRes.First = rdr.GetString(0);
            oRes.Second = rdr.GetString(0) + " - " + rdr.GetString(1);
        }
        finally
        {
            con.Close();
        }

        return oRes;
    }
    /// <summary>
    /// Инст. сек. экономики (К070)
    /// </summary>    
    public ListAndIndex GetDB_ISE_List()
    {
        ListAndIndex oRes = new ListAndIndex();
        oRes.List = new ListItemCollection();

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.CommandText = "select ISE, NAME from ISE";

            rdr = com.ExecuteReader();
            while (rdr.Read())
            {
                oRes.List.Add(new ListItem(rdr.GetString(0) + " - " + rdr.GetString(1), rdr.GetString(0)));
            }
        }
        finally
        {
            con.Close();
        }

        if (this._ISE != string.Empty)
            oRes.SelectedIndex = oRes.List.IndexOf(oRes.List.FindByValue(this._ISE));

        return oRes;
    }
    private Pair GetDB_ISE_Default()
    {
        Pair oRes = new Pair();

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.CommandText = "select ISE, NAME from ISE";

            rdr = com.ExecuteReader();
            rdr.Read();

            oRes.First = rdr.GetString(0);
            oRes.Second = rdr.GetString(0) + " - " + rdr.GetString(1);
        }
        finally
        {
            con.Close();
        }

        return oRes;
    }
    /// <summary>
    /// Форма собственности (К080)
    /// </summary>    
    public ListAndIndex GetDB_FS_List()
    {
        ListAndIndex oRes = new ListAndIndex();
        oRes.List = new ListItemCollection();
        int nCUSTTYPE = this.CUSTTYPE;

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            if (nCUSTTYPE == 1 || nCUSTTYPE == 2)
                com.CommandText = "select FS, NAME from FS";
            else if (nCUSTTYPE == 3)
                com.CommandText = "select FS, NAME from FS where FS = '10' and (D_CLOSE is null or D_CLOSE > bankdate)";

            rdr = com.ExecuteReader();
            while (rdr.Read())
            {
                oRes.List.Add(new ListItem(rdr.GetString(0) + " - " + rdr.GetString(1), rdr.GetString(0)));
            }
        }
        finally
        {
            con.Close();
        }

        if (this._FS != string.Empty)
            oRes.SelectedIndex = oRes.List.IndexOf(oRes.List.FindByValue(this._FS));

        return oRes;
    }
    private Pair GetDB_FS_Default()
    {
        Pair oRes = new Pair();
        int nCUSTTYPE = this.CUSTTYPE;

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            if (nCUSTTYPE == 1 || nCUSTTYPE == 2)
                com.CommandText = "select FS, NAME from FS";
            else if (nCUSTTYPE == 3)
                com.CommandText = "select FS, NAME from FS where FS = '10' and (D_CLOSE is null or D_CLOSE > bankdate)";

            rdr = com.ExecuteReader();
            rdr.Read();

            oRes.First = rdr.GetString(0);
            oRes.Second = rdr.GetString(0) + " - " + rdr.GetString(1);
        }
        finally
        {
            con.Close();
        }

        return oRes;
    }
    /// <summary>
    /// Вид эк. деятельности (К110)
    /// </summary>    
    public ListAndIndex GetDB_VED_List()
    {
        ListAndIndex oRes = new ListAndIndex();
        oRes.List = new ListItemCollection();

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.CommandText = "select VED, NAME, OELIST from VED";

            rdr = com.ExecuteReader();
            while (rdr.Read())
            {
                oRes.List.Add(new ListItem(rdr.GetString(0) + " - " + rdr.GetString(1), rdr.GetString(0)));
            }
        }
        finally
        {
            con.Close();
        }

        if (this._VED != string.Empty)
            oRes.SelectedIndex = oRes.List.IndexOf(oRes.List.FindByValue(this._VED));

        return oRes;
    }
    private Pair GetDB_VED_Default()
    {
        Pair oRes = new Pair();

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.CommandText = "select VED, NAME, OELIST from VED";

            rdr = com.ExecuteReader();
            rdr.Read();

            oRes.First = rdr.GetString(0);
            oRes.Second = rdr.GetString(0) + " - " + rdr.GetString(1);
        }
        finally
        {
            con.Close();
        }

        return oRes;
    }
    /// <summary>
    /// Отрасль экономики (К090)
    /// </summary>    
    public ListAndIndex GetDB_OE_List()
    {
        ListAndIndex oRes = new ListAndIndex();
        oRes.List = new ListItemCollection();

        string sCondition = "";
        object oTmp = this.VED.Third;
        ArrayList oOEList = null;
        if (oTmp != null)
        {
            oOEList = (ArrayList)oTmp;
            sCondition = "where Oe in (";
            for (int i = 0; i<oOEList.Count; i++)
                sCondition += (string)oOEList[i] + ",";
            sCondition = sCondition.Substring(0, sCondition.Length - 1);
            sCondition += ")";
        }

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.CommandText = "select OE, NAME from OE" + sCondition;

            rdr = com.ExecuteReader();
            while (rdr.Read())
            {
                oRes.List.Add(new ListItem(rdr.GetString(0) + " - " + rdr.GetString(1), rdr.GetString(0)));
            }
        }
        finally
        {
            con.Close();
        }

        if (this._OE != string.Empty)
            oRes.SelectedIndex = oRes.List.IndexOf(oRes.List.FindByValue(this._OE));

        return oRes;
    }
    private Pair GetDB_OE_Default()
    {
        Pair oRes = new Pair();

        string sCondition = "";
        object oTmp = this.VED.Third;
        ArrayList oOEList = null;
        if (oTmp != null)
        {
            oOEList = (ArrayList)oTmp;
            sCondition = "where Oe in (";
            for (int i = 0; i<oOEList.Count; i++)
                sCondition += (string)oOEList[i] + ",";
            sCondition = sCondition.Substring(0, sCondition.Length - 1);
            sCondition += ")";
        }

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.CommandText = "select OE, NAME from OE" + sCondition;

            rdr = com.ExecuteReader();
            rdr.Read();

            oRes.First = rdr.GetString(0);
            oRes.Second = rdr.GetString(0) + " - " + rdr.GetString(1);
        }
        finally
        {
            con.Close();
        }

        return oRes;
    }
    /// <summary>
    /// Форма хозяйствования (К051)
    /// </summary>    
    public ListAndIndex GetDB_SED_List()
    {
        ListAndIndex oRes = new ListAndIndex();
        oRes.List = new ListItemCollection();

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.CommandText = "select SED, NAME from SED";

            rdr = com.ExecuteReader();
            while (rdr.Read())
            {
                oRes.List.Add(new ListItem(rdr.GetString(0) + " - " + rdr.GetString(1), rdr.GetString(0)));
            }
        }
        finally
        {
            con.Close();
        }

        if (this._SED != string.Empty)
            oRes.SelectedIndex = oRes.List.IndexOf(oRes.List.FindByValue(this._SED));

        return oRes;
    }
    private Pair GetDB_SED_Default()
    {
        Pair oRes = new Pair();

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.CommandText = "select SED, NAME from SED";

            rdr = com.ExecuteReader();
            rdr.Read();

            oRes.First = rdr.GetString(0);
            oRes.Second = rdr.GetString(0) + " - " + rdr.GetString(1);
        }
        finally
        {
            con.Close();
        }

        return oRes;
    }
    /// <summary>
    /// Удостоверения физических лиц
    /// </summary>    
    public ListAndIndex GetDB_PASSP_List()
    {
        ListAndIndex oRes = new ListAndIndex();
        oRes.List = new ListItemCollection();

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.CommandText = "select PASSP, NAME from PASSP";

            rdr = com.ExecuteReader();
            while (rdr.Read())
            {
                oRes.List.Add(new ListItem(rdr.GetInt32(0).ToString() + " - " + rdr.GetString(1), rdr.GetInt32(0).ToString()));
            }
        }
        finally
        {
            con.Close();
        }

        if (this._PASSP != int.MinValue)
            oRes.SelectedIndex = oRes.List.IndexOf(oRes.List.FindByValue(this._PASSP.ToString()));

        return oRes;
    }
    /// <summary>
    /// Пол
    /// </summary>    
    public ListAndIndex GetDB_SEX_List()
    {
        ListAndIndex oRes = new ListAndIndex();
        oRes.List = new ListItemCollection();

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.CommandText = "select ID, NAME from SEX";

            rdr = com.ExecuteReader();
            while (rdr.Read())
            {
                oRes.List.Add(new ListItem(rdr.GetString(0) + " - " + rdr.GetString(1), rdr.GetString(0)));
            }
        }
        finally
        {
            con.Close();
        }

        if (this._SEX != string.Empty)
            oRes.SelectedIndex = oRes.List.IndexOf(oRes.List.FindByValue(this._SEX));

        return oRes;
    }
    /// <summary>
    /// Класс заемщика
    /// </summary>    
    public ListAndIndex GetDB_CRISK_List()
    {
        ListAndIndex oRes = new ListAndIndex();
        oRes.List = new ListItemCollection();
        oRes.List.Add(new ListItem("0 - Пусто", "0"));

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.CommandText = @"select FIN, NAME from STAN_FIN";

            rdr = com.ExecuteReader();
            while (rdr.Read())
            {
                oRes.List.Add(new ListItem(rdr.GetDecimal(0).ToString() + " - " + rdr.GetString(1), rdr.GetDecimal(0).ToString()));
            }
        }
        finally
        {
            con.Close();
        }

        if (this._CRISK != int.MinValue)
            oRes.SelectedIndex = oRes.List.IndexOf(oRes.List.FindByValue(this._CRISK.ToString()));

        return oRes;
    }    
    /// <summary>
    /// Принадлежность малому бизнесу
    /// </summary>    
    public ListAndIndex GetDB_MB_List()
    {
        ListAndIndex oRes = new ListAndIndex();
        oRes.List = new ListItemCollection();

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.CommandText = "SELECT K140, TXT FROM KL_K140";

            rdr = com.ExecuteReader();
            while (rdr.Read())
            {
                oRes.List.Add(new ListItem(rdr.GetString(0) + " - " + rdr.GetString(1), rdr.GetString(0)));
            }
        }
        finally
        {
            con.Close();
        }

        if (this._MB != string.Empty)
            oRes.SelectedIndex = oRes.List.IndexOf(oRes.List.FindByValue(this._MB));

        return oRes;
    }
    # endregion
    //=========================================================
    # region Валидация данных
    /// <summary>
    /// Проверяет заполненость обязательных полей
    /// </summary>
    private void CheckObligatoryFields()
    {
        // Тип гос реестра 1 - ЄДР, 2 - ДРФ, 3 - тимчас
        if (this._TGR == int.MinValue) throw new ClientRegisterException("Не заполнен Тип гос реестра", "ddlTGR");
        // Страна клиента
        if (this._COUNTRY == int.MinValue) throw new ClientRegisterException("Не заполнена Страна клиента", "ddlCOUNTRY");
        // Полное Наименование контрагента
        if (this._NMK == string.Empty) throw new ClientRegisterException("Не заполнено Полное Наименование контрагента", "edNMK");
        // Характеристика
        if (this._CODCAGENT == int.MinValue) throw new ClientRegisterException("Не заполнена Характеристика", "ddlCODCAGENT");
        // Код инсайдера
        if (this._PRINSIDER == decimal.MinValue) throw new ClientRegisterException("Не заполнен Код инсайдера", "ddlPRINSIDER");
        // Идентификационный код клиента
        if (this._OKPO == string.Empty) throw new ClientRegisterException("Не заполнен Идентификационный код клиента", "edOKPO");
        // Адрес клиента
        bool isADROk = false;
        for (int i = 0; i < this._ADR.Rows.Count; i++)
            if (this._ADR.Rows[i]["TYPE_ID"].ToString() == "1")
            {
                isADROk = true;
                if (this._ADR.Rows[i]["LOCALITY"].ToString().Trim() == "" || this._ADR.Rows[i]["ADDRESS"].ToString().Trim() == "") isADROk = false;
            }
        if (!isADROk) throw new ClientRegisterException("Не заполнен Адрес клиента", "");

        if (this.bFillEconomNorm)
        {    
            // Код сектора экономики
            if (this._ISE == string.Empty) throw new ClientRegisterException("Не заполнен Код сектора экономики", "edISE");
            // Форма собственности
            if (this._FS == string.Empty) throw new ClientRegisterException("Не заполнена Форма собственности", "edFS");
            // Отрасли экономики
            if (this._OE == string.Empty) throw new ClientRegisterException("Не заполнена Отрасли экономики", "edOE");
            // Вид экономичческой деятельности
            if (this._VED == string.Empty) throw new ClientRegisterException("Не заполнен Вид экономичческой деятельности", "edVED");
            // Код отрасли экономики
            if (this._SED == string.Empty) throw new ClientRegisterException("Не заполнен Код отрасли экономики", "edVED");
        }

        switch (this.CUSTTYPE)
        {
            case 1:
                // банк
                // Код МФО банка
                if (this._MFO == string.Empty) throw new ClientRegisterException("Не заполнен № док", "edNUMDOC");
                break;
            case 2:
                // юр лицо
                break;
            case 3:
                // физ лицо
                // № док
                if (this._NUMDOC == string.Empty) throw new ClientRegisterException("Не заполнен № док", "edNUMDOC");
                // Дата выдачи док
                if (this._PDATE == DateTime.MinValue) throw new ClientRegisterException("Не заполнена Дата выдачи док", "edPDATE");
                // Организация, выдавшая удостоверяющий документ
                if (this._ORGAN == string.Empty) throw new ClientRegisterException("Не заполнена Организация, выдавшая удостоверяющий документ", "edORGAN");
                // Дата рождения
                if (this._BDAY == DateTime.MinValue) throw new ClientRegisterException("Не заполнена Дата рождения", "edBDAY");

                break;
        }

        isADROk = true;
        for (int i = 0; i < this._ADR.Rows.Count; i++)
            if (this._ADR.Rows[i]["TYPE_ID"].ToString() != "1")
                if (this._ADR.Rows[i]["LOCALITY"].ToString().Trim() == "" || this._ADR.Rows[i]["ADDRESS"].ToString().Trim() == "") isADROk = false;
        if (!isADROk) throw new ClientRegisterException("Неверно заполнены дополнительные адреса клиента", "");

        // Код отделенния
        if (this._TOBO == string.Empty) throw new ClientRegisterException("Не заполнен Код отделенния", "ddlTOBO");

        // Текушие счета клиента
        bool isACCOk = false;
        for (int i = 0; i < this._CORPS_ACC_FILLED.Rows.Count; i++)
            if (this._CORPS_ACC_FILLED.Rows[i]["MFO"].ToString().Trim() == "" ||
                this._CORPS_ACC_FILLED.Rows[i]["NLS"].ToString().Trim() == "" ||
                this._CORPS_ACC_FILLED.Rows[i]["KV"].ToString().Trim() == "")
                isACCOk = false;
        if (!isACCOk) throw new ClientRegisterException("Неверно заполнены Текушие счета клиента", "");

        // Дополнительные реквизиты
        bool isDOPREKVOk = false;
        for (int i = 0; i < this._DOPREKV_FILLED.Rows.Count; i++)
            if (this._DOPREKV_FILLED.Rows[i]["TAG"].ToString().Trim() == "")
                isDOPREKVOk = false;
        if (!isDOPREKVOk) throw new ClientRegisterException("Неверно заполнены Дополнительные реквизиты", "");

        // Довереные лица заполненые
        bool isDovLicaOk = false;
        for (int i = 0; i < this._DovLica_FILLED.Rows.Count; i++)
            if (this._DovLica_FILLED.Rows[i]["FIO"].ToString().Trim() == "")
                isDovLicaOk = false;
        if (!isDovLicaOk) throw new ClientRegisterException("Неверно заполнены Довереные лица заполненые", "");
    }
    # endregion
}