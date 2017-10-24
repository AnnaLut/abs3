using System.Linq;
using Areas.AccpReport.Models;
using ExcelLibrary.BinaryFileFormat;
using System.Collections.Generic;
using Areas.AccpReportDocs.Models;

namespace BarsWeb.Areas.AccpReport.Infrastructure.Repository.DI.Abstract
{
    public interface IAccpReportRepository
    {

        /// <summary>
        /// Get all accounts
        /// </summary>
        /// <returns></returns>
        IQueryable<V_ACCP_ACCOUNTS> GetAccounts();

        
        /// <summary>
        /// Mark account as add to report 
        /// </summary>
        /// <returns></returns>
        void SetAccounts(string OKPO, string NLS, bool Check);

        /// <summary>
        /// Mark account as add to report 
        /// </summary>
        /// <returns></returns>
        void CheckAccountsDoc(decimal REF, bool Check);
        

        /// <summary>
        /// Call procedure to make report 
        /// </summary>
        /// <returns></returns>
        void CreateReport(string DateFrom, string DateTo, string OKPO);



        IEnumerable<ACCPDOCS> GetAccountsDocs(string OKPO);


    }

}
