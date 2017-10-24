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

namespace Bars.Ins
{
    public partial class VInsPartnerTypes
    {
        public List<VInsPartnerTypesRecord> SelectPartnerTypes(Decimal? PARTNER_ID)
        {
            this.Filter.PARTNER_ID.Equal(PARTNER_ID);
            return this.Select();
        }
        public List<VInsPartnerTypesRecord> SelectPartnerActiveTypes(Decimal? PARTNER_ID)
        {
            this.Filter.PARTNER_ID.Equal(PARTNER_ID);
            this.Filter.ACTIVE.Equal(1);

            return this.Select();
        }
        public new void Update(VInsPartnerTypesRecord Item)
        {
            InsPack ip = new InsPack(this.Connection);
            ip.SET_PARTNER_TYPE(Item.PARTNER_ID, Item.TYPE_ID, Item.TARIFF_ID, Item.FEE_ID, Item.LIMIT_ID, Item.ACTIVE);
        }
    }
}