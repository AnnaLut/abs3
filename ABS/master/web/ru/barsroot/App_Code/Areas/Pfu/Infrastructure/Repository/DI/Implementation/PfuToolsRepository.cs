using Areas.Pfu.Models;
using BarsWeb.Areas.Pfu.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Pfu.Models.Grids;
using BarsWeb.Models;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Linq;

namespace BarsWeb.Areas.Pfu.Infrastructure.Repository.DI.Implementation
{
    public class PfuToolsRepository : IPfuToolsRepository
    {
        private readonly PfuModel _pfu;
        public PfuToolsRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("PfuModel", "Pfu");
            this._pfu = new PfuModel(connectionStr);
        }
        public IEnumerable<PensionerType> GetPensionerType()
        {
            PensionerType[] res = {
                //new PensionerType { Id = PensionerTypes.GET_EPP_BATCH_LISTS },
                new PensionerType { Id = PensionerTypes.GET_CONVERT_LISTS }
                //new PensionerType { Id = PensionerTypes.DEATH_LIST }
            };
            return res;
        }

        public void CreateEnvelopeRequest(DateTime startDate, DateTime endDate, int type)
        {
            string command = "";
            //if (type == PensionerTypes.GET_EPP_BATCH_LISTS)
            //{
            //    command = @"
            //        begin
            //             PFU.PFU_UI.create_epp_batch_request(:p_date_from, :p_date_to);
            //        end;";
            //}
            //else if (type == PensionerTypes.GET_CONVERT_LISTS)
            {
                command = @"
                    begin
                         PFU.PFU_UI.create_envelope_list_request(:p_date_from, :p_date_to);
                    end;";
            }
            //else {
            //    command = @"
            //        begin
            //             PFU.PFU_UI.create_death_list_request(p_date_from => :p_date_from, p_date_to => :p_date_to);
            //        end;";
            //}

            var parameters = new object[]
            {
                new OracleParameter("p_date_from", OracleDbType.Date) { Value = startDate },
                new OracleParameter("p_date_to", OracleDbType.Date) { Value = endDate }
            };
            _pfu.ExecuteStoreCommand(command, parameters);
        }

        public V_PFUFILE_BLOB GetPfuFileBlob(decimal fileId)
        {
            string command = @"select* from PFU.V_GET_FILE_DATA where id = :p_id";
            object[] parameters = new object[] {
                new OracleParameter("p_id", OracleDbType.Decimal) { Value = fileId }
            };

            return _pfu.ExecuteStoreQuery<V_PFUFILE_BLOB>(command, parameters).FirstOrDefault();
        }
    }
}