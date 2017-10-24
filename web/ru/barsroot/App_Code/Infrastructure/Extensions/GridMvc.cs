using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using GridMvc;
using GridMvc.Pagination;

namespace Infrastructure.Extensions
{
    public class GridMvc<T> : Grid<T> where T : class
    {
        //private IGridPager _pager;
        private bool _enablePaging;
        private IGridItemsProcessor<T> _pagerProcessor;
        public GridMvc(IEnumerable<T> items)
            : this(items.AsQueryable())
        {
        }

        public GridMvc(IQueryable<T> items)
            : base(items)
        {
            Language = Thread.CurrentThread.CurrentCulture.Parent.Name;
            RenderOptions.RenderRowsOnly = Convert.ToBoolean(HttpContext.Current.Request.Params["grid-RenderRowsOnly"]);
            Pager = new GridPager();
            EnablePaging = false;
            if (HttpContext.Current.Request.Params["grid-page-size"] != null)
            {
                Pager.PageSize = Convert.ToInt32(HttpContext.Current.Request.Params["grid-page-size"]);
            }
        }

        /*public IGridPager Pager
        {
            get { return _pager ?? (_pager = new GridPager()); }
            set { _pager = value; }
        }*/
        /*public object HtmlAttributes{get;set;}*/
        /*public bool EnablePaging
        {
            get { return _enablePaging; }
            set
            {
                if (_enablePaging == value) return;
                _enablePaging = value;
                if (_enablePaging)
                {
                    if (_pagerProcessor == null)
                        _pagerProcessor = new PagerGridItemsProcessor<T>(Pager);
                    AddItemsProcessor(_pagerProcessor);
                }
                else
                {
                    RemoveItemsProcessor(_pagerProcessor);
                }
            }
        }*/
    }

    public class PagerGridItemsProcessor<T> : IGridItemsProcessor<T> where T : class
    {
        private readonly IGridPager _pager;

        public PagerGridItemsProcessor(IGridPager pager)
        {
            _pager = pager;
        }

        #region IGridItemsProcessor<T> Members

        public IQueryable<T> Process(IQueryable<T> items)
        {
            _pager.Initialize(items); //init pager

            if (_pager.CurrentPage <= 0) return items; //incorrect page

            int skip = (_pager.CurrentPage - 1) * _pager.PageSize;
            return items.Skip(skip).Take(_pager.PageSize+10);
        }

        #endregion
    }
    public class GridPager : GridMvc.Pagination.GridPager
    {
        public GridPager(): this(HttpContext.Current)
        {
        }

        public GridPager(HttpContext context): base(context)
        {
        }

        public override void Initialize<T>(IQueryable<T> items)
        {
             ItemsCount = 1000000;
        }
       /* protected override void RecalculatePages()
        {
            if (ItemsCount == 0)
            {
                PageCount = 0;
                return;
            }
            PageCount = (int)(Math.Ceiling(ItemsCount / (double)PageSize));

            //if (CurrentPage > PageCount)
            //    CurrentPage = PageCount;

            StartDisplayedPage = (CurrentPage - MaxDisplayedPages / 2) < 1 ? 1 : CurrentPage - MaxDisplayedPages / 2;
            EndDisplayedPage = (CurrentPage + MaxDisplayedPages / 2) > PageCount
                                   ? PageCount
                                   : CurrentPage + MaxDisplayedPages / 2;
        }*/
    }
}