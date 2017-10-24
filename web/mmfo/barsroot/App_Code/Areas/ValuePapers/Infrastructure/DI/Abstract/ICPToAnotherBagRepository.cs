using BarsWeb.Areas.ValuePapers.Models;
using System.Collections.Generic;

namespace BarsWeb.Areas.ValuePapers.Infrastructure.DI.Abstract
{
    public interface ICPToAnotherBagRepository
    {
        List<Inputs> GetInputs(decimal id);
        List<FirstComboBox> GetFirstComboBox(decimal id);
        List<SecondComboBox> GetSecondComboBox(decimal id, decimal vidd);
        List<SecondInputs> GetInputs(decimal id, decimal ryn, decimal emi, decimal pf, decimal vidd, decimal kv);
        List<FirstComboBox> GetThirdComboBox(decimal emi, decimal dox, decimal pf);
        List<SecondComboBox> GetFourthComboBox(decimal emi, decimal dox, decimal vidd);
        string GetNlsa(decimal ryn, decimal emi, decimal pf, decimal vidd);
        void MakeMDTable(decimal id, decimal pf, decimal ryn);
        ResultInsert InsertValuePaper(decimal id, decimal pf_1, decimal ryn_1, decimal pf_2, decimal ryn_2, decimal sum, decimal _ref, string nazn, bool kor);
        void UpdateTicketNumber(int REF_MAIN, string ticket_number);
    }
}
