using Areas.PfuSync.Server.Models;
using BarsWeb.Areas.PfuServer.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.PfuServer.Models;
using BarsWeb.Areas.PfuSync.SyncModels;
using BarsWeb.Core.Logger;
using BarsWeb.Models;
using Ninject;
using Oracle.DataAccess.Client;
using System.Collections.Generic;
using System.Data;

namespace BarsWeb.Areas.PfuServer.Infrastructure.Repository.DI.Implementation
{
    public class PfuServerRepository : IPfuServerRepository
    {
        private readonly PfuServerModel _pfu;
        //[Inject]
        //public IDbLogger _logger { get; set; }
        //private string _ModuleName = "PfuSync";
        public PfuServerRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("PfuServerModel", "PfuSync.Server");
            this._pfu = new PfuServerModel(connectionStr);
            //UserLogin();
        }

        public IEnumerable<SyncRuParam> GetSyncRuParams()
        {
            string SqlText = "select * from pfu.v_pfu_syncru_params";
            return _pfu.ExecuteStoreQuery<SyncRuParam>(SqlText, new object[0]);
        }
        public PfuObjId[] SavePensioner(PensionerQueue[] pens)
        {
            string SqlText = @"begin
                pfu.pfu_sync_ru.save_pensioner_pack(:p_pensioner_tab, :p_objid_tab);
            end;";

            object[] SqlParams = new object[] {
                new OracleParameter("p_pensioner_tab", OracleDbType.Array) {
                    UdtTypeName = "BARS.T_PFU_PENSIONER",
                    Value = pens
                },
                new OracleParameter("p_objid_tab", OracleDbType.Array) {
                    Direction = ParameterDirection.Output,
                    UdtTypeName = "BARS.T_PFU_OBJ_ID"
                }
            };
            _pfu.ExecuteStoreCommand(SqlText, SqlParams);
            return ((OracleParameter)SqlParams[1]).Value as PfuObjId[];
        }

        public PfuObjId[] SavePensAcc(PensAccQueue[] pens)
        {
            string SqlText = @"begin
                pfu.pfu_sync_ru.save_pensacc_pack(:p_pensacc_tab, :p_objid_tab);
            end;";

            object[] SqlParams = new object[] {
                new OracleParameter("p_pensacc_tab", OracleDbType.Array) {
                    UdtTypeName = "BARS.T_PFU_PENSACC",
                    Value = pens
                },
                new OracleParameter("p_objid_tab", OracleDbType.Array) {
                    Direction = ParameterDirection.Output,
                    UdtTypeName = "BARS.T_PFU_OBJ_ID"
                }
            };
            _pfu.ExecuteStoreCommand(SqlText, SqlParams);
            return ((OracleParameter)SqlParams[1]).Value as PfuObjId[];
        }

        public decimal StartProtocol(string mfo, string url, string tableName)
        {
            string SqlText = @"begin
                pfu.pfu_sync_ru.start_protocol(:p_mfo, :p_url, :p_transfer_type, :p_id);
            end;";

            OracleParameter[] SqlParams = new OracleParameter[] {
                new OracleParameter("p_mfo", OracleDbType.Varchar2) { Value = mfo },
                new OracleParameter("p_url", OracleDbType.Varchar2) { Value = url },
                new OracleParameter("p_transfer_type", OracleDbType.Varchar2) { Value = tableName },
                new OracleParameter("p_id", OracleDbType.Decimal, ParameterDirection.Output)
            };

            _pfu.ExecuteStoreCommand(SqlText, SqlParams);
            return decimal.Parse(SqlParams[3].Value.ToString());
        }

        public void ErrorProtocol(decimal Id, string Comm)
        {
            string SqlText = @"begin
                pfu.pfu_sync_ru.error_protocol(:p_id, :p_comm);
            end;";

            object[] SqlParams = new object[] {
                new OracleParameter("p_id", OracleDbType.Decimal) { Value = Id },
                new OracleParameter("p_comm", OracleDbType.Varchar2) { Value = Comm }
            };

            _pfu.ExecuteStoreCommand(SqlText, SqlParams);
        }

        public void StopProtocol(decimal Id, decimal transferCount)
        {
            string SqlText = @"begin
                pfu.pfu_sync_ru.stop_protocol(:p_id, :p_transfer_rows);
            end;";

            object[] SqlParams = new object[] {
                new OracleParameter("p_id", OracleDbType.Decimal) { Value = Id },
                new OracleParameter("p_transfer_rows", OracleDbType.Decimal) { Value = transferCount }
            };

            _pfu.ExecuteStoreCommand(SqlText, SqlParams);
        }

        //public void Info(string Message)
        //{
        //    _logger.Info(Message, _ModuleName);
        //}
        //public void Error(string Message)
        //{
        //    _logger.Error(Message, _ModuleName);
        //}
    }
}