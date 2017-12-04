using BarsWeb.Areas.PfuServer.Models;
using BarsWeb.Areas.PfuSync.SyncModels;
using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.PfuServer.Infrastructure.Repository.DI.Abstract
{
    public interface IPfuServerRepository
    {
        IEnumerable<SyncRuParam> GetSyncRuParams();
        PfuObjId[] SavePensioner(PensionerQueue[] pens);
        PfuObjId[] SavePensAcc(PensAccQueue[] pens);
        decimal StartProtocol(string mfo, string url, string tableName);
        void StopProtocol(decimal Id, decimal transferCount);
        void ErrorProtocol(decimal Id, string Comm);
        //void Info(string Message);
        //void Error(string Message);
    }
}