using BarsWeb.Areas.F601.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.F601.Infrastructure.DI.Abstract
{
    /// <summary>
    /// Summary description for F601Repository
    /// </summary>
    public interface IF601Repository
    {
        string GetCreditInfoDetail(long id);

        List<CreditInfoObject> GetCreditInfoList();

        List<string> GetStatusesList();

        List<string> GetObjectTypesList();

        string GetPrivateKeyId();

        List<ToSignObject> GetSignDataList(long number);

        void PutSignedObject(int id, string nbuObject);
    }
}