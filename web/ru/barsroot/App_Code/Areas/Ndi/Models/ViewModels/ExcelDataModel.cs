using BarsWeb.Areas.Ndi.Infrastructure;
using BarsWeb.Areas.Ndi.Models.FilterModels;

namespace BarsWeb.Areas.Ndi.Models.ViewModels
{
    public class ExcelDataModel : DataModel
    {
        public ExcelDataModel()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public string ColumnsVisible { get; set; }

        public override string DynamicFilter
        {
            get
            {
                if (!string.IsNullOrEmpty(this.Base64DynamicFilter))
                    return FormatConverter.ConvertFormBase64ToUTF8(this.Base64DynamicFilter);
                else
                    return base.DynamicFilter;
            }

            set
            {
                base.DynamicFilter = value;
            }
        }
        public string Base64DynamicFilter { get; set; }
    }

}