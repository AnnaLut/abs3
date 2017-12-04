using System;
using System.Data;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.Crkr.Infrastructure.Helper
{
    public class InteractionWithProc
    {
        /// <summary>
        /// Метод для создания Oracle команды
        /// </summary>
        /// <param name="connection"></param>
        /// <param name="commandText">Название процедуры в базе данных</param>
        /// <returns>Возвращает созданную команду</returns>
        protected OracleCommand MakeCommand(OracleConnection connection, string commandText)
        {
            //var connections = OraConnector.Handler.IOraConnection.GetUserConnection();
            var command = connection.CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = commandText;
            return command;
        }

        /// <summary>
        /// Метод для возвращения кода из Oracle процедуры
        /// </summary>
        /// <param name="command"></param>
        /// <returns>Возвращает decimal код елси p_ret больше 0, либо текстовое сообщение с ошибкой, если p_ret меньше 0</returns>
        protected decimal ReturnValues(OracleCommand command)
        {
            var errorMessage = ((OracleString)command.Parameters["p_err"].Value).IsNull ? string.Empty : ((OracleString)command.Parameters["p_err"].Value).Value;
            var outputCode = ((OracleDecimal)command.Parameters["p_ret"].Value).IsNull ? 0 : ((OracleDecimal)command.Parameters["p_ret"].Value).Value;
            if (outputCode >= 0)
                return outputCode;
            throw new Exception(errorMessage);
        }
    }
}