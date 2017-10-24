namespace BarsWeb.Areas.Cdm.Utils
{
    /// <summary>
    /// Class Model for additional information from CDM.
    /// </summary>
    /// 
    public class AdditionalСlientInformation
    {
        public string Tag { get; set; }
        public string PropertyName { get; set; }
        public AdditionalСlientInformation ChildPropertyName { get; set; }
        public bool NeedToConvertToDate { get; set; }

    }

}

