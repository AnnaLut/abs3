using System;
using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Swift.Infrastructure.DI.Implementation
{
    public class SqlCreatorGPIMessages
    {       
        public static BarsSql GetGPIMessagesList()
        {
            return new BarsSql()
            {
                SqlText = @"Select 
                                Ref, 
                                MT103, 
                                io_ind_103 as InputOutputInd103,
                                swref_103 as SWRef,
                                date_input_103 as DateIn,
                                vdate_103 as VDate,
                                date_output_103 as DateOut,
                                sender_103 as SenderCode,
                                sender_account as SenderAccount,
                                receiver_103 as ReceiverCode,
                                payer_103 as Payer,
                                payee_103 as Payee,
                                amount as Summ,
                                Currency,
                                STI,
                                UETR,
                                status_code as Status,
                                status_description as StatusDescription
                                    from v_sw_gpi_statuses",
                SqlParams = new object[] { }
            };
        }

        public static BarsSql GetGPIMessages199List(string uetr)
        {
            return new BarsSql()
            {
                SqlText = @"Select 
                                UETR,
                                Ref, 
                                MT, 
                                date_out as DateOut,
                                sender as SenderCode,
                                receiver as ReceiverCode,
                                amount as Summ,
                                Currency,
                                Status,
                                status_description as StatusDescription
                                    from V_SW_GPI_STATUSES_MT199 where UETR = :p_uetr",
                SqlParams = new object[]
                {
                    new OracleParameter("p_uetr", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = uetr }
                }
            };
        }
    }
}
