using Bars.DocPrint;
using Oracle.DataAccess.Client;
using System;
using System.Linq;
using BarsWeb.Areas.DocView.Models;
using BarsWeb.Models;

namespace BarsWeb.Areas.DocView.Infrastructure.DI.Abstract
{
    public interface IDocumentsRepository
    {
        IQueryable<BarsWeb.Models.Documents> GetDocuments(AccessDocType accessType, DateTime dStart, DateTime dEnd, DirectionDocType dirType);
        cDocPrint CreateTicket(OracleConnection connect, int id, bool printModel = true);
        byte[] GetByteArrayTicket(int id, bool printModel = true);
        cDocPrint CreateTicket(int[] id, bool printModel = true);
        IQueryable<BP_REASON> ReasonsHandbookData();
    }
}
