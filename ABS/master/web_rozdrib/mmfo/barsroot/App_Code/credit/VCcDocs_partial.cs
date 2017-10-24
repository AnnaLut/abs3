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
    public partial class VCcDocs
    {
        public List<VCcDocsRecord> SelectVCcDocs(String CC_ID, DateTime? SDATE)
        {
            if (String.IsNullOrEmpty(CC_ID) || !SDATE.HasValue)
                return (List<VCcDocsRecord>)null;

            this.Filter.CC_ID.Equal(CC_ID);
            this.Filter.SDATE.Equal(SDATE);

            return this.Select();
        }
        public VCcDocsRecord SelectVCcDoc(Decimal? ND, String SCHEME_ID)
        {
            this.Filter.ND.Equal(ND);
            this.Filter.SCHEME_ID.Equal(SCHEME_ID);

            return this.Select()[0];
        }
    }
}