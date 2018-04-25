using BarsWeb.Areas.Kernel.Models;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text;

namespace BarsWeb.Areas.Mcp.Infrastructure.DI.Implementation {
    public class SqlCreator
    {
        public static BarsSql SearchFiles(string DateRegister, string PaymentType, string FileNameRegister,
            int? ReceiverMFO, long? IDRegister, short? StateRegister)
        {
            List<OracleParameter> SqlParams = new List<OracleParameter>();
            StringBuilder SqlText = new StringBuilder("select * from msp.v_msp_files2pay where");
            if (IDRegister.HasValue)
            {
                SqlParams.Add(new OracleParameter("P_ID", OracleDbType.Int64, System.Data.ParameterDirection.Input) { Value = IDRegister });
                SqlText.Append(" ID=:P_ID ");
            }
            if (StateRegister.HasValue)
            {
                if (IDRegister.HasValue) { SqlText.Append("and"); }
                SqlParams.Add(new OracleParameter("P_PAY_STATE", OracleDbType.Int16, System.Data.ParameterDirection.Input) { Value = StateRegister });
                SqlText.Append(" STATE_ID=:P_PAY_STATE ");
            }
            if (ReceiverMFO.HasValue)
            {
                if (IDRegister.HasValue || StateRegister.HasValue) { SqlText.Append("and"); }
                SqlParams.Add(new OracleParameter("P_RECEIVER_MFO", OracleDbType.Int32, System.Data.ParameterDirection.Input) { Value = ReceiverMFO });
                SqlText.Append(" RECEIVER_MFO=:P_RECEIVER_MFO ");
            }
            if (!string.IsNullOrEmpty(FileNameRegister))
            {
                if (IDRegister.HasValue || StateRegister.HasValue || ReceiverMFO.HasValue) { SqlText.Append("and"); }
                SqlParams.Add(new OracleParameter("P_FILE_NAME", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = FileNameRegister });
                SqlText.Append(" FILE_NAME like '%'||:P_FILE_NAME||'%' ");                
            }
            if (!string.IsNullOrEmpty(PaymentType))
            {
                if (!string.IsNullOrEmpty(FileNameRegister) || IDRegister.HasValue || StateRegister.HasValue || ReceiverMFO.HasValue) { SqlText.Append("and"); }
                SqlParams.Add(new OracleParameter("P_PAYMENT_TYPE", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = PaymentType });
                SqlText.Append(" PAYMENT_TYPE=:P_PAYMENT_TYPE ");
            }
            if (!string.IsNullOrEmpty(DateRegister))
            {
                if (!string.IsNullOrEmpty(PaymentType) || !string.IsNullOrEmpty(FileNameRegister) || 
                    IDRegister.HasValue || StateRegister.HasValue || ReceiverMFO.HasValue) { SqlText.Append("and"); }

                DateTime dRegister = DateTime.ParseExact(DateRegister, "dd/mm/yyyy", CultureInfo.InvariantCulture);
                SqlParams.Add(new OracleParameter("P_FILE_DATETIME", OracleDbType.Date, System.Data.ParameterDirection.Input) { Value = dRegister });
                SqlText.Append(" FILE_DATETIME= :P_FILE_DATETIME");
            }

            return new BarsSql() { SqlText = SqlText.ToString(), SqlParams = SqlParams.ToArray() };
        }

        public static BarsSql SearchInfoLines(long file_id)
        {
            return new BarsSql()
            {
                SqlText = @"select * from msp.v_msp_file_records where file_id = :p_file_id",
                SqlParams = new object[] {
                    new OracleParameter("p_file_id", OracleDbType.Int64, System.Data.ParameterDirection.Input){ Value = file_id }
                }
            };            
        }

        public static BarsSql FileStates()
        {
            return new BarsSql()
            {
                SqlText = @"select ID,NAME from msp.v_msp_file_state",
                SqlParams = new object[] { }
            };
        }

        public static BarsSql InfoLineStates()
        {
            return new BarsSql()
            {
                SqlText = @"select ID,NAME from msp.v_msp_file_record_state",
                SqlParams = new object[] { }
            };
        }

        public static BarsSql SearchFileRecordsErr(string kF_BANK, decimal? fILE_ID, short? sTATE_ID)
        {
            List<OracleParameter> SqlParams = new List<OracleParameter>();
            StringBuilder SqlText = new StringBuilder("select * from msp.v_msp_file_records_err where");
            if (fILE_ID.HasValue)
            {
                SqlParams.Add(new OracleParameter("P_FILE_ID", OracleDbType.Decimal, System.Data.ParameterDirection.Input) { Value = fILE_ID });
                SqlText.Append(" FILE_ID=:P_FILE_ID ");
            }
            if (sTATE_ID.HasValue)
            {
                if (fILE_ID.HasValue) { SqlText.Append("and"); }
                SqlParams.Add(new OracleParameter("P_STATE_ID", OracleDbType.Int16, System.Data.ParameterDirection.Input) { Value = sTATE_ID });
                SqlText.Append(" STATE_ID=:P_STATE_ID ");
            }
            if (!string.IsNullOrEmpty(kF_BANK))
            {
                if (fILE_ID.HasValue || sTATE_ID.HasValue) { SqlText.Append("and"); }
                SqlParams.Add(new OracleParameter("P_KF_BANK", OracleDbType.Varchar2, System.Data.ParameterDirection.Input) { Value = kF_BANK });
                SqlText.Append(" KF_BANK=:P_KF_BANK");
            }

            return new BarsSql() { SqlText = SqlText.ToString(), SqlParams = SqlParams.ToArray() };
        }

