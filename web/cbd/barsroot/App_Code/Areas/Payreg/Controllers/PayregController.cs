using Areas.Payreg.Models;
using BarsWeb.Areas.Payreg.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Payreg.Models;
using BarsWeb.Controllers;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using Bars.Logger;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;

namespace BarsWeb.Areas.Payreg.Controllers
{
    [AuthorizeUser]
    public class PayregController : ApplicationController
    {
        private readonly IPayRegularRepository _repository;
        private readonly IBankDatesRepository _bankDates;
        private readonly IHomeRepository _homeRepo;

        public PayregController(IPayRegularRepository payRegular, IBankDatesRepository bankDates, IHomeRepository homeRepo)
        {
            _repository = payRegular;
            _bankDates = bankDates;
            _homeRepo = homeRepo;
        }

        public ActionResult GetSbonPropviders([DataSourceRequest] DataSourceRequest request)
        {
            try
            {
                var providerList = _repository.GetSbonProviders();
                return Json(providerList.ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
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

        public ActionResult GetAllSbonProviders()
        {
            var providerList = _repository.GetSbonProviders();
            return Json(providerList, JsonRequestBehavior.AllowGet);
        }

        public ActionResult SearchCustomers([DataSourceRequest] DataSourceRequest request, CustomerSearchParams csp)
        {
            try
            {
                if (request != null)
                {   //покажем первых десять
                    request.PageSize = 10;
                }
                var customerList = _repository.CustomerSearch(csp);
                var result = customerList.ToDataSourceResult(request);
                foreach (var customer in result.Data)
                {
                   CustomerInfo item = (CustomerInfo) customer;
                   item.HasActiveAccounts = _repository.GetCustAcounts(item.Rnk).Any();
                }
                return Json(result);
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

        public ActionResult GetSbonOrders([DataSourceRequest] DataSourceRequest request, int custId)
        {
            try
            {
                var orderList = _repository.GetCustSbonOrders(custId);
                return Json(orderList.ToDataSourceResult(request));
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

        public ActionResult AddNewSbonWithContractOrder(RegularSbonWithContractOrder order)
        {
            try
            {
                var result = _repository.AddNewSbonOrder(order);
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

        public ActionResult AddNewSbonWithoutContractOrder(RegularSbonWithoutContractOrder order)
        {
            try
            {
                var result = _repository.AddNewSbonOrder(order);
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

        public ActionResult AddNewSbonFreeOrder(RegularSbonFreeOrder order)
        {
            try
            {
                var result = _repository.AddNewSbonOrder(order);
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

        public ActionResult AddNewSepOrder(RegularSepPaymentOrder order)
        {
            try
            {
                var result = _repository.AddNewSepOrder(order);
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
        public ActionResult GetCustomerAccounts(int? custId)
        {
            List<V_STO_ACCOUNTS> accounts = null;
            if (custId != null)
            {
                accounts = _repository.GetCustAcounts(custId.Value).ToList();
            }


            if (accounts == null || !accounts.Any())
            {
                accounts = new List<V_STO_ACCOUNTS>
                {
                    new V_STO_ACCOUNTS()
                    {
                        ACC = 0,
                        NLS = "Відсутні рахунки"
                    }
                };
            }

            var result = accounts.Select(a => new AccountInfo()
            {
                ACC = a.ACC,
                NLS = a.NLS + (a.ACC == 0 ? "" : " (" + a.NMS + ")")
            });    
            
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ShiftPriority(int orderId, int direction)
        {
            _repository.ShiftPriority(orderId, direction);
            return null;
        }

        public ActionResult CloseOrder(int orderId)
        {
            _repository.CloseOrder(orderId);
            return null;
        }
        public ActionResult GetFreqList()
        {
            var freqList = _repository.GetFreqs();
            return (Json(freqList, JsonRequestBehavior.AllowGet));
        }
        public ActionResult SbonProviderIndex()
        {
            return View();
        }

        public ActionResult SbonOrders()
        {
            ViewBag.BankDate = _bankDates.GetBankDate();
            ViewBag.CurrentUserName = _homeRepo.GetUserParam().USER_FULLNAME;
            return View();
        }

        public ActionResult GetProviderExtraFiledsMeta(int provId)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                IEnumerable<ExtraAttrMeta> extFields = _repository.GetProviderExtraFiledsMeta(provId);
                result.data = extFields.ToList();
            }
            catch (Exception ex)
            {
                result.status = JsonResponseStatus.Error;
                result.message = "Виникла помилка формування списку додаткових реквізитів! <br/>" +
                    (ex.InnerException == null ? ex.Message : ex.InnerException.Message) +
                    "<br/><strong>Роботу із цим провайдером заборонено!</strong>";
            }
            return Json(result, JsonRequestBehavior.AllowGet); 
        }

        public ActionResult GetSepOrder(int orderId)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetSepOrder(orderId);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet); 
        }

        public ActionResult GetSbonFreeOrder(int orderId)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetSbonFreeOrder(orderId);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet); 
        }

        public ActionResult GetSbonWithoutContractOrder(int orderId)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetSbonWithoutContractOrder(orderId);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet); 
        }

        public ActionResult GetSbonWithContractOrder(int orderId)
        {
            var result = new JsonResponse(JsonResponseStatus.Ok);
            try
            {
                result.data = _repository.GetSbonWithContractOrder(orderId);
            }
            catch (Exception e)
            {
                result.status = JsonResponseStatus.Error;
                result.message = e.InnerException == null ? e.Message : e.InnerException.Message;
            }
            return Json(result, JsonRequestBehavior.AllowGet); 
        }

        public ActionResult PrintF190(int orderId)
        {
            const string templateName = "STO_F190.frx";
            string templatePath = FrxDoc.GetTemplatePathByFileName(templateName);
            FrxParameters pars = new FrxParameters
            {
                new FrxParameter("order_id", TypeCode.Int64, orderId)
            };
            DBLogger.Info(string.Format("STO_F190 парамтер orderId = {0}", orderId));
            FrxDoc doc = new FrxDoc(templatePath, pars, null);
            using (var str = new MemoryStream())
            {
                doc.ExportToMemoryStream(FrxExportTypes.Pdf, str);
                return File(str.ToArray(), "application/pdf", string.Format("f190_{0}.pdf", orderId));
            }
        }
        
    }
}