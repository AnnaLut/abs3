using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BarsWeb.Areas.Kernel.Models.KendoViewModels;
using Kendo.Mvc.UI;
using Kendo.Mvc.Infrastructure.Implementation;
using Kendo.Mvc;
using System.ComponentModel;

/// <summary>
/// Summary description for DataSourceAdapter
/// </summary>

namespace BarsWeb.Areas.Kernel.Infrastructure
{
    public class DataSourceAdapter
    {

        DataSourceRequest _request;
        private Dictionary<string, FilterOperator> filterOperatorDict;
        private Dictionary<string, FilterCompositionLogicalOperator> LogicOperatorDict;
        private Dictionary<string, ListSortDirection> sortDict;


        public DataSourceAdapter()
        {
            this._request = new DataSourceRequest();
            FillOperatorDictionary();
            FillSortDict();
        }

        public DataSourceRequest ParsWebDataSourceToKendo(GridFiltersModel filterModel)
        {

            _request.Filters = new List<IFilterDescriptor>();
            if (filterModel == null || filterModel.filters == null || filterModel.filters.Count < 1)
                return _request;
            int filterCount = filterModel.filters.Count;

            if (filterCount == 1 && filterModel.filters[0].filters == null)
            {
                _request.Filters.Add(ParsWebFilterToFilter(filterModel.filters[0]));
                return _request;
            }

            for (int i = 0; i < filterModel.filters.Count; i++)
            {
                if(filterModel.filters[i].filters == null)
                {
                    CompositeFilterDescriptor compositFilter = new CompositeFilterDescriptor();
                    compositFilter.LogicalOperator = LogicOperatorDict[filterModel.logic];
                    compositFilter.FilterDescriptors.Add(ParsWebFilterToFilter(filterModel.filters[i]));
                    _request.Filters.Add(compositFilter);
                }
                else
                {
                    _request.Filters.Add(ParsWebColFilterToCompositeFilter(filterModel.filters[i]));
                }


                    
            }

            return _request;
        }


        public DataSourceRequest ParsDataSours(WebDatasourceModel datasourceModel)
        {
            ParsWebDataSourceToKendo(datasourceModel.filters);
            ParsSorts(datasourceModel.sort);
            _request.Page = datasourceModel.page;
            _request.PageSize = datasourceModel.pageSize == 0 ? 10 : datasourceModel.pageSize;
            return _request;
        }


        private CompositeFilterDescriptor ParsWebColFilterToCompositeFilter(ColumnFilters columnFilter)
        {
            CompositeFilterDescriptor compositFilter = new CompositeFilterDescriptor();
            compositFilter.FilterDescriptors = new FilterDescriptorCollection();
            compositFilter.LogicalOperator = LogicOperatorDict[columnFilter.logic];
            foreach (var item in columnFilter.filters)
            {
                compositFilter.FilterDescriptors.Add(ParsWebFilterToFilter(item));
            }

            return compositFilter;
        }

       
        private IFilterDescriptor ParsWebFilterToFilter(Filter filter)
        {

            FilterDescriptor newFilter = new FilterDescriptor();
            newFilter.Operator = filterOperatorDict[filter.@operator];
            newFilter.Member = filter.field;
            newFilter.Value = filter.value;
            return newFilter;
        }

        private void FillOperatorDictionary()
        {
            if (filterOperatorDict == null)
            {
                filterOperatorDict = new Dictionary<string, FilterOperator>();
                filterOperatorDict.Add("startswith", FilterOperator.StartsWith);
                filterOperatorDict.Add("endswith", FilterOperator.EndsWith);
                filterOperatorDict.Add("contains", FilterOperator.Contains);
                filterOperatorDict.Add("doesnotcontain", FilterOperator.DoesNotContain);
                filterOperatorDict.Add("eq", FilterOperator.IsEqualTo);
                filterOperatorDict.Add("neq", FilterOperator.IsNotEqualTo);
                filterOperatorDict.Add("gt", FilterOperator.IsGreaterThan);
                filterOperatorDict.Add("lt", FilterOperator.IsLessThan);
                filterOperatorDict.Add("lte", FilterOperator.IsLessThanOrEqualTo);
                filterOperatorDict.Add("gte", FilterOperator.IsGreaterThanOrEqualTo);
            }
            if (LogicOperatorDict == null)
            {
                LogicOperatorDict = new Dictionary<string, FilterCompositionLogicalOperator>();
                LogicOperatorDict.Add("or", FilterCompositionLogicalOperator.Or);
                LogicOperatorDict.Add("and", FilterCompositionLogicalOperator.And);
            }

        }

        private void FillSortDict()
        {
            sortDict = new Dictionary<string, ListSortDirection>();
            sortDict.Add("asc", ListSortDirection.Ascending);
            sortDict.Add("desc", ListSortDirection.Descending);
        }

        public void ParsSorts(IList<SortRequestModel> sort)
        {
            _request.Sorts = new List<SortDescriptor>();
            if (sort == null || sort.Count < 1)
                return;
            foreach (var item in sort)
	    {
            _request.Sorts.Add(new SortDescriptor()
            {
                Member = item.field,
                SortDirection = sortDict[item.dir]
            });
        }
            
        }


    }
}