using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using System.ComponentModel;

namespace Bars.UserControls
{
    public interface IBarsUserControl
    {
        /// <summary>
        /// Аттрибуты дочернего контрола
        /// </summary>
        System.Web.UI.AttributeCollection BaseAttributes { get; }
        /// <summary>
        /// Только чтение
        /// </summary>
        Boolean ReadOnly { get; set; }
    }
    public interface IHasRelControls
    {
        /// <summary>
        /// Изменение значения контрола
        /// </summary>
        event EventHandler ValueChanged;
    }
}