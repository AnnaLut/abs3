using Areas.Sep.Models;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Models;
using BarsWeb.Models;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Globalization;
using System.Linq;
using System.Text;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Implementation
{     
    /// <summary>
    /// SepTechFlagRepository для SepTechFlag
    /// </summary>
    public class SepTechFlagRepository : ISepTechFlagRepository
    {
        private readonly SepFiles _entities;
        private bool _isWhereAdded = false;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IBankDatesRepository _bankDateRepository;
        private BarsSql _baseSepDocsSql;
        private readonly IParamsRepository _paramRepo;

        public SepTechFlagRepository(IKendoSqlTransformer kendoSqlTransformer, IBankDatesRepository bankDateRepository, IParamsRepository paramRepo)
        {
            var connectionStr = EntitiesConnection.ConnectionString("SepFiles", "Sep");
            _entities = new SepFiles(connectionStr);
            _sqlTransformer = kendoSqlTransformer;
            _bankDateRepository = bankDateRepository;
            _paramRepo = paramRepo;
        }

        public void GetNModel()
        {
            var numModel = _paramRepo.GetParam("NUMMODEL");            
        }
    }
}