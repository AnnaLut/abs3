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
    public partial class VWcsQuestionListItems
    {
        public List<VWcsQuestionListItemsRecord> SelectQuestionListItems(String QUESTION_ID)
        {
            this.Filter.QUESTION_ID.Equal(QUESTION_ID);
            this.Filter.VISIBLE.Equal(1);
            return Select();
        }
        public List<VWcsQuestionListItemsRecord> SelectQuestionListItemsAll(String QUESTION_ID)
        {
            this.Filter.QUESTION_ID.Equal(QUESTION_ID);
            return Select();
        }
    }
}