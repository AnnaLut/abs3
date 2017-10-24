using System.Data.Objects;
using System.Linq;
using Areas.Sep.Models;
using BarsWeb.Areas.Sep.Models;
using Kendo.Mvc.UI;
using System.Collections.Generic;
using System;
using System.IO;


namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract
{
    public interface ISepRequestipsRepository
    {
        IQueryable<IPS_RRP> GetRequestips(SepRequestipsFilterParams fp, DataSourceRequest request);
        FileInfo GetFileContent(SepRequestipsFilterParams fp);
        StreamWriter WriteFile(SepRequestipsFilterParams fp, StreamWriter writer);
    }
}