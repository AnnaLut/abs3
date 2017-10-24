using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using Kendo.Mvc;
using Kendo.Mvc.UI;
using System;
using System.Linq;

namespace BarsWeb.Areas.Kernel.Infrastructure.DI.Implementation
{
    public class KendoRequestTransformer : IKendoRequestTransformer
    {
        public DataSourceRequest MultiplyFilterValue(DataSourceRequest request, string fieldName, decimal multiplier = 100)
        {
            return MultiplyFilterValue(request, new [] {fieldName}, multiplier);
        }
        public DataSourceRequest MultiplyFilterValue(DataSourceRequest request, string[] fieldsName, decimal multiplier = 100)
        {
            if (request.Filters == null)
                return request;

            foreach (var flt in request.Filters)
            {
                if (flt is FilterDescriptor)
                {
                    IncFilterSum((flt as FilterDescriptor), fieldsName, multiplier);
                }
                else if (flt is CompositeFilterDescriptor)
                {
                    //рекурсивный вызов!
                    parseCompositeMultiplyFilter(flt as CompositeFilterDescriptor, fieldsName, multiplier);
                }
            }
            return request;
        }
        public void parseCompositeMultiplyFilter(CompositeFilterDescriptor filter, string[] fieldsName, decimal multiplier = 100)
        {
            foreach (var flt in filter.FilterDescriptors)
            {
                if (flt is FilterDescriptor)
                {
                    IncFilterSum((flt as FilterDescriptor), fieldsName, multiplier);
                }
                else if (flt is CompositeFilterDescriptor)
                {
                    //рекурсивный вызов!
                    parseCompositeMultiplyFilter(flt as CompositeFilterDescriptor, fieldsName, multiplier);
                }
            }        
        }

        private void IncFilterSum(FilterDescriptor sumFlt, string[] fieldName, decimal multiplier)
        {
            if (fieldName.Contains(sumFlt.Member))
            {
                sumFlt.Value = decimal.Parse(sumFlt.Value.ToString()) * multiplier;
            }
        }
        public DataSourceRequest CenturaDateFilterValue(DataSourceRequest request, string fieldsName)
        {
            return CenturaDateFilterValue(request, new[] { fieldsName });
        }
        public DataSourceRequest CenturaDateFilterValue(DataSourceRequest request, string[] fieldsName)
        {
            if (request.Filters == null)
                return request;

            foreach (var flt in request.Filters)
            {
                if (flt is FilterDescriptor)
                {
                    DateFilterValue((flt as FilterDescriptor), fieldsName);
                }
                else if (flt is CompositeFilterDescriptor)
                {
                    parseCompositeDateFilter(flt as CompositeFilterDescriptor, fieldsName);
                }
            }
            return request;
        }

        public void parseCompositeDateFilter(CompositeFilterDescriptor filter, string[] fieldsName)
        {
            foreach (var flt in filter.FilterDescriptors)
            {
                if (flt is FilterDescriptor)
                {
                    DateFilterValue((flt as FilterDescriptor), fieldsName);
                }
                else if (flt is CompositeFilterDescriptor)
                {
                    //рекурсивный вызов!
                    parseCompositeDateFilter(flt as CompositeFilterDescriptor, fieldsName);
                }
            }
        }

        private void DateFilterValue(FilterDescriptor dateFlt, string[] fieldName)
        {
            if (dateFlt != null && fieldName.Contains(dateFlt.Member))
            {
                DateTime dt = (DateTime)dateFlt.Value;
                dateFlt.Value = dt.ToString("yyMMdd");
            }
        }
    }
}