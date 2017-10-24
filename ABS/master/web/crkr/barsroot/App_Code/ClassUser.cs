using System;
using System.Data;
using System.Globalization;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Configuration;
using System.Xml;
using System.Security.Cryptography;
using System.Text;

/// <summary>
/// Класс пользователя системы
/// </summary>
public class ClassUser
{
    # region System Vars    
    OracleConnection con = new OracleConnection();
    OracleCommand com = new OracleCommand();
    OracleDataReader rdr;
    OracleDataAdapter adp = new OracleDataAdapter();
    DataTable dt = new DataTable();
    private string sClassRole = "WR_NS";
    private DateTimeFormatInfo dtf = new DateTimeFormatInfo();
    private NumberFormatInfo nf = new NumberFormatInfo();
    # endregion
    // ===============================================
    # region Privat Properties
    private decimal _nId = -1; // -1 - новый пользователь
    private string _sFIO = "";
    private string _sTabN = "";
    private string _sLogin = "";
    private string _sPassword = "";
    private string _sPasswordConfirm = "";
    private decimal _nType = -1;
    private string _sDep = "-1";
    private DataTable _dtARMs = new DataTable();
    private DataTable _dtFiles = new DataTable();
    private DataTable _dtDocs = new DataTable();
    /// <summary>
    /// Хешированый пароль
    /// </summary>
    private string sPassworHash
    {
        get
        {
            SHA1 sha = new SHA1CryptoServiceProvider();
            byte[] inputBytes = ASCIIEncoding.UTF8.GetBytes(this._sPassword);
            byte[] hashData = sha.ComputeHash(inputBytes);

            return BitConverter.ToString(hashData).Replace("-", "").ToLower();
        }
    }
    # endregion
    // ===============================================
    # region Public Properties
    public bool bIsNewUser
    {
        get
        {
            if (this._nId == -1) return true;
            else return false;
        }
    }
    /// <summary>
    /// ФИО пользователя
    /// </summary>
    public string sFIO
    {
        get { return this._sFIO.Trim(); }
        set 
        {
            if (value.Trim() == string.Empty) throw new Exception("Незаполнено поле 'ФИО пользователя'");
            this._sFIO = value.Trim(); 
        }
    }
    /// <summary>
    /// Табельный номер
    /// </summary>
    public string sTabN
    {
        get { return this._sTabN.Trim(); }
        set
        {
            this._sTabN = value.Trim();
        }
    }
    /// <summary>
    /// Логин пользователя
    /// </summary>
    public string sLogin
    {
        get { return this._sLogin.Trim().ToUpper(); }
        set 
        {
            if (value.Trim() == string.Empty) throw new Exception("Незаполнено поле 'Логин пользователя'");
            this._sLogin = value.Trim().ToUpper();
        }
    }
    /// <summary>
    /// Пароль пользователя
    /// </summary>
    public string sPassword
    {
        set
        {
            if (value.Trim().Length < 6) throw new Exception("Длина пароля должна быть больше 6-ти символов");
            this._sPassword = value.Trim();
        }
    }
    /// <summary>
    /// Подтверждение пароля
    /// </summary>
    public string sPasswordConfirm
    {
        set
        {
            if (value.Trim() != this._sPassword) throw new Exception("Ошибка подтверждения пароля");
        }
    }
    /// <summary>
    /// Тип пользователя
    /// </summary>
    public decimal nType
    {
        get
        {
            return this._nType;
        }
        set
        {
            if (value == -1) throw new Exception("Незаполнено поле 'Тип пользователя'");
            this._nType = value;
        }
    }
    /// <summary>
    /// Подразделение
    /// </summary>
    public string sDep
    {
        get
        {
            return this._sDep;
        }
        set
        {
            if (value == "-1") throw new Exception("Незаполнено поле 'Подразделение'");
            this._sDep = value;
        }
    }
    /// <summary>
    /// Выданые АРМы
    /// </summary>
    public ListItemCollection licGrantedARMs
    {
        get 
        {
            ListItemCollection licTmp = new ListItemCollection();
            for (int i = 0; i < this._dtARMs.Rows.Count; i++)
                if (Convert.ToString(this._dtARMs.Rows[i]["STATUS"]) == "0" || Convert.ToString(this._dtARMs.Rows[i]["STATUS"]) == "3")
                {
                    ListItem liTmp = new ListItem(Convert.ToString(this._dtARMs.Rows[i]["NAME"]), Convert.ToString(this._dtARMs.Rows[i]["ID"]));
                    licTmp.Add(liTmp);
                }
            
            return licTmp;
        }
    }
    /// <summary>
    /// Доступные АРМы
    /// </summary>
    public ListItemCollection licAvailableARMs
    {
        get
        {
            ListItemCollection licTmp = new ListItemCollection();
            for (int i = 0; i < this._dtARMs.Rows.Count; i++)
                if (Convert.ToString(this._dtARMs.Rows[i]["STATUS"]) == "1" || Convert.ToString(this._dtARMs.Rows[i]["STATUS"]) == "2")
                {
                    ListItem liTmp = new ListItem(Convert.ToString(this._dtARMs.Rows[i]["NAME"]), Convert.ToString(this._dtARMs.Rows[i]["ID"]));
                    licTmp.Add(liTmp);
                }

            return licTmp;
        }
    }
    /// <summary>
    /// Выданые файлы
    /// </summary>
    public ListItemCollection licGrantedFiles
    {
        get
        {
            ListItemCollection licTmp = new ListItemCollection();
            for (int i = 0; i < this._dtFiles.Rows.Count; i++)
                if (Convert.ToString(this._dtFiles.Rows[i]["STATUS"]) == "0" || Convert.ToString(this._dtFiles.Rows[i]["STATUS"]) == "3")
                {
                    ListItem liTmp = new ListItem(Convert.ToString(this._dtFiles.Rows[i]["NAME"]), Convert.ToString(this._dtFiles.Rows[i]["ID"]));
                    licTmp.Add(liTmp);
                }

            return licTmp;
        }
    }
    /// <summary>
    /// Доступные файлы
    /// </summary>
    public ListItemCollection licAvailableFiles
    {
        get
        {
            ListItemCollection licTmp = new ListItemCollection();
            for (int i = 0; i < this._dtFiles.Rows.Count; i++)
                if (Convert.ToString(this._dtFiles.Rows[i]["STATUS"]) == "1" || Convert.ToString(this._dtFiles.Rows[i]["STATUS"]) == "2")
                {
                    ListItem liTmp = new ListItem(Convert.ToString(this._dtFiles.Rows[i]["NAME"]), Convert.ToString(this._dtFiles.Rows[i]["ID"]));
                    licTmp.Add(liTmp);
                }

            return licTmp;
        }
    }
    /// <summary>
    /// Выданые документы
    /// </summary>
    public ListItemCollection licGrantedDocs
    {
        get
        {
            ListItemCollection licTmp = new ListItemCollection();
            for (int i = 0; i < this._dtDocs.Rows.Count; i++)
                if (Convert.ToString(this._dtDocs.Rows[i]["STATUS"]) == "0" || Convert.ToString(this._dtDocs.Rows[i]["STATUS"]) == "3")
                {
                    ListItem liTmp = new ListItem(Convert.ToString(this._dtDocs.Rows[i]["NAME"]), Convert.ToString(this._dtDocs.Rows[i]["ID"]));
                    licTmp.Add(liTmp);
                }

            return licTmp;
        }
    }
    /// <summary>
    /// Доступные документы
    /// </summary>
    public ListItemCollection licAvailableDocs
    {
        get
        {
            ListItemCollection licTmp = new ListItemCollection();
            for (int i = 0; i < this._dtDocs.Rows.Count; i++)
                if (Convert.ToString(this._dtDocs.Rows[i]["STATUS"]) == "1" || Convert.ToString(this._dtDocs.Rows[i]["STATUS"]) == "2")
                {
                    ListItem liTmp = new ListItem(Convert.ToString(this._dtDocs.Rows[i]["NAME"]), Convert.ToString(this._dtDocs.Rows[i]["ID"]));
                    licTmp.Add(liTmp);
                }

            return licTmp;
        }
    }
    # endregion
    // ===============================================
    # region Constructors
    private void Init(decimal nUserId)
    {
        // Форматирование даты
        dtf.ShortDatePattern = "dd/MM/yyyy";
        dtf.DateSeparator = "/";

        // Форматирование чисел
        nf.NumberDecimalSeparator = ".";
        nf.NumberDecimalDigits = 2;
        nf.NumberGroupSeparator = " ";
        nf.NumberGroupSizes = new int[] { 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 };

        con = Bars.Classes.OraConnector.Handler.UserConnection;
        com.Connection = con;
        adp.SelectCommand = com;

        this._nId = nUserId;
        this.GetUser();
    }
    public ClassUser(decimal nUserId)
    {
        Init(nUserId);
    }
    public ClassUser()
	{
        Init(-1);
    }
    # endregion
    // ===============================================
    # region Public Methods
    /// <summary>
    /// Наполнение дропдауна списка типов юзеров
    /// </summary>
    /// <param name="ddl">Объект дропдауна</param>
    public void FillUserTypes(DropDownList ddl)
    {
        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandType = CommandType.Text;
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.Parameters.Clear();
            com.CommandType = CommandType.Text;
            com.CommandText = "select TYPE_ID as ID, TYPE_NAME as NAME from V_NS_TYPE_STAFF order by TYPE_ID";
            dt.Clear();
            adp.Fill(dt);
        }
        finally
        {
            con.Close();
        }

