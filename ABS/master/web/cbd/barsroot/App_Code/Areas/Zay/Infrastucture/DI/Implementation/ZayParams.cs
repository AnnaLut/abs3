using System;
using System.Linq;
using Areas.Zay.Models;
using BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Models;

namespace BarsWeb.Areas.Zay.Infrastructure.Repository.DI.Implementation
{
    public class ZayParams: IZayParams
    {
        private readonly ZayModel _entities;
        public ZayParams()
        {
            var connectionStr = EntitiesConnection.ConnectionString("ZayModel", "Zay");
            _entities = new ZayModel(connectionStr);
        }

        public IQueryable<Kernel.Models.Params> GetAllParams()
        {
            return _entities.BIRJA.Select(b =>
                new Params()
                {
                    Comment = b.COMM,
                    IsGlobal = true,
                    Param = b.PAR,
                    Value = b.VAL
                });
        }

        public Kernel.Models.Params GetParam(string id)
        {
            var paramList = GetAllParams();
            return paramList.SingleOrDefault(p => p.Param == id);
        }

        public Kernel.Models.Params SetParam(Kernel.Models.Params param)
        {
            throw new NotImplementedException();
        }

        public Kernel.Models.Params UpdateParam(Kernel.Models.Params param)
        {
            throw new NotImplementedException();
        }

        public void DeleteParam(string id)
        {
            throw new NotImplementedException();
        }
    }
}