using System.Linq;
using System.Collections.Generic;
using BarsWeb.Areas.CreditUi.Models;
using BarsWeb.Areas.CreditUi.Infrastructure.DI.Abstract;
using Bars.Classes;
using Oracle.DataAccess.Client;
using System;
using BarsWeb.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;
using System.Globalization;
using System.Data;
using Bars;
using System.Web.Services;

namespace BarsWeb.Areas.CreditUi.Infrastructure.DI.Implementation
{
    public class glkRepository : IglkRepository
    {
        CultureInfo ci = CultureInfo.CreateSpecificCulture("en-GB");
        private readonly IHomeRepository _homeRepository;

        public glkRepository(IHomeRepository homeRepository)
        {
            _homeRepository = homeRepository;
        }

        public IQueryable<GLK> GetGLK(decimal nd)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();

            List<GLK> GLKList = new List<GLK>();
            var select_sql = @"select ND,FDAT,LIM2,OST,DEL2,LIM1,D9129,DAYSN,NOT_9129,ACC from V_CCK_GLK where nd=:nd";
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = select_sql;
                cmd.Parameters.Clear();
                cmd.Parameters.Add("nd", OracleDbType.Decimal, nd, System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {

                    GLK r = new GLK();
                    r.ND = String.IsNullOrEmpty(reader.GetValue(0).ToString()) ? (Decimal?)null : reader.GetDecimal(0);
                    r.FDAT = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? (DateTime?)null : Convert.ToDateTime(reader.GetValue(1).ToString());
                    r.LIM2 = String.IsNullOrEmpty(reader.GetValue(2).ToString()) ? (Decimal?)null : reader.GetDecimal(2);
                    r.OST = String.IsNullOrEmpty(reader.GetValue(3).ToString()) ? (Decimal?)null : reader.GetDecimal(3);
                    r.DEL2 = String.IsNullOrEmpty(reader.GetValue(4).ToString()) ? (Decimal?)null : reader.GetDecimal(4);
                    r.LIM1 = String.IsNullOrEmpty(reader.GetValue(5).ToString()) ? (Decimal?)null : reader.GetDecimal(5);
                    r.D9129 = String.IsNullOrEmpty(reader.GetValue(6).ToString()) ? (Decimal?)null : reader.GetDecimal(6);
                    r.DAYSN = String.IsNullOrEmpty(reader.GetValue(7).ToString()) ? (int?)null : reader.GetInt32(7);
                    r.NOT_9129 = String.IsNullOrEmpty(reader.GetValue(8).ToString()) ? (int?)null : reader.GetInt32(8);
                    r.ACC = String.IsNullOrEmpty(reader.GetValue(9).ToString()) ? (decimal?)null : reader.GetDecimal(9);
                    GLKList.Add(r);
                }

                cmd.CommandText =  "Begin bars.PUL.PUT('ND',:nd); End;";
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return GLKList.AsQueryable();
        }

        public glkStaticData GetStaticData(decimal nd)
        {
            glkStaticData data = new glkStaticData();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();

            var sql = @"select t.cc_id, t.limit, t.sdog,t.sdate,c.nmk,c.rnk,t.sos,c.custtype from cc_deal t, customer c  where  c.rnk = t.rnk AND t.nd=" + nd;
            var get_bank_date = @"select gl.bd from dual";
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = sql;
                cmd.Parameters.Clear();

                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                   
                    data.CC_ID = reader.GetString(0);
                    data.LIMIT = reader.GetDecimal(1);
                    data.SDOG = reader.GetDecimal(2);
                    data.SDATE = Convert.ToDateTime(reader.GetValue(3).ToString()).ToString("dd/MM/yyyy");
                    data.NMK = reader.GetString(4);
                    data.RNK = reader.GetDecimal(5);
                    data.SOS = reader.GetInt32(6);
                    data.CUSTYPE = reader.GetInt32(7);
                }

                cmd.CommandText = get_bank_date;
                cmd.Parameters.Clear();
                reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    data.BANKDATE = Convert.ToDateTime(reader.GetValue(0).ToString()).ToString("dd/MM/yyyy");
                }

                cmd.CommandText = "Begin bars.PUL.PUT('ND',:nd); End;";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("nd", OracleDbType.Decimal, nd, System.Data.ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return data;

        }

