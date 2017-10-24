using System.Linq;
using BarsWeb.Areas.Admin.Models;
using Kendo.Mvc.UI;
using System.Collections.Generic;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract
{
    public interface IOperRepository
    {
        #region mainOperGrid

        IEnumerable<TTS> OperData(DataSourceRequest request);
        decimal OperDataCount(DataSourceRequest request);
        TTS OperItem(DataSourceRequest request, string tt);

        void UpdateOperItem(TTS item);

        #endregion

        #region CardHandbooks

        IEnumerable<TTS_DK_Handbook> DkHandbookData();
        IEnumerable<TTS_INTERBANK_Handbook> InterbankHandbookData();

        #endregion

        #region FLAGS & Props Data

        IEnumerable<TTS_OpFlags> FlagsData(DataSourceRequest request, int[] code, string tt);
        decimal FlagsDataCount(DataSourceRequest request, int[] code, string tt);
        IEnumerable<TTS_FLAGS> FlagsOutData(DataSourceRequest request, int[] code);
        decimal FlagsOutCount(DataSourceRequest request, int[] code);

        IEnumerable<TTS_Prop> PropData(DataSourceRequest request, string tt);
        decimal PropDataCount(DataSourceRequest request, string tt);
        IEnumerable<TTS_OP_FIELD> PropOutData(DataSourceRequest request, string tt);
        decimal PropOutDataCount(DataSourceRequest request, string tt);

        void UpdateProps(string tt, string tag, string opt, decimal used, decimal? ord, string val);

        #endregion

        #region Balance Accounts Data

        IEnumerable<TTS_PS> BalanceAccountsData(DataSourceRequest request, string tt);
        decimal BalanceAccountsCount(DataSourceRequest request, string tt);

        IEnumerable<TTS_NBS> AccountsData(DataSourceRequest request, string tt);
        decimal AccountsCount(DataSourceRequest request, string tt);

        void InsertAccount(string tt, string nbs, decimal dk, string ob22);
        void DeleteAccount(string tt, string nbs, decimal dk, string ob22);

        #endregion

        #region RelatedTransactionsGrid (Tab "Пов'язані операції")

        IEnumerable<TTS_RelatedTransaction> RelatedTransactionData(DataSourceRequest request, string tt);
        decimal RelatedTransactionDataCount(DataSourceRequest request, string tt);
        IEnumerable<TTS> TransactionData(DataSourceRequest request, string tt);
        decimal TransactionDataCount(DataSourceRequest request, string tt);

        void InsertTransaction(string tt, string ttap, decimal dk);
        void DeleteTransaction(string tt, string ttap);

        #endregion

        #region VobGrid (Tab "Види документів")

        IEnumerable<TTS_VOB> VobData(DataSourceRequest request, string tt);
        decimal VobDataCount(DataSourceRequest request, string tt);

        IEnumerable<TTS_BankDocsHandbook> BankDocsData(DataSourceRequest request, string tt);
        decimal BankDocsCount(DataSourceRequest request, string tt);

        void InsertVob(string tt, decimal vob, decimal? ord);
        void DeleteVob(string tt, decimal vob);

        #endregion

        #region MonitoringGroupsGrid (Tab "Групи контролю")

        IEnumerable<TTS_MonitoringGroup> MonitoringGroupData(DataSourceRequest request, string tt);
        decimal MonitoringGroupDataCount(DataSourceRequest request, string tt);

        IEnumerable<CHKLIST> GroupData(DataSourceRequest request, string tt);
        decimal GroupDataCount(DataSourceRequest request, string tt);

        //TTS_MonitoringGroup GroupItem(decimal chkId);

        void InsertGroup(string tt, decimal idchk, decimal priority, string sql, decimal? charge, string respond);
        void DeleteGroup(string tt, decimal idchk);

        #endregion
        
        #region FoldersGrid (Tab "Директорії")

        IEnumerable<TTS_FOLDERS> FolderData(DataSourceRequest request, string tt);
        decimal FolderDataCount(DataSourceRequest request, string tt);

        IEnumerable<TTS_FOLDERS> OutFoldersData(DataSourceRequest request, string tt);
        decimal OutFoldersDataCount(DataSourceRequest request, string tt);

        void InsertFolder(string tt, decimal idfo);
        void DeleteFolder(string tt, decimal idfo);

        #endregion
    }
}
