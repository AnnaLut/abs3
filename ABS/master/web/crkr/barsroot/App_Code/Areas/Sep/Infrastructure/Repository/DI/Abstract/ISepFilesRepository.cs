using System.Data.Objects;
using System.Linq;
using Areas.Sep.Models;
using BarsWeb.Areas.Sep.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract
{
    public interface ISepFilesRepository
    {
        IQueryable<Zag> GetSepFilesInfo(SepFilesFilterParams filter, DataSourceRequest request);
        decimal GetSepFilesCount(SepFilesFilterParams filter, DataSourceRequest request);
        decimal GetSepDocsCount(SepFileDocParams sepDocParam, DataSourceRequest request);
        ObjectResult<SepFileDoc> GetSepFileDocs(SepFileDocParams sepDocParams, DataSourceRequest request);
        int RecreateZagB(string fileName, string fileCreateDate);
        int MatchSepFile(SepFileMatchParams matchParams);
        int UnCreateSepFile(SepFileUncreateParams uncreateParams);
        void DeleteSepFile(SepFilesDelParams delParams);
        void DoIpsRequest(SepFileDoc doc);
    }
}