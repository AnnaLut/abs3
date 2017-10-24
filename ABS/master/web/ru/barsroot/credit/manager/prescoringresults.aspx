<%@ Page Language="C#" AutoEventWireup="true" CodeFile="prescoringresults.aspx.cs" Inherits="inh_prescoringresults" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/barsroot/Content/Bootstrap/bootstrap.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/kendo.common.min.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/kendo.dataviz.min.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/kendo.bootstrap.min.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/kendo.dataviz.bootstrap.min.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/Styles.css" rel="stylesheet" />
    <link href="/barsroot/Content/images/PureFlat/pf-icons.css" rel="stylesheet" />
    <script src="/barsroot/Scripts/jquery/jquery.js"></script>
    <script src="/barsroot/Scripts/bootstrap/bootstrap.min.js"></script>
    <script src="/barsroot/Scripts/jquery/jquery.bars.ui.js"></script>
    <script src="/barsroot/Scripts/kendo/kendo.all.min.js"></script>
    <script src="/barsroot/Scripts/json3.js"></script>
    <script src="/barsroot/Scripts/kendo/kendo.aspnetmvc.min.js"></script>
    <script src="/barsroot/Scripts/kendo/kendo.timezones.min.js"></script>
    <script src="/barsroot/lib/jsZip/jszip.js"></script>

    <%:Scripts.Render("~/bundles/bars")%>
</head>
<body>
    <div>
        <h1>Результати попереднього скорингу по заявці №<span id="bidId" runat="server"></span></h1>
        <div id="GridScoring"></div>

      <script>
          $(function () {
              var cntGarantees = $.ajax({
                  async: false,
                  type: "GET",
                  url: bars.config.urlContent('/api/Wcs/Scoring/Get/?bidId=' + <%= Request.Params.Get("bid_id") %> + '&type=cnt')
              }).responseText;
              
              var result = $.ajax({
                  async: false,
                  type: "GET",
                  url: bars.config.urlContent('/api/Wcs/Scoring/Get/?bidId=' + <%= Request.Params.Get("bid_id") %> + '&type=res')
              }).responseText;
              var obj = JSON.parse(result);

              var columns = [{
                  field: "Name",
                  title: "Показник"
              },
              {
                  title: "Позичальник",
                  columns: [{
                      title: "Визначення ВКР",
                      columns:[{
                          field: "scoreCust",
                          title: "Бал",
                          name: "cell"
                      },
                      {
                          field: "valueCust",
                          title: "Значення",
                          name: "cell"
                      }]
                  },
                  {
                      title: "Визначення класу",
                      columns:[{
                          field: "scoreClass",
                          title: "Бал",
                          name: "cell"
                      },
                      {
                          field: "valueClass",
                          title: "Значення",
                          name: "cell"
                      }]
                  }]
              }];
              for (var i=0; i < cntGarantees; i++)
              {
                  columns.push({
                      title: "Поручитель"+(i+1),
                      columns: [{ 
                          field: "listGuarant["+ i +"].scoreCust", 
                          title: "Бал" 
                      },
                      {
                          field: "listGuarant["+ i +"].valueCust", 
                          title: "Значення" 
                      }]
                  });
              }
              $('#GridScoring').kendoGrid({
                  toolbar: "<table style='width:100%'><tr><td><div><label class='category-label' for='titleStrObu'>Внутрішній кредитний рейтинг Позичальника:</label> <span id='titleStrObu' style='font-style: italic;font-size:16px'>"+obj.rObu+"</span><br />"+
                           "<label class='category-label' for='titleStrNbu'>Клас Позичальника (відповідно до класифікації НБУ):</label> <span id='titleStrNbu' style='font-style: italic;font-size:16px'>"+obj.rNbu+"</span></div></td>"+
                           "<td style='text-align:right'><div><a id='exportExcel' class='k-button k-button-icontext'><span class='k-icon k-i-excel'></span>Export to Excel</a></div></td></tr></table>",
                  excel: {
                      fileName: "Scoring" + <%= Request.Params.Get("bid_id") %> + ".xlsx",
                      proxyURL: bars.config.urlContent('/ExcelExport/ExcelExport_Save/?rObu='+obj.rObu+'&rNbu='+obj.rNbu),
                      allPages: true
                  },
                  dataBound: function() {
                      var rows = $("#GridScoring tbody:eq(1) > tr[data-uid]");
                      var grid = $("#GridScoring").data("kendoGrid");
                      rows.each(function (index, row) {
                          var selectedItem = grid.dataItem(row);
                          if (selectedItem.scoreClass == "" && selectedItem.valueClass == "") {
                              $(row).children().eq(4).hide();
                              $(row).children().eq(3).hide();
                              $(row).children().eq(2).attr("colspan", "2");
                              $(row).children().eq(1).attr("colspan", "2");
                          }
                      });
                  },
                  dataSource: {
                      transport: {
                          read: {
                              type: "GET",
                              url: bars.config.urlContent('/api/Wcs/Scoring/Get/?bidId=' + <%= Request.Params.Get("bid_id") %>),
                              async: true
                          },
                          schema: {
                              model:{
                                  fields:{
                                      bidId: { type: "number" },
                                      questionId: { type: "string" },
                                      Name: { type: "string" },
                                      scoreCust: { type: "string" },
                                      valueCust: { type: "string" },
                                      scoreClass: { type: "string" },
                                      valueClass: { type: "string" },
                                      Ord: { type: "number" },
                                      listGuarant: [{
                                          bidId: { type: "number" },
                                          garanteeNum: { type: "number" },
                                          questionId: { type: "string" },
                                          scoreCust: { type: "string" },
                                          valueCust: { type: "string" },
                                          Ord: { type: "number" }
                                      }]
                                  }
                              }
                          },
                          requestEnd: function(e) {
                              this.data = e.responce.columns;
                          }
                      }
                  },
                  scrollable: false,
                  columns: columns
              });

              $("#exportExcel").on("click",function(e){
                  var grid = $("#GridScoring").data("kendoGrid");
                  grid.saveAsExcel();
              })
          });
      </script>
    </div>
</body>
</html>