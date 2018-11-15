using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace Bars.WebServices.XRM.Services.DepositXrm.Models
{
    public class OpenDepositRequest
    {
        public string Kf { get; set; }
        public string Branch { get; set; }
        public Int16 DepositType { get; set; }       //0 (стандартний депозит); 1 (депозит на бенефіціара);2 (депозит на імя малолітньої особи);3 (депозит на користь малолітньої особи), 4( відкритий по довіреності)
        public Int64 RnkBeneficiary { get; set; }    //рнк бенефициара
        public Int64 RnkInfant { get; set; }       //рнк малолетнего лица
        public Int64 RnkTrustee { get; set; }      //рнк опекуна малолетнего лица
        public Int32 Vidd { get; set; }            //dpt_deposit.vidd%type,                        -- код вида вклада
        public Int64 Rnk { get; set; }             //dpt_deposit.rnk%type,                         -- рег.№ вкладчика                
        public decimal Sum { get; set; }           //dpt_deposit.limit%type,                       -- сумма вклада пол договору
        public int Nocash { get; set; }            //number,                                       -- БЕЗНАЛ взнос (0-НАЛ,1- БЕЗНАЛ)
        public DateTime? DateZ { get; set; }       //dpt_deposit.datz%type,                        -- дата заключения договора
        public string Namep { get; set; }          //dpt_deposit.name_p%type,                      -- получатель %%
        public string Okpop { get; set; }          //dpt_deposit.okpo_p%type,                      -- идентиф.код получателя %%
        public string Nlsp { get; set; }           //dpt_deposit.nls_p%type,                       -- счет для выплаты %%
        public string Mfop { get; set; }           //dpt_deposit.mfo_p%type,                       -- МФО для выплаты %%  
        public int FlPerekr { get; set; }         //dpt_vidd.fl_2620%type,                        -- флаг открытия техн.счета
        public string NamePerekr { get; set; }    //dpt_deposit.nms_d%type,                       -- получатель депозита
        public string OkpoPerekr { get; set; }    //dpt_deposit.okpo_p%type,                      -- идентиф.код получателя депозита
        public string NlsPerekr { get; set; }     //dpt_deposit.nls_d%type,                       -- счет для возврата депозита
        public string MfoPerekr { get; set; }     //dpt_deposit.mfo_d%type,                       -- МФО для возврата депозита
        public string Comment { get; set; }        //dpt_deposit.comments%type,                    -- комментарий
        public DateTime? Datbegin { get; set; }    //dpt_deposit.dat_begin%type  default null,     -- дата открытия договора
        public int? Duration { get; set; }         //dpt_vidd.duration%type      default null,     -- длительность (мес.)
        public int? DurationDays { get; set; }    //dpt_vidd.duration_days%type default null){ get; set; }  -- длительность (дней)                            
    }
    public class OpenDepositResponse
    {
        public decimal? DptId { get; set; }
        public string Nls { get; set; }
        public decimal Rate { get; set; }
        public string NlsInt { get; set; }
        public string Daos { get; set; }
        public string DateBegin { get; set; }
        public string DateEnd { get; set; }
        public int BlkD { get; set; }
        public int BlkK { get; set; }
        public string DkboNumber { get; set; }
        public string DkboIn { get; set; }
        public string DkboOut { get; set; }

        [XmlArrayItem("Agreement")]
        public List<DepositAgreementAddInfo> Agreements { get; set; }
    }

    public class SignDepositDocumentsRequest
    {
        public string UserLogin { get; set; }
        [XmlArrayItem("Document")]
        public List<DepositDocument> Documents { get; set; }
    }
    public class DepositDocument
    {
        public decimal TransactionId { get; set; }
        public decimal DepositId { get; set; }
    }

    public class SignDocumentsResponse
    {
        public decimal ResultCode { get; set; }
        public string ResultMessage { get; set; }
        [XmlArrayItem("Document")]
        public List<DocumentSignResult> Documents { get; set; }
    }
    public class DocumentSignResult
    {
        public decimal ArchiveDocumentId { get; set; }
        public decimal ResultCode { get; set; }
        public string ResultMessage { get; set; }
    }
    public class FilesResponse
    {
        public string Doc { get; set; }
    }
}