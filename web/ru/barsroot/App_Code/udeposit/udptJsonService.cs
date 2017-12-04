using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Mvc;

using Bars;
using BarsWeb.Core.Logger;

namespace barsroot.udeposit
{
    public class pnyType
    {
        public int PenaltyTypeId { get; set; }
        public string PenaltyTypeName { get; set; }
    }

    public class prdType
    {
        public int PeriodTypeId { get; set; }
        public string PeriodTypeName { get; set; }
    }

    public class PenaltyDetail
    {
        public string PenaltyId { get; set; }
        public string LowerLimit { get; set; }
        public string UpperLimit { get; set; }
        public pnyType PenaltyType { get; set; }
        public string PenaltyValue { get; set; }
        public prdType PenaltyPeriodType { get; set; }
        public string PenaltyPeriodValue { get; set; }
    }

    /// <summary>
    /// Summary description for udptJsonService
    /// </summary>
    [WebService]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [ScriptService]
    public class DpuJsonService : BarsWebService
    {

        private IDbLogger DBLogger;

        public DpuJsonService()
        {
            //Uncomment the following line if using designed components 
            //InitializeComponent(); 
            DBLogger = DbLoggerConstruct.NewDbLogger();
        }

        [WebMethod(Description = "Returns the list of Penalty Details")]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public JsonResult GetPenaltyDetails(Int32 pny_id)
        {
            List<PenaltyDetail> pnyDtls = new List<PenaltyDetail>();

            try
            {
                InitOraConnection();

                SetParameters("pny_id", DB_TYPE.Decimal, pny_id, DIRECTION.Input);

                SQL_Reader_Exec( "select PNY_ID, PNY_LWR_LMT, PNY_UPR_LMT " +
                                 "     , PNY_TP_ID, PNY_TP_NM, PNY_VAL " +
                                 "     , PNY_PRD_TP_ID, PNY_PRD_TP_NM, PNY_PRD_VAL " +
                                 "  from BARS.V_DPU_PENALTY_DETAILS " +
                                 " where PNY_ID = :pny_id" );

                while (SQL_Reader_Read())
                {
                    ArrayList reader = SQL_Reader_GetValues();

                    pnyDtls.Add( new PenaltyDetail(){ 
                        PenaltyId = Convert.ToString(reader[0]),
                        LowerLimit = Convert.ToString(reader[1]),
                        UpperLimit = Convert.ToString(reader[2]),                        
                        PenaltyType =  new pnyType(){ 
                            PenaltyTypeId = Convert.ToInt32(reader[3]),
                            PenaltyTypeName = Convert.ToString(reader[4])
                        },
                        PenaltyValue = Convert.ToString(reader[5]),
                        PenaltyPeriodType = new prdType() {
                            PeriodTypeId = Convert.ToInt32(reader[6]),
                            PeriodTypeName = Convert.ToString(reader[7])
                        },
                        PenaltyPeriodValue = Convert.ToString(reader[8]),
                    });
                }

                SQL_Reader_Close();
            }
            finally
            {
                DisposeOraConnection();
            }

            myController jsonCntl = new myController();

            return jsonCntl.GetJson(pnyDtls);

            // return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(pnyDtls);
        }
        /*
        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public List<PenaltyDetail> GetPnyDtls(Int32 pny_id)
        {
            List<PenaltyDetail> pnyDtls = new List<PenaltyDetail>();

            try
            {
                InitOraConnection();

                SetParameters("pny_id", DB_TYPE.Decimal, pny_id, DIRECTION.Input);

                SQL_Reader_Exec("select PNY_ID, PNY_LWR_LMT, PNY_UPR_LMT" +
                                 "     , PNY_TP_ID, PNY_TP_NM, PNY_VAL   " +
                                 "     , PNY_PRD_TP_ID, PNY_PRD_VAL      " +
                                 "  from BARS.V_DPU_PENALTY_DETAILS      " +
                                 " where PNY_ID = :pny_id");

                while (SQL_Reader_Read())
                {
                    ArrayList reader = SQL_Reader_GetValues();

                    pnyDtls.Add(new PenaltyDetail()
                    {
                        PenaltyId = Convert.ToString(reader[0]),
                        LowerLimit = Convert.ToString(reader[1]),
                        UpperLimit = Convert.ToString(reader[2]),
                        PenaltyType = new pnyType()
                        {
                            PenaltyTypeId = Convert.ToInt32(reader[3]),
                            PenaltyTypeName = Convert.ToString(reader[4])
                        },
                        PenaltyValue = Convert.ToString(reader[5]),
                        PenaltyPeriodType = Convert.ToString(reader[6]),
                        PenaltyPeriodValue = Convert.ToString(reader[7]),
                    });
                }

                SQL_Reader_Close();
            }
            finally
            {
                DisposeOraConnection();
            }

            return pnyDtls;
        }
        */
        [WebMethod(EnableSession = true, Description = "Edit Penalty Details record.")]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public string SetPenaltyDetails(Int32 PenaltyId, Int32 LowerLimit,
            Int32 PenaltyType, Int32 PenaltyValue,
            Int32 PenaltyPeriodType, string PenaltyPeriodValue)
        {
            // System.Diagnostics.Debug.Write(String.Format("PenaltyId={0}, LowerLimit={1}, PenaltyType={2}, PenaltyValue={3}, PenaltyPeriodType={4}, PenaltyPeriodValue={5}.",
            //     sPenaltyId, sLowerLimit, sPenaltyType, sPenaltyValue, sPenaltyPeriodType, sPenaltyPeriodValue) );

            string result = string.Empty;

            try
            {
                InitOraConnection();
                
                ClearParameters();

                SetParameters("penalty_id", DB_TYPE.Decimal, PenaltyId, DIRECTION.Input);
                SetParameters("pny_lwr_lmt", DB_TYPE.Decimal, LowerLimit, DIRECTION.Input);
                SetParameters("penalty_val", DB_TYPE.Decimal, PenaltyValue, DIRECTION.Input);
                SetParameters("penalty_tp", DB_TYPE.Decimal, PenaltyType, DIRECTION.Input);
                if (PenaltyPeriodType == 0)
                {
                    SetParameters("pny_prd_val", DB_TYPE.Decimal, null, DIRECTION.Input);
                }
                else
                {
                    SetParameters("pny_prd_val", DB_TYPE.Decimal, PenaltyPeriodValue, DIRECTION.Input);
                }
                SetParameters("pny_prd_tp", DB_TYPE.Decimal, PenaltyPeriodType, DIRECTION.Input);
                SetParameters("p_err_msg", DB_TYPE.Varchar2, 2000, null, DIRECTION.Output);

                SQL_PROCEDURE("DPU_UTILS.SET_PENALTY_VALUE");

                result = Convert.ToString(GetParameter("p_err_msg"));
            }
            catch (Exception ex)
            {
                result = "Помилка внесенні змін у параметри штрафу #" + PenaltyId.ToString() + ": " + ex.Message;
                // DBLogger.Error(ex.Message);
            }
            finally
            {
                DisposeOraConnection();
            }

            return result;
        }

