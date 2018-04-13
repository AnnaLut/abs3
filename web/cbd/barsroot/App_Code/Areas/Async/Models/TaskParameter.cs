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
        public object Value { get; set; }
        public string Description { get; set; }
        public int? Position { get; set; }
        public string SchedulerCode { get; set; }
    }
}

