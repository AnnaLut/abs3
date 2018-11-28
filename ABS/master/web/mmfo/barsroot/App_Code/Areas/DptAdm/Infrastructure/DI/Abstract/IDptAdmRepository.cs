using System.Collections.Generic;
using System.Linq;
using Areas.DptAdm.Models;
using BarsWeb.Areas.DptAdm.Models;
using System.Web.Mvc;

namespace BarsWeb.Areas.DptAdm.Infrastructure.Repository.DI.Abstract
{
    public interface IDptAdmRepository
    {       
        List<DPT_TYPES> GetDptType();      
        IQueryable<pipe_DPT_TYPES> GetDptTypeInfo(decimal TYPE_ID);
        IQueryable<pipe_DPT_TYPES> GetDptTypeLst();
        IQueryable<pipe_DPT_ARCH> GetDptArchive( System.DateTime? cdat, decimal? VIDD, string BRANCH);
        IQueryable<pipe_DPT_VIDD_SHORT> GetDptVidd(decimal? TYPE_ID);
        IQueryable<pipe_DPT_VIDD_SHORT> GetDptViddInfo(decimal VIDD);
        IQueryable<pipe_DPT_VIDD_INFO> GetDptViddINFOALL(decimal VIDD);
        IQueryable<pipe_DPT_VIDD_PARAMS> GetDptViddParam(decimal VIDD);
        void PutParam(decimal vidd, string tag, string val);
        DPT_RESULT saveVidd(pipe_DPT_VIDD_INFO UpdateVidd);
        DPT_RESULT saveTYPE(pipe_DPT_TYPES UpdateType);
        IQueryable<pipe_DPT_JOBS> GetDptJobs();
        IQueryable<pipe_KV> GetKV();
        IQueryable<pipe_BSD> GetBSD();  
        IQueryable<pipe_BSN> GetBSN(string BSD);
        IQueryable<pipe_BSA> GetBSA(string BSD, string Avans);
        IQueryable<pipe_BASEY> GetBASEY();
        IQueryable<pipe_FREQ> GetFREQ();
        IQueryable<pipe_METR> GetMETR();
        IQueryable<pipe_ION> GetION();
        IQueryable<pipe_BRATES> GetBRATES();
        IQueryable<pipe_DPT_STOP> GetDPT_STOP();
        IQueryable<pipe_DPT_VIDD_EXTYPES> GetDPT_VIDD_EXTYPES();
        IQueryable<pipe_TARIF> GetTARIF();
        IQueryable<pipe_ACTIVE> GetActive();        
        int ShiftPriority(decimal Type_id, decimal direction);
        int ActivateType(decimal Type_id);
        int setWBType(decimal Type_id);
        int ActivateVidd(decimal Vidd);
        int ActivateDOC(decimal VIDD, int FLG, string DOC, string DOC_FR);
        DPT_RESULT DeleteType(decimal TYPE_ID);
        DPT_RESULT DeleteVidd(decimal VIDD);
        IQueryable<pipe_DPT_VIDD_TTS> GetViddTTS(decimal VIDD);
        IQueryable<pipe_DPT_VIDD_TTS> GetAvaliableTTS(decimal VIDD);
        IQueryable<pipe_DPT_VIDD_DOC> GetViddDOC(decimal VIDD);
        IQueryable<pipe_DPT_VIDD_DOC> GetAvaliableFLG(decimal VIDD);
        int AddTTS(decimal Vidd, string OP_TYPE);
        int GetNextTypeId();
        int GetNextVidd();
        int AddDoc(decimal VIDD, int FLG, string DOC, string DOC_FR);
        int AddDoc2Type(decimal TYPE_ID, int FLG, string DOC, string DOC_FR);
        int AddDoc2Vidd(decimal VIDD, int FLG, string DOC, string DOC_FR);
        int ClearDoc2Vidd(decimal VIDD, int FLG);
        int ClearDoc2Type(decimal TYPE_ID, int FLG);
        IQueryable<pipe_DPT_DOC_SCHEME> GetDocScheme(int FR);
        IQueryable<pipe_DPT_VIDD_LIST> GetVidd();
        IQueryable<pipe_DPT_BRANCH_LIST> GetBranchList();       
        void DoJob(string JOB_CODE, int JOB_MODE);
        void DoJobCode(string JOB_CODE);
        IQueryable<pipe_DICTS> GetDictList();
        IQueryable<pipe_DPT_VIDD_DOC> GetDptTypeDocs(int TYPE_ID);
        System.Tuple<System.IO.MemoryStream, string> DptBratesExport(string date);
        IQueryable<pipe_DPT_JOBS_JRNL> GetDptJobsJrnl(int JOB_ID);
        IQueryable<pipe_DPT_JOBS_LOG> GetDptJobsBlog(int Run_ID);
        IQueryable<pipe_DPT_DEPOSIT> GetDepostiStartAndEndDates(long depositId);
        void PutTermDepCorrForm (long depositNm, System.DateTime depositStartDt, System.DateTime depositEndDt, System.DateTime newDepositStartDt, System.DateTime newDepositEndDt, int prolongationNm);
        void PutReportForPnFondFormToDb(int repPeriodNum, System.DateTime repDt);
        decimal? GetRate(decimal br_id, int kv);
        string GetRateDate(decimal br_id, int kv);
        IQueryable<pipe_BR_TIER> GetDpBrTier(decimal BR_ID, decimal kv);
        void NewPF(System.DateTime date_p);
        void CorrectHolydayDeposit(CorrectHolydayData data);

    }
}