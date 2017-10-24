using System.Web.Mvc;
using BarsWeb.Core.Models.Binders;

namespace BarsWeb.Core.Attributes
{
    public class DateBinderAttribute : CustomModelBinderAttribute
    {
        public override IModelBinder GetBinder()
        {
            return new DateModelBinder();
        }
    }
}
