/*
    AUTOGENERATED! Do not modify this code.
*/

using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Collections.Specialized;
using System.Data;
using System.Web.Configuration;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using ibank.core;
using Bars.Classes;

namespace credit
{
    public partial class VWcsCrdsrvBids
    {
        public List<VWcsCrdsrvBidsRecord> SelectCrdsrvBids(String SRV_HIERARCHY, Decimal? BidId, String Inn, String Fio, String SortExpression, int maximumRows, int startRowIndex)
        {
            this.Filter.SRV_HIERARCHY.Equal(SRV_HIERARCHY.ToUpper());

            // поиск по BidId
            if (BidId.HasValue)
            {
                this.Filter.BID_ID.Equal(BidId);
            }

            // поиск по ИНН
            if (!String.IsNullOrEmpty(Inn))
            {
                this.Filter.INN.Equal(Inn.Trim());
            }

            // поиск по ФИО
            if (!String.IsNullOrEmpty(Fio))
            {
                this.Filter.FIO.LikeBoth(Fio.Trim().ToUpper(), CaseFlags.UpperCase);
            }

            return Select(SortExpression, maximumRows, startRowIndex);
        }
    }
}