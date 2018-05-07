using BarsWeb.Areas.Clients.Models.Enums;
using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;

namespace BarsWeb.Areas.Clients.Infrastructure.Repository
{
    public class SqlCreator
    {

        const string SelectCustomer = @"select
                                a.RNK as Id,
                                a.CUSTTYPE as TypeId,
                                a.CUSTTYPENAME as TypeName,
                                a.DATE_ON as DateOpen,
                                a.DATE_OFF as DateClosed,
                                a.ND as ContractNumber,
                                a.NMK as Name,
                                a.NMKK as NameShort,
                                a.NMKV as NameInternational,
                                a.OKPO as Code,
                                a.BRANCH as Branch,
                                a.SED as Sed,
                                a.REQ_TYPE as RequestType,
                                a.REQ_STATUS as RequestStatus,
                                a.ISE AS ISE,
                                a.VED AS VED,
                                (select VALUE from V_CUSTOMERW where RNK = a.RNK and tag in ('DEATH')) as DEATH,
                                (select VALUE from V_CUSTOMERW where RNK = a.RNK and tag in ('DTDIE')) as DTDIE
                            from V_CUSTOMER a";

        public static BarsSql Customers(CustomerType type, bool showClosed)
        {
            if (type == CustomerType.Corp || type == CustomerType.Person)
            {
                return new BarsSql
                {
                    SqlText = string.Format(@"{0} where a.CUSTTYPE = :P_CUSTTYPE {1}", SelectCustomer , showClosed ? "" : "and a.DATE_OFF is null"),
                    SqlParams = new object[]
                    {
                    new OracleParameter("P_CUSTTYPE", OracleDbType.Int32) {Value = (int)type}
                    }
                };
            }
            if (type == CustomerType.PersonSpd)
            {
                return new BarsSql
                {
                    SqlText = string.Format(@"{0} where A.SED = 91 and A.ISE in (14200, 14100, 14201, 14101) and nvl(a.ved , 00000) <> '00000' {1}", SelectCustomer, showClosed ? "" : "and a.DATE_OFF is null")
                };
            }

            return new BarsSql
            {
                SqlText = SelectCustomer
            };
        }

        public static BarsSql CustomerImage(decimal? CustomerID, string TypePicture)
        {
            return new BarsSql
            {
                SqlText = "select IMAGE from CUSTOMER_IMAGES where RNK = :p_rnk and TYPE_IMG = :p_type",
                SqlParams = new object[]
                {
                    new OracleParameter("p_rnk", OracleDbType.Decimal) {Value = CustomerID},
                    new OracleParameter("p_type", OracleDbType.Varchar2) {Value = TypePicture}
                }
            };
        }
    }
}