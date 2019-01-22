using System.Collections.Generic;
using BarsWeb.Areas.Crkr.Models;

namespace BarsWeb.Areas.Crkr.Infrastructure.DI.Abstract
{
    public interface ISightRepository
    {
        void VisaDbProc(PaymentsList item);
        void StornoDbProc(PaymentsList item);
        void StornoAllDbProc(PaymentsList item);
        List<dynamic> Deposit(TabIndex tabIndex, UserType userType);
        void ErrorDbProc(PaymentsList item);
        List<string> Count(UserType userType);
    }
}
