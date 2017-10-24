using BarsWeb.Areas.Pfu.Models.Grids;
using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.Pfu.Infrastructure.Repository.DI.Abstract
{
    /// <summary>
    /// Summary description for IPfuToolsRepository
    /// </summary>
    public interface IPfuToolsRepository
    {
        void CreateEnvelopeRequest(DateTime startDate, DateTime endDate, int type);
        V_PFUFILE_BLOB GetPfuFileBlob(decimal fileId);

        IEnumerable<PensionerType> GetPensionerType();
    }
}