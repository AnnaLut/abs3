using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Collections.Generic;
using Oracle.DataAccess.Client;
using Bars.Classes;

namespace Bars.LinkDocs
{
    public class LinkedDocs
    {
        private Int32 _ID;
        private Decimal? _Sk;
        private Decimal? _S;
        private String _Nazn;
        private String _Nls;
        private String _NlsName;
        private String _Okpo;

        private List<LinkedDocs> Docs
        {
            get
            {
                if (HttpContext.Current.Session["LINKED_DOCS"] == null)
                    HttpContext.Current.Session["LINKED_DOCS"] = new List<LinkedDocs>();

                return ((List<LinkedDocs>)HttpContext.Current.Session["LINKED_DOCS"]);
            }
            set { HttpContext.Current.Session["LINKED_DOCS"] = value; }
        }

        public Int32 ID
        {
            get { return _ID; }
            set { _ID = value; }
        }
        public Decimal? Sk
        {
            get { return _Sk; }
            set { _Sk = value; }
        }
        public String S
        {
            get { return Convert.ToString(_S); }
            set { _S = Convert.ToDecimal(value.Replace(" ", String.Empty)); }
        }
        public String Nazn
        {
            get { return _Nazn; }
            set { _Nazn = value; }
        }
        public String Nls
        {
            get { return _Nls; }
            set { _Nls = value; }
        }
        public String NlsName
        {
            get { return _NlsName; }
            set { _NlsName = value; }
        }

        public LinkedDocs()
        {
        }
        public LinkedDocs(Int32 ID, Decimal? Sk, String S, String Nazn, String Nls, String NlsName)
        {
            this.ID = ID;
            this.Sk = Sk;
            this.S = S;
            this.Nazn = Nazn;
            this.Nls = Nls;
            this.NlsName = NlsName;
        }

        public List<LinkedDocs> SelectDocs()
        {
            return this.Docs;
        }
        public LinkedDocs SelectDoc(Int32 ID)
        {
            if (ID >= this.Docs.Count)
                return null;
            else
                return this.Docs[ID];
        }
        public void InsertDoc(Decimal? Sk, String S, String Nazn, String Nls, String NlsName)
        {
            this.Docs.Add(new LinkedDocs(this.Docs.Count, Sk, S, Nazn, Nls, NlsName));
        }
        public void UpdateDoc(Int32 ID, Decimal? Sk, String S, String Nazn, String Nls, String NlsName)
        {
            this.Docs[ID].Sk = Sk;
            this.Docs[ID].S = S;
            this.Docs[ID].Nazn = Nazn;
            this.Docs[ID].Nls = Nls;
            this.Docs[ID].NlsName = NlsName;
        }
        public void DeleteDoc(Int32 ID)
        {
            this.Docs.RemoveAt(ID);
        }
        public static void ClearData()
        {
            HttpContext.Current.Session["LINKED_DOCS"] = new List<LinkedDocs>();
        }
    }
}