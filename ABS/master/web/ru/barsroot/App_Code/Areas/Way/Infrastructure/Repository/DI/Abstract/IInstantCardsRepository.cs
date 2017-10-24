using BarsWeb.Areas.Way.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Way.Infrastructure.DI.Abstract
{
    public interface IInstantCardsRepository
    {
        List<T> GetProduct<T>();
        List<T> GetCardType<T>(dynamic code);
        string GetBranch();
        void GetInstantCards(dynamic CARD_TYPE,  dynamic CARD_AMOUNT);
        string GetNB(dynamic sProductId);
        string GetKV(dynamic sProductId);
    }
}