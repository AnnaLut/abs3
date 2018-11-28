using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;
using System.Data;

namespace BarsWeb.Areas.TranspUi.Infrastructure.DI.Implementation {
    public class SqlCreator
    {
        public static BarsSql SearchMainOutReqs()
        {
            return new BarsSql()
            {
                SqlText = @"select 
                                Id, 
                                SEND_TYPE as SendType, 
                                INS_DATE as InsDate, 
                                STATUS as Status, 
                                DONE_DATE as DoneDate, 
                                USER_ID as UserId, 
                                USER_KF as UserKf 
                            from barstrans.v_out_main_req 
                            order by INS_DATE desc",
                SqlParams = new object[] { }
            };

        }

        public static BarsSql SearchMainInReqs()
        {
            return new BarsSql()
            {
                SqlText = @"select 
                                Id,
                                HTTP_TYPE as HttpType, 
                                TYPE_NAME as TypeName, 
                                TYPE_DESC as TypeDesc, 
                                REQ_ACTION as ReqAction, 
                                REQ_USER as ReqUser, 
                                FIO as FullName,
                                INSERT_TIME as InsertTime,
                                CONVERT_TIME as ConvertTime,
                                Status,
                                PROCESSED_TIME as ProcessedTime
                            from barstrans.v_input_reqs 
                            order by INSERT_TIME desc",
                SqlParams = new object[] { }
            };

        }

        public static BarsSql SearchOutReqs(string guid)
        {
            return new BarsSql()
            {
                SqlText = @"select 
                                Id, 
                                MAIN_ID as MainId,
                                REQ_ID as ReqId, 
                                URI_GR_ID as UriGrId, 
                                URI_KF as UriKf, 
                                TYPE_ID as TypeId, 
                                INSERT_TIME as InsertTime, 
                                SEND_TIME as SendTime, 
                                STATUS as Status, 
                                PROCESSED_TIME as ProcessedTime  
                            from barstrans.out_reqs where MAIN_ID=upper(:p_guid)
                            order by INSERT_TIME desc",
                SqlParams = new object[] 
                {
                    new OracleParameter("p_guid", OracleDbType.Varchar2, guid, ParameterDirection.Input)
                }
            };
        }

        public static BarsSql SearchOutQueue(string guid)
        {
            return new BarsSql()
            {
                SqlText = @"select 
                                REQ_ID as ReqId,
                                IS_MAIN as IsMain, 
                                PRIORITY as Priority, 
                                STATUS as Status,
                                INSERT_TIME as InsertTime,
                                EXEC_TRY as ExecTry,
                                LAST_TRY as LastTry
                            from barstrans.out_queue where REQ_ID=upper(:p_guid)
                            order by INSERT_TIME desc",
                SqlParams = new object[]
                {
                    new OracleParameter("p_guid", OracleDbType.Varchar2, guid, ParameterDirection.Input)
                }
            };
        }

        public static BarsSql SearchInQueue(string guid)
        {
            return new BarsSql()
            {
                SqlText = @"select 
                                REQ_ID as ReqId,
                                IS_MAIN as IsMain, 
                                PRIORITY as Priority, 
                                STATUS as Status,
                                INSERT_TIME as InsertTime,
                                EXEC_TRY as ExecTry,
                                LAST_TRY as LastTry
                            from barstrans.input_queue where REQ_ID=upper(:p_guid)
                            order by INSERT_TIME desc",
                SqlParams = new object[]
                {
                    new OracleParameter("p_guid", OracleDbType.Varchar2, guid, ParameterDirection.Input)
                }
            };
        }

        public static BarsSql SearchOutTypes()
        {
            return new BarsSql()
            {
                SqlText = @"select
                                Id,
                                TYPE_NAME as TypeName,
                                TYPE_DESC as TypeDesc, 
                                SESS_TYPE as SessType, 
                                WEB_METHOD as WebMethod,
                                HTTP_METHOD as HttpMethod,
                                OUTPUT_DATA_TYPE as OutputDataType,
                                INPUT_DATA_TYPE as InputDataType,
                                CONT_TYPE as ContType,
                                IS_PARALLEL as IsParallel,
                                SEND_TYPE as SendType,
                                URI_GROUP as UriGroup,
                                URI_SUF as UriSuf,
                                PRIORITY as Priority,
                                DONE_ACCTION as DoneAcction,
                                MAIN_TIMEOUT as MainTimeout,
                                SEND_TRYS as SendTrys,
                                SEND_PAUSE as SendPause,
                                CHK_PAUSE as ChkPause,
                                XML2JSON as Xml2json,
                                JSON2XML as Json2xml,
                                COMPRESS_TYPE as CompressType,
                                INPUT_DECOMPRESS as InputDecompress,
                                OUTPUT_COMPRESS as OutputCompress,
                                INPUT_BASE_64 as InputBase64,
                                OUTPUT_BASE_64 as OutputBase64,
                                CHECK_SUM as CheckSum,
                                STORE_HEAD as StoreHead,
                                ACC_CONT_TYPE as AccContType,
                                LOGING as Loging
                            from barstrans.out_types",
                SqlParams = new object[] { }
            };
        }

        public static BarsSql SearchInTypes()
        {
            return new BarsSql()
            {
                SqlText = @"select
                                Id,
                                TYPE_NAME as TypeName,
                                TYPE_DESC as TypeDesc, 
                                SESS_TYPE as SessType,
                                ACT_TYPE as AccType,                
                                OUTPUT_DATA_TYPE as OutputDataType,
                                INPUT_DATA_TYPE as InputDataType,                                
                                PRIORITY as Priority,
                                CONT_TYPE as ContType,
                                JSON2XML as Json2xml,                                
                                XML2JSON as Xml2json,                                
                                COMPRESS_TYPE as CompressType,
                                INPUT_DECOMPRESS as InputDecompress,
                                OUTPUT_COMPRESS as OutputCompress,
                                INPUT_BASE_64 as InputBase64,
                                OUTPUT_BASE_64 as OutputBase64,
                                STORE_HEAD as StoreHead,
                                ADD_HEAD as AddHead,
                                CHECK_SUM as CheckSum,                                
                                LOGING as Loging,
                                EXEC_TIMEOUT as ExecTimeout
                            from barstrans.input_types",
                SqlParams = new object[] { }
            };
        }

