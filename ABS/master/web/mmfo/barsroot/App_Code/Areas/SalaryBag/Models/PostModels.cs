using System;

namespace Areas.SalaryBag.Models
{
    public class DealModel
    {
        public decimal Id { get; set; }
        public decimal Rnk { get; set; }
        public string DealName { get; set; }
        public string StartDate { get; set; }
        public int Premium { get; set; }
        public int Central { get; set; }
        public int KodTarif { get; set; }
        public decimal? Account { get; set; }
        public int? Fs { get; set; }
        public decimal? acc3570 { get; set; }
        public string Branch { get; set; }
    }

    public class PostFileModel
    {
        public string p_id_pr { get; set; } //id ведомости
        public string p_file_name { get; set; } //название файла
        public byte[] p_clob { get; set; } //тело файла
        public string p_encoding { get; set; } //кодировка виндос
        public string p_nazn { get; set; } //назанчение из ведомости
        public string p_id_dbf_type { get; set; }
        public string p_file_type { get; set; }
        public string p_nlsb_map { get; set; } //Номер рахунку (всегда требовать заполнения )
        public string p_s_map { get; set; } //Сумма (всегда требовать заполнения )
        public string p_okpob_map { get; set; } //ІПН
        public string p_mfob_map { get; set; } //МФО отримувача
        public string p_namb_map { get; set; } //Назва отримувача 
        public string p_nazn_map { get; set; } //Призначення платежу
        public string p_sum_delimiter { get; set; } //В чому сума. 1 - грн. 100 - коп.
        public string p_save_draft { get; set; } //Назва шаблону
    }
    public class RejectDealModel
    {
        public decimal Id { get; set; }
        public string Comment { get; set; }
    }

    public class SearchCustomersModel
    {
        public string rnk { get; set; }
        public string okpo { get; set; }
        public string name { get; set; }
    }

    public class CalcCommissionModel
    {
        public string tarifCode { get; set; }
        public string nls2909 { get; set; }
        public decimal? summ { get; set; }
    }

    public class PayRollDocumentModel
    {
        public decimal? DocumentId { get; set; }
        public decimal? payrollId { get; set; }
        public string OkpoB { get; set; }
        public string NameB { get; set; }
        public string MfoB { get; set; }
        public string NlsB { get; set; }
        public decimal? Source { get; set; }
        public string PaymentPurpose { get; set; }
        public decimal? Summ { get; set; }

        public string PasspSeries { get; set; }
        public string PasspNumber { get; set; }
        public string IdCardNumber { get; set; }
    }

    public class SosArray
    {
        public int[] sos { get; set; }
    }
    public class ArrayOfIdsModel
    {
        public string[] pIds { get; set; }
    }

    public class GetDataForSignModel : ArrayOfIdsModel
    {
        public bool isPayroll { get; set; }
    }

    public class SignResultsPostModel
    {
        public OracleSignArrayItem[] records { get; set; }
        //public SignArrayItem[] records { get; set; }
        public string payrollId { get; set; }
    }

    public class PayPayrollModel
    {
        public string payrollId { get; set; }
        public string sign { get; set; }
        public string keyId { get; set; }
        public string buffer { get; set; }
    }

    public class CreatePayRollModel
    {
        public decimal Id { get; set; }
        public string PrDate { get; set; }
        public string PayrollNum { get; set; }
        public string Purpose { get; set; }
    }
}
