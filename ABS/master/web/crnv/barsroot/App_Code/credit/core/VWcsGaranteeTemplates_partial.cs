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
    public partial class VWcsGaranteeTemplates
    {
        public List<VWcsGaranteeTemplatesRecord> SelectGaranteeTemplates(String GARANTEE_ID)
        {
            this.Filter.GARANTEE_ID.Equal(GARANTEE_ID);
            return Select();
        }
    }
}