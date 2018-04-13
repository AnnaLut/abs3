<%@ Page Language="C#" AutoEventWireup="true" CodeFile="byteimage_show.aspx.cs" Inherits="dialogs_byteimage_show"
    meta:resourcekey="PageResource1" Theme="default" MasterPageFile="~/credit/master.master"
    Title="Сканкопия" Trace="false" %>

<%@ MasterType VirtualPath="~/credit/master.master" %>
<%@ Register Src="~/credit/usercontrols/ByteImage.ascx" TagPrefix="bars" TagName="ByteImage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <script language="javascript" type="text/jscript">
        // получение максимального размера окна
        function MaxWidth(ImgWidth) {
            var width = null;

            if (window.innerWidth != null) {
                width = window.innerWidth;
            }
            else if (document.documentElement.clientWidth != null) {
                width = document.documentElement.clientWidth;
            }
            else if (document.body != null) {
                width = document.body.clientWidth;
            }

             return Math.min(ImgWidth + 50, width - 50);
        }
        function MaxHeight(ImgHeight) {
            var height = null;

            if (window.innerHeight != null) {
                height = window.innerHeight;
            }
            else if (document.documentElement.clientHeight != null) {
                height = document.documentElement.clientHeight;
            }
            else if (document.body != null) {
                height = document.body.clientHeight;
            }

            return Math.min(ImgHeight + 50, height - 150);
        }

        // закрываем диалог
        function CloseDialog(res) {
            window.returnValue = res;
            window.close();
            return false;
        }

        // инициализация картинки
        function InitByteImage(csxi_id, sid, pcount_id, prev_id, next_id) {
            var csxi_obj = $get(csxi_id);

            // ид. сессии
            csxi_obj.sid = sid;
            csxi_obj.dwnldUrl = location.protocol + '//' + location.host + '/barsroot/credit/usercontrols/dialogs/byteimage_tiffile.ashx?sid=' + sid + '&rnd=' + Math.random();

            // контролы пейджера
            csxi_obj.pcount_id = pcount_id;
            csxi_obj.prev_id = prev_id;
            csxi_obj.next_id = next_id;

            // значения пейджера
            csxi_obj.imgcount = 0;
            csxi_obj.curimg = 0;

            // получаем кол-во картинок и загружаем первую если есть
            try {
                csxi_obj.imgcount = csxi_obj.ImageCount(csxi_obj.dwnldUrl);
                csxi_obj.curimg = 1;

                ShowCurrentImage(csxi_id);
            } catch (e) {
                csxi_obj.imgcount = 0;
                csxi_obj.curimg = 0;
            }

            // отображем подпись
            RedrawPagerTitle(csxi_id);
        }
        // пейджинг
        function ShowCurrentImage(csxi_id) {
            var csxi_obj = $get(csxi_id);

            csxi_obj.ReadImageNumber = csxi_obj.curimg;
            csxi_obj.LoadFromURL(csxi_obj.dwnldUrl);

            // размер окна
            csxi_obj.width = MaxWidth(csxi_obj.ImageWidth);
            csxi_obj.height = MaxHeight(csxi_obj.ImageHeight);
        }
        function RedrawPagerTitle(csxi_id) {
            var csxi_obj = $get(csxi_id);

            // если нет контрола для отображенияы пейджера то выходим
            if (csxi_obj.pcount_id == null || $get(csxi_obj.pcount_id) == null) return;

            var pcount_obj = $get(csxi_obj.pcount_id);
            pcount_obj.innerHTML = String.Format("<asp:Literal runat=server text='<%$ Resources: credit.StringConstants, text_pagecount %>' />", csxi_obj.curimg, csxi_obj.imgcount);
        }
        function ShowPrevImage(csxi_id) {
            var csxi_obj = $get(csxi_id);

            if (csxi_obj.curimg - 1 >= 1) {
                csxi_obj.curimg--;
                ShowCurrentImage(csxi_id);
                RedrawPagerTitle(csxi_id);
            }
        }
        function ShowNextImage(csxi_id) {
            var csxi_obj = $get(csxi_id);

            if (csxi_obj.curimg + 1 <= csxi_obj.imgcount) {
                csxi_obj.curimg++;
                ShowCurrentImage(csxi_id);
                RedrawPagerTitle(csxi_id);
            }
        }
    </script>
    <table border="0" cellpadding="3" cellspacing="0" width="99%" style="text-align: center">
        <tr>
            <td style="padding-top: 10px">
                <asp:ImageButton ID="ibPrint" runat="server" ImageUrl="/Common/Images/default/24/printer.png"
                    Text="Печать" ToolTip="Печать" OnClick="ibPrint_Click" meta:resourcekey="ibPrintResource1" />
                <asp:ImageButton ID="ibCancel" runat="server" ImageUrl="/Common/Images/default/24/delete2.png"
                    Text="Отмена" ToolTip="Отмена" OnClientClick="CloseDialog(null); return false;"
                    meta:resourcekey="ibCancelResource1" />
            </td>
        </tr>
        <tr>
            <td colspan="2" id="ph" runat="server">
                <bars:ByteImage runat="server" ID="BImg" ShowLabel="true" ShowPager="true" ShowView="false" Type="Original" Width="500px" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:ImageButton ID="ibPrev" runat="server" ImageUrl="/Common/Images/default/16/navigate_left.png"
                    Text="Предидущая" ToolTip="Предидущая страница" meta:resourcekey="ibPrevResource1" />
                <asp:Label ID="lbPageCount" runat="server" Text="Зображення 0 з 0" Font-Bold="True"
                    Font-Italic="True" ForeColor="#94ABD9" meta:resourcekey="lbPageCountResource1"></asp:Label>
                <asp:ImageButton ID="ibNext" runat="server" ImageUrl="/Common/Images/default/16/navigate_right.png"
                    Text="Следующая" ToolTip="Следующая страница" meta:resourcekey="ibNextResource1" />
            </td>
        </tr>
    </table>
</asp:Content>
