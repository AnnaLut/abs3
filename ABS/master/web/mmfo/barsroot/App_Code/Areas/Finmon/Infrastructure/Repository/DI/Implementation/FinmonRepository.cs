using Areas.Finmon.Models;
using BarsWeb.Areas.Finmon.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;
using Bars.Classes;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Data;

namespace BarsWeb.Areas.Finmon.Infrastructure.Repository.DI.Implementation
{
    public class FinmonRepository : IFinmonRepository
    {
        private readonly FinmonModel _entities;
        public FinmonRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("FmonModel", "Finmon");
            _entities = new FinmonModel(connectionStr);
        }

        public System.Linq.IQueryable<V_OPER_FM> GetOperFm()
        {
            return _entities.V_OPER_FM;
        }

        /// <summary>
        /// Загрузка ФМ-файла - списка террористов / публичных деятелей
        /// </summary>
        /// <param name="fileType">Тип файла для загрузки: (Terr, PEP, KIS) -> (террористы, публичные от pep.org.ua, публичные от ТОВ "КИС")</param>
        /// <param name="data">Содержимое файла</param>
        /// <returns>"Завантажено %n записів"</returns>
        public string ImportFile(string fileType, string data)
        {
            decimal? imported = 0;
            using (var connection = OraConnector.Handler.UserConnection)
            {
                string importProc = "";
                if (fileType == "Terr")
                    importProc = "BARS.FM_TERRORIST_UTL.IMPORT_XY_FILE";
                else
                    if (fileType == "PEP")
                    importProc = "BARS.FM_PUBLIC_UTL.IMPORT_PEP_FILE";
                else
                        if (fileType == "KIS")
                    importProc = "BARS.FM_PUBLIC_UTL.IMPORT_PUBLIC_FILE";
                OracleCommand command = new OracleCommand(importProc, connection);
                OracleParameter p_imported = new OracleParameter("p_imported", OracleDbType.Decimal, imported, ParameterDirection.Output);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("p_clob", OracleDbType.Clob, data, ParameterDirection.Input);
                command.Parameters.Add(p_imported);
                command.ExecuteNonQuery();
                imported = ((OracleDecimal)p_imported.Value).Value;
            }
            return "Завантажено " + imported.ToString() + " записів.";
        }
    }
}