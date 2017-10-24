using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Services;
using BarsWeb.Areas.OpenCloseDay.Infrastructure.DI.Abstract;
using BarsWeb.Areas.OpenCloseDay.Models;
using System.Globalization;

namespace BarsWeb.Areas.OpenCloseDay.Controllers.Api
{
    [AuthorizeApi]
    public class DepartmentInfoController : ApiController
    {

        private readonly IStatisticsOperations _stat;

        public DepartmentInfoController(IStatisticsOperations stat)
        {
            _stat = stat;
        }

        [HttpGet]
        public HttpResponseMessage GetBranchStages()
        {
            try
            {
                var data = _stat.GetBranchStages();
                return Request.CreateResponse(HttpStatusCode.OK, data);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetAllBranchStages()
        {
            try
            {
                var data = _stat.GetAllBranchStages();
                return Request.CreateResponse(HttpStatusCode.OK, data);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetDeployRunId(string date)
        {
            System.Threading.Thread.CurrentThread.CurrentCulture = new CultureInfo("en-CA");
            var new_date = DateTime.ParseExact(date, "dd.MM.yyyy", CultureInfo.InvariantCulture);
            try
            {
                var data = _stat.GetDeployRunId(new_date);
                return Request.CreateResponse(HttpStatusCode.OK, data);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetTaskList(int session_id)
        {
            try
            {
                var data = _stat.GetTaskList(session_id);
                return Request.CreateResponse(HttpStatusCode.OK, data);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage GetBranchTaskList(int session_id, int func_id)
        {
            try
            {
                var data = _stat.GetBranchTaskList(session_id, func_id);
                return Request.CreateResponse(HttpStatusCode.OK, data);

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage EnableTaskForRun(int session_id, int func_id)
        {
            try
            {
                _stat.EnableTaskForRun(session_id, func_id);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
        [HttpGet]
        public HttpResponseMessage DisableTaskForRun(int session_id, int func_id)
        {
            try
            {
                _stat.DisableTaskForRun(session_id, func_id);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }


        [HttpGet]
        public HttpResponseMessage EnableTaskForBranch(int func_id)
        {
            try
            {
                _stat.EnableTaskForBranch(func_id);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage DisableTaskForBranch(int func_id)
        {
            try
            {
                _stat.DisableTaskForBranch(func_id);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
        [HttpGet]
        public HttpResponseMessage GetRunHistory()
        {
            try
            {
                var data = _stat.GetRunHistory();
                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
        [HttpGet]
        public HttpResponseMessage StartRun(int run_id)
        {
            try
            {
                _stat.StartRun(run_id);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
        [HttpGet]
        public HttpResponseMessage GetTaskMonitor()
        {
            try
            {
                //_stat.StartRun(run_id);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SetNewBankDate(int run_id, string new_date)
        {
            try
            {
                System.Threading.Thread.CurrentThread.CurrentCulture = new CultureInfo("en-CA");
                var date = DateTime.ParseExact(new_date, "dd.MM.yyyy", CultureInfo.InvariantCulture);

                _stat.SetNewBankDate(run_id, date);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
        [HttpGet]
        public HttpResponseMessage GetTaskMonitor(int deploy_run_id)
        {
            try
            {
                var data =_stat.GetTaskMonitor(deploy_run_id);
                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
        [HttpGet]
        public HttpResponseMessage GetBranchStageDirectory()
        {
            try
            {
                var data = _stat.GetBranchStageDirectory();
                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage SetSingleBranchStage(string branch_code, int stage_id)
        {
            try
            {
                _stat.SetSingleBranchStage(branch_code, stage_id);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
        [HttpGet]
        public HttpResponseMessage GetTaskRunReportData(int mon_id)
        {
            try
            {
                var data = _stat.GetTaskRunReportData(mon_id);
                return Request.CreateResponse(HttpStatusCode.OK, data);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpGet]
        public HttpResponseMessage MonitorStartTaskRun(int mon_id)
        {
            try
            {
                _stat.MonitorStartTaskRun(mon_id);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
        [HttpGet]
        public HttpResponseMessage MonitorTerminateTaskRun(int mon_id)
        {
            try
            {
                _stat.MonitorTerminateTaskRun(mon_id);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
        [HttpGet]
        public HttpResponseMessage MonitorDisableTaskRun(int mon_id)
        {
            try
            {
                _stat.MonitorDisableTaskRun(mon_id);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }
        [HttpGet]
        public HttpResponseMessage MonitorRepeatTaskRun(int mon_id)
        {
            try
            {
                _stat.MonitorRepeatTaskRun(mon_id);
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, ex.Message);
            }
        }

    }
}