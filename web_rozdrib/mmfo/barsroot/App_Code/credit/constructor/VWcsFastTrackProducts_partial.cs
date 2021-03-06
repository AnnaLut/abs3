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
    public partial class VWcsFastTrackProducts
    {
        public List<VWcsFastTrackProductsRecord> SelectProducts()
        {
            VWcsFastTrackProductsRecord rec = new VWcsFastTrackProductsRecord();
            return Select(rec);
        }
        public List<VWcsFastTrackProductsRecord> SelectProduct(String PRODUCT_ID)
        {
            VWcsFastTrackProductsRecord rec = new VWcsFastTrackProductsRecord();
            rec.PRODUCT_ID = PRODUCT_ID;
            return Select(rec);
        }
        public new void Update(VWcsFastTrackProductsRecord Item)
        {
            WcsPack wp = new WcsPack(this.Connection);
            wp.PROD_SET(Item.PRODUCT_ID, Item.PRODUCT_NAME);
        }
        public new void Insert(VWcsFastTrackProductsRecord Item)
        {
            WcsPack wp = new WcsPack(this.Connection);
            wp.PROD_SET(Item.PRODUCT_ID, Item.PRODUCT_NAME);
        }
        public new void Delete(VWcsFastTrackProductsRecord Item)
        {
            WcsPack wp = new WcsPack(this.Connection);
            wp.PROD_DEL(Item.PRODUCT_ID);
        }
    }
}