        DataRow row = dt.NewRow();
        row["ID"] = "-1";
        row["NAME"] = "Пусто";
        dt.Rows.InsertAt(row, 0);

        ddl.DataSource = dt;
        ddl.DataValueField = "ID";
        ddl.DataTextField = "NAME";
        ddl.DataBind();

        ddl.SelectedValue = this._nType.ToString();
    }
    /// <summary>
    /// Наполнение дропдауна списка подразделений
    /// </summary>
    /// <param name="ddl">Объект дропдауна</param>
    public void FillDeps(DropDownList ddl)
    {
        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandType = CommandType.Text;
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.Parameters.Clear();
            com.CommandType = CommandType.Text;
            com.CommandText = "select DEP_ID as sID, DEP_NAME as NAME from V_NS_DEPS order by DEP_ID";
            dt.Clear();
            adp.Fill(dt);
        }
        finally
        {
            con.Close();
        }

        DataRow row = dt.NewRow();
        row["sID"] = "-1";
        row["NAME"] = "Пусто";
        dt.Rows.InsertAt(row, 0);

        ddl.DataSource = dt;
        ddl.DataValueField = "sID";
        ddl.DataTextField = "NAME";
        ddl.DataBind();

        ddl.SelectedValue = this._sDep;
    }
    /// <summary>
    /// Добавляет АРМ из списка доступных
    /// </summary>
    /// <param name="nId">ID АРМа</param>
    public void AddARM(string sId)
    {
        for (int i = 0; i < this._dtARMs.Rows.Count; i++)
            if (Convert.ToString(this._dtARMs.Rows[i]["ID"]) == sId)
            {
                if (Convert.ToString(this._dtARMs.Rows[i]["STATUS"]) == "1") this._dtARMs.Rows[i]["STATUS"] = "3";
                else if (Convert.ToString(this._dtARMs.Rows[i]["STATUS"]) == "2") this._dtARMs.Rows[i]["STATUS"] = "0";
            }
    }
    /// <summary>
    /// Удаляет АРМ из выданых
    /// </summary>
    /// <param name="nId">ID АРМа</param>
    public void DeleteARM(string sId)
    {
        for (int i = 0; i < this._dtARMs.Rows.Count; i++)
            if (Convert.ToString(this._dtARMs.Rows[i]["ID"]) == sId)
            {
                if (Convert.ToString(this._dtARMs.Rows[i]["STATUS"]) == "0") this._dtARMs.Rows[i]["STATUS"] = "2";
                else if (Convert.ToString(this._dtARMs.Rows[i]["STATUS"]) == "3") this._dtARMs.Rows[i]["STATUS"] = "1";
            }
    }
    /// <summary>
    /// Добавляет файл из списка доступных
    /// </summary>
    /// <param name="nId">ID файла</param>
    public void AddFile(int nId)
    {
        for (int i = 0; i < this._dtFiles.Rows.Count; i++)
            if (Convert.ToInt32(this._dtFiles.Rows[i]["ID"]) == nId)
            {
                if (Convert.ToString(this._dtFiles.Rows[i]["STATUS"]) == "1") this._dtFiles.Rows[i]["STATUS"] = "3";
                else if (Convert.ToString(this._dtFiles.Rows[i]["STATUS"]) == "2") this._dtFiles.Rows[i]["STATUS"] = "0";
            }
    }
    /// <summary>
    /// Удаляет файл из выданых
    /// </summary>
    /// <param name="nId">ID файла</param>
    public void DeleteFile(int nId)
    {
        for (int i = 0; i < this._dtFiles.Rows.Count; i++)
            if (Convert.ToInt32(this._dtFiles.Rows[i]["ID"]) == nId)
            {
                if (Convert.ToString(this._dtFiles.Rows[i]["STATUS"]) == "0") this._dtFiles.Rows[i]["STATUS"] = "2";
                else if (Convert.ToString(this._dtFiles.Rows[i]["STATUS"]) == "3") this._dtFiles.Rows[i]["STATUS"] = "1";
            }
    }
    /// <summary>
    /// Добавляет документ из списка доступных
    /// </summary>
    /// <param name="nId">ID документа</param>
    public void AddDoc(int nId)
    {
        for (int i = 0; i < this._dtDocs.Rows.Count; i++)
            if (Convert.ToInt32(this._dtDocs.Rows[i]["ID"]) == nId)
            {
                if (Convert.ToString(this._dtDocs.Rows[i]["STATUS"]) == "1") this._dtDocs.Rows[i]["STATUS"] = "3";
                else if (Convert.ToString(this._dtDocs.Rows[i]["STATUS"]) == "2") this._dtDocs.Rows[i]["STATUS"] = "0";
            }
    }
    /// <summary>
    /// Удаляет документ из выданых
    /// </summary>
    /// <param name="nId">ID документа</param>
    public void DeleteDoc(int nId)
    {
        for (int i = 0; i < this._dtDocs.Rows.Count; i++)
            if (Convert.ToInt32(this._dtDocs.Rows[i]["ID"]) == nId)
            {
                if (Convert.ToString(this._dtDocs.Rows[i]["STATUS"]) == "0") this._dtDocs.Rows[i]["STATUS"] = "2";
                else if (Convert.ToString(this._dtDocs.Rows[i]["STATUS"]) == "3") this._dtDocs.Rows[i]["STATUS"] = "1";
            }
    }
    /// <summary>
    /// Сохранить изменения
    /// </summary>
    public void Save()
    {
        this.SaveUser();
    }
    /// <summary>
    /// Удалить пользователя
    /// </summary>
    public void Delete()
    {
        this.DeleteUser();
    }
    # endregion
    // ===============================================
    # region Private Methods
    private void GetUser()
    {
        DataTable dtARMs = new DataTable();

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandType = CommandType.Text;
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            if (!this.bIsNewUser)
            {
                com.Parameters.Clear();
                com.Parameters.Add("pId", OracleDbType.Decimal, this._nId, ParameterDirection.Input);
                com.CommandType = CommandType.Text;
                com.CommandText = "select * from V_NS_STAFF where STAFF_ID = :pId";
                dt.Clear();
                adp.Fill(dt);

                // наполняем класс данными
                if (dt.Rows.Count > 0)
                {
                    this._sFIO = Convert.ToString(dt.Rows[0]["FIO"]);
                    this._sLogin = Convert.ToString(dt.Rows[0]["LOGNAME"]);
                    this._nType = Convert.ToDecimal(dt.Rows[0]["TYPE_ID"]);
                    this._sDep = Convert.ToString(dt.Rows[0]["DEP_ID"]);
                    this._sTabN = Convert.ToString(dt.Rows[0]["TABN"]);
                }
                else
                {
                    //!!! сделать свой Exception
                    throw new Exception("Не найден пользователь по заданному Id");
                }
            }

            this._dtARMs.Clear();

            com.Parameters.Clear();
            com.Parameters.Add("pId", OracleDbType.Decimal, this._nId, ParameterDirection.Input);
            com.CommandType = CommandType.Text;
            com.CommandText = "select '0' as STATUS, ARM_ID as ID, ARM_NIK || ' - ' || ARM_NAME as NAME from V_NS_SAR where STAFF_ID = :pId order by ARM_ID";
            adp.Fill(this._dtARMs);

            com.Parameters.Clear();
            com.Parameters.Add("pId", OracleDbType.Decimal, this._nId, ParameterDirection.Input);
            com.CommandType = CommandType.Text;
            com.CommandText = "select '1' as STATUS, ARM_ID as ID, ARM_NIK || ' - ' || ARM_NAME as NAME from V_NS_ARM where ARM_ID not in (select ARM_ID from V_NS_SAR where STAFF_ID = :pId) order by ARM_ID";
            adp.Fill(this._dtARMs);
            
            this._dtFiles.Clear();

            com.Parameters.Clear();
            com.Parameters.Add("pId", OracleDbType.Decimal, this._nId, ParameterDirection.Input);
            com.CommandType = CommandType.Text;
            com.CommandText = "select '0' as STATUS, FILE_ID as ID, '(' || KODF || '-' || A017 || ') ' || FILE_NAME as NAME from V_NS_SFI where STAFF_ID = :pId order by FILE_ID";
            adp.Fill(this._dtFiles);

            com.Parameters.Clear();
            com.Parameters.Add("pId", OracleDbType.Decimal, this._nId, ParameterDirection.Input);
            com.CommandType = CommandType.Text;
            com.CommandText = "select '1' as STATUS, FILE_ID as ID, '(' || KODF || '-' || A017 || ') ' || FILE_NAME as NAME from V_NS_FILES where FILE_ID not in (select FILE_ID from V_NS_SFI where STAFF_ID = :pId) order by FILE_ID";
            adp.Fill(this._dtFiles);

            this._dtDocs.Clear();

            com.Parameters.Clear();
            com.Parameters.Add("pId", OracleDbType.Decimal, this._nId, ParameterDirection.Input);
            com.CommandType = CommandType.Text;
            com.CommandText = "select '0' as STATUS, DOC_ID as ID, '(' || DOC_NUM || '-' || DOC_PERIOD || ') ' || DOC_NAME as NAME from V_NS_SDO where STAFF_ID = :pId order by DOC_ID";
            adp.Fill(this._dtDocs);

            com.Parameters.Clear();
            com.Parameters.Add("pId", OracleDbType.Decimal, this._nId, ParameterDirection.Input);
            com.CommandType = CommandType.Text;
            com.CommandText = "select '1' as STATUS, DOC_ID as ID, '(' || DOC_NUM || '-' || DOC_PERIOD || ') ' || DOC_NAME as NAME from V_NS_DOCS where DOC_ID not in (select DOC_ID from V_NS_SDO where STAFF_ID = :pId) order by DOC_ID";
            adp.Fill(this._dtDocs);
        }
        finally
        {
            con.Close();
        }
    }

    private void DeleteUser()
    {
        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandType = CommandType.Text;
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.Parameters.Clear();

            com.Parameters.Add("staff_id_", OracleDbType.Decimal, this._nId, ParameterDirection.InputOutput);
            com.Parameters.Add("fio_", OracleDbType.Varchar2, this._sFIO, ParameterDirection.Input);
            com.Parameters.Add("logname_", OracleDbType.Varchar2, this._sLogin, ParameterDirection.Input);
            com.Parameters.Add("psw_", OracleDbType.Varchar2, this._sPassword, ParameterDirection.Input);
            com.Parameters.Add("tabn_", OracleDbType.Varchar2, this._sTabN, ParameterDirection.Input);
            com.Parameters.Add("type_id_", OracleDbType.Decimal, this._nType, ParameterDirection.Input);
            com.Parameters.Add("dep_id_", OracleDbType.Varchar2, this._sDep, ParameterDirection.Input);
            com.Parameters.Add("flag_", OracleDbType.Decimal, 2, ParameterDirection.Input);
            com.CommandType = CommandType.StoredProcedure;
            com.CommandText = "NS_EDIT_STAFF";
            com.ExecuteNonQuery();
        }
        finally
        {
            con.Close();
        }
        DeleteUserMap(this._sLogin);
    }
    private void SaveUser()
    {
        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            bool bNewUser = this.bIsNewUser;

            com.CommandType = CommandType.Text;
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sClassRole);
            com.ExecuteNonQuery();

            com.Parameters.Clear();

            if (!bNewUser) com.Parameters.Add("staff_id_", OracleDbType.Decimal, this._nId, ParameterDirection.InputOutput);
            else com.Parameters.Add("staff_id_", OracleDbType.Decimal, null, ParameterDirection.InputOutput);

            com.Parameters.Add("fio_", OracleDbType.Varchar2, this._sFIO, ParameterDirection.Input);
            com.Parameters.Add("logname_", OracleDbType.Varchar2, this._sLogin, ParameterDirection.Input);
            com.Parameters.Add("psw_", OracleDbType.Varchar2, this._sPassword, ParameterDirection.Input);
            com.Parameters.Add("tabn_", OracleDbType.Varchar2, this._sTabN, ParameterDirection.Input);
            com.Parameters.Add("type_id_", OracleDbType.Decimal, this._nType, ParameterDirection.Input);
            com.Parameters.Add("dep_id_", OracleDbType.Varchar2, this._sDep, ParameterDirection.Input);
            com.CommandType = CommandType.StoredProcedure;
            com.CommandText = "NS_EDIT_STAFF";
            com.ExecuteNonQuery();

            this._nId = ((OracleDecimal)com.Parameters["staff_id_"].Value).Value;

            for(int i=0; i<this._dtARMs.Rows.Count; i++)
                if(Convert.ToString(this._dtARMs.Rows[i]["STATUS"]) == "2")
                {
                    com.Parameters.Clear();
                    com.Parameters.Add("staff_id_", OracleDbType.Decimal, this._nId, ParameterDirection.InputOutput);
                    com.Parameters.Add("arm_id_", OracleDbType.Varchar2, Convert.ToString(this._dtARMs.Rows[i]["ID"]), ParameterDirection.Input);
                    com.Parameters.Add("mode_", OracleDbType.Decimal, 1, ParameterDirection.Input);
                    com.CommandType = CommandType.StoredProcedure;
                    com.CommandText = "NS_EDIT_STAFF_ARM";
                    com.ExecuteNonQuery();
                }
                else if(Convert.ToString(this._dtARMs.Rows[i]["STATUS"]) == "3")
                {
                    com.Parameters.Clear();
                    com.Parameters.Add("staff_id_", OracleDbType.Decimal, this._nId, ParameterDirection.InputOutput);
                    com.Parameters.Add("arm_id_", OracleDbType.Varchar2, Convert.ToString(this._dtARMs.Rows[i]["ID"]), ParameterDirection.Input);
                    com.Parameters.Add("mode_", OracleDbType.Decimal, 0, ParameterDirection.Input);
                    com.CommandType = CommandType.StoredProcedure;
                    com.CommandText = "NS_EDIT_STAFF_ARM";
                    com.ExecuteNonQuery();
                }

            for (int i = 0; i < this._dtFiles.Rows.Count; i++)
                if (Convert.ToString(this._dtFiles.Rows[i]["STATUS"]) == "2")
                {
                    com.Parameters.Clear();
                    com.Parameters.Add("staff_id_", OracleDbType.Decimal, this._nId, ParameterDirection.InputOutput);
                    com.Parameters.Add("doc_id_", OracleDbType.Int32, Convert.ToInt32(this._dtFiles.Rows[i]["ID"]), ParameterDirection.Input);
                    com.Parameters.Add("mode_", OracleDbType.Decimal, 1, ParameterDirection.Input);
                    com.CommandType = CommandType.StoredProcedure;
                    com.CommandText = "NS_EDIT_STAFF_FILES";
                    com.ExecuteNonQuery();
                }
                else if (Convert.ToString(this._dtFiles.Rows[i]["STATUS"]) == "3")
                {
                    com.Parameters.Clear();
                    com.Parameters.Add("staff_id_", OracleDbType.Decimal, this._nId, ParameterDirection.InputOutput);
                    com.Parameters.Add("doc_id_", OracleDbType.Int32, Convert.ToInt32(this._dtFiles.Rows[i]["ID"]), ParameterDirection.Input);
                    com.Parameters.Add("mode_", OracleDbType.Decimal, 0, ParameterDirection.Input);
                    com.CommandType = CommandType.StoredProcedure;
                    com.CommandText = "NS_EDIT_STAFF_FILES";
                    com.ExecuteNonQuery();
                } 
            
            for (int i = 0; i < this._dtDocs.Rows.Count; i++)
                if (Convert.ToString(this._dtDocs.Rows[i]["STATUS"]) == "2")
                {
                    com.Parameters.Clear();
                    com.Parameters.Add("staff_id_", OracleDbType.Decimal, this._nId, ParameterDirection.InputOutput);
                    com.Parameters.Add("doc_id_", OracleDbType.Int32, Convert.ToInt32(this._dtDocs.Rows[i]["ID"]), ParameterDirection.Input);
                    com.Parameters.Add("mode_", OracleDbType.Decimal, 1, ParameterDirection.Input);
                    com.CommandType = CommandType.StoredProcedure;
                    com.CommandText = "NS_EDIT_STAFF_DOCS";
                    com.ExecuteNonQuery();
                }
                else if (Convert.ToString(this._dtDocs.Rows[i]["STATUS"]) == "3")
                {
                    com.Parameters.Clear();
                    com.Parameters.Add("staff_id_", OracleDbType.Decimal, this._nId, ParameterDirection.InputOutput);
                    com.Parameters.Add("doc_id_", OracleDbType.Int32, Convert.ToInt32(this._dtDocs.Rows[i]["ID"]), ParameterDirection.Input);
                    com.Parameters.Add("mode_", OracleDbType.Decimal, 0, ParameterDirection.Input);
                    com.CommandType = CommandType.StoredProcedure;
                    com.CommandText = "NS_EDIT_STAFF_DOCS";
                    com.ExecuteNonQuery();
                }

            // Делаем запись в UserMap.Config
            if (bNewUser)
                CreateUserMap(this._sLogin, 0, this.sPassworHash, "Веб-пользователь " + this._sLogin, 0);
            
            /* Изменение пароля не доступно
            else
                EditUserMap(this._sLogin, 0, this._sPassword, "Веб-пользователь " + this._sLogin, 0);
             */
        }
        finally
        {
            con.Close();
        }

        // перечитываем данные
        this.GetUser();
    }
    private void CreateUserMap(string sLogName, int nErrMode, string sAdminPass, string sComm, int nBlock)
    {
        bool secEnabled = (ConfigurationSettings.AppSettings.Get("CustomAuthentication.SecureValidation") == "Off") ? (false) : (true);
        XmlDocument doc = ConfigurationSettings.UserMapConfiguration;

        XmlNode section = doc.SelectSingleNode("//userMapSettings");
        XmlNode node = section.ChildNodes[0].Clone();
        node.Attributes["webuser"].Value = sLogName.Trim().ToLower();
        node.Attributes["dbuser"].Value = sLogName.Trim();
        node.Attributes["errormode"].Value = nErrMode.ToString();
        if (secEnabled)
        {
            node.Attributes["adminpass"].Value = sAdminPass.Trim();
            if (sAdminPass.Trim() != string.Empty)
                node.Attributes["webpass"].Value = "";
        }
        else
        {
            if (sAdminPass.Trim() != string.Empty)
                node.Attributes["webpass"].Value = sAdminPass.Trim();
            node.Attributes["adminpass"].Value = "";
        }

        node.Attributes["comm"].Value = sComm.Trim();
        node.Attributes["blocked"].Value = nBlock.ToString();
        node.Attributes["attemps"].Value = "0";
        node.Attributes["chgdate"].Value = "";
        
        section.AppendChild(node);

        ConfigurationSettings.SaveXmlConfiguration(doc, 2);
        AppDomain.CurrentDomain.SetData("userMapSettings", null);
        AppDomain.CurrentDomain.SetData("UserMapConfiguration", null);
    }
    private void EditUserMap(string sLogName, int nErrMode, string sAdminPass, string sComm, int nBlock)
    {
        bool secEnabled = (ConfigurationSettings.AppSettings.Get("CustomAuthentication.SecureValidation") == "Off") ? (false) : (true);
        XmlDocument doc = ConfigurationSettings.UserMapConfiguration;

        XmlNode section = doc.SelectSingleNode("//userMapSettings");

        foreach (XmlNode node in section.ChildNodes)
        {
            if (node.NodeType != XmlNodeType.Comment)
            {
                if (sLogName.Trim().ToLower() == node.Attributes["webuser"].Value.ToLower())
                {
                    node.Attributes["dbuser"].Value = sLogName.Trim();
                    node.Attributes["errormode"].Value = nErrMode.ToString();
                    if (secEnabled)
                    {
                        node.Attributes["adminpass"].Value = sAdminPass.Trim();
                        if (sAdminPass.Trim() != string.Empty)
                            node.Attributes["webpass"].Value = "";
                    }
                    else
                    {
                        if (sAdminPass.Trim() != string.Empty)
                            node.Attributes["webpass"].Value = sAdminPass.Trim();
                        node.Attributes["adminpass"].Value = "";
                    }
                    node.Attributes["comm"].Value = sComm.Trim();
                    node.Attributes["blocked"].Value = nBlock.ToString();
                    node.Attributes["attemps"].Value = "0";
                }
            }
        }

        ConfigurationSettings.SaveXmlConfiguration(doc, 2);
        AppDomain.CurrentDomain.SetData("userMapSettings", null);
        AppDomain.CurrentDomain.SetData("UserMapConfiguration", null);
    }

    private void DeleteUserMap(string sLogName)
    {
        bool secEnabled = (ConfigurationSettings.AppSettings.Get("CustomAuthentication.SecureValidation") == "Off") ? (false) : (true);
        XmlDocument doc = ConfigurationSettings.UserMapConfiguration;

        XmlNode section = doc.SelectSingleNode("//userMapSettings");

        foreach (XmlNode node in section.ChildNodes)
        {
            if (node.NodeType != XmlNodeType.Comment)
            {
                if (sLogName.Trim().ToLower() == node.Attributes["webuser"].Value.ToLower())
                    section.RemoveChild(node);
            }
        }
        ConfigurationSettings.SaveXmlConfiguration(doc, 2);
        AppDomain.CurrentDomain.SetData("userMapSettings", null);
        AppDomain.CurrentDomain.SetData("UserMapConfiguration", null);
    }
    # endregion
}
