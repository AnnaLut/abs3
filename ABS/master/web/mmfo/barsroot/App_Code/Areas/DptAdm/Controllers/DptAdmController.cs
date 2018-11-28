using BarsWeb.Controllers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System;
using System.Web;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Core.Logger;
using BarsWeb.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;
using Ninject;
using Areas.Payreg.Models;
using BarsWeb.Areas.DptAdm.Infrastructure.Repository.DI.Abstract;
using Areas.DptAdm.Models;
using BarsWeb.Areas.Payreg.Models;
using Oracle.DataAccess.Client;
using BarsWeb.Areas.DptAdm.Models;
using System.Globalization;
using Microsoft.Ajax.Utilities;
using System.Web.Script.Serialization;

namespace BarsWeb.Areas.DptAdm.Controllers
{
    [AuthorizeUser]
    public class DptAdmController : ApplicationController
    {
        private readonly IDptAdmRepository _repository;
        private readonly IBankDatesRepository _bankDates;
        private readonly IHomeRepository _homeRepo;
        [Inject]
        public IDbLogger Logger { get; set; }

        public DptAdmController(IDptAdmRepository listDptAdm, IBankDatesRepository bankDates, IHomeRepository homeRepo)
        {
            _repository = listDptAdm;
            _bankDates = bankDates;
            _homeRepo = homeRepo;
        }

        public ActionResult DPTViddGrid()
        {
            return View();
        }
        public ActionResult DPTAutoOperations()
        {
            return View();
        }
        public ActionResult DPTArch()
        {
            return View();
        }
        public ActionResult DPTTotals()
        {
            return View();
        }

        public ActionResult DPTAdditional()
        {
            return View();
        }
        public ActionResult GetDptType()
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetDptTypeLst();
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetDptTypeInfo(decimal TYPE_ID)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetDptTypeInfo(TYPE_ID);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetDptArchive(System.DateTime? cdat, decimal? VIDD, string BRANCH)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetDptArchive(cdat, VIDD, BRANCH);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetDptTypes([DataSourceRequest] DataSourceRequest request)
        {
            try
            {

                var typeList = _repository.GetDptType();
                return Json(typeList.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new DataSourceResult
                {
                    Errors = new
                    {
                        message = ex.ToString()
                    },
                });
            }
        }
        public ActionResult GetDptVidd(decimal? TYPE_ID)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetDptVidd(TYPE_ID);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetDpBrTier(decimal BR_ID, decimal kv)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetDpBrTier(BR_ID,kv);
                result.message = "Ok";
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetDptVidds([DataSourceRequest] DataSourceRequest request, decimal TYPE_ID)
        {
            try
            {

                var viddList = _repository.GetDptVidd(TYPE_ID);
                return Json(viddList.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new DataSourceResult
                {
                    Errors = new
                    {
                        message = ex.ToString()
                    },
                });
            }
        }

        public ActionResult GetDptViddInfo(decimal VIDD)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetDptViddInfo(VIDD);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetDptJobs()
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetDptJobs();               
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetDptJobsJrnl([DataSourceRequest] DataSourceRequest request, int JOB_ID)
        {           
            try
            {
                var items = _repository.GetDptJobsJrnl(JOB_ID).ToList();
                return Json(items.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new DataSourceResult
                {
                    Errors = new
                    {
                        message = ex.ToString()
                    },
                });
            }           
        }

