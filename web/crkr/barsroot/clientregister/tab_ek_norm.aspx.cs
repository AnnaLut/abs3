using System;
using Bars;

namespace clientregister
{
    public partial class tab_ek_norm : BarsPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var EN_FS = GetGlobalParam("EN_FS","");
            if (EN_FS != "1")
            {
                trK080.Visible = false;
            }
        }
    }
}
