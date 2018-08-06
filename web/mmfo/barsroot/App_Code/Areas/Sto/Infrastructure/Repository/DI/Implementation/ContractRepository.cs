using Areas.Sto.Models;
using BarsWeb.Areas.Sto.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sto.Models;
using BarsWeb.Models;
using Oracle.DataAccess.Client;
using System;
using System.Linq;

namespace BarsWeb.Areas.Sto.Infrastructure.Repository.DI.Implementation
{
    /// <summary>
    /// Summary description for ContractRepository
    /// </summary>
    public class ContractRepository : IContractRepository
    {
        private readonly stoContainer _sto;
        public ContractRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("stoContainer", "Sto");
            this._sto = new stoContainer(connectionStr);
        }
        public IQueryable<STO_LST> ContractData()
        {
            var data = _sto.STO_LST;
            return data;
        }
        public IQueryable<V_STO_DET> ContractDetData()
        {
            var data = _sto.V_STO_DET;
            return data;
        }
        public IQueryable<STO_GRP> GroupData()
        {
            return _sto.STO_GRP;
        }
        public int ClaimProc(string idd, string statusId, string disclaimId)
        {
            var procResult = 1;
            const string command = @"
                    begin
                        sto_all.claim_idd ( :p_IDD, :p_statusid, :p_disclaimid);
                    end;
                ";
            var commParams = new object[] {
                new OracleParameter("p_IDD", OracleDbType.Decimal) { Value = idd },
                new OracleParameter("p_statusid", OracleDbType.Decimal) { Value = statusId },
                new OracleParameter("p_disclaimid", OracleDbType.Decimal) { Value = disclaimId }
            };
            try
            {
                _sto.ExecuteStoreCommand(command, commParams);
            }
            catch (Exception ex)
            {
                procResult = 0;
            }
            return procResult;
        }
        public IQueryable<STO_DISCLAIMER> DisclaimerData()
        {
            return _sto.STO_DISCLAIMER;
        }
        public IQueryable<V_STO_DET_HIST> DetInfoData()
        {
            return _sto.V_STO_DET_HIST;
        }

        public string CurrentBranch()
        {
            const string query = @"select SYS_CONTEXT('bars_context', 'user_branch') from dual";
            var branch = _sto.ExecuteStoreQuery<string>(query).Single();
            return branch;
        }
        public IQueryable<pipe_FREQ> GetFREQ()
        {
            const string query = @"select * from table(BARS.STO_ALL.get_FREQ)";
            return _sto.ExecuteStoreQuery<pipe_FREQ>(query).AsQueryable();
        }
        public IQueryable<pipe_customer> GetRNKLIST(string OKPO)
        {
            const string query = @"select * from table(BARS.STO_ALL.get_RNKBYOKPO(:p_okpo))";
            var parameters = new object[] {
                new OracleParameter("p_okpo", OracleDbType.Varchar2) { Value = OKPO}
            };
            return _sto.ExecuteStoreQuery<pipe_customer>(query, parameters).AsQueryable();
        }
        public IQueryable<pipe_TTS> GetTTS()
        {
            const string query = @"select * from table(BARS.STO_ALL.get_TTS)";
            return _sto.ExecuteStoreQuery<pipe_TTS>(query).AsQueryable();
        }
        public IQueryable<string> GetNLS(decimal RNK, decimal? KV)
        {
            string query = "";
            var parameters = new object[] { };
            if (KV == null)
            {
                query = @"select nls from accounts where rnk = :p_rnk";
                parameters = new object[] {
                new OracleParameter("p_rnk", OracleDbType.Decimal) { Value = RNK}
                };
            }
            else
            {
                query = @"select nls from accounts where rnk = :p_rnk and dazs is null and kv = :p_kv";
                parameters = new object[] {
                    new OracleParameter("p_rnk", OracleDbType.Decimal) { Value = RNK},
                    new OracleParameter("p_kv", OracleDbType.Decimal) { Value = KV}
                    };
            }
            return _sto.ExecuteStoreQuery<string>(query, parameters).AsQueryable();
        }

