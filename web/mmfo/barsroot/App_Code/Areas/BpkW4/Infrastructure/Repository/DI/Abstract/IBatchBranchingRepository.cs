using BarsWeb.Areas.BpkW4.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Abstract
{
    public interface IBatchBranchingRepository
    {
        string ImportRebranchFile(string fileName, byte[] fileBody);
        IQueryable<FileModel> GetRebranchedFiles();
        IQueryable<FileContentModel> GetFileContent(decimal? id);
    }
}