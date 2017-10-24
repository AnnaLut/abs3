using BarsWeb.Areas.Crkr.Models;
using System.Collections.Generic;

namespace BarsWeb.Areas.Crkr.Infrastructure.DI.Abstract
{
    public interface IRegisterRepository
    {
        ResultPay CreateRegister(Registry item);
        ResultPay SendRegister(Registry item);
        ResultPay BlockOrUnBlock(Registry item);
        IEnumerable<PayRegister> GetPeyments(Registry item);
    }
}
