using System.Web.Optimization;

namespace BarsWeb
{
    public class BundleConfig
    {
        // Дополнительные сведения о Bundling см. по адресу http://go.microsoft.com/fwlink/?LinkId=254725
        public static void RegisterBundles(BundleCollection bundles)
        {
            const string themeUrl = "~/Content/themes/modernui/css/";

            BundleTable.EnableOptimizations = false;   
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/scripts/jquery/jquery.js",
                        "~/scripts/jquery/pnotify.custom.min.js")); 

            bundles.Add(new ScriptBundle("~/bundles/jquery-ui").Include(
                        "~/scripts/jquery/jquery-ui.js"));

            bundles.Add(new ScriptBundle("~/bundles/junggridview").Include(
                        "~/scripts/jquery/junggridview.js"));

            bundles.Add(new ScriptBundle("~/bundles/jquery-bars-ui").Include(
                        "~/scripts/jquery/jquery.bars.ui.js"));

            bundles.Add(new ScriptBundle("~/bundles/bars").Include(
                        "~/scripts/bars/bars.*"/*,
                        "~/scripts/bars/bars.ui.js",
                        "~/scripts/bars/bars.http.js"*/));

            bundles.Add(new ScriptBundle("~/bundles/jquery-masked").Include(
                        "~/scripts/jquery/jquery.maskMoney.js",
                        "~/scripts/jquery/jquery.numberMask.js",
                        "~/scripts/jquery/jquery.maskedinput-1.3.1.js"));

            bundles.Add(new ScriptBundle("~/bundles/gridmvc").Include(
                        "~/Scripts/gridmvc/gridmvc.js",
                        "~/Scripts/gridmvc/gridmvc.customwidgets.js",
                        "~/Scripts/gridmvc/gridmvc.ajaxloading.js"));

            bundles.Add(new ScriptBundle("~/scripts/ext.js").Include(
                        "~/scripts/ExtJs/ext/ext-all.js",
                        "~/scripts/ExtJs/ext/src/ux/grid/FiltersFeature.js",
                        "~/scripts/ExtJs/ext/src/ux/grid/menu/ListMenu.js", 
                        "~/scripts/ExtJs/ext/src/ux/grid/menu/RangeMenu.js", 
                        "~/scripts/ExtJs/ext/src/ux/grid/filter/Filter.js", 
                        "~/scripts/ExtJs/ext/src/ux/grid/filter/BooleanFilter.js", 
                        "~/scripts/ExtJs/ext/src/ux/grid/filter/DateFilter.js", 
                        "~/scripts/ExtJs/ext/src/ux/grid/filter/ListFilter.js", 
                        "~/scripts/ExtJs/ext/src/ux/grid/filter/NumericFilter.js", 
                        "~/scripts/ExtJs/ext/src/ux/grid/filter/StringFilter.js",
                        "~/scripts/ExtJs/ext/src/ux/grid/filter/DateTimeFilter.js",
                        "~/scripts/ExtJs/ext/src/ux/ClearButton.js",
                        "~/scripts/ExtJs/ext/src/ux/PageSizePlugin.js"));

            bundles.Add(new ScriptBundle("~/bundles/kendo").Include(
                        "~/Scripts/kendo/kendo.all.min.js",
                        "~/Scripts/kendo/kendo.aspnetmvc.min.js",
                        "~/Scripts/kendo/kendo.timezones.min.js"));

            bundles.Add(new StyleBundle(themeUrl + "modernui").Include(
                themeUrl + "style.css",
                themeUrl + "jquery-ui.css",
                themeUrl + "buttons.css",
                themeUrl + "tiptip.css",
                themeUrl + "junggridview.css",
                themeUrl + "calculator.css",
                themeUrl + "converter.css",
                themeUrl + "pnotify.custom.min.css",
                themeUrl + "pnotify.theme.css"));

            bundles.Add(new StyleBundle(themeUrl + "gridmvc").Include(
                themeUrl + "Gridmvc.css",
                themeUrl + "GridMvcAddition.css",
                themeUrl + "gridmvc.datepicker.css"));



            bundles.Add(new StyleBundle("~/Content/themes/kendo/css").Include(
                "~/Content/Themes/Kendo/kendo.common.min.css",
                "~/Content/Themes/Kendo/kendo.dataviz.min.css"));

            bundles.Add(new StyleBundle("~/Content/themes/kendo/styles").Include(
                "~/Content/Themes/Kendo/Styles.css"));

        }
    }
}