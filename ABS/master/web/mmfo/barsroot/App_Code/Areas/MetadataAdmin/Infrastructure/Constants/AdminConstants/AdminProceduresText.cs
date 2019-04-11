using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for AdminProceduresText
/// </summary>
namespace BarsWeb.Areas.MetaDataAdmin.Infrastructure.Constants.AdminConstants
{
    public static class AdminProceduresText
    {
        public const string deletColProcText = "begin " +
                                "bars_metabase.delete_metacolumns(p_tabid => :p_tabid," +
                                "p_colid => :p_colid);" +
                                " end;";

        public const string addColProcText = "begin "
                               + "bars_metabase.add_column(p_tabid => :p_tabid,"
                               + "p_colid => :p_colid,"
                               + "p_colname => :p_colname,"
                               + "p_coltype => :p_coltype,"
                               + "p_semantic => :p_semantic,"
                               + "p_showwidth => :p_showwidth,"
                               + "p_showmaxchar => :p_showmaxchar,"
                               + "p_showpos => :p_showpos,"
                               + "p_showin_ro => :p_showin_ro,"
                               + "p_showretval => :p_showretval,"
                               + "p_instnssemantic => :p_instnssemantic,"
                               + "p_extrnval => :p_extrnval,"
                               + "p_showrel_ctype => :p_showrel_ctype,"
                               + "p_showformat => :p_showformat,"
                               + "p_showin_fltr => :p_showin_fltr);"
                               + " end;";

        public const string syncColProcText = "begin "
              + "bars_metabase.sync_column(p_tabid => :p_tabid,"
              + "p_colname => :p_colname,"
              + "p_coltype => :p_coltype,"
              + "p_semantic => :p_semantic,"
              + "p_showmaxchar => :p_showmaxchar);"
              + " end;";
    }
}