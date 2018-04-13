using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace Bars.UserControls
{
    /// <summary>
    /// Схема работы с идент. документами
    /// </summary>
    public class IDDocScheme
    {
        /// <summary>
        /// Фото клиента (в ЭА не передается):
        /// 0. Фото клиента отключено
        /// 1. Вырезает менеджер из сканкопии/фото паспорта
        /// 2. Далет менеджер через веб-камеру (реальное фото клиента)
        /// 3. Вырезается в Бэк-офисе через интерфейс архива (АБС получит через дополнительный сервис ЭА) !!! пока не реализовано
        /// </summary>
        public Int16 ClientPhoto
        {
            get;
            set;
        }

        /// <summary>
        /// Подпись клиента (в ЭА не передается):
        /// 0. Подпись клиента отключено
        /// 1. Вырезает менеджер из сканкопии/фото паспорта
        /// 2. Вырезается в Бэк-офисе через интерфейс архива (АБС получит через дополнительный сервис ЭА) !!! пока не реализовано
        /// </summary>
        public Int16 ClientSign
        {
            get;
            set;
        }

        /// <summary>
        /// Копия оригиналов идент документов (паспорт, код):
        /// 0. Копии оригиналов отключены (в ЭА передаваться не будет)
        /// 1. Документы сканируются/фотографируются менеджером (попадет в ЭА онлайн)
        /// 2. Система формирует шаблон с QR-кодом и БЕЗ текста "копия верна" для последующего ксерокопирования на нем (попадет в ЭА через потоковый скан)
        /// </summary>
        public Int16 DocsOriginals
        {
            get;
            set;
        }

        /// <summary>
        /// Заверенные копии оригиналов идент документов (паспорт, код):
        /// 0. Копии оригиналов отключены (в ЭА передаваться не будет)
        /// 1. Документы сканируются/фотографируются менеджером после чего распечатываются с QR-кодом и текстом "копия верна" (попадет в ЭА через потоковый скан)
        /// 2. Система формирует шаблон с QR-кодом и текстом "копия верна" для последующего ксерокопирования на нем (попадет в ЭА через потоковый скан)
        /// </summary>
        public Int16 DocsSignedCopies
        {
            get;
            set;
        }

        public IDDocScheme()
        {
            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();

            try
            {
                cmd.CommandText = @"select *
                                  from (select bp.branch, bp.val
                                          from branch_parameters bp
                                         where bp.tag = 'EBP_IDDOCSCHEME'
                                           and sys_context('bars_context', 'user_branch') like
                                               bp.branch || '%'
                                           and regexp_like(bp.val, '^\d{4}$')
                                         order by bp.branch desc)
                                 where rownum = 1";

                OracleDataReader rdr = cmd.ExecuteReader();
                try
                {
                    if (rdr.Read())
                    {
                        String Val = (String)rdr["val"];

                        this.ClientPhoto = Convert.ToInt16(Val.Substring(0, 1));
                        this.ClientSign = Convert.ToInt16(Val.Substring(1, 1));
                        this.DocsOriginals = Convert.ToInt16(Val.Substring(2, 1));
                        this.DocsSignedCopies = Convert.ToInt16(Val.Substring(3, 1));
                    }
                    else
                        throw new System.Exception("Не задано параметр відділення EBP_IDDOCSCHEME або він задан з помилкою");
                }
                finally
                {
                    rdr.Close();
                    rdr.Dispose();
                }
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }
    }
}