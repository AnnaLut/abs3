using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Areas.Sep.Models;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Implementation
{
    public class SepParamsRepository : ISepParams
    {
        private readonly SepFiles _entities;
        public SepParamsRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("SepFiles", "Sep");
            _entities = new SepFiles(connectionStr);
        }

        public IQueryable<Kernel.Models.Params> GetAllParams()
        {
            return _entities.SEP_PARAMS.Select(sp =>
                new Params()
                {
                   Comment = sp.PAR_COMMENT,
                   IsGlobal = false,
                   Kf = sp.KF,
                   Param = sp.PAR_NAME,
                   Value = sp.PAR_VALUE
                });
        }

        public Kernel.Models.Params GetParam(string id)
        {
            return GetAllParams().SingleOrDefault(sp => sp.Param == id);
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