        public ActionResult GetDptJobsBlog([DataSourceRequest] DataSourceRequest request, int Run_ID)
        {
            try
            {
                var items = _repository.GetDptJobsBlog(Run_ID).ToList();
                return Json(items.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new DataSourceResult
                {
                    Errors = new
                    {
                        message = ex.ToString()
                    },
                });
            }
        }
        public ActionResult GetKV()
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetKV();
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetDptViddINFOALL(decimal VIDD)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetDptViddINFOALL(VIDD);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetBSD()
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetBSD();
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetBSN(string BSD)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetBSN(BSD);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetBSA(string BSD, string Avans)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetBSA(BSD, Avans);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetBASEY()
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetBASEY();
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetFREQ()
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetFREQ();
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetMETR()
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetMETR();
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetION()
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetION();
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetBRATES()
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetBRATES();
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetDPT_STOP()
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetDPT_STOP();
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetDPT_VIDD_EXTYPES()
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetDPT_VIDD_EXTYPES();
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetTARIF()
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetTARIF();
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetActive()
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetActive();
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult saveVidd(pipe_DPT_VIDD_INFO UpdateVidd)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            DPT_RESULT dt = new DPT_RESULT();
            try
            {
                dt = _repository.saveVidd(UpdateVidd);
                if (dt.res == 0)
                    result.message = dt.mess;
                else
                {
                    result.status = JsonResponseStatus.Error;
                    result.message = String.Format("Тип депозиту {0} {1} не збережено з помилкою \n\r {2}", UpdateVidd.VIDD, UpdateVidd.TYPE_NAME, dt.mess);
                }               
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                if (dt.mess != null)
                    result.message = dt.mess;
                else result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult saveTYPE(pipe_DPT_TYPES UpdateType)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            DPT_RESULT dt = new DPT_RESULT();
            try
            {               
                dt = _repository.saveTYPE(UpdateType);
                if (dt.res == 0)
                    result.message = dt.mess;
                else
                {
                    result.status = JsonResponseStatus.Error;
                    result.message = String.Format("Тип депозиту {0} {1} не збережено з помилкою \n\r{2}", UpdateType.TYPE_ID, UpdateType.TYPE_CODE, dt.mess);
                }
                
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                if (dt.mess != null)
                    result.message = dt.mess;
                else result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult ShiftPriority(decimal Type_id, decimal direction)
        {
            try
            {
                var result = _repository.ShiftPriority(Type_id, direction);
                return Json(new
                {
                    message = result
                });

            }
            catch (Exception ex)
            {
                return Json(new
                {
                    error = ex.InnerException.Message
                });
            }
        }
        public ActionResult ActivateType(decimal Type_id)
        {
            try
            {
                var result = _repository.ActivateType(Type_id);
                return Json(new
                {
                    message = result
                });

            }
            catch (Exception ex)
            {
                return Json(new
                {
                    error = ex.InnerException.Message
                });
            }
        }
        public ActionResult setWBType(decimal Type_id)
        {
            try
            {
                var result = _repository.setWBType(Type_id);
                return Json(new
                {
                    message = result
                });

            }
            catch (Exception ex)
            {
                return Json(new
                {
                    error = ex.InnerException.Message
                });
            }
        }

        public ActionResult ActivateDOC(decimal VIDD, int FLG, string DOC, string DOC_FR)
        {
            try
            {
                var result = _repository.ActivateDOC(VIDD, FLG, DOC, DOC_FR);
                return Json(new
                {
                    message = result
                });

            }
            catch (Exception ex)
            {
                return Json(new
                {
                    error = ex.InnerException.Message
                });
            }
        }
        public ActionResult ActivateVidd(decimal Vidd)
        {
            try
            {
                var result = _repository.ActivateVidd(Vidd);
                return Json(new
                {
                    message = result
                });

            }
            catch (Exception ex)
            {
                return Json(new
                {
                    error = ex.InnerException.Message
                });
            }
        }
        public ActionResult GetViddTTS(decimal VIDD)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetViddTTS(VIDD);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetViddDOC(decimal VIDD)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetViddDOC(VIDD);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetAvaliableTTS(decimal VIDD)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetAvaliableTTS(VIDD);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetAvaliableFLG(decimal VIDD)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetAvaliableFLG(VIDD);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult AddTTS(decimal Vidd, string OP_TYPE)
        {
            try
            {
                var result = _repository.AddTTS(Vidd, OP_TYPE);
                return Json(new
                {
                    message = result
                });

            }
            catch (Exception ex)
            {
                return Json(new
                {
                    error = ex.InnerException.Message
                });
            }
        }
        
        public ActionResult GetDocScheme(int FR)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetDocScheme(FR);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetVidd()
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetVidd();
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetBranchList()
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetBranchList();
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult DeleteType(decimal TYPE_ID)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            DPT_RESULT dt = new DPT_RESULT();
            try
            {
                dt = _repository.DeleteType(TYPE_ID);
                if (dt.res == 0)
                    result.message = dt.mess;
                else
                {
                    result.status = JsonResponseStatus.Error;
                    result.message = String.Format("Тип депозиту {0} не видалено з помилкою \n\r{2}", TYPE_ID, dt.mess);
                }

            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                if (dt.mess != null)
                    result.message = dt.mess;
                else result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult DeleteVidd(decimal VIDD)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            DPT_RESULT dt = new DPT_RESULT();
            try
            {
                dt = _repository.DeleteVidd(VIDD);
                if (dt.res == 0)
                    result.message = dt.mess;
                else
                {
                    result.status = JsonResponseStatus.Error;
                    result.message = String.Format("Вид депозиту {0} не видалено з помилкою \n\r{2}", VIDD, dt.mess);
                }

            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                if (dt.mess != null)
                    result.message = dt.mess;
                else result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);        
        }

        public void DoJob(string JOB_CODE, int JOB_MODE)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repository.DoJob(JOB_CODE, JOB_MODE);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }            
        }
       
