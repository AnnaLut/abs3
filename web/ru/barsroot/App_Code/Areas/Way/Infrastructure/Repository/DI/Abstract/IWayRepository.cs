using System;
using System.Collections.Generic;
using BarsWeb.Areas.Way.Models;

namespace BarsWeb.Areas.Way.Infrastructure.DI.Abstract
{
    public interface IWayRepository
    {
        string GetGlobalOption(string param);
        IEnumerable<OicFile> Files(string dateFrom, string dateTo);
        UpdateStatusDb ImportFile(string fileName, byte[] fileBody);
        IEnumerable<ProcessedFile> ProcessedFiles(decimal fileId);
        IEnumerable<AFtransfers> NoProccessedAFtransfers(decimal fileId);
        IEnumerable<Documents> NoProccessedDocuments(decimal fileId);
        IEnumerable<Stransfers> NoProccessedStransfers(decimal fileId);
        void DeleteFile(decimal id);
        void RepayFile(decimal id);
        IEnumerable<OwSalaryFilse> ArchFiles();
        TicketInfo DoFormSalaryTicket(decimal? fileid);
        string GetFileData(decimal? fileid);
    }
}