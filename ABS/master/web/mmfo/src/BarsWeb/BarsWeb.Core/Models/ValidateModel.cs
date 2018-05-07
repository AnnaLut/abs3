using BarsWeb.Core.Models.Enums;

namespace BarsWeb.Core.Models
{
    public class ValidateModel
    {
        public ValidateModel()
        {
            Status = ValidateStatus.Ok;
            Message = string.Empty;
            Data = null;
        }

        public ValidateStatus Status { get; set; }
        public string Message { get; set; }
        public object Data { get; set; }
    }
}
