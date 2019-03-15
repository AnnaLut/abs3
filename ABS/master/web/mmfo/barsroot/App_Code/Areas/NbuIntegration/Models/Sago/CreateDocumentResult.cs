namespace Areas.NbuIntegration.Models
{
    public class SaveDocumentsResult
    {
        public SaveDocumentsResult()
        {
            Sum = 0;
            CountSaved = 0;
        }
        public decimal? Sum { get; set; }
        public int CountSaved { get; set; }
    }
}