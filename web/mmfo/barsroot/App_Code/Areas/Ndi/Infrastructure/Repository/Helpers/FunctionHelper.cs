using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for FunctionHelper
/// </summary>
namespace BarsWeb.Areas.Ndi.Infrastructure.Repository.Helpers
{
    public class FunctionHelper
    {
        public FunctionHelper()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public static void GetCustomer()
        {
            using (OracleConnection connection = new OracleConnection("Data Source=COBUMMFO_DEV_E;User ID=bars_access_user;Proxy User ID=appserver;Proxy Password=appserver;Pooling=yes;"))
            {
                connection.Open();

                OracleCommand command = new OracleCommand("bars.test_udt.get_customer", connection) { CommandType = CommandType.StoredProcedure };

                OracleParameter customer = new OracleParameter("p_customer", OracleDbType.Object, ParameterDirection.ReturnValue);
                customer.UdtTypeName = "BARS.T_CUSTOMER";

                command.Parameters.Add(customer);

                command.ExecuteNonQuery();

                foreach (OracleParameter p in command.Parameters)
                {
                    Console.WriteLine("UserId : " + p.ParameterName + " " + p.Value);
                }
            }
        }
    }
}