using System;
using System.Collections.Generic;
using System.Linq;
using BarsWeb.Areas.Doc.Models;

namespace BarsWeb.Areas.Doc.Infrastructure.Repository.DI.Abstract
{
    public interface IAddDocsInfo
    {
        List<AddOtcnTraceMain> GetAllReqInfo(string KODF, string DATEF);
        List<AddOtcnTraceChild> GetReqDependInfo(decimal Ref,string KODF);
        List<AddCodesInfoItem> GetUniqKodf();
        void DelDocuments(decimal Ref, string KODF);
    }
}