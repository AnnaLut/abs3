using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// Модель для сохранения взыскателя с подписью!
    /// </summary>
    public class UpdateReceiverModel
    {
        public Receiver Receiver { get; set; }
        public Sign Sign { get; set; }
    }
}