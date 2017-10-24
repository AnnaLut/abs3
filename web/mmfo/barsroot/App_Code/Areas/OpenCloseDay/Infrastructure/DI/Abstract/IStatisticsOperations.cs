using System;
using System.Collections.Generic;
using BarsWeb.Areas.OpenCloseDay.Models;

namespace BarsWeb.Areas.OpenCloseDay.Infrastructure.DI.Abstract
{
    public interface IStatisticsOperations
    {
        List<BranchStage> GetBranchStages();
        List<BranchStage> GetAllBranchStages();

        int GetDeployRunId(DateTime date);
        List<OPTask> GetTaskList(int session_id);
        List<OPBranchTask> GetBranchTaskList(int session_id, int func_id);

        void DisableTaskForRun(int session_id, int func_id);
        void EnableTaskForRun(int session_id, int func_id);
        void EnableTaskForBranch(int func_id);
        void DisableTaskForBranch(int func_id);

        List<OpenCloseHistoryItem> GetRunHistory();

        void StartRun(int run_id);
        void SetNewBankDate(int run_id, DateTime new_date);

        OpenCloseMonitorInfo GetTaskMonitor(int deploy_run_id);
        List<OpenCloseBranchStage> GetBranchStageDirectory();
        void SetSingleBranchStage(string branch_code, int stage_id);

        OpenCloseStateInfo GetTaskRunReportData(int mon_id);

        void MonitorStartTaskRun(int id);
        void MonitorTerminateTaskRun(int id);
        void MonitorDisableTaskRun(int id);
        void MonitorRepeatTaskRun(int id);

    }
}