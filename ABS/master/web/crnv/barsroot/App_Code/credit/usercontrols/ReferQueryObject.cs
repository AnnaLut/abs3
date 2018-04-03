using System;
using System.Data;
using System.Configuration;
using System.Collections.Specialized;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using System.Collections;

namespace credit
{
    public class ReferQueryObject
    {
        # region Конструкторы
        public ReferQueryObject()
        {
            this._Columns = new NameValueCollection();
        }
        # endregion

        # region Приватные свойства
        private Decimal? _BID_ID;
        private String _WS_ID;
        private Decimal? _WS_NUM;
        private String _TableSemantic;
        private NameValueCollection _Columns;
        private String _QuerySTMT;
        # endregion

        # region Публичные свойства
        public Decimal? BID_ID
        {
            get { return _BID_ID; }
            set { _BID_ID = value; }
        }
        public String WS_ID
        {
            get { return _WS_ID; }
            set { _WS_ID = value; }
        }
        public Decimal? WS_NUM
        {
            get { return _WS_NUM; }
            set { _WS_NUM = value; }
        }
        public String TableSemantic
        {
            get { return _TableSemantic; }
            set { _TableSemantic = value; }
        }
        public NameValueCollection Columns
        {
            get { return _Columns; }
            set { _Columns = value; }
        }
        public String QuerySTMT
        {
            get { return _QuerySTMT; }
            set { _QuerySTMT = value; }
        }
        # endregion
    }
}