using System;

using BarsWeb.Areas.CDO.Common.Models;
using BarsWeb.Areas.CDO.Corp2.Models;

namespace BarsWeb.Areas.CDO.Corp2.Services
{
    public static class Mapper
    {
        public static User MapRelatedCustomerToUser(RelatedCustomer rc)
        {
            decimal userId;
            string acskKeySn = rc.AcskSertificateSn;
            if (string.IsNullOrEmpty(acskKeySn) && rc.AcskRegistrationId.HasValue && rc.AcskRegistrationId != 0)
            {
                try
                {
                    acskKeySn = ((int)rc.AcskRegistrationId.Value).ToString("X8");
                }
                finally
                {
                }
            }
            return new User
            {
                Id = decimal.TryParse(rc.UserId, out userId) ? new Nullable<decimal>(userId) : null,
                CustomerId = rc.CustId,
                VisaId = (int)(rc.SignNumber ?? 0),
                SequentialVisa = rc.SequentialVisa,
                TaxCode = rc.TaxCode,
                Login = rc.Login,
                FirstName = rc.FirstName,
                LastName = rc.LastName,
                SecondName = rc.SecondName,
                FullNameGenitiveCase = rc.FullNameGenitiveCase,
                Email = rc.Email,
                PhoneNumber = rc.CellPhone,
                AcskSertificateKeySn = acskKeySn,
                BirthDate = rc.BirthDate,
                DocSeries = rc.DocSeries,
                DocNumber = rc.DocNumber,
                DocOrganization = rc.DocOrganization,
                DocDate = rc.DocDate,
                AddressRegionId = rc.AddressRegionId.ToString(),
                AddressCity = rc.AddressCity,
                AddressStreet = rc.AddressStreet,
                AddressHouseNumber = rc.AddressHouseNumber,
                AddressAddition = rc.AddressAddition
            };
        }
        public static RelatedCustomer MapUserToRelatedCustomer(User user)
        {
            decimal addrRegId;
            decimal? acskRegId = null;
            try
            {
                acskRegId = Convert.ToInt32(user.AcskSertificateKeySn, 16);
            }
            finally
            {
            }
            return new RelatedCustomer
            {
                UserId = user.Id == null ? null : user.Id.ToString(),
                //CustId = user.CustomerId,
                SignNumber = user.VisaId,
                SequentialVisa = user.SequentialVisa,
                TaxCode = user.TaxCode,
                Login = user.Login,
                FirstName = user.FirstName,
                LastName = user.LastName,
                SecondName = user.SecondName,
                FullNameGenitiveCase = user.FullNameGenitiveCase,
                Email = user.Email,
                CellPhone = user.PhoneNumber,
                BirthDate = user.BirthDate,
                DocSeries = user.DocSeries,
                DocNumber = user.DocNumber == null ? null : user.DocNumber.ToString(),
                DocOrganization = user.DocOrganization,
                DocDate = user.DocDate,
                AddressRegionId = decimal.TryParse(user.AddressRegionId, out addrRegId) ? new Nullable<decimal>(addrRegId) : null,
                AddressCity = user.AddressCity,
                AddressStreet = user.AddressStreet,
                AddressHouseNumber = user.AddressHouseNumber,
                AddressAddition = user.AddressAddition,
                AcskSertificateSn = user.AcskSertificateKeySn,
                AcskRegistrationId = acskRegId
            };
        }

        public static Account MapUserAccountPermissionViewModelToAccount(UserAccountPermissionViewModel a)
        {
            return new Account
            {
                ACCID = a.CORP2_ACC,
                VISAID = a.VISA_ID,
                ACTIVE = a.CAN_WORK == true ? "Y" : "N",
                CANDEBIT = a.CAN_DEBIT ? "Y" : "N",
                CANVIEW = a.CAN_VIEW ? "Y" : "N",
                CANVISA = a.CAN_VISA ? "Y" : "N",
                SEQUENTIALVISA = a.SEQUENTIAL_VISA ? "Y" : "N"
            };
        }
        public static UserAccountPermissionViewModel MapUserAccountPermissionDBModelToViewModel(UserAccountPermissionDBModel a)
        {
            return new UserAccountPermissionViewModel
            {
                USER_ID = a.USER_ID,
                NUM_ACC = a.NUM_ACC,
                CORP2_ACC = a.CORP2_ACC,
                KF = a.KF,
                KV = a.KV,
                VISA_ID = a.VISA_ID,
                CAN_WORK = a.ACTIVE == "Y" ? true : false,
                CAN_DEBIT = a.CAN_DEBIT == "Y" ? true : false,
                CAN_VIEW = a.CAN_VIEW == "Y" ? true : false,
                CAN_VISA = a.CAN_VISA == "Y" ? true : false,
                CUST_ID = a.CUST_ID,
                NAME = a.NAME,
                SEQUENTIAL_VISA = a.SEQUENTIAL_VISA == "Y" ? true : false
            };
        }
        public static UserAccountPermissionDBModel MapUserAccountPermissionViewModelToDBModel(UserAccountPermissionViewModel a)
        {
            return new UserAccountPermissionDBModel
            {
                USER_ID = a.USER_ID,
                NUM_ACC = a.NUM_ACC,
                CORP2_ACC = a.CORP2_ACC,
                KF = a.KF,
                KV = a.KV,
                VISA_ID = a.VISA_ID,
                ACTIVE = a.CAN_WORK == true ? "Y" : "N",
                CAN_DEBIT = a.CAN_DEBIT ? "Y" : "N",
                CAN_VIEW = a.CAN_VIEW ? "Y" : "N",
                CAN_VISA = a.CAN_VISA ? "Y" : "N",
                CUST_ID = a.CUST_ID,
                NAME = a.NAME,
                SEQUENTIAL_VISA = a.SEQUENTIAL_VISA ? "Y" : "N"
            };
        }
        public static Limit MapLimitVMToLimit(LimitViewModel l)
        {
            return new Limit
            {
                LIMIT_ID = l.LIMIT_ID,
                USER_ID = l.USER_ID,
                DOC_SUM = l.DOC_SUM,
                DOC_CREATED_COUNT = l.DOC_CREATED_COUNT,
                DOC_SENT_COUNT = l.DOC_SENT_COUNT,
                DOC_DATE_LIM = l.DOC_DATE_LIM
            };
        }
    }
}