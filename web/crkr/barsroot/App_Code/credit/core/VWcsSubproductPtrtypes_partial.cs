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
    public partial class VWcsSubproductPtrtypes
    {
        public List<VWcsSubproductPtrtypesRecord> SelectSubproductPtrtypes(String SUBPRODUCT_ID)
        {
            this.Filter.SUBPRODUCT_ID.Equal(SUBPRODUCT_ID);
            return Select();
        }
        public new void Insert(VWcsSubproductPtrtypesRecord Item)
        {
            WcsPack wp = new WcsPack(this.Connection);
            wp.SBP_PTRTYPE_SET(Item.SUBPRODUCT_ID, Item.PTR_TYPE_ID);
        }
        public new void Delete(VWcsSubproductPtrtypesRecord Item)
        {
            WcsPack wp = new WcsPack(this.Connection);
            wp.SBP_PTRTYPE_DEL(Item.SUBPRODUCT_ID, Item.PTR_TYPE_ID);
        }
    }
}