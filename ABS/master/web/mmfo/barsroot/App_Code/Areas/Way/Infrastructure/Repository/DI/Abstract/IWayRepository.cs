using System;
using System.Collections.Generic;
using BarsWeb.Areas.Way.Models;

namespace BarsWeb.Areas.Way.Infrastructure.DI.Abstract
{
    public interface IWayRepository
    {
        string GetGlobalOption(string param);
        IEnumerable<OicFile> Files(string dateFrom, string dateTo,string condition = "");
        UpdateStatusDb ImportFile(string fileName, byte[] fileBody, bool isZip);
        IEnumerable<ProcessedFile> ProcessedFiles(decimal fileId);
        IEnumerable<AFtransfers> NoProccessedAFtransfers(decimal fileId);
        IEnumerable<Documents> NoProccessedDocuments(decimal fileId);
        IEnumerable<Stransfers> NoProccessedStransfers(decimal fileId);
        void DeleteFile(decimal id);
        void RepayFile(decimal id);
        IEnumerable<OwSalaryFilse> ArchFiles();
        TicketInfo DoFormSalaryTicket(decimal? fileid);
        string GetFileData(decimal? fileid);
        IEnumerable<Documents> DeletedDocuments(decimal fileId);
        void SetRowState(decimal id, decimal idn, decimal state);
        IEnumerable<AFtransfers> DeletedAFtransfers(decimal fileId);
        IEnumerable<Stransfers> DeletedStransfers(decimal fileId);
        
    }
}