        [WebMethod(Description = "Deletes record from the list of Penalty Details.")]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public string DeletePenaltyDetails(Int32 PenaltyId, Int32 LowerLimit)
        {
            string result = string.Empty;

            try
            {
                InitOraConnection();

                SetParameters("penalty_id", DB_TYPE.Decimal, PenaltyId, DIRECTION.Input);
                SetParameters("penalty_prd", DB_TYPE.Decimal, LowerLimit, DIRECTION.Input);
                SetParameters("p_err_msg", DB_TYPE.Varchar2, 2000, null, DIRECTION.Output);

                SQL_PROCEDURE("DPU_UTILS.DEL_PENALTY_VALUE");

                result = Convert.ToString(GetParameter("p_err_msg"));

                // DBLogger.Info("Користувач видалив запис з параметрів штрафу #" + PenaltyId.ToString(), "barsroot.udeposit");
            }
            catch (Exception ex)
            {
                result = "Помилка видалення запису з параметрів штрафу #" + PenaltyId.ToString() + ", LowerLimit=" + LowerLimit.ToString() + ": " + ex.Message;
                //DBLogger.Error(ex.Message);
            }
            finally
            {
                DisposeOraConnection();
            }

            return result;
        }
    }

    /// <summary>
    /// 
    /// </summary>
    public class myController : BarsWeb.Controllers.ApplicationController
    {
        public JsonResult GetJson(List<PenaltyDetail> data )
        {
            return Json(data, JsonRequestBehavior.AllowGet);
        }
    }
}