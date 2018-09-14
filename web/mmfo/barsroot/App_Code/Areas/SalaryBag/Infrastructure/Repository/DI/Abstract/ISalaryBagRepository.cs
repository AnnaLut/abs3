using Areas.SalaryBag.Models;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Core.Models;
using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.SalaryBag.Infrastructure.DI.Abstract
{
    public interface ISalaryBagRepository
    {
        IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery);
        decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery);
        IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery);
        int ExecuteStoreCommand(string commandText, params object[] parameters);
        Params GetParam(string id);
        void CreateDeal(DealModel model);
        void UpdateDeal(DealModel model);
        void ApproveDeal(decimal id, string comment);
        void AdditionalChangeDeal(decimal id, string comment);
        void DeleteDeal(decimal id);
        void AuthorizeDeal(decimal id);
        void RejectDeal(decimal id, string comment);
        void MigrateAcc(decimal dealId);
        void SetAccSos(decimal acc, int sos);
        void CloseDeal(decimal id, string comment);

        long GetNewPayRollId(string zpId);
        ZpDealInfo GetZpDealAndPayRollInfoByPId(string id);
        void ApprovePayroll(string id, List<OracleSignArrayItem> results);
        void DeletePayroll(string id);

        decimal? CalculateCommission(string tarifCode, string nls2909, decimal? summ);
        string GetOwnMfo();
        void AddEditPayRollDocument(PayRollDocumentModel model);
        void DeletePayrollDocument(string id);
        void DeletePayrollDocuments(List<string> ids);
        void CreatePayRoll(CreatePayRollModel model);
        void ClonePayrollDocuments(string idFrom, string idTo);

        void RejectPayroll(string payrollId, string comment);
        void PayPayroll(SignResultsPostModel data);

        string ImportPayrollItemsFile(PostFileModel postFileModel);
        void DeleteImportedFile(string fileId);

        //DBF preload procedure.
        object PreloadDbf(PostFileModel postFileModel);
        void Pay3570(string acc);

        bool CheckAcc(string mfo, string acc);

        List<Bars.EAD.Structs.Result.DocumentData> CheckDocs(List<Bars.EAD.Structs.Result.DocumentData> val, List<string> filterCodes);

        ClientModel SearchExistingClient(string nls);
    }
}