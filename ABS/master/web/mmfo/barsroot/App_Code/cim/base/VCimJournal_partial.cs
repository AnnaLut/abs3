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

namespace cim
{
    public partial class VCimJournal
    {
        public List<VCimJournalRecord> SelectJournal(decimal? JTYPE, String JBranch, DateTime? StartDate, DateTime? FinishDate, String SortExpression, int maximumRows, int startRowIndex)
        {
            this.Filter.JOURNAL_NUM.Equal(JTYPE);
            //this.Filter.JOURNAL_NUM.IsNull();
            this.Filter.CREATE_DATE.Between(StartDate, FinishDate);
            if (!string.IsNullOrEmpty(JBranch) && JBranch.Contains("%"))
                this.Filter.BRANCH.LikeRight(JBranch);
            else
                this.Filter.BRANCH.Equal(JBranch);

            return this.Select(SortExpression, maximumRows, startRowIndex);
        }
    }
}