        public static BarsSql SearchOutputLog(string guid)
        {
            return new BarsSql()
            {
                SqlText = @"select
                                Id,
                                REQ_ID as ReqId,
                                SUB_REQ as SubReq, 
                                CHK_REQ as ChkReq, 
                                ACT as Act,
                                STATE as State,
                                MESSAGE as Message,
                                INSERT_DATE as InsertDate
                            from barstrans.output_log where REQ_ID=upper(:p_guid) 
                            order by INSERT_DATE desc",
                SqlParams = new object[]
                {
                    new OracleParameter("p_guid", OracleDbType.Varchar2, guid, ParameterDirection.Input)
                }
            };
        }

        public static BarsSql SearchInputLog(string guid)
        {
            return new BarsSql()
            {
                SqlText = @"select
                                Id,
                                REQ_ID as ReqId,
                                Act,
                                State,
                                Message,
                                INSERT_DATE as InsertDate
                            from barstrans.input_log where REQ_ID=upper(:p_guid) 
                            order by INSERT_DATE desc",
                SqlParams = new object[]
                {
                    new OracleParameter("p_guid", OracleDbType.Varchar2, guid, ParameterDirection.Input)
                }
            };
        }

        public static BarsSql SearchParams()
        {
            return new BarsSql()
            {
                SqlText = @"select                                
                                PARAM_NAME as ParamName,
                                PARAM_VALUE as ParamValue 
                            from barstrans.transp_params",
                SqlParams = new object[] { }
            };
        }

        public static BarsSql SearchInRespParams(string guid)
        {
            return new BarsSql()
            {
                SqlText = @"select                                
                                RESP_ID as RespId,
                                PARAM_TYPE as ParamType,
                                Tag,
                                Value
                            from barstrans.input_resp_params where RESP_ID=upper(:p_guid)",
                SqlParams = new object[] 
                {
                    new OracleParameter("p_guid", OracleDbType.Varchar2, guid, ParameterDirection.Input)
                }
            };
        }

        public static BarsSql SearchInReqParams(string guid)
        {
            return new BarsSql()
            {
                SqlText = @"select                                
                                REQ_ID as ReqId,
                                PARAM_TYPE as ParamType,
                                Tag,
                                Value
                            from barstrans.input_req_params where REQ_ID=upper(:p_guid)",
                SqlParams = new object[] 
                {
                    new OracleParameter("p_guid", OracleDbType.Varchar2, guid, ParameterDirection.Input)
                }
            };
        }

        public static BarsSql SearchInputResponses(string guid)
        {
            return new BarsSql()
            {
                SqlText = @"select                                
                                REQ_ID as ReqId,
                                INSERT_TIME as InsertTime,
                                CONVERT_TIME as ConvertTime,
                                SEND_TIME as SendTime
                            from barstrans.input_resp where REQ_ID=upper(:p_guid)",
                SqlParams = new object[]
                {
                    new OracleParameter("p_guid", OracleDbType.Varchar2, guid, ParameterDirection.Input)
                }
            };
        }

        public static BarsSql GetMainOutClob(string guid)
        {
            return new BarsSql()
            {
                SqlText = "select C_DATA from barstrans.out_main_req where ID=upper(:p_guid)",
                SqlParams = new object[]
                {
                    new OracleParameter("p_guid", OracleDbType.Varchar2, guid, ParameterDirection.Input)
                }
            };
        }

        public static BarsSql GetMainInClob(string guid)
        {
            return new BarsSql()
            {
                SqlText = "select D_CLOB from barstrans.input_reqs where ID=upper(:p_guid)",
                SqlParams = new object[]
                {
                    new OracleParameter("p_guid", OracleDbType.Varchar2, guid, ParameterDirection.Input)
                }
            };

        }

        public static BarsSql GetReqClob(string id)
        {
            return new BarsSql()
            {
                SqlText = "select C_DATE as C_DATA from barstrans.out_reqs where ID=upper(:p_id)",
                SqlParams = new object[]
                {
                    new OracleParameter("p_id", OracleDbType.Varchar2, id, ParameterDirection.Input)
                }
            };
        }

        public static BarsSql GetRespClob(string id)
        {
            return new BarsSql()
            {
                SqlText = "select RESP_CLOB from barstrans.out_reqs where ID=upper(:p_id)",
                SqlParams = new object[]
                {
                    new OracleParameter("p_id", OracleDbType.Varchar2, id, ParameterDirection.Input)
                }
            };
        }

        public static BarsSql GetLogClob(int id)
        {
            return new BarsSql()
            {
                SqlText = "select BIG_MESSAGE from barstrans.output_log where ID=upper(:p_id)",
                SqlParams = new object[]
                {
                    new OracleParameter("p_id", OracleDbType.Int32, id, ParameterDirection.Input)
                }
            };
        }

        public static BarsSql GetInputLogClob(int id)
        {
            return new BarsSql()
            {
                SqlText = "select BIG_MESSAGE from barstrans.input_log where ID=upper(:p_id)",
                SqlParams = new object[]
                {
                    new OracleParameter("p_id", OracleDbType.Int32, id, ParameterDirection.Input)
                }
            };
        }
    }
}
