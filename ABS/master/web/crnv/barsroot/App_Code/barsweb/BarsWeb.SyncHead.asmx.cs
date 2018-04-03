using System.ComponentModel;
using System.Web.Services;
using Bars.Oracle;
using Bars.Application;
using System;
using System.Collections;
using System.Web;
using System.Web.Services.Protocols;
using Oracle.DataAccess.Client;

namespace barsweb
{
    /// <summary>
    /// Summary description for SyncHead.
    /// </summary>
    /// 
    public class SyncHead : WebService
    {
        public SyncHead()
        {
            //CODEGEN: This call is required by the ASP.NET Web Services Designer
            InitializeComponent();
        }

        #region Component Designer generated code

        //Required by the Web Services Designer 
        private IContainer components = null;

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
        }

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        protected override void Dispose(bool disposing)
        {
            if (disposing && components != null)
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #endregion

        [WebMethod(EnableSession = true)]
        public string CheckEDocs()
        {
            string result = String.Empty;
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection(Context);
            try
            {
                OracleCommand command = connect.CreateCommand();
                command.CommandText = conn.GetSetRoleCommand("basic_info");
                command.ExecuteNonQuery();

                // вычитываем наличие роли WR_EDOCS
                command.CommandText = "select to_char(web_utl.is_role_granted('wr_edocs')) from dual";

                //проверить наличие не подписанных экспортируемых проводок
                if ("1" == Convert.ToString(command.ExecuteScalar()))
                {
                    command.CommandText = @"begin bars_role_auth.set_role('WR_EDOCS');end;";
                    command.ExecuteNonQuery();
                    command.CommandText = "select bars_edocs.edocs_found from dual";
                    result = Convert.ToString(command.ExecuteScalar()) == "1" ? "2" : String.Empty;
                }

            }
            finally
            {
                connect.Close();
                connect.Dispose();
            }
            return result;
        }

        [WebMethod(EnableSession = true)]
        public string[] GetHeadData(string old_date, string checkVis)
        {

            string[] headData = new string[6];
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection();
            try
            {
                OracleCommand command = connect.CreateCommand();
                command.CommandText = conn.GetSetRoleCommand("basic_info");
                command.ExecuteNonQuery();

                // вычитываем банковскую дату, код отделения и наличие ролей WR_EDOCS*
                command.CommandText =
                    @"select 
                        to_char(web_utl.get_bankdate,'dd.MM.yyyy'), 
					    tobopack.gettobo, 
                        web_utl.is_bankdate_accessible(web_utl.get_bankdate),
                        web_utl.can_user_change_date,
                        web_utl.is_bankdate_open
                        from dual";

                OracleDataReader reader = command.ExecuteReader();
                int isBankDateAccessible = 0;
                int isCanUserChangeDate = 0;
                int isBankdateOpen = 1;
                if (reader.Read())
                {
                    headData[0] = reader.GetString(0);
                    headData[1] = reader.GetString(1);
                    isBankDateAccessible = Convert.ToInt32(reader.GetValue(2));
                    isCanUserChangeDate = Convert.ToInt32(reader.GetValue(3));
                    isBankdateOpen = Convert.ToInt32(reader.GetValue(4));
                }
                reader.Close();
                reader.Dispose();
                // пользовательская дата закрыта
                if (isBankdateOpen == 0)
                {
                    headData[0] = "closeBankdate";
                    return headData;
                }

                if (isBankDateAccessible == 0 && isCanUserChangeDate == 0)
                    SetLocalDateAsGlobal();	// установить локальную равной глобальной

                headData[4] = isBankDateAccessible.ToString();
                headData[5] = isCanUserChangeDate.ToString();

                if (checkVis != "1")
                {
                    return headData;
                }
                //Сообщение о наличии незавизированых документов
                /*command.CommandText = "select nvl(min(to_number(val)),0) from params where par='W_CH_VIS'";
                string w_ch_vis = Convert.ToString(command.ExecuteScalar());
                if (w_ch_vis == "1")
                {
                    command.CommandText = "select Web_Check_Visa() from dual";
                    headData[3] = Convert.ToString(command.ExecuteScalar());
                }*/
            }
            finally
            {
                connect.Close();
                connect.Dispose();
            }

            return headData;
        }

        /// <summary>
        /// Устанавливает локальную дату пользователя в таблице staff_bankdates
        /// равной глобальной дате
        /// </summary>
        [WebMethod(EnableSession = true)]
        public void SetLocalDateAsGlobal()
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection(Context);
            try
            {
                // получаем данные из БД
                OracleCommand command = connect.CreateCommand();
                command.CommandText = conn.GetSetRoleCommand("basic_info");
                command.ExecuteNonQuery();

                OracleTransaction tx = connect.BeginTransaction();
                bool txCommited = false;
                try
                {
                    command.CommandText = "begin web_utl.set_localdate_as_global; end;";
                    command.ExecuteNonQuery();
                    tx.Commit();
                    txCommited = true;
                }
                finally
                {
                    if (!txCommited) tx.Rollback();
                }
            }
            finally
            {
                connect.Close();
                connect.Dispose();
            }
        }

        [WebMethod(EnableSession = true)]
        public void ChangeSchema(string schema)
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection(Context);
            try
            {
                // получаем данные из БД
                OracleCommand command = connect.CreateCommand();
                command.CommandText = conn.GetSetRoleCommand("basic_info");
                command.ExecuteNonQuery();

                OracleTransaction tx = connect.BeginTransaction();
                bool txCommited = false;
                try
                {
                    command.Parameters.Add("shema", OracleDbType.Varchar2, schema, System.Data.ParameterDirection.Input);
                    command.CommandText = "begin bars_context.set_cschema(:schema); end;";
                    command.ExecuteNonQuery();
                    tx.Commit();
                    txCommited = true;
                }
                finally
                {
                    if (!txCommited) tx.Rollback();
                }
            }
            finally
            {
                connect.Close();
                connect.Dispose();
            }
        }
    }
}
