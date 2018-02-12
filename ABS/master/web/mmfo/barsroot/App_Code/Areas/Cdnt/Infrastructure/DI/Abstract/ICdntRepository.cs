using System.Collections.Generic;
using System.Linq;
using Areas.Cdnt.Models;
using BarsWeb.Areas.Cdnt.Models;
using BarsWeb.Areas.Cdnt.Models.Transport;


// ReSharper disable once CheckNamespace
namespace BarsWeb.Areas.Cdnt.Infrastructure.DI.Abstract
{
    public interface ICdntRepository
    {
        IQueryable<V_NOTARY> GetNotaries();
        decimal AddNotary(NOTARY notary);
        void EditNotary(NOTARY notary);
        void DeleteNotary(long id);
        IQueryable<V_NOTARY_ACCREDITATION> GetNotaryAccreditations(decimal notaryId);
        V_NOTARY_ACCREDITATION GetAccreditation(decimal accreditationId);
        decimal AddAcreditation(NOTARY_ACCREDITATION accreditation);
        void EditAccreditation(NOTARY_ACCREDITATION accreditation);
        V_NOTARY_ACCREDITATION CloseAccreditation(decimal accreditationId);
        void CancelAccreditation(decimal accreditationId);
        IQueryable<V_NOTARY_TRANSACTION> GetAccreditationTransactions(decimal accreditationId);
        IEnumerable<BarsListItem> GetAccreditationTypes();
        IEnumerable<BarsListItem> GetAccreditationStates();
        IQueryable<NOTARY_TRANSACTION_TYPES> GetTransactionTypes();
        IEnumerable<BarsListItem> GetSegmentsOfBusiness();
        IEnumerable<string> GetAccreditationBranches(decimal accrId);
        IEnumerable<decimal> GetAccreditationBusinesses(decimal accrId);
        IQueryable<V_NOTARY_TRANSACTION> GetTransactions(decimal accrId);
        IQueryable<NOTARY> GetNotary();
        decimal GetNotaryCount();
        void AddAccreditationQuery(AccreditationQuery query);
        void AlterAccreditationQuery(AccreditationQuery query);
        IEnumerable<BarsListItem> GetNotaryTypes();
        IEnumerable<BarsListItem> GetDocumentTypes();
        void AddProfit(V_NOTARY_PROFIT profit);
    }
}