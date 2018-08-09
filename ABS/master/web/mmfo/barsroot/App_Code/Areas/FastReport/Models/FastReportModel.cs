using BarsWeb.Areas.FastReport.ModelBinders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http.ModelBinding;

namespace BarsWeb.Areas.FastReport.Models
{
    /// <summary>
    /// Модель для создания FrxDoc
    /// корневой каталог - '/TEMPLATE.RPT/' (не barsroot!)
    /// </summary>
    [ModelBinder(BinderType = typeof(FastReportModelBinderd))]
    public class FastReportModel
    {
        /// <summary>
        /// Имя файла шаблона (к примеру file.frx)
        /// находящемся в каталоге
        /// </summary>
        public String FileName { get; set; }

        /// <summary>
        /// Возвращаемый формат файла
        /// </summary>
        public FrxExportTypes ResponseFileType { get; set; }

        /// <summary>
        /// Параметры передаваемые в файл
        /// </summary>
        public FrxParameters Parameters { get; set; }
    }

}