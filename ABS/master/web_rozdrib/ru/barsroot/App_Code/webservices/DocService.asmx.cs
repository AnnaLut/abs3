using System;
using System.ComponentModel;
using System.Web.Services;

namespace Bars.WebServices
{
    /// <summary>
    /// Сервис для работы с документом
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [ToolboxItem(false)]
    
    public class DocService : BarsWebService
    {
        /// <summary>
        /// Берем ключ операциониста
        /// </summary>
        [WebMethod(EnableSession = true)]
        public string GetIdOper()
        {
            object tmp;

            InitOraConnection();
            try
            {
                // используем роль приложения просмотра карточки документа
                SetRole("WR_DOCVIEW");

                tmp = SQL_SELECT_scalar(@"select docsign.GetIdOper from dual");
            }
            finally
            {
                DisposeOraConnection();
            }

            return (tmp == null) ? (String.Empty) : (Convert.ToString(tmp));
        }

        /// <summary>
        /// Получаем СЭП буффер документа
        /// </summary>
        /// <param name="pref">Референс документа</param>
        /// <param name="id_oper">Ключ операциониста</param>
        /// <param name="buf">Буффер</param>
        [WebMethod(EnableSession = true)]
        public void RetrieveSEPBuffer(long pref, string id_oper, out string buf)
        {
            buf = new string(' ', 444);

            InitOraConnection();
            try
            {
                // используем роль приложения просмотра карточки документа
                SetRole("WR_DOCVIEW");

                ClearParameters();
                
                SetParameters("pref", DB_TYPE.Int64, pref, DIRECTION.Input);
                SetParameters("id_oper", DB_TYPE.Varchar2, id_oper, DIRECTION.Input);
                SetParameters("buf", DB_TYPE.Varchar2, buf.Length, buf, DIRECTION.Output);
                
                SQL_NONQUERY(@"begin docsign.RetrieveSEPBuffer(:pref,:id_oper,:buf); end;");

                buf = (GetParameter("buf") == DBNull.Value) ? (String.Empty) : (Convert.ToString(GetParameter("buf")));
            }
            finally
            {
                DisposeOraConnection();
            }
        }

        /// <summary>
        /// Записывает полученую подпись СЭП
        /// </summary>
        /// <param name="pref">Референс документа</param>
        /// <param name="buf">Буффер</param>
        /// <param name="id_oper">Ключ операциониста</param>
        /// <param name="bsign">Подпись</param>
        [WebMethod(EnableSession = true)]
        public void StoreSEPSign(long pref, string buf, string id_oper, string bsign)
        {
            InitOraConnection();
            try
            {
                // используем роль приложения просмотра карточки документа
                SetRole("WR_DOCVIEW");

                // конвертируем подпись
                byte[] sign_buf = new byte[bsign.Length / 2];
                int j = 0;
                for (int i = 0; i < bsign.Length; i = i + 2)
                {
                    sign_buf[j++] = Convert.ToByte(bsign.Substring(i, 2), 16);
                }

                ClearParameters();

                SetParameters("pref", DB_TYPE.Int64, pref, DIRECTION.Input);
                SetParameters("buf", DB_TYPE.Varchar2, buf, DIRECTION.Input);
                SetParameters("id_oper", DB_TYPE.Varchar2, id_oper, DIRECTION.Input);
                SetParameters("bsign", DB_TYPE.Raw, sign_buf.Length, sign_buf, DIRECTION.Input);

                SQL_NONQUERY(@"begin docsign.StoreSEPSign(:pref,:buf,:id_oper,:bsign); end;");
            }
            finally
            {
                DisposeOraConnection();
            }
        }
    }
}
