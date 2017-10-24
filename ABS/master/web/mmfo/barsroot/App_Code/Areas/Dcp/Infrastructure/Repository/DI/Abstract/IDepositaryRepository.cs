using System;
using System.Collections.Generic;
using System.Linq;
using BarsWeb.Areas.Dcp.Models;

namespace BarsWeb.Areas.Dcp.Infrastructure.Repository.DI.Abstract
{
    public interface IDepositaryRepository
    {
        List<PFileGridData> GetGridData(decimal nPar, string fn);
        Vob GetVob(string type);
        List<PFileGridData> GetArchGridData();
        void Pay(List<PFileGridData> list);
        object AcceptFile(bool update);
        object CheckFile();
        void DeleteRow(decimal? id);
        bool CheckStorno();
        NlsModel GetDataByNLS(string nls, decimal id, string okpo);
        List<BP_REASON> GetBPReasons();
        object Storno(int reasonid, string fn);
        HeaderData GetHeaderFromFile(string path);
        string GetPath();
    }
}
