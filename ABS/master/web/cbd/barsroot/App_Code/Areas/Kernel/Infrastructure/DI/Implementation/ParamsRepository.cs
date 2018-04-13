using System.Linq;
using Areas.Kernel.Models;
using BarsWeb.Areas.Kernel.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;


namespace BarsWeb.Areas.Kernel.Infrastructure.DI.Implementation
{
    public class ParamsRepository : IParamsRepository
    {
        private readonly KernelContext _entities;

        public ParamsRepository(IKernelModel model)
        {
            _entities = model.KernelEntities;
        }

        public IQueryable<Params> GetAllParams()
        {
            const string sql = @"select 
                                    p.par as param,
                                    p.val as value,
                                    p.comm as ""comment""
                                from 
                                    params p";
            return _entities.ExecuteStoreQuery<Params>(sql).AsQueryable();
        }

        public Params GetParam(string id)
        {
            object[] parameters =         
            { 
                new OracleParameter("p_par",OracleDbType.Varchar2).Value=id
            };
            const string sql = @"select 
                                    par as param,
                                    val as value,
                                    comm as ""comment""
                                from 
                                    params p
                                where 
                                    p.par = :p_par";

            return _entities.ExecuteStoreQuery<Params>(sql,parameters).FirstOrDefault();
        }

        public Params SetParam(Params param)
        {
            throw new System.NotImplementedException();
        }

        public Params UpdateParam(Params param)
        {
            throw new System.NotImplementedException();
        }

        public void DeleteParam(string id)
        {
            throw new System.NotImplementedException();
        }
    }
}