using BarsWeb.Areas.PC.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.PC.Infrastructure.Repository.DI.Abstract
{
    public interface IPCRepository
    {
        List<Operations> GetOperations();
        string RunSelectedProcedure(int id);
        List<Grid> GetGridData(string date_from, string date_to);
    }
}