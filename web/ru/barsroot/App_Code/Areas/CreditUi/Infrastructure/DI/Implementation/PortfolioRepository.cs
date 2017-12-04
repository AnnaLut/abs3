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
    public class PortfolioRepository : IPortfolioRepository
    {
        CultureInfo ci = CultureInfo.CreateSpecificCulture("en-GB");
        private readonly IHomeRepository _homeRepository;

        public PortfolioRepository(IHomeRepository homeRepository)
        {
            _homeRepository = homeRepository;
        }

        public IQueryable<Portfolio> GetPortfolio(byte cusstype)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();

            List<Portfolio> PortfolioList = new List<Portfolio>();
            try
            {
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = @"select ISP, ND, CC_ID, VIDD, RNK, KV, S, GPK, DSDATE, DWDATE, PR, OSTC, SOS, NAMK, ACC8, DAZS, BRANCH, CUSTTYPE, PROD, NDI, VIDD_NAME, SOS_NAME, TR, OPL_DAY,
                                        NDG, DAYSN, FREQ, FREQP, OPL_DATE, ND0, I_CR9, SDOG from V_CCK_RU";
                cmd.Parameters.Clear();

                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {

                    Portfolio r = new Portfolio();
                    r.ISP = String.IsNullOrEmpty(reader.GetValue(0).ToString()) ? (int?)null : reader.GetInt32(0);
                    r.ND = reader.GetDecimal(1);
                    r.CC_ID = String.IsNullOrEmpty(reader.GetValue(2).ToString()) ? String.Empty : reader.GetString(2);
                    r.VIDD = String.IsNullOrEmpty(reader.GetValue(3).ToString()) ? (int?)null : reader.GetInt32(3);
                    r.RNK = String.IsNullOrEmpty(reader.GetValue(4).ToString()) ? (int?)null : reader.GetInt32(4);
                    r.KV = String.IsNullOrEmpty(reader.GetValue(5).ToString()) ? (int?)null : reader.GetInt32(5);
                    r.S = String.IsNullOrEmpty(reader.GetValue(6).ToString()) ? (decimal?)null : reader.GetDecimal(6);
                    r.GPK = String.IsNullOrEmpty(reader.GetValue(7).ToString()) ? (decimal?)null : reader.GetDecimal(7);
                    r.DSDATE = String.IsNullOrEmpty(reader.GetValue(8).ToString()) ? (DateTime?)null : reader.GetDateTime(8);
                    r.DWDATE = String.IsNullOrEmpty(reader.GetValue(9).ToString()) ? (DateTime?)null : reader.GetDateTime(9);
                    r.PR = String.IsNullOrEmpty(reader.GetValue(10).ToString()) ? (decimal?)null : reader.GetDecimal(10);
                    r.OSTC = String.IsNullOrEmpty(reader.GetValue(11).ToString()) ? (decimal?)null : reader.GetDecimal(11);
                    r.SOS = String.IsNullOrEmpty(reader.GetValue(12).ToString()) ? (int?)null : reader.GetInt32(12);
                    r.NAMK = String.IsNullOrEmpty(reader.GetValue(13).ToString()) ? String.Empty : reader.GetString(13);
                    r.ACC8 = reader.GetDecimal(14);
                    r.DAZS = String.IsNullOrEmpty(reader.GetValue(15).ToString()) ? (DateTime?)null : reader.GetDateTime(15);
                    r.BRANCH = String.IsNullOrEmpty(reader.GetValue(16).ToString()) ? String.Empty : reader.GetString(16);
                    r.CUSTTYPE = String.IsNullOrEmpty(reader.GetValue(17).ToString()) ? (int?)null : reader.GetInt32(17);
                    r.PROD = String.IsNullOrEmpty(reader.GetValue(18).ToString()) ? String.Empty : reader.GetString(18);
                    r.NDI = String.IsNullOrEmpty(reader.GetValue(19).ToString()) ? (int?)null : reader.GetInt32(19);
                    r.VIDD_NAME = String.IsNullOrEmpty(reader.GetValue(20).ToString()) ? String.Empty : reader.GetString(20);
                    r.SOS_NAME = String.IsNullOrEmpty(reader.GetValue(21).ToString()) ? String.Empty : reader.GetString(21);
                    int? tr_number = String.IsNullOrEmpty(reader.GetValue(22).ToString()) ? (int?)null : reader.GetInt32(22);
                    r.TR = tr_number.HasValue && tr_number == 1;
                    r.OPL_DAY = String.IsNullOrEmpty(reader.GetValue(23).ToString()) ? (int?)null : reader.GetInt32(23);
                    r.NDG = String.IsNullOrEmpty(reader.GetValue(24).ToString()) ? (decimal?)null : reader.GetDecimal(24);
                    r.DAYSN = String.IsNullOrEmpty(reader.GetValue(25).ToString()) ? String.Empty : reader.GetString(25);
                    r.FREQ = String.IsNullOrEmpty(reader.GetValue(26).ToString()) ? String.Empty : reader.GetString(26);
                    r.FREQP = String.IsNullOrEmpty(reader.GetValue(27).ToString()) ? String.Empty : reader.GetString(27);
                    r.OPL_DATE = String.IsNullOrEmpty(reader.GetValue(28).ToString()) ? (DateTime?)null : reader.GetDateTime(28);
                    r.NDO = String.IsNullOrEmpty(reader.GetValue(29).ToString()) ? (decimal?)null : reader.GetDecimal(29);
                    r.I_CR9 = String.IsNullOrEmpty(reader.GetValue(30).ToString()) ? String.Empty : reader.GetString(30);
                    r.SDOG = String.IsNullOrEmpty(reader.GetValue(31).ToString()) ? (decimal?)null : reader.GetDecimal(31);
                    PortfolioList.Add(r);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return PortfolioList.AsQueryable();
        }

        public PortfolioStaticData GetBankDate()
        {
            PortfolioStaticData data = new PortfolioStaticData();

            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = @"select gl.bd from dual";
                data.BANKDATE = Convert.ToDateTime(cmd.ExecuteScalar().ToString()).ToString("dd/MM/yyyy");

                cmd.CommandText = @"select cv.name from bars.cc_vidd cv where cv.vidd in (1,2,3) and cv.tipd = 1";
                OracleDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    data.LIST_VIDD.Add(new { NAME = reader.GetString(0) });
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return data;
        }
    }
}