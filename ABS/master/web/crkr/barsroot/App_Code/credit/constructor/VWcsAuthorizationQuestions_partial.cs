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
    public partial class VWcsAuthorizationQuestions
    {
        public List<VWcsAuthorizationQuestionsRecord> SelectAuthorizationQuestions(String AUTH_ID, String SortExpression)
        {
            this.Filter.AUTH_ID.Equal(AUTH_ID);
            return Select(String.IsNullOrEmpty(SortExpression) ? "ORD" : SortExpression);
        }
        public List<VWcsAuthorizationQuestionsRecord> SelectAuthorizationQuestion(String AUTH_ID, String QUESTION_ID)
        {
            this.Filter.AUTH_ID.Equal(AUTH_ID);
            this.Filter.QUESTION_ID.Equal(QUESTION_ID);
            return Select();
        }
        public new void Insert(VWcsAuthorizationQuestionsRecord Item)
        {
            WcsPack wp = new WcsPack(this.Connection);
            wp.QUEST_SET(Item.QUESTION_ID, Item.QUESTION_NAME, Item.TYPE_ID, 0, (String)null);
            wp.AUTH_QUEST_SET(Item.AUTH_ID, Item.QUESTION_ID, Item.SCOPY_QID, Item.IS_REQUIRED, Item.IS_CHECKABLE, Item.CHECK_PROC);
        }
        public new void Update(VWcsAuthorizationQuestionsRecord Item)
        {
            WcsPack wp = new WcsPack(this.Connection);
            wp.AUTH_QUEST_SET(Item.AUTH_ID, Item.QUESTION_ID, Item.SCOPY_QID, Item.IS_REQUIRED, Item.IS_CHECKABLE, Item.CHECK_PROC);
        }
        public new void Delete(VWcsAuthorizationQuestionsRecord Item)
        {
            WcsPack wp = new WcsPack(this.Connection);
            wp.AUTH_QUEST_DEL(Item.AUTH_ID, Item.QUESTION_ID);
        }
    }
}