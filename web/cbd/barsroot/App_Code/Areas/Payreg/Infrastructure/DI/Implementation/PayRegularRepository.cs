using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using Areas.Payreg.Models;
using BarsWeb.Areas.Payreg.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Payreg.Models;
using BarsWeb.Models;
using FastReport.Utils;
using Newtonsoft.Json;

namespace BarsWeb.Areas.Payreg.Infrastructure.Repository.DI.Implementation
{
    public class PayRegularRepository : IPayRegularRepository
    {
        private readonly PayregEntities _entities;

        private string ConvertExtraParamsFromJsonToXml(string jsonParams)
        {
            List<ExtraAttrData> extAttributes = JsonConvert.DeserializeObject<List<ExtraAttrData>>(jsonParams);
            var result = new StringBuilder("<Attributes>");
            foreach (var attr in extAttributes)
            {
                result.Append(String.Format("\n\t<{0}>{1}</{0}>", attr.Code, attr.Value));
            }
            result.Append("\n</Attributes>");
            return result.ToString();
        }
        public PayRegularRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("Payreg", "Payreg");
            _entities = new PayregEntities(connectionStr); 
        }
        public IQueryable<V_STO_SBON_PROVIDER> GetSbonProviders()
        {
            return _entities.V_STO_SBON_PROVIDER;
        }

        public IQueryable<CustomerInfo> CustomerSearch(CustomerSearchParams sp)
        {
            decimal? rnk = sp.CustomerId == null ? (decimal?) null : Convert.ToInt32(sp.CustomerId);
            string custName = String.IsNullOrEmpty(sp.CustomerName) ? sp.CustomerName : sp.CustomerName.ToUpper();
            return from customer in _entities.CUSTOMER
                   where (String.IsNullOrEmpty(sp.Okpo) || customer.OKPO.Contains(sp.Okpo))
                    && (String.IsNullOrEmpty(custName) || customer.NMK.ToUpper().Contains(custName))
                    && (rnk == null || customer.RNK == rnk)
                   join person in _entities.PERSON
                        on customer.RNK equals person.RNK into customerPerson
                        from personOfCustomer in customerPerson.DefaultIfEmpty()
                        where (String.IsNullOrEmpty(sp.DocNumber) || personOfCustomer.NUMDOC.Contains(sp.DocNumber)) 
                            && (String.IsNullOrEmpty(sp.DocSerial) || personOfCustomer.SER.Contains(sp.DocSerial))
                        join passp in _entities.PASSP
                        on personOfCustomer.PASSP equals passp.PASSP1 into personPassport
                        from passportOfPerson in personPassport.DefaultIfEmpty()
                select new CustomerInfo
                {
                    Okpo = customer.OKPO,
                    Adr = customer.ADR,
                    Branch = customer.BRANCH,
                    CustomerName = customer.NMK,
                    DayOfBirth =  personOfCustomer.BDAY,
                    DocumentNumber = passportOfPerson.NAME + " - " + personOfCustomer.SER + personOfCustomer.NUMDOC,
                    Rnk = customer.RNK
                };
        }

        public IQueryable<V_STO_ORDER> GetCustSbonOrders(decimal customerId)
        {
            return _entities.V_STO_ORDER.Where(o => o.CUSTOMER_ID == customerId);
        }

