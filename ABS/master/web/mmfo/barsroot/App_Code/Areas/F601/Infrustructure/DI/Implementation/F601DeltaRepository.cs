using System;
using System.Data;
using System.Data.Objects;
using System.Collections.Generic;
using System.Linq;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;
using BarsWeb.Models;
using BarsWeb.Core.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.F601.Models;

namespace BarsWeb.Areas.F601.Infrastructure.DI
{

    /// <summary>
    /// Summary description for F601DeltaRepository
    /// </summary>
    public class F601DeltaRepository: IF601DeltaRepository
    {
        public F601DeltaRepository()
        {
        }
        /// <summary>
        /// Получить список звітів НБУ по 601 формі
        /// </summary>
        /// <returns>список звітів</returns>
        public List<NBUReportInstance> GetReports()
        {
            List<NBUReportInstance> reports = new List<NBUReportInstance>();
            BarsSql sql = SqlCreator.GetNBUReports();
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand cmd = connection.CreateCommand())
                {
                    cmd.CommandText = sql.SqlText;

                    using (OracleDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            reports.Add(new NBUReportInstance()
                            {
                                ID = Convert.ToInt64(reader["ID"]),
                                REPORTING_DATE = Convert.ToDateTime(reader["REPORTING_DATE"]),
                                STAGE_NAME = Convert.ToString(reader["STAGE_NAME"])
                            });
                        }
                    }
                }
            }

            return reports;
        }
        /// <summary>
        /// Отримати список сесій по обраному звіту по 601 формі
        /// </summary>
        /// <param name="id">ID Звіту</param>
        /// <returns></returns>
        public List<NBUSessionHistory> GetNBUSessionHistory(Decimal? id)
        {
            List<NBUSessionHistory> sessions = new List<NBUSessionHistory>();
            BarsSql sql = SqlCreator.GetNBUSessionHistory(id);
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand cmd = connection.CreateCommand())
                {
                    cmd.CommandText = sql.SqlText;
                    cmd.Parameters.AddRange(sql.SqlParams);
                    using (OracleDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            sessions.Add(new NBUSessionHistory()
                            {
                                ID = Convert.ToInt64(reader["ID"]),
                                REPORT_ID = Convert.ToInt64(reader["REPORT_ID"]),
                                OBJECT_ID = Convert.ToInt64(reader["OBJECT_ID"]),
                                OBJECT_TYPE_ID = Convert.ToInt64(reader["OBJECT_TYPE_ID"]),
                                OBJECT_TYPE_NAME = Convert.ToString(reader["OBJECT_TYPE_NAME"]),
                                OBJECT_KF = Convert.ToString(reader["OBJECT_KF"]),
                                OBJECT_CODE = Convert.ToString(reader["OBJECT_CODE"]),
                                OBJECT_NAME = Convert.ToString(reader["OBJECT_NAME"]),
                                SESSION_CREATION_TIME = Convert.ToDateTime(reader["SESSION_CREATION_TIME"]),
                                SESSION_ACTIVITY_TIME = Convert.ToDateTime(reader["SESSION_ACTIVITY_TIME"]),
                                SESSION_TYPE_ID = Convert.ToInt64(reader["SESSION_TYPE_ID"]),
                                SESSION_TYPE_NAME = Convert.ToString(reader["SESSION_TYPE_NAME"]),
                                STATE_ID = Convert.ToInt64(reader["STATE_ID"]),
                                SESSION_STATE = Convert.ToString(reader["SESSION_STATE"]),
                                SESSION_DETAILS = Convert.ToString(reader["SESSION_DETAILS"])
                            });
                        }
                    }
                }
            }

            return sessions;
        }
        /// <summary>
        /// Отримати дані для обрахування дельти 
        /// </summary>
        /// <param name="reportId"></param>
        /// <param name="sessionId"></param>
        /// <returns>Дані в форматі json, формат залежить від значення поля --> NBUSessionHistory.OBJECT_TYPE_ID (Отримуються з GetNBUSessionHistory)</returns>
        public List<NBUSessionData> GetNBUSessionData(Decimal? reportId, Decimal? sessionId)
        {
            List<NBUSessionData> sessions = new List<NBUSessionData>();
            BarsSql sql = SqlCreator.GetNBUSessionData(reportId, sessionId);
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand cmd = connection.CreateCommand())
                {
                    cmd.CommandText = sql.SqlText;
                    cmd.Parameters.AddRange(sql.SqlParams);
                    using (OracleDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            using (OracleClob clob = reader.GetOracleClob(3)) //reader["json"] as OracleClob
                            {
                                sessions.Add(new NBUSessionData()
                                {
                                    id = Convert.ToInt64(reader["id"]),
                                    report_id = Convert.ToInt64(reader["report_id"]),
                                    object_id = Convert.ToInt64(reader["object_id"]),
                                    json = null != clob && !clob.IsNull ? clob.Value.Replace("\n", string.Empty) : string.Empty
                                });
                            }
                        }
                    }
                }
            }

            return sessions;

        }
        //public int ExecuteStoreProcedere(string commandText, params object[] parameters)
        //{
        //    int rv = 0;
        //    using (var connection = OraConnector.Handler.UserConnection)
        //    {
        //        try
        //        {
        //            using (OracleCommand cmd = connection.CreateCommand())
        //            {
        //                cmd.CommandType = System.Data.CommandType.StoredProcedure;
        //                cmd.CommandText = commandText;
        //                cmd.Parameters.Clear();
        //                cmd.BindByName = true;
        //                cmd.Parameters.AddRange(parameters);

        //                rv = cmd.ExecuteNonQuery();
        //            }
        //        }
        //        catch (Exception ex)
        //        {
        //            throw ex;
        //        }
        //    }
        //    return rv;
        //}

    }
}