        public static BarsSql SaveSign(decimal id, short kvitId, string sign)
        {
            return new BarsSql
            {
                SqlText = string.Format(@"begin
                                                pfu.pfu_service_utl.gen_matching{0}(:Id, :Sign);
                                        end;", kvitId),
                SqlParams = new object[]
                {
                    new OracleParameter("Id", OracleDbType.Decimal) { Value = id },
                    new OracleParameter("Sign", OracleDbType.Varchar2) { Value = sign }
                }
            };
        }

        public static BarsSql Send(decimal id, short kvitId)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                                 msp.msp_utl.set_match_processing(:p_envelope_id, :p_matching_tp);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_envelope_id", OracleDbType.Decimal) { Value = id },
                    new OracleParameter("p_matching_tp", OracleDbType.Int16) { Value = kvitId }
                }
            };
        }

        public static BarsSql GetBuffer(decimal id, short kvitId, short type)
        {
            return new BarsSql()
            {
                SqlText = string.Format(@"select pfu.pfu_service_utl.prepare_matching{0}(:ID, :Type) from dual", kvitId),
                SqlParams = new object[] 
                {
                    new OracleParameter("ID", OracleDbType.Decimal) { Value = id },
                    new OracleParameter("Type", OracleDbType.Int16) {Value = type }
                }
            };
        }

        public static BarsSql Set2Pay(decimal id)
        {
            return new BarsSql
            {
                SqlText = @"begin
                                msp.msp_utl.set_file_record2pay(:p_file_record_id);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_file_record_id", OracleDbType.Decimal) { Value = id }
                }
            };
        }

        public static BarsSql BlockTypes()
        {
            return new BarsSql()
            {
                SqlText = @"select ID,NAME from msp.v_msp_block_type",
                SqlParams = new object[] { }
            };
        }

        public static BarsSql RemoveFromPay(decimal id, string comment, short block_type)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                                msp.msp_utl.set_file_record_blocked(p_file_record_id => :p_id, p_comment => :p_comm, p_block_type_id => :p_block_type);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_id",             OracleDbType.Decimal) { Value = id },
                    new OracleParameter("p_comm",           OracleDbType.Varchar2) { Value = comment },
                    new OracleParameter("p_block_type",     OracleDbType.Int16) {Value = block_type }
                }
            };
        }

        public static BarsSql BalanceRu(decimal id, string accNum2560, int receiverMfo)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                                msp.msp_utl.prepare_get_rest_request(p_acc => :acc, p_fileid => :id, p_kf => :kf);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_acc", OracleDbType.Varchar2) { Value = accNum2560 },
                    new OracleParameter("p_fileid", OracleDbType.Decimal) { Value = id },
                    new OracleParameter("p_kf", OracleDbType.Int32) { Value = receiverMfo }
                }
            };
        }

        public static BarsSql SearchPayAccept(short kvitId)
        {
            return new BarsSql()
            {
                SqlText = string.Format(@"select * from msp.v_msp_envelopes_match{0}", kvitId),
                SqlParams = new object[] { }
            };
        }

        public static BarsSql VerifyFile(decimal id)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                                pfu.pfu_files_utl.checking_record2(:p_id);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_id", OracleDbType.Decimal) { Value = id }
                }
            };
        }

        public static BarsSql PreparePayment(decimal id)
        {
            return new BarsSql()
            {
                SqlText = @"select acc_2909 as RecipientAccNum, 
                                name_2909 as RecipientName, 
                                okpo_2909 as RecipientCustCode, 
                                mfo_2909 as RecipientBankId, 
                                acc_2560 as SenderAccNum, 
                                name_2560 as SenderName, 
                                okpo_2560 as SenderCustCode, 
                                mfo_2560 as SenderBankId, 
                                debet_tts as OpCode,
                                sum, 
                                nazn as Narrative 
                            from msp.v_msp_paym_fields where id=:p_id",
                SqlParams = new object[]
                {
                    new OracleParameter("p_id", OracleDbType.Decimal) { Value = id }
                }
            };
        }

        public static BarsSql SetFileState(decimal id, short stateId)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                                msp.msp_utl.set_file_state(p_file_id => :p_file_id, p_state_id => :p_state_id);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_file_id", OracleDbType.Decimal) { Value = id },
                    new OracleParameter("p_state_id", OracleDbType.Int16) { Value = stateId }
                }
            };
        }

        public static BarsSql SearchEnvelopes(short kvitId)
        {
            return new BarsSql()
            {
                SqlText = string.Format(@"msp.v_msp_envelopes_match{0}_hist", kvitId),
                SqlParams = new object[] { }
            };
        }

        public static BarsSql SearchFile4Match(decimal envelope_file_id)
        {
            return new BarsSql()
            {
                SqlText = @"select * from msp.v_msp_file_for_match where envelope_file_id = :p_envelope_file_id",
                SqlParams = new object[] {
                    new OracleParameter("p_envelope_file_id", OracleDbType.Decimal) { Value = envelope_file_id }
                }
            };
        }

        public static BarsSql SearchFileRecForMatch(decimal value)
        {
            return new BarsSql()
            {
                SqlText = @"select * from msp.v_msp_file_rec_for_match where file_id = :p_file_id",
                SqlParams = new object[]
                            {
                    new OracleParameter("p_file_id", OracleDbType.Decimal) { Value = value }
                            }
            };
        }

        public static BarsSql SearchRecBlockFm()
        {
            return new BarsSql()
            {
                SqlText = @"select * from msp.v_msp_rec_block_fm",
                SqlParams = new object[] { }
            };
        }

        public static BarsSql Pay(decimal id)
        {
            return new BarsSql()
            {
                SqlText = @"begin
                                msp.msp_utl.set_file_for_pay(:p_file_id);
                            end;",
                SqlParams = new object[]
                {
                    new OracleParameter("p_file_id", OracleDbType.Decimal) { Value = id }
                }
            };
        }
    }
}
