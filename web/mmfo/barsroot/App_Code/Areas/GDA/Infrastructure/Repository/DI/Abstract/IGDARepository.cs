using Areas.GDA.Models;
using BarsWeb.Areas.GDA.Models;
using BarsWeb.Areas.Kernel.Models;
using Kendo.Mvc.UI;
//using BarsWeb.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using Xml2CSharp;

namespace BarsWeb.Areas.GDA.Infrastructure.DI.Abstract
{
    public interface IGDARepository
    {
        IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery);
        decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery);
        IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery);
        int ExecuteStoreCommand(string commandText, params object[] parameters);
        Params GetParam(string id);
        string Serialize<T>(object details);
        T Deserialize<T>(string str);

        List<Option> GetList();
        List<ActionOption> GetActionList();
        List<PaymentOption> GetPaymentList();
        List<CapitalizationOption> GetCapitalizationList();
        List<ProlongationOption> GetProlongationList();
        List<PenaltyOption> GetPenaltyList();
        List<SumOption> GetSumTrancheList();
        List<TimeAddTranchesOption> GetTimeAddTrancheList();
        List<DepositDemandOption> GetDepositDemandList();

        List<ReplenishmentOption> GetReplenishmentList();

        List<DepositOnDemandType> GetDepositOnDemandCalcTypeList();

        List<Option> GetBlockRateList();
        List<Option> GetBonusProlongationList();


        Option SetOption(Option option);
        CONDITION SetCondition(CONDITION condition);

        ActionOption SetActionOption(ActionOption option);
        CONDITION SetActionCondition(CONDITION condition);

        PaymentOption SetPaymentOption(PaymentOption option);
        CONDITION SetPaymentCondition(CONDITION condition);

        CapitalizationOption SetCapitalizationOption(CapitalizationOption option);
        CONDITION SetCapitalizationCondition(CONDITION condition);

        ProlongationOption SetProlongationOption(ProlongationOption option);
        CONDITION SetProlongationCondition(CONDITION condition);

        PenaltyOption SetPenaltyOption(PenaltyOption option);
        CONDITION SetPenaltyCondition(CONDITION condition);

        SumOption SetSumTrancheOption(SumOption option);
        CONDITION SetSumTrancheCondition(CONDITION condition);
        TimeAddTranchesOption SetTimeAddTrancheOption(TimeAddTranchesOption option);
        CONDITION SetTimeAddTrancheCondition(CONDITION condition);
        DepositDemandOption SetDepositDemandOption(DepositDemandOption option);
        CONDITION SetDepositDemandCondition(CONDITION condition);

        ReplenishmentOption SetReplenishmentOption(ReplenishmentOption option);
        CONDITION SetReplenishmentCondition(CONDITION condition);

        DepositOnDemandType SetDepositOnDemandCalcType(DepositOnDemandType option);

        Option SetBlockRateOption(Option option);
        CONDITION SetBlockRateCondition(CONDITION condition);

        Option SetBonusProlongationOption(Option option);
        CONDITION SetBonusProlongationCondition(CONDITION condition);

        string GetNewTranche();
        SMBDepositTranche SetNewTranche(SMBDepositTranche o);
        string SetTrancheToDB(string processId,string xml);

        //SMBDepositTranche GetReplacementTrancheR(SMBDepositTranche o, string processId);

        string GetTrancheFromDB(string processId);

        SMBDepositTranche SetReplacementTranche(SMBDepositTranche o);
        IQueryable<BackProcessTrancheInfo> GetBackProcessTrancheList(DataSourceRequest request);
        decimal GetBackProcessTrancheCount(DataSourceRequest request);
        List<BackHistoryTrancheInfo> GetBackHistory();
        List<BackHistoryTrancheInfo> GetBackTrancheHistory(string trancheId);

        string GetKf();

    }
}