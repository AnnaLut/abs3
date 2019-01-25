using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Model
{
    /// <summary>
    /// номиналы купюр, код валюты и их количество в АТМ
    /// </summary>
    public class ConfirmTox
    {
        public String DocRef { get; set; }
        public String OperRef { get; set; }
    }
}