        public IQueryable<DropDown> GetKVs(decimal? RNK)
        {
            string query = "";
            var parameters = new object[] { };
            if (RNK != null)
            {
                query = @"select kv, name from tabval where kv in 
                    (select distinct kv from accounts where rnk = :p_rnk and dazs is null)";
                parameters = new object[] {
                new OracleParameter("p_rnk", OracleDbType.Decimal) { Value = RNK}
            };
            }
            else
            {
                query = @"select kv, name from tabval";
            }
            return _sto.ExecuteStoreQuery<DropDown>(query, parameters).AsQueryable();
        }
        public IQueryable<string> GetNMK(decimal RNK)
        {
            const string query = @"select nmk from customer where rnk = :p_rnk";
            var parameters = new object[] {
                new OracleParameter("p_rnk", OracleDbType.Decimal) { Value = RNK}
            };
            return _sto.ExecuteStoreQuery<string>(query, parameters).AsQueryable();
        }

        public decimal AddPayment(payment newpayment)
        {
            const string query = @"begin sto_all.Add_RegularTreaty( :IDS,:ord, :tt, :vob, :dk, :nlsa,:kva, :nlsb, :kvb, :mfob, :polu, " +
                    ":nazn,:fsum, :okpo, :DAT1, :DAT2, :FREQ, null,:WEND, :DR, null, :p_nd,:p_sdate,:p_idd,:p_status,:p_status_text);end;";
            var parameters = new object[] {
                new OracleParameter("IDS", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = newpayment.IDS},
                new OracleParameter("ord", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = newpayment.ord},
                new OracleParameter("tt", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = newpayment.tt},
                  new OracleParameter("vob", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = newpayment.vob},
                  new OracleParameter("dk", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = newpayment.dk},
                  new OracleParameter("nlsa", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = newpayment.nlsa},
                  new OracleParameter("kva", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = newpayment.kva},
                  new OracleParameter("nlsb", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = newpayment.nlsb},
                  new OracleParameter("kvb", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = newpayment.kvb},
                  new OracleParameter("mfob", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = newpayment.mfob},
                  new OracleParameter("polu", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = newpayment.polu},
                  new OracleParameter("nazn", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = newpayment.nazn},
                  new OracleParameter("fsum", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = newpayment.fsum},
                  new OracleParameter("okpo", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = newpayment.okpo},
                  new OracleParameter("DAT1", OracleDbType.Date, System.Data.ParameterDirection.Input) { Value = newpayment.DAT1},
                  new OracleParameter("DAT2", OracleDbType.Date, System.Data.ParameterDirection.Input) { Value = newpayment.DAT2},
                  new OracleParameter("FREQ", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = newpayment.FREQ},
                  new OracleParameter("WEND", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = newpayment.WEND},
                  new OracleParameter("DR", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = newpayment.DR},
                  new OracleParameter("p_nd", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = newpayment.nd},
                  new OracleParameter("p_sdate", OracleDbType.Date, System.Data.ParameterDirection.Input) { Value = newpayment.sdate},
                  new OracleParameter("p_idd", OracleDbType.Decimal, System.Data.ParameterDirection.Output) { Value = newpayment.idd},
                  new OracleParameter("p_status", OracleDbType.Decimal, System.Data.ParameterDirection.Output) { Value = newpayment.status},
                  new OracleParameter("p_status_text", OracleDbType.Varchar2, 4000, System.Data.ParameterDirection.Output) { Value = newpayment.status_text}
             };
            _sto.ExecuteStoreQuery<payment>(query, parameters).Single();
            return newpayment.idd;
        }
        public decimal AvaliableNPP(decimal IDS)
        {
            const string query = @"select bars.sto_all.get_AvaliableNPP(:p_ids) from dual";
            var parameters = new object[] {
                new OracleParameter("p_ids", OracleDbType.Decimal) { Value = IDS}
            };
            return _sto.ExecuteStoreQuery<decimal>(query, parameters).Single();

        }
        public decimal AddIDS(ids newids)
        {
            const string query = @"begin sto_all.add_RegularLST( :IDG,:IDS, :RNK, :NAME, :SDAT); end;";
            var parameters = new object[] {

                new OracleParameter("IDG", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = newids.IDG},
                new OracleParameter("IDS", OracleDbType.Decimal, System.Data.ParameterDirection.Output) { Value = newids.IDS},
                new OracleParameter("RNK", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = newids.RNK},
                new OracleParameter("NAME", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = newids.NAME},
                new OracleParameter("SDAT", OracleDbType.Date, System.Data.ParameterDirection.Input) { Value = newids.SDAT}
             };
            _sto.ExecuteStoreQuery<payment>(query, parameters).Single();
            return newids.IDS;
        }
    }
}
