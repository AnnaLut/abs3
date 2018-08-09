using Bars.Oracle;
using BarsWeb.Infrastructure.Repository.DI.Abstract;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.FastReport.Infrastructure.DI.Implementation
{
    public class FastReportRepository: IFastReportRepository
    {
        EntitiesBars entities;
        IOraConnection connection;
        public FastReportRepository(IAppModel appModel)
        {
            entities = appModel.Entities;
            connection = (IOraConnection)AppDomain.CurrentDomain.GetData("OracleConnectClass");
        }
    }
}