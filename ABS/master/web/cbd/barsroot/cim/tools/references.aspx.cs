using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class cim_tools_references : System.Web.UI.Page
{

    public class CimRefList
    {
        public string Code { get; set; }
        public string Name { get; set; }
        public string XmlForm { get; set; }
        public string Mode { get; set; }
    }

    private List<CimRefList> refList = new List<CimRefList>()
    {
        new CimRefList()
        {
            Code = "cim_license_type",
            Name = "Типи ліцензій мінекономіки",
            XmlForm = "frm_cim_license_type",
            Mode = "RW"
        },

        new CimRefList()
        {
            Code = "cim_operation_types",
            Name = "Типи операцій",
            XmlForm = "frm_cim_operation_types",
            Mode = "RW"
        },
        new CimRefList()
        {
            Code = "cim_credit_type",
            Name = "Типи кредитів",
            XmlForm = "frm_cim_credit_type",
            Mode = "RW"
        },
        new CimRefList()
        {
            Code = "frm_cim_creditor_type",
            Name = "Типи кредиторів",
            XmlForm = "frm_cim_creditor_type",
            Mode = "RW"
        },
        new CimRefList()
        {
            Code = "frm_cim_credit_opertype",
            Name = "Типи кредитних операцій",
            XmlForm = "frm_cim_credit_opertype",
            Mode = "RW"
        },
        new CimRefList()
        {
            Code = "frm_cim_contract_specs",
            Name = "Спеціалізації контрактів",
            XmlForm = "frm_cim_contract_specs",
            Mode = "RW"
        },
        new CimRefList()
        {
            Code = "frm_cim_contract_deadline",
            Name = "Контрольні строки по торгових контрактах",
            XmlForm = "frm_cim_contract_deadline",
            Mode = "RW"
        },
        new CimRefList()
        {
            Code = "frm_cim_ape_servicecode",
            Name = "Коди класифікатора послуг",
            XmlForm = "frm_cim_ape_servicecode",
            Mode = "RW"
        },
        new CimRefList()
        {
            Code = "frm_cim_conclusion_org",
            Name = "Органи, що  видають висновки",
            XmlForm = "frm_cim_conclusion_org",
            Mode = "RW"
        },
        new CimRefList()
        {
            Code = "frm_cim_credit_borrower",
            Name = "Вид позичальника",
            XmlForm = "frm_cim_credit_borrower",
            Mode = "RW"
        }
    };

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            tabRefList.Rows.Clear();
            string urlTemplate = " /barsroot/barsweb/dynform.aspx?form={0}";
            try
            {
                
                foreach (var refItem in refList)
                {
                    TableRow row = new TableRow();
                    TableCell cell = new TableCell();
                    
                    Image img = new Image();
                    img.ImageUrl = "/Common/Images/default/16/reference.png";
                    img.Style["padding-right"] = "10px";
                    img.ImageAlign = ImageAlign.Middle;
                    cell.Controls.Add(img);
                    row.Cells.Add(cell);

                    HtmlAnchor a = new HtmlAnchor();
                    a.HRef = string.Format(urlTemplate, refItem.XmlForm);
                    a.InnerText = refItem.Name;
                    cell.Height = Unit.Pixel(20);
                    cell.CssClass = "ctrl-td-val";
                    cell.Controls.Add(a);
                    
                    row.Cells.Add(cell);

                    tabRefList.Rows.Add(row);
                }
            }
            finally
            {
            }
        }
    }
}