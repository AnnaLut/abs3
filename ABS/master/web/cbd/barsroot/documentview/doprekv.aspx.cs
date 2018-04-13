using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.Collections.Generic;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

public partial class DopRekv : Bars.BarsPage
{
    // доп. реквизит документа
    public class DocAddAttr
    {
        public String _Tag;
        public String _Name;
        public String _Value;

        public String Tag
        {
            get { return _Tag; }
            set { _Tag = value; }
        }
        public String Name
        {
            get { return _Name; }
            set { _Name = value; }
        }
        public String Value
        {
            get { return _Value; }
            set { _Value = value; }
        }

        public DocAddAttr(String Tag, String Name, String Value)
        {
            _Tag = Tag;
            _Name = Name;
            _Value = Value;
        }

        public Boolean ExistsIn(List<DocAddAttr> Attrs)
        {
            foreach (DocAddAttr Attr in Attrs)
                if (this.Tag == Attr.Tag)
                    return true;
            return false;
        }
    }

    public Decimal REF
    {
        get
        {
            return Convert.ToDecimal(Request.Params.Get("ref"));
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        List<DocAddAttr> Attrs = new List<DocAddAttr>();

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        try
        {
            // наполняем список из operw
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_ref", OracleDbType.Decimal, REF, ParameterDirection.Input);
            cmd.CommandText = @"select trim(o.tag) as tag, f.name, o.value
                                  from operw o, op_field f
                                 where o.ref = :p_ref
                                   and o.tag = f.tag";
            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                while (rdr.Read())
                {
                    Attrs.Add(new DocAddAttr(Convert.ToString(rdr["tag"]), Convert.ToString(rdr["name"]), Convert.ToString(rdr["value"])));
                }
                rdr.Close();
            }

            // наполняем список из d_rec
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_ref", OracleDbType.Decimal, REF, ParameterDirection.Input);
            cmd.CommandText = "select d_rec from oper where ref = :p_ref";
            String DRec = Convert.ToString(cmd.ExecuteScalar());

            if (!String.IsNullOrEmpty(DRec))
            {
                //разбераем d_rec на под реквизиты
                //структура поля D_REC:
                //{'#'<один символ - код реквизита><его значение>#}
                foreach (String item in DRec.Split('#'))
                {
                    if (String.IsNullOrEmpty(item)) continue;

                    String Tag = item.Substring(0, 1);
                    String Value = item.Substring(1);

                    // берем строковое представление тега из OP_FIELD  
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("p_tag", OracleDbType.Varchar2, Tag, ParameterDirection.Input);
                    cmd.CommandText = "select name from op_field where trim(tag) = trim(:p_tag)";
                    String Name = Convert.ToString(cmd.ExecuteScalar());

                    //если в таблице не было найдено соответствия, то определяем 
                    //реквизит как СЕП
                    DocAddAttr Attr = new DocAddAttr(Tag, String.IsNullOrEmpty(Name) ? "Допоміжний реквізит СЕП " + Tag : Name, Value);
                    if (!Attr.ExistsIn(Attrs)) Attrs.Add(Attr);
                }
            }
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        // если данных не выбрано, то добавляем пустую строку
        if (Attrs.Count == 0)
            Attrs.Add(new DocAddAttr(String.Empty, String.Empty, String.Empty));

        // загрузка результата
        grdRes.DataSource = Attrs;
        grdRes.DataBind();
    }
}
