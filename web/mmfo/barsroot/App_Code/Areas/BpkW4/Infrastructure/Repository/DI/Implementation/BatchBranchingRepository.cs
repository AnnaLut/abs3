using Areas.BpkW4.Models;
using BarsWeb.Models;
using Oracle.DataAccess.Client;
using System.Data;
using BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.BpkW4.Models;
using System.Collections.Generic;
using System.Linq;

class BatchBranchingRepository : IBatchBranchingRepository
{
    private readonly W4Model _entities;
    public BatchBranchingRepository()
    {
        var connectionStr = EntitiesConnection.ConnectionString("BpkW4", "BpkW4");
        _entities = new W4Model(connectionStr);
    }

    public string ImportRebranchFile(string fileName, byte[] fileBody)
    {
        OracleParameter[] parameters =
                {
                    new OracleParameter("p_filename", OracleDbType.Varchar2, fileName, ParameterDirection.Input),
                    new OracleParameter("p_filebody", OracleDbType.Blob, fileBody, ParameterDirection.Input),
                    new OracleParameter("p_fileid", OracleDbType.Decimal, 200){Direction = ParameterDirection.ReturnValue},
                    new OracleParameter("p_msg", OracleDbType.Varchar2, 4000){Direction = ParameterDirection.ReturnValue},
                };
        string sql = @"begin 
                            ow_utl.rebranch_file_processing(:p_filename, :p_filebody, :p_fileid, :p_msg );
                        end;";
        _entities.ExecuteStoreCommand(sql, parameters);
        return parameters[2].Value.ToString();
    }

    public IQueryable<FileModel> GetRebranchedFiles()
    {
        string sql = @"select t.id, t.file_name, t.file_date, t.file_n, t.file_status, t.err_text
                        from bars.v_ow_rebranch_file t";
        return _entities.ExecuteStoreQuery<FileModel>(sql).AsQueryable();
    }

    public IQueryable<FileContentModel> GetFileContent(decimal? id)
    {
        OracleParameter[] parameters =
        {
                    new OracleParameter("id", OracleDbType.Decimal, id, ParameterDirection.Input),
                };
        string sql = @"select t.id, t.fileid, t.idn, t.rnk, t.nls, t.branch, t.state, t.msg
                      from bars.v_ow_rebranch_data t
                        where t.fileid = :id";
        return _entities.ExecuteStoreQuery<FileContentModel>(sql, parameters).AsQueryable();
    }
}