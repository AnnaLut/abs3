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
    public partial class VWcsSubproductScoring
    {
        public List<VWcsSubproductScoringRecord> SelectSubproductScoring(String SUBPRODUCT_ID)
        {
            this.Filter.SUBPRODUCT_ID.Equal(SUBPRODUCT_ID);
            return Select();
        }
    }
}