        public void GroupUpdateGLK(int mode, List<UpdateGLK> list_glk)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = @"cck_ui.GLK_UPD";
                foreach (UpdateGLK glk in list_glk)
                {
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("p_mode", OracleDbType.Decimal, mode, System.Data.ParameterDirection.Input);
                    cmd.Parameters.Add("p_nd", OracleDbType.Decimal, glk.ND, System.Data.ParameterDirection.Input);
                    cmd.Parameters.Add("p_fdat", OracleDbType.Date, Convert.ToDateTime(glk.FDAT), System.Data.ParameterDirection.Input);
                    cmd.Parameters.Add("p_lim2", OracleDbType.Decimal, glk.LIM2, System.Data.ParameterDirection.Input);
                    cmd.Parameters.Add("p_d9129", OracleDbType.Decimal, glk.D9129, System.Data.ParameterDirection.Input);
                    cmd.Parameters.Add("p_daysn", OracleDbType.Decimal, glk.DAYSN, System.Data.ParameterDirection.Input);
                    cmd.Parameters.Add("p_upd_flag", OracleDbType.Int16, glk.UPD_FLAG, System.Data.ParameterDirection.Input);
                    cmd.Parameters.Add("p_not_9129", OracleDbType.Int16, glk.NOT_9129, System.Data.ParameterDirection.Input);
                    cmd.ExecuteNonQuery();
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }

        public void BalanceGLK(decimal nd)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "Begin cck_ui.glk_bal(p_nd => :nd, p_dat_beg => null, p_mode => 0); End;";
                cmd.Parameters.Add("nd", OracleDbType.Decimal, nd, System.Data.ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }

        public void CreateGLKProject(decimal nd, decimal acc)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "Begin cck.cc_grf_lim(nd_ => :nd, acc_ => :acc); End;";
                cmd.Parameters.Add("nd", OracleDbType.Decimal, nd, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("acc", OracleDbType.Decimal, acc, System.Data.ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }

        public void PreGpkOpen(decimal nd)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "Begin bars.PUL.PUT('ND',:ND); cck_ui.gpk_bal(p_nd => :nd, p_dat_beg => null, p_mode => 0); End;";
                cmd.Parameters.Add("nd", OracleDbType.Decimal, nd, System.Data.ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }

        public IQueryable<glkArchive> GetArchive(decimal nd)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();

            List<glkArchive> GLKList = new List<glkArchive>();

            var select_sql = @"select ID,ND,OPER_DATE,FIO from V_CC_LIM_COPY_HEADER where nd = :nd order by id desc";
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = select_sql;
                cmd.Parameters.Clear();
                cmd.Parameters.Add("nd", OracleDbType.Decimal, nd, System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {

                    glkArchive r = new glkArchive();
                    r.ID = reader.GetDecimal(0);
                    r.ND = reader.GetDecimal(1);
                    r.OPER_DATE = Convert.ToDateTime(reader.GetValue(2).ToString());
                    r.FIO = reader.GetString(3);
                    GLKList.Add(r);
                }

            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return GLKList.AsQueryable();
        }


        public IQueryable<glkArchiveBody> GetArchiveBody(decimal id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();

            List<glkArchiveBody> GLKList = new List<glkArchiveBody>();

            var select_sql = @"select FDAT,LIM2,SUMG,SUMO,OTM,SUMK,NOT_SN from V_CC_LIM_COPY_BODY where id = :id";
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = select_sql;
                cmd.Parameters.Clear();
                cmd.Parameters.Add("id", OracleDbType.Decimal, id, System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {

                    glkArchiveBody r = new glkArchiveBody();
                    r.FDAT = String.IsNullOrEmpty(reader.GetValue(0).ToString()) ? (DateTime?)null : Convert.ToDateTime(reader.GetValue(0).ToString());
                    r.LIM2 = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? (Decimal?)null : reader.GetDecimal(1);
                    r.SUMG = String.IsNullOrEmpty(reader.GetValue(2).ToString()) ? (Decimal?)null : reader.GetDecimal(2);
                    r.SUMO = String.IsNullOrEmpty(reader.GetValue(3).ToString()) ? (Decimal?)null : reader.GetDecimal(3);
                    r.OTM = String.IsNullOrEmpty(reader.GetValue(4).ToString()) ? (int?)null: reader.GetInt32(4);
                    r.SUMK = String.IsNullOrEmpty(reader.GetValue(5).ToString()) ? (decimal?)null : reader.GetDecimal(5);
                    r.NOT_SN = String.IsNullOrEmpty(reader.GetValue(6).ToString()) ? (int?)null : reader.GetInt32(6);
                    GLKList.Add(r);
                }

            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return GLKList.AsQueryable();
        }

        public void RestoreGLK(decimal id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Clear();
                cmd.CommandText = @"cck_ui.p_cc_lim_repair";
                cmd.Parameters.Add("p_id", OracleDbType.Decimal, id, System.Data.ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }
    }
}