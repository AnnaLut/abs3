using System;
using System.Collections.Generic;
using Oracle.DataAccess.Client;
using BarsWeb.Areas.LinkedGroupReference.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.LinkedGroupReference.Models;
using Bars.Classes;
using System.Data;
using Dapper;
using Oracle.DataAccess.Types;
using System.ComponentModel;
using System.Linq;

namespace BarsWeb.Areas.LinkedGroupReference.Infrastructure.Repository.DI.Implementation
{
    public class LinkedGroupReferenceRepository : ILinkedGroupReferenceRepository
    {

        /// <summary>
        /// Конвертация списка в DataTable - вспомогательный метод; в дальнейшем есть смысл вынести в общий класс
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="data"></param>
        /// <returns></returns>
        public DataTable ListToDataTable<T>(IList<T> data)
        {
            PropertyDescriptorCollection props =
                TypeDescriptor.GetProperties(typeof(T));
            DataTable table = new DataTable();
            for (int i = 0; i < props.Count; i++)
            {
                PropertyDescriptor prop = props[i];
                table.Columns.Add(prop.Name, Nullable.GetUnderlyingType(prop.PropertyType) ?? prop.PropertyType);
            }
            object[] values = new object[props.Count];
            foreach (T item in data)
            {
                for (int i = 0; i < values.Length; i++)
                {
                    values[i] = props[i].GetValue(item);
                }
                table.Rows.Add(values);
            }
            return table;
        }

        /// <summary>
        /// Конвертация в систему исчисления с произвольным основанием
        /// </summary>
        /// <param name="value"></param>
        /// <param name="baseChars"></param>
        /// <returns></returns>
        public static string IntToStringFast(int value, char[] baseChars)
        {
            
            // 32 is the worst cast buffer size for base 2 and int.MaxValue
            int i = 32;
            char[] buffer = new char[i];
            int targetBase = baseChars.Length;

            do
            {
                buffer[--i] = baseChars[value % targetBase];
                value = value / targetBase;
            }
            while (value > 0);

            char[] result = new char[32 - i];
            Array.Copy(buffer, i, result, 0, 32 - i);

            return new string(result);
        }


        public void ClearLinkedGroups()
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var sql = "bars.p_clear_tmp_link_groups";
                using (OracleCommand cmd = new OracleCommand(sql, connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();
                }
            }
        }

        //Inserting all the records from Excel Reference file
        //If something goes wrong no record should be commited
        public void InsertLinkGroups(List<LinkGroup> groupList)
        {
            OracleConnection connect = new OracleConnection();
            using (connect = OraConnector.Handler.UserConnection)
            {
                var transaction = connect.BeginTransaction();
                try
                {
                    char[] baseChars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".ToCharArray();
                    groupList.ForEach(x => x.Link_Code = IntToStringFast(Convert.ToInt32(x.Link_Group), baseChars));

                    DataTable dt = ListToDataTable(groupList.Select(x => new { x.OKPO, x.Link_Group, S_MAIN = new Decimal(), x.Link_Code,  x.GroupName, x.RNK, MFO = x.KF }).ToList());

                    OracleBulkCopy blk = new OracleBulkCopy(connect);
                    blk.BatchSize = groupList.Count;
                    blk.DestinationTableName = "BARS.D8_CUST_LINK_GROUPS";
                    blk.WriteToServer(dt);

                    transaction.Commit();
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    throw ex;
                }
            }
        }

        //Calls procedure that sets link groups on client cards and returns log file
        //In case everything was correct - file is Empty
        //Otherwise it has text log
        public String SetLinkGroups()
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var sql = "bars.p_set_link_groups";

                using (OracleCommand cmd = new OracleCommand(sql, connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("p_errlog", OracleDbType.Clob, ParameterDirection.Output);
                    cmd.ExecuteNonQuery();

                    using (OracleClob resClob = (OracleClob)cmd.Parameters["p_errlog"].Value)
                    {
                        return resClob.Length != 0 ? resClob.Value : string.Empty;
                    }
                }
            }
            
        }

        public List<string> GetMFOList()
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var sql = "Select KF from bars.kf_ru";
                return connection.Query<string>(sql).AsList();
            }
        }
    }

}
