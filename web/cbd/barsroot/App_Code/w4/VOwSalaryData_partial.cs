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

namespace Bars.W4
{
    public partial class VOwSalaryData
    {
        public List<VOwSalaryDataRecord> SelectSalaryData(Decimal? FileID)
        {
            this.Filter.ID.Equal(FileID);
            return this.Select("IDN ASC");
        }
        public List<VOwSalaryDataRecord> SelectSalaryData2(Decimal? FileID)
        {
            this.Filter.ID.Equal(FileID);
            this.Filter.FLAG_OPEN.Equal(2);
            return this.Select("IDN ASC");
        }
    }
}