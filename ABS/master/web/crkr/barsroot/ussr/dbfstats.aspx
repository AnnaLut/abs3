<%@ Page Language="C#" AutoEventWireup="true" CodeFile="dbfstats.aspx.cs" Inherits="ussr_dbfstats" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Перегляд звiтiв</title>
    <style type="text/css">
      .grid td {padding: 3px 3px 3px 3px;}
      .grid th {padding: 3px 3px 3px 3px;}
    </style>
</head>
<body style="font-size:8pt;">
    <form id="form1" runat="server">
    <div>
    <table>
        <tr>
            <td style="padding-bottom:20px; width: 334px;" ><div style="border-bottom: 1px solid gray;font-size:12pt;">Iдентифiкованi вклади за перiод</div></td>
        </tr>
        <tr>
            <td nowrap="nowrap">
                Дата з <cc1:DateEdit ID="deFrom" runat="server"></cc1:DateEdit>
                по <cc1:DateEdit ID="deTo" runat="server"></cc1:DateEdit>
                <asp:Button ID="btnReload" runat="server" Text="Перечитати" />
            </td>
        </tr>
        <tr>
            <td style="padding-top:20px">
                <asp:RadioButton ID="rbRU" runat="server" Text="по РУ" AutoPostBack="True" GroupName="reptype" Checked="True" />    
                <asp:RadioButton ID="rbMfo" runat="server" Text="по МФО" AutoPostBack="True" GroupName="reptype"/>    
                <asp:RadioButton ID="rbTvbv" runat="server" Text="по ТВБВ" AutoPostBack="True" GroupName="reptype"/>    
            </td>
        </tr>        
        <tr>
            <td>    
                <Bars:BarsSqlDataSource ID="dsRu" runat="server" ProviderName="barsroot.core" 
                    PreliminaryStatement="begin bars_role_auth.set_role('WR_USSR_TECH'); end;"
                    SelectCommand="select&#13;&#10;  t.*,&#13;&#10;  round((t.nvyp * 100) / sum(t.nvyp) over (),2) as nvypp,&#13;&#10;  round((t.s9760 * 100) / sum(t.s9760) over (),2) as s9760p,&#13;&#10;  round((t.kols * 100) / sum(t.kols) over (),2) as kolsp, &#13;&#10;  round((t.kolk * 100) / sum(t.kolk) over (),2) as kolkp&#13;&#10;from&#13;&#10;(&#13;&#10;  select &#13;&#10;    h.ru, &#13;&#10;    to_char(null) as branch, &#13;&#10;    to_char(null) as fullname,  &#13;&#10;    sum(s.kolk) as kolk, &#13;&#10;    sum(s.kols) as kols, &#13;&#10;    sum(s.s9760)/100 as s9760, &#13;&#10;    sum(s.nvyp)/100 as nvyp&#13;&#10;  from &#13;&#10;    (select branch, nameukrr ru from alegrob ) h,     &#13;&#10;    (&#13;&#10;      select &#13;&#10;       branch, &#13;&#10;       count(*) &#13;&#10;       kolk, &#13;&#10;       sum(kols) as kols,&#13;&#10;       sum(s9760) as s9760, &#13;&#10;       sum(nvyp) nvyp&#13;&#10;     from &#13;&#10;     (&#13;&#10;       select a.kf,a.branch, a.rnk, &#13;&#10;          count(*) kols, -sum(a.ostb) s9760,  least(-sum(a.ostb),c.lim) nvyp &#13;&#10;       from accounts a, customer c&#13;&#10;       where a.tip='DEP' and a.nbs='9760' and c.rnk=a.rnk and a.ostb<0 &#13;&#10;         and a.daos>= :ddat1 and a.daos<= :ddat2 &#13;&#10;       group by a.kf, a.branch, a.rnk, c.lim &#13;&#10;     ) &#13;&#10;     group by  branch &#13;&#10;  ) s&#13;&#10;  where h.branch = s.branch  &#13;&#10;  group by h.ru &#13;&#10;) t&#13;&#10;order by t.ru&#13;&#10;">
                </Bars:BarsSqlDataSource>        
                <Bars:BarsSqlDataSource ID="dsMfo" runat="server" ProviderName="barsroot.core"
                    PreliminaryStatement="begin bars_role_auth.set_role('WR_USSR_TECH'); end;"
                    SelectCommand="select&#13;&#10;  t.*,&#13;&#10;  round((t.nvyp * 100) / sum(t.nvyp) over (),2) as nvypp,&#13;&#10;  round((t.s9760 * 100) / sum(t.s9760) over (),2) as s9760p,&#13;&#10;  round((t.kols * 100) / sum(t.kols) over (),2) as kolsp, &#13;&#10;  round((t.kolk * 100) / sum(t.kolk) over (),2) as kolkp&#13;&#10;from&#13;&#10;(&#13;&#10;  select &#13;&#10;    h.ru as ru, &#13;&#10;    h.mfo as branch, &#13;&#10;    h.fullname as fullname,  &#13;&#10;    s.kolk as kolk,  &#13;&#10;    s.kols as kols,  &#13;&#10;    s.s9760/100 as s9760, &#13;&#10;    s.nvyp/100 as nvyp &#13;&#10;  from &#13;&#10;    (select nameukrr ru, substr(branch,2,6) mfo,fullname from alegrob where length(branch)=8 ) h, &#13;&#10;    (&#13;&#10;      select &#13;&#10;        kf,  count(*) kolk, sum(kols) kols, sum(s9760) s9760, sum(nvyp) nvyp&#13;&#10;      from &#13;&#10;      (&#13;&#10;        select a.kf,a.branch, a.rnk, &#13;&#10;           count(*) kols, -sum(a.ostb) s9760,  least(-sum(a.ostb),c.lim) nvyp &#13;&#10;        from accounts a, customer c&#13;&#10;        where a.tip='DEP' and a.nbs='9760' and c.rnk=a.rnk and a.ostb<0 &#13;&#10;          and a.daos>= :ddat1 and a.daos<= :ddat2 &#13;&#10;        group by a.kf, a.branch, a.rnk, c.lim &#13;&#10;      ) &#13;&#10;      group by  kf &#13;&#10;    ) s&#13;&#10;  where h.mfo = s.kf  &#13;&#10;) t order by t.fullname, t.branch  ">
                </Bars:BarsSqlDataSource>                 
                <Bars:BarsSqlDataSource ID="dsBranch" runat="server" ProviderName="barsroot.core"
                    PreliminaryStatement="begin bars_role_auth.set_role('WR_USSR_TECH'); end;"
                    SelectCommand="select&#13;&#10;  t.*,&#13;&#10;  round((t.nvyp * 100) / sum(t.nvyp) over (),2) as nvypp,&#13;&#10;  round((t.s9760 * 100) / sum(t.s9760) over (),2) as s9760p,&#13;&#10;  round((t.kols * 100) / sum(t.kols) over (),2) as kolsp, &#13;&#10;  round((t.kolk * 100) / sum(t.kolk) over (),2) as kolkp&#13;&#10;from&#13;&#10;(&#13;&#10;select h.nameukrr as ru, h.branch as branch, h.fullname as fullname, s.kolk as kolk, s.kols as , s.s9760/100 as s9760, s.nvyp/100 as nvyp&#13;&#10;from  alegrob h, (select branch,  count(*) kolk, sum(kols) kols, sum(s9760) s9760, sum(nvyp) nvyp&#13;&#10;from (select a.kf,a.branch, a.rnk, &#13;&#10; count(*) kols, -sum(a.ostb) s9760,  least(-sum(a.ostb),c.lim) nvyp &#13;&#10;      from accounts a, customer c&#13;&#10;      where a.tip='DEP' and a.nbs='9760' and c.rnk=a.rnk and a.ostb<0 &#13;&#10;        and a.daos>= :ddat1 and a.daos<= :ddat2 &#13;&#10;      group by a.kf, a.branch, a.rnk, c.lim ) &#13;&#10;group by  branch ) s&#13;&#10;where h.branch = s.branch  &#13;&#10;) t&#13;&#10;order by ru, branch&#13;&#10;">
                </Bars:BarsSqlDataSource>                                 
                <asp:GridView ID="gv" runat="server" AutoGenerateColumns="False" 
                 CssClass="grid"  >
                    <Columns>
                        <asp:BoundField DataField="RU" HeaderText="РУ">
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="branch" HeaderText="Код установи">
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="fullname" HeaderText="Назва установи">
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>                        
                        <asp:BoundField DataField="kolk" HeaderText="Кiлькiсть клiєнтiв">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>            
                        <asp:BoundField DataField="kolkp" HeaderText="% кл">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>            
                        <asp:BoundField DataField="kols" HeaderText="Кiлькiсть рахункiв">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>            
                        <asp:BoundField DataField="kolsp" HeaderText="% рах">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>            
                        <asp:BoundField DataField="S9760" HeaderText="Сума зобов'язань">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>            
                        <asp:BoundField DataField="S9760p" HeaderText="% зоб">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>                                                                                                            
                        <asp:BoundField DataField="NVYP" HeaderText="Сума до сплати">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>            
                        <asp:BoundField DataField="NVYPP" HeaderText="% спл">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>                                                                                                     
                        
                    </Columns>
                    
                </asp:GridView> &nbsp;&nbsp;
                
             </td>
        </tr>
    </table>           
    </div>
    </form>
</body>
</html>
