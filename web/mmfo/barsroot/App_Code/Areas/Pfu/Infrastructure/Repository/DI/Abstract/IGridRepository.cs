using System.Collections.Generic;
using BarsWeb.Areas.Pfu.Models.Console;
using BarsWeb.Areas.Pfu.Models.Grids;
using Kendo.Mvc.UI;
using BarsWeb.Areas.Pfu.Models.ApiModels;
using BarsWeb.Areas.Kernel.Models;
using System.Linq;
using System;

namespace BarsWeb.Areas.Pfu.Infrastructure.Repository.DI.Abstract
{
    /// <summary>
    /// IGridRepository - робота з даними для грідів
    /// </summary>
    public interface IGridRepository
    {
        IEnumerable<V_PFU_REQUEST> RequestsData(DataSourceRequest request);
        decimal CountRequests(DataSourceRequest request);

        IEnumerable<V_PFU_FILE> FilesData(decimal Id, DataSourceRequest request);
        decimal CountFiles(decimal Id, DataSourceRequest request);

        IEnumerable<V_PFU_ENVELOPE_WFILE> EnvelopesData(DataSourceRequest request);
        decimal CountEnvelopes(DataSourceRequest request);

        IEnumerable<V_PFU_FILE_STATE> PfuFileStatus();
        IEnumerable<EnvelopState> PfuEnvelopState();

        IEnumerable<V_PFU_SESSION_TRACKING> SessionInfo(decimal id, DataSourceRequest request);
        decimal CountSession(decimal id, DataSourceRequest request);

        IEnumerable<V_PFU_PENSIONER> Search(SearchQuery qv, DataSourceRequest request);
        decimal CountSearch(SearchQuery qv, DataSourceRequest request);

        void BlockPensioner(IList<BlockPensioner> pensioners);

        IEnumerable<V_PFU_REGISTERS> Catalog(SearchCatalog search, DataSourceRequest request);
        IEnumerable<V_PFU_REGISTERS> CatalogInPay(SearchCatalog search, DataSourceRequest request);
        void ProcessRegistres(int[] registersIds);
        decimal CountCatalog(SearchCatalog search, DataSourceRequest request);
        decimal CountCatalogInPay(SearchCatalog search, DataSourceRequest request);
        IEnumerable<V_PFU_RECORDS> LineCatalog(decimal Id, DataSourceRequest request);
        IEnumerable<V_PFU_RECORDS> LineCatalogInPay(decimal? id, DataSourceRequest request);
        decimal CountLineCatalog(decimal Id, DataSourceRequest request);
        decimal CountLineCatalogInPay(decimal? id, DataSourceRequest request);
        void ProcessRecords(int[] ids, string stateName);
        void SetReadyForSignStatus(decimal id);
        void SetCheckingPayStatus(decimal id, decimal docRef);
        Payment VerifyFile(decimal id);
        void SetReadyForMatchingStatus(FileForMatchingKvit1And2 kvit);
        void SetReadyForMatchingStatus2(decimal file_id);
        IEnumerable<V_PFU_ENVELOPES> Envelopes(SearchEnvelop search, DataSourceRequest request);
        decimal CountEnvelopes(SearchEnvelop search, DataSourceRequest request);
        IEnumerable<PensionerBlockType> GetPensionerBlockType();
        IEnumerable<V_PFU_DESTROYED_EPC> SearchDestroyedEpc(SearchDestroyedEpcQuery qv, DataSourceRequest request);
        decimal CountSearchDestroyedEpc(SearchDestroyedEpcQuery qv, DataSourceRequest request);
        IEnumerable<SignEPC> GetSignsEPC();
        void DestroyEpc(IList<DestroyEpc> pensioners);
        IEnumerable<V_PFU_REGISTERS_EPC> SearchRegisterEpc(SearchRegisterEpc search, DataSourceRequest request);
        decimal CountRegisterEpc(SearchRegisterEpc search, DataSourceRequest request);
        IEnumerable<V_PFU_REGISTERS_LINES_EPC> SearchRegisterEpcLine(SearchRegisterLinesEpc search, DataSourceRequest request);
        decimal CountRegisterEpcLine(SearchRegisterLinesEpc search, DataSourceRequest request);
        IEnumerable<V_PFU_EPC_LINE_STATE> PfuEpcLineeStatus();
        V_PFU_DESTROYED_EPC_INFO GetDestroyedEpcInfo(string epcId);
        void SyncPensioners(IList<SyncPensioners> pensioners);
        IEnumerable<V_PFU_SYNC_STATE> PfuSyncStatus();
        IEnumerable<V_PFU_SYNC> SearchSync(SearchSyncPensioners search, DataSourceRequest request);
        decimal CountSync(SearchSyncPensioners search, DataSourceRequest request);
        void RemoveFromPayPensioner(IList<BlockPensioner> pensioners);
        IEnumerable<V_PFU_REGISTERS> CatalogHistory(DataSourceRequest request);
        decimal CountCatalogHistory(DataSourceRequest request);
        IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery);
        decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery);
        IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery);
        void SetPaybackKvit2(decimal p_id_rec, string p_numpay_back, System.DateTime? p_dateback);
        string PrepareForMatchingStatus(FileForMatching d);
        void BalanceRequest(string acc, decimal id, decimal p_kf);
        List<BranchesMonitoring> GetBranchСode();
        List<pfuMFO> GetMFO();
        List<Enquiry> GetEnquiries(string kf);
        List<CmEpp> GetCmEpp(decimal id);
        List<EppLine> GetVEppLine(string id);
        void SendRequest(int kf);
        List<PfuEppLine> GetEppLine(DataSourceRequest request, string kff, string bdate1, string bdate, string status, string epp, string inn, string acc);
        decimal GetCountGrid();
        List<PfuEppLine> GetTableByRNK(string id, decimal id_row);
        List<PfuEppLine> GetTableByEppNum(string id);
        List<PfuEppLine> GetTableByAccNum(string id);
        List<DateTime> GetEppDate();
        void RepeatProcessing(dynamic rows);
        void AssignRNK(dynamic rows);
        StatesEppLines GetStatusRows(decimal? kff, string bdate, string date1, string cod_epp, string inden_cod, string account);
        List<PfuEppLine> GetRowsByStatus(string status, decimal kff, string bdate);
        List<V_PFU_ENVELOP_ARH> GetSentConvert();
        IQueryable<ErrorRows> GetErrorRows(string MFO, string ID, string STATE);
        List<LineStates> GetStatesFromLine(decimal id);
        List<pfuState> GetStates();
        void MarkToPayment(decimal id);
        IQueryable<V_PFU_DEATHS> GetNotifyList(string id, string rdate, string state);
        List<V_PFU_DEATHS_RECORDS> GetNotifyRecords(decimal id);
        void BlockPensioner(string id);
        void BalanceReq(string acc, string id, string mfo);
        PaymentDoc GetOption(string id);
        void SetDeathDebetRef(string id, string docref);
        void SetRegenMatchingStatus(FileForMatchingKvit1And2 kvit);
        IQueryable<V_PFU_JOB_INFO> GetJobList();
        void JobON(string job_name);
        void JobOFF(string job_name);
        void JobStart(string job_name);
        void JobStop(string job_name);
        string PrepareForNoTurnover(decimal id, string mfo);
        void GenNoTurnover(FileForNoTurnOver d);
        string GetBranch();


        IEnumerable<FileType> GetFileTypes();
    }

}