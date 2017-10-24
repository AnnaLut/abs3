using System;
using System.Web.Mvc;
using BarsWeb.Areas.Async.Models.Binders;

namespace BarsWeb.Areas.Async.Models
{
    [ModelBinder(typeof(TaskParameterModelBinder))]
    public class TaskParameter
    {
        public int? Id { get; set; }
        public string Name { get; set; }
        public TypeCode Type { get; set; }
        public string OriginalDbType { get; set; }
        public object Value { get; set; }
        public string Description { get; set; }
        public string Minimum { get; set; }
        public string Maximum { get; set; }
        public string UiType { get; set; }
        public string Directory { get; set; }
        public int? Position { get; set; }
        public string SchedulerCode { get; set; }
    }
}