        public ActionResult DoJobCode(string JOB_CODE)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                _repository.DoJobCode(JOB_CODE);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result);
        }

         public ActionResult GetNextTypeId()
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetNextTypeId();
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
         public ActionResult GetNextVidd()
         {
             var result = new JsonResponse(JsonResponseStatus.Ok);
             try
             {
                 result.data = _repository.GetNextVidd();
             }
             catch (Exception e)
             {
                 result.status = JsonResponseStatus.Error;
                 result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
             }
             return Json(result, JsonRequestBehavior.AllowGet);
         }
         public ActionResult GetDptViddParam(decimal VIDD)
         {
             var result = new JsonResponse(JsonResponseStatus.Ok);
             try
             {
                 result.data = _repository.GetDptViddParam(VIDD);
             }
             catch (Exception e)
             {
                 result.status = JsonResponseStatus.Error;
                 result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
             }
             return Json(result, JsonRequestBehavior.AllowGet);
         }
         public void GetDictList()
         {
             var result = new JsonResponse(JsonResponseStatus.Ok);
             try
             {
                 _repository.GetDictList();
             }
             catch (Exception e)
             {
                 result.status = JsonResponseStatus.Error;
                 result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
             }            
         }         
          public ActionResult GetDptTypeDocs(int TYPE_ID)
          {
             var result = new JsonResponse(JsonResponseStatus.Ok);
             try
             {
                 result.data = _repository.GetDptTypeDocs(TYPE_ID);
             }
             catch (Exception e)
             {
                 result.status = JsonResponseStatus.Error;
                 result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
             }
             return Json(result, JsonRequestBehavior.AllowGet);
         }
          public ActionResult AddDoc2Type(decimal TYPE_ID, int FLG, string DOC, string DOC_FR)
          {
              try
              {
                  var result = _repository.AddDoc2Type(TYPE_ID, FLG, DOC, DOC_FR);
                  return Json(new
                  {
                      message = result
                  });

              }
              catch (Exception ex)
              {
                  return Json(new
                  {
                      error = ex.InnerException.Message
                  });
              }
          }
          public ActionResult AddDoc2Vidd(decimal VIDD, int FLG, string DOC, string DOC_FR)
          {
              try
              {
                  var result = _repository.AddDoc2Vidd(VIDD, FLG, DOC, DOC_FR);
                  return Json(new
                  {
                      message = result
                  });

              }
              catch (Exception ex)
              {
                  return Json(new
                  {
                      error = ex.InnerException.Message
                  });
              }   
          }

          public void PutParam(decimal vidd, string tag, string val)
             {                
                     _repository.PutParam(vidd, tag, val);
                
          }  
              
          public ActionResult AddDoc(decimal VIDD, int FLG, string DOC, string DOC_FR)
          {
              try
              {
                  var result = _repository.AddDoc(VIDD, FLG, DOC, DOC_FR);
                  return Json(new
                  {
                      message = result
                  });

              }
              catch (Exception ex)
              {
                  return Json(new
                  {
                      error = ex.InnerException.Message
                  });
              }
          }
          public ActionResult ClearDoc2Vidd(decimal VIDD, int FLG)
          {
              try
              {
                  var result = _repository.ClearDoc2Vidd(VIDD, FLG);
                  return Json(new
                  {
                      message = result
                  });

              }
              catch (Exception ex)
              {
                  return Json(new
                  {
                      error = ex.InnerException.Message
                  });
              }
          }
        public ActionResult ClearDoc2Type(decimal TYPE_ID, int FLG)
          {
              try
              {
                  var result = _repository.ClearDoc2Type(TYPE_ID, FLG);
                  return Json(new
                  {
                      message = result
                  });

              }
              catch (Exception ex)
              {
                  return Json(new
                  {
                      error = ex.InnerException.Message
                  });
              }
          }
        /// <summary>
        /// Выполнить экспорт в Excel
        /// </summary>
        /// <param name="DateFrom"></param>
        /// <returns></returns>
        public FileContentResult DptBratesExport(string date)
        {
            //var pl_date = DateTime.ParseExact(date, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            var file = _repository.DptBratesExport(date);
            return File(file.Item1.ToArray(), "text / plain; charset = UTF - 8", file.Item2.ToString());
           
        }


        public ActionResult GetDepostiStartAndEndDates(long depositId)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetDepostiStartAndEndDates(depositId);
                
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result);
        }

        public ActionResult PutTermDepCorrForm(long depositNm, DateTime depositStartDt, DateTime depositEndDt, DateTime newDepositStartDt, DateTime newDepositEndDt, int prolongationNm )
        {

            var result = new JsonResponse(JsonResponseStatus.Ok);

            try
            {
                _repository.PutTermDepCorrForm(depositNm, depositStartDt, depositEndDt, newDepositStartDt, newDepositEndDt, prolongationNm);

            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result);
        }


        public ActionResult PutReportForPnFondFormToDb (int repPeriodNum, DateTime repDt)
        {

            var result = new JsonResponse(JsonResponseStatus.Ok);

            try
            {
                _repository.PutReportForPnFondFormToDb(repPeriodNum, repDt);

            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result);
        }
        public ActionResult GetRate(decimal br_id, int kv)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetRate(br_id, kv);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GetRateDate(decimal br_id, int kv)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetRateDate(br_id, kv);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult NewPF(DateTime date)
        {

            var result = new JsonResponse(JsonResponseStatus.Ok);

            try
            {
                _repository.NewPF(date);

            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result);
        }

        public ActionResult CorrectHolydayDeposit(string correct_holyday_data)
        {
            try
            {
                _repository.CorrectHolydayDeposit(new JavaScriptSerializer().Deserialize<CorrectHolydayData>(correct_holyday_data));
                return Json(new JsonResponse { status = JsonResponseStatus.Ok });
            }
            catch(Exception e)
            {
                return Json(new JsonResponse { status = JsonResponseStatus.Error, message = e.Message });
            }
        }

    }
}