        public int AddNewSepOrder(RegularSepPaymentOrder order)
        {
            if (order.Id != null)
            {
                return _entities.STO_UI_EDIT_SEP_ORDER(
                    p_ORDER_ID: order.Id,
                    p_PAYER_ACCOUNT_ID: order.PayerAccountId,
                    p_START_DATE: order.StartDate,
                    p_STOP_DATE: order.StopDate,
                    p_PAYMENT_FREQUENCY: order.PaymentFrequency,
                    p_REGULAR_AMOUNT: order.RegularAmount,
                    p_RECEIVER_MFO: order.ReceiverMfo,
                    p_RECEIVER_ACCOUNT: order.ReceiverAccount,
                    p_RECEIVER_NAME: order.ReceiverName,
                    p_RECEIVER_EDRPOU: order.ReceiverEdrpou,
                    p_PURPOSE: order.Purpose,
                    p_HOLIDAY_SHIFT: order.HolidayShift);
            }
            else
            {
                return _entities.STO_UI_NEW_SEP_ORDER(
                    p_PAYER_ACCOUNT_ID: order.PayerAccountId,
                    p_START_DATE: order.StartDate,
                    p_STOP_DATE: order.StopDate,
                    p_PAYMENT_FREQUENCY: order.PaymentFrequency,
                    p_REGULAR_AMOUNT: order.RegularAmount,
                    p_RECEIVER_MFO: order.ReceiverMfo,
                    p_RECEIVER_ACCOUNT: order.ReceiverAccount,
                    p_RECEIVER_NAME: order.ReceiverName,
                    p_RECEIVER_EDRPOU: order.ReceiverEdrpou,
                    p_PURPOSE: order.Purpose,
                    p_HOLIDAY_SHIFT: order.HolidayShift);
            }
        }
        public int AddNewSbonOrder(RegularSbonWithContractOrder order)
        {
            if (order.Id == null)
            {
                return _entities.STO_UI_NEW_SBON_ORDER_WITH_CONTR(
                  order.PayerAccountId,
                  order.StartDate,
                  order.StopDate,
                  order.PaymentFrequency,
                  order.HolidayShift,
                  order.ProviderId,
                  order.PersonalAccount,
                  order.RegularAmount,
                  order.CeilingAmount,
                  ConvertExtraParamsFromJsonToXml(order.ExtraAttributes)
                  );
            }
            else
            {
                return _entities.STO_UI_EDIT_SBON_ORDER_WITH_CONTR(
                    order.Id,
                    order.PayerAccountId,
                    order.StartDate,
                    order.StopDate,
                    order.PaymentFrequency,
                    order.HolidayShift,
                    order.ProviderId,
                    order.PersonalAccount,
                    order.RegularAmount,
                    order.CeilingAmount,
                    ConvertExtraParamsFromJsonToXml(order.ExtraAttributes)
                    );
            }
        }

        public int AddNewSbonOrder(RegularSbonWithoutContractOrder order)
        {
            if (order.Id == null)
            {
                return _entities.STO_UI_NEW_SBON_ORDER_WITH_NO_CONTR(
                    order.PayerAccountId,
                    order.StartDate,
                    order.StopDate,
                    order.PaymentFrequency,
                    order.HolidayShift,
                    order.ProviderId,
                    order.PersonalAccount,
                    order.RegularAmount,
                    ConvertExtraParamsFromJsonToXml(order.ExtraAttributes)
                    );
            }
            else
            {
                return _entities.STO_UI_EDIT_SBON_ORDER_WITH_NO_CONTR(
                    order.Id,
                    order.PayerAccountId,
                    order.StartDate,
                    order.StopDate,
                    order.PaymentFrequency,
                    order.HolidayShift,
                    order.ProviderId,
                    order.PersonalAccount,
                    order.RegularAmount,
                    ConvertExtraParamsFromJsonToXml(order.ExtraAttributes)
                    );                
            }
        }
        public int AddNewSbonOrder(RegularSbonFreeOrder order)
        {
            if (order.Id == null)
            {
                return _entities.STO_UI_NEW_FREE_SBON_ORDER(
                    order.PayerAccountId,
                    order.StartDate,
                    order.StopDate,
                    order.PaymentFrequency,
                    order.HolidayShift,
                    order.ProviderId,
                    order.RegularAmount,
                    order.ReceiverMfo,
                    order.ReceiverAccount,
                    order.ReceiverName,
                    order.ReceiverEdrpou,
                    order.Purpose,
                    ConvertExtraParamsFromJsonToXml(order.ExtraAttributes)
                    );
            }
            else
            {
                return _entities.STO_UI_EDIT_FREE_SBON_ORDER(
                    order.Id,
                    order.PayerAccountId,
                    order.StartDate,
                    order.StopDate,
                    order.PaymentFrequency,
                    order.HolidayShift,
                    order.ProviderId,
                    order.RegularAmount,
                    order.ReceiverMfo,
                    order.ReceiverAccount,
                    order.ReceiverName,
                    order.ReceiverEdrpou,
                    order.Purpose,
                    ConvertExtraParamsFromJsonToXml(order.ExtraAttributes)
                    );
            }
        }
        public IQueryable<V_STO_ACCOUNTS> GetCustAcounts(decimal customerId)
        {
            return _entities.V_STO_ACCOUNTS.Where(a => a.RNK == customerId);
        }

