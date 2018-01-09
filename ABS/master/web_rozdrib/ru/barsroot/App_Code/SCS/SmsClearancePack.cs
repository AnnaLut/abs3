using System;
using System.Collections.Generic;
using ibank.core;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;
using System.Data;

namespace Bars.SCS
{

    public class SmsClearancePack : BbPackage
    {
        public SmsClearancePack(BbConnection Connection, AutoCommit AutoCommitMode) : base(Connection, AutoCommitMode) { }
        public SmsClearancePack(BbConnection Connection) : base(Connection, AutoCommit.Enabled) { }

        public void PAY_FOR_SMS_BY_ACC(Decimal? P_ACC)
        {
            try
            {
                List<OracleParameter> parameters = new List<OracleParameter>();
                parameters.Add(new OracleParameter("P_ACC", OracleDbType.Decimal, P_ACC, ParameterDirection.Input));
                object ReturnValue = null;
                ExecuteNonQuery("bars_sms_clearance.pay_for_sms_by_acc", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            }
            catch (SystemException ex)
            {
                throw ex;
            }
        }
        public void PAY_CLEARANCE(Decimal? P_ACC)
        {
            try
            {
                List<OracleParameter> parameters = new List<OracleParameter>();
                parameters.Add(new OracleParameter("P_ACC_PARENT", OracleDbType.Decimal, P_ACC, ParameterDirection.Input));
                object ReturnValue = null;
                ExecuteNonQuery("bars_sms_clearance.pay_clearance", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            }
            catch (SystemException ex)
            {
                throw ex;
            }
        }
        public void TRANSFER_CLEARANCE(Decimal? P_ACC)
        {
            try
            {
                List<OracleParameter> parameters = new List<OracleParameter>();
                parameters.Add(new OracleParameter("P_ACC", OracleDbType.Decimal, P_ACC, ParameterDirection.Input));
                object ReturnValue = null;
                ExecuteNonQuery("bars_sms_clearance.transfer_clearance", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            }
            catch (SystemException ex)
            {
                throw ex;
            }
        }

    }
}