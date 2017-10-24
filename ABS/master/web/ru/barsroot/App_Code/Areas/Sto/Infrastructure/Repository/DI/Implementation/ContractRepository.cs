using Areas.Sto.Models;
using BarsWeb.Areas.Sto.Infrastructure.Repository.DI.Abstract;
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
    }
}
