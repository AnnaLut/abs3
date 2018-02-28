using System;
using System.Collections.Generic;

namespace Bars.WebServices.XRM.Services.DepositXrm.Models
{
    public class XRMOpenDepositReq
    {
        public Decimal TransactionId;
        public String UserLogin;
        public Int16 OperationType;
        public string KF;
        public string Branch;
        public Int16 DepositType;       //0 (стандартний депозит); 1 (депозит на бенефіціара);2 (депозит на імя малолітньої особи);3 (депозит на користь малолітньої особи), 4( відкритий по довіреності)
        public Int64 RNKBeneficiary;    //рнк бенефициара
        public Int64 RNKInfant;         //рнк малолетнего лица
        public Int64 RNKTrustee;        //рнк опекуна малолетнего лица
        public Int32 Vidd;              //dpt_deposit.vidd%type,                        -- код вида вклада
        public Int64 Rnk;               //dpt_deposit.rnk%type,                         -- рег.№ вкладчика                
        public decimal Sum;             //dpt_deposit.limit%type,                       -- сумма вклада пол договору
        public int Nocash;              //number,                                       -- БЕЗНАЛ взнос (0-НАЛ,1- БЕЗНАЛ)
        public DateTime? DateZ;         //dpt_deposit.datz%type,                        -- дата заключения договора
        public string Namep;            //dpt_deposit.name_p%type,                      -- получатель %%
        public string Okpop;            //dpt_deposit.okpo_p%type,                      -- идентиф.код получателя %%
        public string Nlsp;             //dpt_deposit.nls_p%type,                       -- счет для выплаты %%
        public string Mfop;             //dpt_deposit.mfo_p%type,                       -- МФО для выплаты %%  
        public int Fl_perekr;           //dpt_vidd.fl_2620%type,                        -- флаг открытия техн.счета
        public string Name_perekr;      //dpt_deposit.nms_d%type,                       -- получатель депозита
        public string Okpo_perekr;      //dpt_deposit.okpo_p%type,                      -- идентиф.код получателя депозита
        public string Nls_perekr;       //dpt_deposit.nls_d%type,                       -- счет для возврата депозита
        public string Mfo_perekr;       //dpt_deposit.mfo_d%type,                       -- МФО для возврата депозита
        public string Comment;          //dpt_deposit.comments%type,                    -- комментарий
        public DateTime? Datbegin;      //dpt_deposit.dat_begin%type  default null,     -- дата открытия договора
        public int? Duration;           //dpt_vidd.duration%type      default null,     -- длительность (мес.)
        public int? Duration_days;      //dpt_vidd.duration_days%type default null);    -- длительность (дней)                            
    }
    public class XRMOpenDepositResult
    {
        public decimal? DptId;
        public int ResultCode;
        public string ResultMessage;
        public string nls;
        public decimal rate;
        public string nlsint;
        public string daos;
        public string dat_begin;
        public string dat_end;
        public int blkd;
        public int blkk;
        public string dkbo_num;
        public string dkbo_in;
        public string dkbo_out;
    }

    public class XRMDepositDoc
    {
        public Decimal TransactionId;
        public String UserLogin;
        public Int16 OperationType;
        public decimal Archdoc_id;
        public string ResultMessage;
    }
    public class XRMDepositDocResult
    {
        public decimal Archdoc_id;
        public decimal Status;
        public string ErrMessage;
    }
    public class XRMDepositFilesRes
    {
        //public byte[] Doc;
        public string Doc;
        public int ResultCode;
        public string ResultMessage;
    }
}