        public IQueryable<V_STO_FREQ> GetFreqs()
        {
            return _entities.V_STO_FREQ;
        }
        public int ShiftPriority(decimal orderId, decimal direction)
        {
            return _entities.STO_UI_SHIFT_PRIORITY(orderId, direction);
        }
        public int CloseOrder(decimal orderId)
        {
            return _entities.STO_UI_CLOSE_ORDER(orderId, DateTime.Now);
        }
        public IEnumerable<ExtraAttrMeta> GetProviderExtraFiledsMeta(int providerId)
        {
            var sbonProvider = _entities.V_STO_SBON_PROVIDER.SingleOrDefault(p => p.ID == providerId);
            if (sbonProvider == null || String.IsNullOrEmpty(sbonProvider.EXTRA_ATTRIBUTES_METADATA) )
            {
                return new List<ExtraAttrMeta>();
            }
            XDocument xml = XDocument.Parse(@"<?xml version=""1.0""?>" + sbonProvider.EXTRA_ATTRIBUTES_METADATA);
            IEnumerable<ExtraAttrMeta> result =
                xml.Element("Attributes").Elements("Attribute").Select(a => new ExtraAttrMeta()
                {
                    Code = a.Element("AttributeCode").Value,
                    Title = a.Element("UserFriendlyName").Value,
                    Type = a.Element("DataType").Value.ToLower(),
                    MaxLen = a.Element("MaxLength") != null ? int.Parse(a.Element("MaxLength").Value) : 0,
                    IsMandatory = a.Element("IsMandatory") != null && a.Element("IsMandatory").Value != "0"
                }).ToList();
            
            return result;
        }
        private List<ExtraAttrData> GetExtraAttributes(int orderId)
        {
            var extAttributesXml = _entities.STO_ORDER_EXTRA_ATTRIBUTES.SingleOrDefault(a => a.ORDER_ID == orderId);

            if (extAttributesXml == null || String.IsNullOrEmpty(extAttributesXml.EXTRA_ATTRIBUTES))
            {
                return new List<ExtraAttrData>();
            }
            XDocument xml = XDocument.Parse(@"<?xml version=""1.0""?>" + extAttributesXml.EXTRA_ATTRIBUTES);
            var result =
                xml.Element("Attributes").Elements().Select(a => new ExtraAttrData()
                {
                    Code = a.Name.ToString(),
                    Value = a.Value
                }).ToList();

            return result;
        }
        public V_STO_ORDER_SEP GetSepOrder(int orderId)
        {
            return _entities.V_STO_ORDER_SEP.FirstOrDefault(o => o.ID == orderId);
        }
        public V_STO_ORDER_SBON_FREE GetSbonFreeOrder(int orderId)
        {
            var result = _entities.V_STO_ORDER_SBON_FREE.FirstOrDefault(o => o.ID == orderId);
            if (result != null)
            {
                result.ExtraData = GetExtraAttributes(orderId);
            }
            return result;
        }
        public V_STO_ORDER_SBON_NO_CONTR GetSbonWithoutContractOrder(int orderId)
        {
            var result = _entities.V_STO_ORDER_SBON_NO_CONTR.FirstOrDefault(o => o.ID == orderId);
            if (result != null)
            {
                result.ExtraData = GetExtraAttributes(orderId);
            }
            return result;
        }
        public V_STO_ORDER_SBON_CONTR GetSbonWithContractOrder(int orderId)
        {
            var result = _entities.V_STO_ORDER_SBON_CONTR.FirstOrDefault(o => o.ID == orderId);
            if (result != null)
            {
                result.ExtraData = GetExtraAttributes(orderId);
            }
            return result;
        }
    }
}