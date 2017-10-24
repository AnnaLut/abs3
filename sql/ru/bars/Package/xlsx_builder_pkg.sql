
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/xlsx_builder_pkg.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.XLSX_BUILDER_PKG 
as

  g_number_format constant varchar2(128) := 'FM999999999999999999999999999990.0999999999999999999999999999999';

  g_number_nlsparam constant varchar2(30) := 'NLS_NUMERIC_CHARACTERS = ''. ''';

  g_date_format constant varchar2(30) := 'YYYY.MM.DD HH24:MI:SS';

  type tp_alignment is record
    ( vertical varchar2(11)
    , horizontal varchar2(16)
    , wrapText boolean
    );

  procedure clear_workbook;

  procedure new_sheet( p_sheetname varchar2 := null );

  function OraFmt2Excel( p_format varchar2 := null )
  return varchar2;

  function get_numFmt( p_format varchar2 := null )
  return pls_integer;

  function get_font
    ( p_name varchar2
    , p_family pls_integer := 2
    , p_fontsize number := 11
    , p_theme pls_integer := 1
    , p_underline boolean := false
    , p_italic boolean := false
    , p_bold boolean := false
    )
  return pls_integer;

  function get_fill
    ( p_patternType varchar2
    , p_fgRGB varchar2 := null
    )
  return pls_integer;

  function get_border
    ( p_top varchar2 := 'thin'
    , p_bottom varchar2 := 'thin'
    , p_left varchar2 := 'thin'
    , p_right varchar2 := 'thin'
    )
















  return pls_integer;

  function get_alignment
    ( p_vertical varchar2 := null
    , p_horizontal varchar2 := null
    , p_wrapText boolean := null
    )

















  return tp_alignment;

  procedure cell
    ( p_col pls_integer
    , p_row pls_integer
    , p_value number
    , p_numFmtId pls_integer := null
    , p_fontId pls_integer := null
    , p_fillId pls_integer := null
    , p_borderId pls_integer := null
    , p_alignment tp_alignment := null
    , p_sheet pls_integer := null
    );

  procedure cell
    ( p_col pls_integer
    , p_row pls_integer
    , p_value varchar2
    , p_numFmtId pls_integer := null
    , p_fontId pls_integer := null
    , p_fillId pls_integer := null
    , p_borderId pls_integer := null
    , p_alignment tp_alignment := null
    , p_sheet pls_integer := null
    );

  procedure cell
    ( p_col pls_integer
    , p_row pls_integer
    , p_value date
    , p_numFmtId pls_integer := null
    , p_fontId pls_integer := null
    , p_fillId pls_integer := null
    , p_borderId pls_integer := null
    , p_alignment tp_alignment := null
    , p_sheet pls_integer := null
    );

  procedure hyperlink
    ( p_col pls_integer
    , p_row pls_integer
    , p_url varchar2
    , p_value varchar2 := null
    , p_sheet pls_integer := null
    );

  procedure comment
    ( p_col pls_integer
    , p_row pls_integer
    , p_text varchar2
    , p_author varchar2 := null
    , p_width pls_integer := 150
    , p_height pls_integer := 100
    , p_sheet pls_integer := null
    );








 procedure page_layout
    ( p_paperSize pls_integer        := 9
     ,p_fitToWidth pls_integer       := 0
     ,p_fitToHeight pls_integer      := 0
     ,p_orientation varchar2         := 'portrait'
     ,p_sheet pls_integer            := null
     ,p_horizontalCentered pls_integer :=1
     ,p_verticalCentered   pls_integer :=0
     ,p_Margins_sleft      number := 0.2
     ,p_Margins_right      number := 0.2
     ,p_Margins_top        number := 0.2
     ,p_Margins_bottom     number := 0.2
     ,p_Margins_header     number := 0.2
     ,p_Margins_footer     number := 0.2
    );

 procedure page_definedName
    ( p_col_tl   pls_integer      := null
     ,p_col_br   pls_integer      := null
     ,p_row_tl   pls_integer      := null
     ,p_row_br   pls_integer      := null
     ,p_sheet    pls_integer      := null
    );

  procedure mergecells
    ( p_tl_col pls_integer
    , p_tl_row pls_integer
    , p_br_col pls_integer
    , p_br_row pls_integer
    , p_sheet pls_integer := null
    );

  procedure set_column_width
    ( p_col pls_integer
    , p_width number
    , p_sheet pls_integer := null
    );

    procedure set_row_Height
    ( p_row pls_integer
    , p_heigth number
    , p_sheet pls_integer := null
    );

  procedure set_column
    ( p_col pls_integer
    , p_numFmtId pls_integer := null
    , p_fontId pls_integer := null
    , p_fillId pls_integer := null
    , p_borderId pls_integer := null
    , p_alignment tp_alignment := null
    , p_sheet pls_integer := null
    );

  procedure set_row
    ( p_row pls_integer
    , p_numFmtId pls_integer := null
    , p_fontId pls_integer := null
    , p_fillId pls_integer := null
    , p_borderId pls_integer := null
    , p_alignment tp_alignment := null
    , p_sheet pls_integer := null
    );

  procedure freeze_rows
    ( p_nr_rows pls_integer := 1
    , p_sheet pls_integer := null
    );

  procedure freeze_cols
    ( p_nr_cols pls_integer := 1
    , p_sheet pls_integer := null
    );

  procedure set_autofilter
    ( p_column_start pls_integer := null
    , p_column_end pls_integer := null
    , p_row_start pls_integer := null
    , p_row_end pls_integer := null
    , p_sheet pls_integer := null
    );

  function finish
  return blob;

  procedure save
    ( p_directory varchar2
    , p_filename varchar2
    );

  procedure query2sheet
    ( p_sql varchar2
    , p_column_headers boolean := true
    , p_directory varchar2 := null
    , p_filename varchar2 := null
    , p_sheet pls_integer := null
    );


end xlsx_builder_pkg;
/
CREATE OR REPLACE PACKAGE BODY BARS.XLSX_BUILDER_PKG wrapped
a000000
ab
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
b
10f73 4347
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
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/xlsx_builder_pkg.sql =========*** En
 PROMPT ===================================================================================== 
 