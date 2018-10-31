
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/fin_rep.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.FIN_REP 
AS
   G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 1.0.1  10.12.2017';


   -- маска формата для преобразования char <--> number
  g_number_format constant varchar2(128) := 'FM999G999G999G999G999G999G999G999G999G990D00999999999999999999999';
  -- параметры преобразования char <--> number
  g_number_nlsparam constant varchar2(30) := 'NLS_NUMERIC_CHARACTERS = ''. ''';
  -- маска формата для преобразования char <--> date
  g_date_format constant varchar2(30) := 'YYYY.MM.DD HH24:MI:SS';


 TYPE t_601_kol IS RECORD (   rnk      cc_deal.rnk%type   --
                            , nd       cc_deal.nd%type    --
							, column7  fin_fm.ved%type    --  (K110) – вид економічної діяльності
							, column8  varchar2(4)        -- (ec_year) – період, за який визначено вид економічної діяльності (календарний рік).
							, column9  number             -- (sales) – показник сукупного обсягу реалізації (SALES);
							, column10 number             -- (ebit) – показник фінансового результату від операційної діяльності (EBIT);
							, column11 number             -- (ebitda) – показник фінансового результату від звичайної діяльності до оподаткування фінансових витрат і нарахування амортизації (EBITDA);
							, column12 number             -- (totalDebt)– показник концентрації залучених коштів (TOTAL NET DEBT).
							, column13 number             -- (isMember)– зазначається приналежність боржника до групи юридичних осіб, що перебувають під спільним контролем (так/ні) – 1 знак: 1 – так; 2 – ні
							, column17 number             --  під спільним контролем(sales) – показник сукупного обсягу реалізації (SALES);
							, column18 number             --  під спільним контролем(ebit) – показник фінансового результату від операційної діяльності (EBIT);
							, column19 number             --  під спільним контролем(ebitda) – показник фінансового результату від звичайної діяльності до оподаткування фінансових витрат і нарахування амортизації (EBITDA);
							, column20 number             --  під спільним контролем(totalDebt)– показник концентрації залучених коштів (TOTAL NET DEBT).
							, column21 number             --  під спільним контролем  (classGr) – зазначається клас групи, визначений на підставі консолідованої/комбінованої фінансової звітності
						  );
 g_601  t_601_kol;

  type tp_nds is record
      ( nd     number
       ,dd     number
       ,kol23  Varchar2(500)
       ,kol24  Varchar2(500)
       ,kol25  Varchar2(500)
       ,kol26  Varchar2(500)
       ,kol27  Varchar2(500)
       ,kol28  Varchar2(500)
       ,kol29  Varchar2(500)
	   ,kol30  Varchar2(500)
       ,ovkr   Varchar2(50)
       ,p_def  Varchar2(50)
       ,ovd    Varchar2(50)
       ,opd    Varchar2(50)
       ,cls1   Varchar2(50)
       ,cls2   Varchar2(50)


       );
  type tp_ndss is table of tp_nds index by pls_integer;
  type tp_rnks is record
      ( rnk       number
	   ,date_open date
	   ,okpo      number
	   ,clas      number
	   ,ipb       number
       ,nd        tp_ndss
       );
  type tb_rnk is table of tp_rnks index by pls_integer;
  type tp_deal is record
    ( rnk     tb_rnk
    );
  t_deal tp_deal;

TYPE tb_trow is record (row_id varchar2(254), rnk rez_cr.rnk%type, nd rez_cr.nd%type, acc rez_cr.acc%type, pawn rez_cr.pawn%type, tipa rez_cr.tipa%type, custtype rez_cr.custtype%type);
TYPE tb_row is table of tb_trow index by pls_integer;



  type tr_col is record(kol23  Varchar2(500)
					   ,kol24  Varchar2(500)
					   ,kol25  Varchar2(500)
					   ,kol26  Varchar2(500)
					   ,kol27  Varchar2(500)
					   ,kol28  Varchar2(500)
					   ,kol29  Varchar2(500)
					   ,kol30  Varchar2(500)
                       ,ovkr   Varchar2(50)
                       ,p_def  Varchar2(50)
                       ,ovd    Varchar2(50)
                       ,opd    Varchar2(50)
                       );

  type tr_p   is record( p161_1 Varchar2(1)  := '0'
                        ,p161_2 Varchar2(1)  := '0'
                        ,p161_3 Varchar2(1)  := '0'
                        ,p162_1 Varchar2(1)  := '0'
                        ,p162_2 Varchar2(1)  := '0'
                        ,p162_3 Varchar2(1)  := '0'
                        ,p162_4 Varchar2(1)  := '0'
                        ,p162_5 Varchar2(1)  := '0'
                        ,p163_1 Varchar2(1)  := '0'
                        ,p163_2 Varchar2(1)  := '0'
                        ,p164_1 Varchar2(1)  := '0'
                        ,p164_2 Varchar2(1)  := '0'
                        ,p165_1 Varchar2(1)  := '0'
                        ,p165_2 Varchar2(1)  := '0'
                        ,p165_3 Varchar2(1)  := '0'
                        ,p165_4 Varchar2(1)  := '0'
                        ,p165_5 Varchar2(1)  := '0'
                        ,p165_6 Varchar2(1)  := '0'
                        ,p165_7 Varchar2(1)  := '0'
                        ,p165_8 Varchar2(1)  := '0'
                        ,p165_9 Varchar2(1)  := '0'
                        ,p165_10 Varchar2(1) := '0'
                        ,p164_11 Varchar2(1) := '0'
                        ,p164_12 Varchar2(1) := '0'
                        ,p165_11 Varchar2(1) := '0'
                        ,p165_12 Varchar2(1) := '0'
                        ,p165_13 Varchar2(1) := '0'
                        ,p165_14 Varchar2(1) := '0'
                        ,p165_15 Varchar2(1) := '0'
                        ,p165_16 Varchar2(1) := '0'
                        ,p165_17 Varchar2(1) := '0'
                        ,p165_18 Varchar2(1) := '0'
                        ,p166_1 Varchar2(1)  := '0'
                        ,p166_2 Varchar2(1)  := '0'
                        ,p166_3 Varchar2(1)  := '0'
                        ,p166_4 Varchar2(1)  := '0'
                        ,p166_5 Varchar2(1)  := '0'
                        ,p166_6 Varchar2(1)  := '0'
                        ,p166_7 Varchar2(1)  := '0'
                        ,p166_8 Varchar2(1)  := '0'
                        ,p166_9 Varchar2(1)  := '0'
                        ,p167_1 Varchar2(1)  := '0'
                        ,p167_2 Varchar2(1)  := '0'
                        ,p167_3 Varchar2(1)  := '0'
						,pVD0   Varchar2(1)  := '0'
						,pCLS1  Varchar2(2)  := null
						,pCLS2  Varchar2(2)  := null

                        );


type  t_col_rep_nbu_351 is record(  nd     number
                                   ,rnk    number
                                   ,fdat   varchar2(20)
								   ,rv     number
								   ,sort   varchar2(30)
                                   ,kod    varchar2(10)
                                   ,name   varchar2(2000)
                                   ,s      varchar2(254)
								   ,kv     varchar2(3)
								  );

TYPE t_rep_nbu_351 iS TABLE OF t_col_rep_nbu_351;


type  t_col_rep_nbu_351_1 is record(  nd     number
                                   ,rnk    number
                                   ,fdat   date --varchar2(20)
								   ,rv     number
								   ,sort   varchar2(30)
                                   ,kod    varchar2(10)
                                   ,name   varchar2(2000)
                                   ,s      varchar2(254)
								   ,kv     varchar2(3)
								  );

TYPE t_rep_nbu_351_1 iS TABLE OF t_col_rep_nbu_351_1;


procedure get_nd_fin_param (p_rnk   number
                          , p_nd    number
						  , P_RW    VARCHAR2
						  , p_ovkr  out varchar2
						  , p_p_def out varchar2
						  , p_ovd   out varchar2
						  , p_opd   out varchar2
						  , p_kol23 out varchar2
						  , p_kol24 out varchar2
						  , p_kol25 out varchar2
						  , p_kol26 out varchar2
						  , p_kol27 out varchar2
						  , p_kol28 out varchar2
						  , p_kol29 out varchar2
						  , p_kol30 out varchar2
						  , p_fin_z out varchar2
						  , p_ipb   out number
						  , p_cls1  out varchar2
						  , p_cls2  out varchar2
						    )  ;

procedure t_deal_del;

FUNCTION  bars_instr(str_ VARCHAR2, p_s varchar2) RETURN varchar2;

procedure kol_rezcr (p_dat date);

procedure rez_kr_table1 (p_dat date default trunc(sysdate,'MM') );

function f_entry (p_indic varchar2, p_value varchar2) return varchar2;

 /**
 * header_version - возвращает версию заголовка пакета
 */
function header_version return varchar2;


/**
 * body_version - возвращает версию тела пакета
 */
function body_version   return varchar2;

-------------------------------
 -- rez_rep Zvit rez351
-------------------------------
procedure rez_rep (p_dat date default trunc(sysdate,'MM') );

procedure rez_rep_dir (p_dat date default trunc(sysdate,'MM') );

function  export_to_script  return blob;

function f_rep_nbu_351( p_sFdat1 date
                       ,p_sFdat2 date
					   ,p_nd     number
					   ,p_rnk    number
                       )
                        RETURN t_rep_nbu_351 PIPELINED  PARALLEL_ENABLE;

function f_rep_z1 ( p_sFdat1 date
                   ,p_kl_m   number
				   ,p_nd     number
				   ,p_rnk    number
                       )
                        RETURN t_rep_nbu_351_1 PIPELINED  PARALLEL_ENABLE;

procedure indicator_601 ( p_rnk     number
                         ,p_nd      number
                         ,p_dat 	date
                         ,p_601     out t_601_kol
						 );

END fin_rep;
/
CREATE OR REPLACE PACKAGE BODY BARS.FIN_REP 
AS

 G_BODY_VERSION  CONSTANT VARCHAR2(64)  :=  'version 1.0.7 29.10.2018';

/*
 2017-05-23 1.0.2  - COBUSUPMMFO-588 Если Клиент одновременно входит в группу под общим контролем
                     и в группу связанных лиц - необходимо заполнять kol24 в REZ_CR значением "100".

 2017-05-23 1.0.3 - COBUSUPABS-6002 Необхідно внести зміни при формуванні поля kol26 в rez_cr при
                    формуванні резервів станом на 01.07.2017. Згідно змін до файлу Д8
					з 01.07.2017 в kol26 замість кода 164216520 необхідно формувати 164216502

 2017-05-23 1.0.4 - COBUSUPABS-6001 Необхідно внести зміни у формування поля kol25 в rez_cr при формуванні резервів станом на 01.07.2017.
                    Згідно змін у формі 613 (файл Д8) при визначенні ознаки про високий кредитний ризик - замість кодів 1631,1632 повинен
				    формуватися код 1630 ( згідно пункту 163 Постанови 351).

 2017-12-10 1.0.6 - COBUMMFO-5544  Розрахунок показників для ф601

*/

 g_fdat date;

 /**
 * header_version - возвращает версию заголовка пакета
 */
function header_version return varchar2 is
begin
  return 'Package header FIN_REP '||G_HEADER_VERSION;
end header_version;

/**
 * body_version - возвращает версию тела пакета
 */
function body_version return varchar2 is
begin
  return 'Package body FIN_REP '||G_BODY_VERSION;
end body_version;


function f_num (p_zn varchar2) return boolean
as
l_num number;
begin
 l_num := to_number(p_zn);
 return true;
 exception  when others then
   if sqlcode=-1722 or sqlcode=-6502 then
       return false;
       else raise;
   end if;
end;


function f_conct (p_kod varchar2, p_zn number, p_n number default 1) return varchar2
as
begin
if p_zn = p_n then
    return ';'||p_kod;
end if;

 return null;

end;






procedure rez_kr_table1 (p_dat date default trunc(sysdate,'MM') )
as
i int := 0;
sTmp varchar2(254);
l_3  varchar2(254);  l_4  varchar2(254); l_5  varchar2(254);
l_6  varchar2(254);  l_7  varchar2(254); l_8  varchar2(254);
l_9  varchar2(254);  l_10 varchar2(254); l_11 varchar2(254);
l_12 varchar2(254);
l_fillId  pls_integer;

begin

 kol_rezcr(p_dat);

XLSX_BUILDER_PKG.clear_workbook;
XLSX_BUILDER_PKG.new_sheet('Таблиця1');
XLSX_BUILDER_PKG.PAGE_LAYOUT(P_PAPERSIZE => 9, P_FITTOWIDTH => 1, P_FITTOHEIGHT => 0, P_ORIENTATION => 'landscape');  -- Параметри сторінки
XLSX_BUILDER_PKG.page_definedName(p_row_tl=> 5, p_row_br=> 7);
XLSX_BUILDER_PKG.freeze_rows(p_nr_rows =>7);



XLSX_BUILDER_PKG.mergecells( 31, 1, 34, 1 );
XLSX_BUILDER_PKG.cell( 31, 1, 'ТЕСТОВИЙ РЕЖИМ', p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'left') );
XLSX_BUILDER_PKG.mergecells( 1, 2, 34, 2 );
XLSX_BUILDER_PKG.SET_ROW_HEIGHT(2, 36.75);
XLSX_BUILDER_PKG.cell( 1, 2, 'Звіт про концентрацію ризиків за операціями банку з боржниками/контрагентами
за станом на '||to_char(p_dat,'dd.mm.yyyy')||' року.', p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,14,1,false, true,true ) );
XLSX_BUILDER_PKG.cell( 34, 3, '(копійки)', p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'right') );


XLSX_BUILDER_PKG.SET_ROW_HEIGHT(4, 16);
XLSX_BUILDER_PKG.SET_ROW_HEIGHT(5, 40);
XLSX_BUILDER_PKG.SET_ROW_HEIGHT(6, 123);

XLSX_BUILDER_PKG.mergecells( 1, 4, 1, 6 );
XLSX_BUILDER_PKG.cell( 1, 4, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 1, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 1, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 1, 4, 'NKB', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ));

XLSX_BUILDER_PKG.mergecells( 2, 4, 2, 6 );
XLSX_BUILDER_PKG.cell( 2, 4, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 2, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 2, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 2, 4, 'Дата', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );

XLSX_BUILDER_PKG.mergecells( 3, 4, 3, 6 );
XLSX_BUILDER_PKG.cell( 3, 4, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 3, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 3, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 3, 4, '№ з/п', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );

XLSX_BUILDER_PKG.mergecells( 4, 4, 4, 6 );
XLSX_BUILDER_PKG.cell( 4, 4, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 4, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 4, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 4, 4, 'Код (номер)   контрагента', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );

XLSX_BUILDER_PKG.mergecells( 5, 4, 5, 6 );
XLSX_BUILDER_PKG.cell( 5, 4, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 5, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 5, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 5, 4, 'Найменування контрагента ', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );

XLSX_BUILDER_PKG.mergecells( 6, 4, 6, 6 );
XLSX_BUILDER_PKG.cell( 6, 4, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 6, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 6, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 6, 4, 'Код типу пов''язаної  з банком  особи', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );

XLSX_BUILDER_PKG.mergecells( 7, 4, 7, 6 );
XLSX_BUILDER_PKG.cell( 7, 4, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 7, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 7, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 7, 4, 'Код країни контрагента', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );

XLSX_BUILDER_PKG.mergecells( 8, 4, 8, 6 );
XLSX_BUILDER_PKG.cell( 8, 4, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 8, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 8, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 8, 4, 'Код інститу-ційного сектора економіки', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );

XLSX_BUILDER_PKG.mergecells( 9, 4, 9, 6 );
XLSX_BUILDER_PKG.cell( 9, 4, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 9, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 9, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 9, 4, 'Номер договору ', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );

XLSX_BUILDER_PKG.mergecells( 10, 4, 10, 6 );
XLSX_BUILDER_PKG.cell( 10, 4, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 10, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 10, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 10, 4, 'Дата договору ', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );

XLSX_BUILDER_PKG.mergecells( 11, 4, 11, 6 );
XLSX_BUILDER_PKG.cell( 11, 4, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 11, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 11, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 11, 4, 'Дата виникнення боргу/ наданих фінансових зобов''язань ', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );

XLSX_BUILDER_PKG.mergecells( 12, 4, 12, 6 );
XLSX_BUILDER_PKG.cell( 12, 4, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 12, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 12, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 12, 4, 'Дата погашення боргу/наданих фінансових зобов''язань', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );

XLSX_BUILDER_PKG.mergecells( 13, 4, 13, 6 );
XLSX_BUILDER_PKG.cell( 13, 4, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 13, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 13, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 13, 4, 'Код валюти ', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );

XLSX_BUILDER_PKG.mergecells( 14, 4, 14, 6 );
XLSX_BUILDER_PKG.cell( 14, 4, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 14, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 14, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 14, 4, 'Номер рахунку', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );

XLSX_BUILDER_PKG.mergecells( 15, 4, 15, 6 );
XLSX_BUILDER_PKG.cell( 15, 4, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 15, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 15, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 15, 4, 'Код місце знаходження контрагента  ', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );

XLSX_BUILDER_PKG.mergecells( 16, 5, 16, 6 );
XLSX_BUILDER_PKG.cell( 16, 4, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 16, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 16, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 16, 4, 'EAD ', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );
XLSX_BUILDER_PKG.cell( 16, 5, 'Експозиція під ризиком (EAD за активними операціями, крім наданих фінансових зобов''язань/EAD*CCF за наданими фінансо-вими зобов''язаннями) на дату оцінки', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );


XLSX_BUILDER_PKG.mergecells( 17, 4, 20, 4 );
XLSX_BUILDER_PKG.cell( 17, 4, 'LGD ', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );
XLSX_BUILDER_PKG.cell( 18, 4, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );
XLSX_BUILDER_PKG.cell( 19, 4, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );
XLSX_BUILDER_PKG.cell( 20, 4, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );

XLSX_BUILDER_PKG.mergecells( 17, 5, 17, 6 );
XLSX_BUILDER_PKG.cell( 17, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 17, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 17, 5, 'Код виду забезпечення', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );

XLSX_BUILDER_PKG.mergecells( 18, 5, 18, 6 );
XLSX_BUILDER_PKG.cell( 18, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 18, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 18, 5, 'Сума забез-печення (CV*k)', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );


XLSX_BUILDER_PKG.mergecells( 19, 5, 19, 6 );
XLSX_BUILDER_PKG.cell( 19, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 19, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 19, 5, 'Інші надход-ження (RС)', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );

XLSX_BUILDER_PKG.mergecells( 20, 5, 20, 6 );
XLSX_BUILDER_PKG.cell( 20, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 20, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 20, 5, 'Значення коефіцієнта LGD    (1-RR) ', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );


XLSX_BUILDER_PKG.mergecells( 21, 4, 31, 4 );
XLSX_BUILDER_PKG.cell( 21, 4, 'PD', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );
for k in 22..31
loop
XLSX_BUILDER_PKG.cell( k, 4, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );
end loop;


XLSX_BUILDER_PKG.mergecells( 21, 5, 21, 6 );
XLSX_BUILDER_PKG.cell( 21, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 21, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 21, 5, 'Клас боржника, визначений на підставі оцінки фінансового стану', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );

XLSX_BUILDER_PKG.mergecells( 22, 5, 27, 5 );
XLSX_BUILDER_PKG.cell( 22, 5, 'Інформація про наявність факторів, на підставі яких банк зобов''язаний скоригувати клас боржника:', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );
for k in 23..27
loop
XLSX_BUILDER_PKG.cell( k, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );
end loop;

XLSX_BUILDER_PKG.cell( 22, 6, 'належність боржника/ контрагента до групи юридичних осіб під спільним контролем/групи пов''язаних контрагентів', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );
XLSX_BUILDER_PKG.cell( 23, 6, 'наявність ознаки, що свідчить про високий кредитний ризик', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );

XLSX_BUILDER_PKG.cell( 24, 6, ' своєчасність сплати боргу боржником/ контрагентом ', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );
XLSX_BUILDER_PKG.cell( 25, 6, ' кредитна історія боржника', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );
XLSX_BUILDER_PKG.cell( 26, 6, ' додаткові характеристики', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );
XLSX_BUILDER_PKG.cell( 27, 6, ' події дефолту боржника/контрагента ', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,11,1,false, true,true ) );

XLSX_BUILDER_PKG.mergecells( 28, 5, 28, 6 );
XLSX_BUILDER_PKG.cell( 28, 5, 'Код фактору, на підставі якого скоригований клас боржника', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) );
XLSX_BUILDER_PKG.cell( 28, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) );

XLSX_BUILDER_PKG.mergecells( 29, 5, 29, 6 );
XLSX_BUILDER_PKG.cell( 29, 5, 'Код ознаки дефолту боржника щодо якої банк довів відсутність дефолту', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) );
XLSX_BUILDER_PKG.cell( 29, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) );

XLSX_BUILDER_PKG.mergecells( 30, 5, 30, 6 );
XLSX_BUILDER_PKG.cell( 30, 5, 'Скоригований клас боржника/ контрагента', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) );
XLSX_BUILDER_PKG.cell( 30, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) );

XLSX_BUILDER_PKG.mergecells( 31, 5, 31, 6 );
XLSX_BUILDER_PKG.cell( 31, 5, 'Значення коефіцієнта PD, застосоване для визначення кредитного ризику боржника/ контрагента', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) );
XLSX_BUILDER_PKG.cell( 31, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) );

XLSX_BUILDER_PKG.mergecells( 32, 5, 32, 6 );
XLSX_BUILDER_PKG.cell( 32, 4, 'CR', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) );
XLSX_BUILDER_PKG.cell( 32, 5, 'Розмір кредитного ризику за активом', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) );
XLSX_BUILDER_PKG.cell( 32, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) );

XLSX_BUILDER_PKG.mergecells( 33, 4, 33, 6 );
XLSX_BUILDER_PKG.cell( 33, 4, 'Розмір резерву за активом згідно з МСФЗ/ уцінки (за цінним папером)', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) );
XLSX_BUILDER_PKG.cell( 33, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) );
XLSX_BUILDER_PKG.cell( 33, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) );

XLSX_BUILDER_PKG.mergecells( 34, 4, 34, 6 );
XLSX_BUILDER_PKG.cell( 34, 4, 'Розмір кредитного ризику за активом згідно з  Положенням № 23', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) );
XLSX_BUILDER_PKG.cell( 34, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) );
XLSX_BUILDER_PKG.cell( 34, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) );


 for k in 1 .. 34
 loop
 XLSX_BUILDER_PKG.cell( k, 7, to_char(k), p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
 end loop;



--XLSX_BUILDER_PKG.set_column_width(3, 7.29);
--XLSX_BUILDER_PKG.set_column_width(4, 10.43);
--XLSX_BUILDER_PKG.set_column_width(5,50);
--XLSX_BUILDER_PKG.set_column_width(6, 7.29);
--XLSX_BUILDER_PKG.set_column_width(7, 13.71);
--XLSX_BUILDER_PKG.set_column_width(8, 15.15);

--XLSX_BUILDER_PKG.set_column_width(9, 11.75);
--XLSX_BUILDER_PKG.set_column_width(10, 14.15);
--XLSX_BUILDER_PKG.set_column_width(11, 11.15);
--XLSX_BUILDER_PKG.set_column_width(14, 14);



   i := 7;
    for x in (
					select gl.kf  , r.fdat , '' "3", r.rnk,r.nmk,' ' "6",c.country,c.ise, n.cc_id,n.sdate,
                 '' "11",n.wdate,r.kv,r.nls,decode(r.rz,1,'[0000]',2,'[1000]') misce, sum(r.eadq)*100 kol16,kol17,
  							  sum (r.ZALq)*100 kol18, 0 rc, r.lgd, r.fin_z kol21, '[000/00]' kol22,kol23,
                  kol24,kol25,kol26,kol27,kol28,kol29,r.fin kol30,kol31, sum(r.CRQ)*100 kol32 , 
                  n.rezq39*100 kol33 ,n.rezq23*100  kol34, n.nd, r.dv, t4
					from rez_cr r,customer c, nbu23_rez n
				   where r.fdat= p_dat and r.rnk=c.rnk and n.fdat= p_dat and r.acc=n.acc  and r.t4=1
					group by  gl.kf ,r.fdat,1,r.rnk,r.nmk,6,c.country,c.ise, n.cc_id,11,n.sdate,
                    n.wdate,r.kv,r.nls,decode(r.rz,1,'[0000]',2,'[1000]'),  0 , r.lgd, r.fin_z, 22 ,
                    kol23,kol24,kol25,kol26,kol27,kol28,kol29,r.fin,  n.rezq39*100,n.rezq23*100 ,
                    r.acc,kol17,kol31, n.nd, r.dv, t4
					order by  r.rnk, r.nls
	          )
	LOOP
     i := i+1;

	 XLSX_BUILDER_PKG.cell( 1, i, to_number(gl.kf), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( '#####0'), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 2, i, x.fdat, p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( 'dd.mm.yyyy'), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 3, i, (i-7), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( '#####0'), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 4, i, x.rnk, p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( '#######0'), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 5, i, x.nmk, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 6, i, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 7, i, x.country, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 8, i, x.ise, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 9, i, x.cc_id, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 10, i, x.sdate, p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( 'dd.mm.yyyy'),  p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 11, i, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 12, i,  x.wdate, p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( 'dd.mm.yyyy'), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 13, i,  x.kv, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 14, i,  x.nls, p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( '###############0'), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 15, i,  x.misce, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 16, i, to_number(x.kol16), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(x.kol16)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 17, i, x.kol17, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 18, i, to_number(x.kol18), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(x.kol18)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 19, i, to_number(x.rc), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('######.###',length(x.rc)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 20, i, to_number(x.lgd), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt(  '###0.0####'  ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 21, i, x.kol21,  p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 22, i, x.kol22,  p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));

	 XLSX_BUILDER_PKG.cell( 23, i, x.kol23,  p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 24, i, x.kol24,  p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 25, i, x.kol25,  p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 26, i, x.kol26,  p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 27, i, x.kol27,  p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 28, i, x.kol28,  p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 29, i, x.kol29,  p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 30, i, x.kol30,  p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 31, i, x.kol31,  p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 32, i, to_number(x.kol32), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(x.kol32)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 33, i, to_number(x.kol33), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(x.kol33)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	 XLSX_BUILDER_PKG.cell( 34, i, to_number(x.kol34), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(x.kol34)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));



	XLSX_BUILDER_PKG.cell( 36, i, x.nd, p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(x.nd)+2,'#') ) ,p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	XLSX_BUILDER_PKG.cell( 37, i, x.dv ,p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
	XLSX_BUILDER_PKG.cell( 38, i, x.t4 ,p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));




	END LOOP;


XLSX_BUILDER_PKG.set_column_width(5,50);
XLSX_BUILDER_PKG.set_column_width(6,11);
XLSX_BUILDER_PKG.set_column_width(8, 10);
XLSX_BUILDER_PKG.set_column_width(9, 26);
XLSX_BUILDER_PKG.set_column_width(17, 18);
XLSX_BUILDER_PKG.set_column_width(22, 18);
XLSX_BUILDER_PKG.set_column_width(23, 14);
XLSX_BUILDER_PKG.set_column_width(24, 12);
XLSX_BUILDER_PKG.set_column_width(25, 12);
XLSX_BUILDER_PKG.set_column_width(26, 12);
XLSX_BUILDER_PKG.set_column_width(27, 34);
XLSX_BUILDER_PKG.set_column_width(28, 9);
XLSX_BUILDER_PKG.set_column_width(29, 34);

end;

procedure rez_table1 (p_dat date default trunc(sysdate,'MM') )
as
i int := 0;
sTmp varchar2(254);
l_3  varchar2(254);  l_4  varchar2(254); l_5  varchar2(254);
l_6  varchar2(254);  l_7  varchar2(254); l_8  varchar2(254);
l_9  varchar2(254);  l_10 varchar2(254); l_11 varchar2(254);
l_12 varchar2(254);
l_fillId  pls_integer;

begin

XLSX_BUILDER_PKG.clear_workbook;
XLSX_BUILDER_PKG.new_sheet('Таблиця1');
XLSX_BUILDER_PKG.PAGE_LAYOUT(P_PAPERSIZE => 9, P_FITTOWIDTH => 1, P_FITTOHEIGHT => 0, P_ORIENTATION => 'landscape');  -- Параметри сторінки
XLSX_BUILDER_PKG.page_definedName(p_row_tl=> 5, p_row_br=> 7);
XLSX_BUILDER_PKG.freeze_rows(p_nr_rows =>7);


XLSX_BUILDER_PKG.mergecells( 9, 1, 12, 1 );
XLSX_BUILDER_PKG.cell( 9, 1, 'Таблиця 1', p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'right') );
XLSX_BUILDER_PKG.mergecells( 9, 2, 12, 2 );
XLSX_BUILDER_PKG.cell( 9, 2, 'ТЕСТОВИЙ РЕЖИМ', p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'left') );
XLSX_BUILDER_PKG.mergecells( 1, 3, 12, 3 );
XLSX_BUILDER_PKG.SET_ROW_HEIGHT(3, 36.75);
XLSX_BUILDER_PKG.cell( 1, 3, 'Звіт про визначення банками України розміру кредитного ризику за активними банківськими операціями, що оцінюються на індивідуальній основі
за станом на '||to_char(p_dat,'dd.mm.yyyy')||' року.', p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,14,1,false, true,true ) );
XLSX_BUILDER_PKG.cell( 12, 4, '(копійки)', p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'right') );



XLSX_BUILDER_PKG.cell( 1, 5, '№ з/п', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 1, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.mergecells( 1, 5, 1, 6 );
XLSX_BUILDER_PKG.cell( 2, 5, 'Назва показника ', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 2, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.mergecells( 2, 5, 2, 6 );

XLSX_BUILDER_PKG.cell( 3, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 3, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 4, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 4, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 5, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 5, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 6, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 6, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 7, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 7, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 8, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 8, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 9, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 9, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 10, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 10, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 11, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 11, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 12, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 12, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );

XLSX_BUILDER_PKG.mergecells( 3, 5, 5, 5 );
XLSX_BUILDER_PKG.cell( 3, 5, 'Борг за активом', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
XLSX_BUILDER_PKG.cell( 3, 6, 'Усього', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
XLSX_BUILDER_PKG.cell( 4, 6, 'у т.ч. нараховані доходи', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
XLSX_BUILDER_PKG.cell( 5, 6, 'З застосованим значенням CCF (за наданими фінансовими зобов''язаннями)', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
XLSX_BUILDER_PKG.mergecells( 6, 5, 8, 5 );
XLSX_BUILDER_PKG.cell( 6, 5, 'Рівень повернення боргу за рахунок реалізації забезпечення та інших надходжень', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
XLSX_BUILDER_PKG.cell( 6, 6, 'Усього, в т.ч.', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
XLSX_BUILDER_PKG.cell( 7, 6, 'за рахунок реалізації забезпечення (CV*k)', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
XLSX_BUILDER_PKG.cell( 8, 6, 'за рахунок інших надходжень (RС)', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));

XLSX_BUILDER_PKG.mergecells( 9, 5, 9, 6 );
XLSX_BUILDER_PKG.cell( 9, 5, 'Розмір кредитного ризику за активами (CR)', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
XLSX_BUILDER_PKG.mergecells( 10, 5, 10, 6 );
XLSX_BUILDER_PKG.cell( 10, 5, 'Розмір резерву за активами згідно з МСФЗ/ уцінки (за цінними паперами)', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
XLSX_BUILDER_PKG.mergecells( 11, 5, 11, 6 );
XLSX_BUILDER_PKG.cell( 11, 5, 'Різниця між розміром кредитного ризику та розміром резерву за МСФЗ', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
XLSX_BUILDER_PKG.mergecells( 12, 5, 12, 6 );
XLSX_BUILDER_PKG.cell( 12, 5, 'Розмір кредитного ризику за активами згідно з  Положенням № 23', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
XLSX_BUILDER_PKG.SET_ROW_HEIGHT(5, 45.75);
XLSX_BUILDER_PKG.SET_ROW_HEIGHT(6, 78.75);


XLSX_BUILDER_PKG.cell( 1, 7, '1', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 2, 7, '2', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 3, 7, '3', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 4, 7, '4', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 5, 7, '5', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 6, 7, '6', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 7, 7, '7', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 8, 7, '8', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 9, 7, '9', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 10, 7, '10', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 11, 7, '11', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 12, 7, '12', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );

XLSX_BUILDER_PKG.set_column_width(3, 7.29);
XLSX_BUILDER_PKG.set_column_width(4, 10.43);
XLSX_BUILDER_PKG.set_column_width(5, 16.05);
XLSX_BUILDER_PKG.set_column_width(6, 7.29);
XLSX_BUILDER_PKG.set_column_width(7, 13.71);
XLSX_BUILDER_PKG.set_column_width(8, 15.15);

XLSX_BUILDER_PKG.set_column_width(9, 11.75);
XLSX_BUILDER_PKG.set_column_width(10, 14.15);
XLSX_BUILDER_PKG.set_column_width(11, 11.15);
XLSX_BUILDER_PKG.set_column_width(12, 13.57);


 --- Цикл по даним.
 for x in (select * from REZ_XLS_REF where sheet = 1 order by ord)
 loop

   if  x.tips = 1 then
   XLSX_BUILDER_PKG.mergecells( 1, x.ord, 12, x.ord );
   XLSX_BUILDER_PKG.cell( 1, x.ord, x.name, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'left',true));
   XLSX_BUILDER_PKG.cell( 12, x.ord, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'left',true));
   elsif x.tips = 2 then
      XLSX_BUILDER_PKG.cell( 1, x.ord, x.pn, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
      XLSX_BUILDER_PKG.cell( 2, x.ord, x.name, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'left',true), p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,12,1,false, true,true ) );
        l_3 := null; l_4 := null; l_5 := null; l_6 := null; l_7 := null; l_8 := null; l_9 := null; l_10 := null; l_11 := null; l_12 := null;
   XLSX_BUILDER_PKG.cell( 3, x.ord, l_3, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   XLSX_BUILDER_PKG.cell( 4, x.ord, l_4, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   XLSX_BUILDER_PKG.cell( 5, x.ord, l_5, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   XLSX_BUILDER_PKG.cell( 6, x.ord, l_6, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   XLSX_BUILDER_PKG.cell( 7, x.ord, l_7, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   XLSX_BUILDER_PKG.cell( 8, x.ord, l_8, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   XLSX_BUILDER_PKG.cell( 9, x.ord, l_9, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   XLSX_BUILDER_PKG.cell( 10, x.ord, l_10, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   XLSX_BUILDER_PKG.cell( 11, x.ord, l_11, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   XLSX_BUILDER_PKG.cell( 12, x.ord, l_12, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   elsif x.tips = 0 then


    if substr(x.pn,1,1) in ('1','2') and length(x.pn) = 5 then
        if x.ord in (33,268) then l_fillId :=XLSX_BUILDER_PKG.get_fill( 'solid', p_fgRGB => 'FEEBA8' );
                             else l_fillId :=XLSX_BUILDER_PKG.get_fill( 'solid', p_fgRGB => 'E2EFDA' );
         end if;
      XLSX_BUILDER_PKG.cell( 1, x.ord, x.pn, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true), p_fillId => l_fillId);
      XLSX_BUILDER_PKG.cell( 2, x.ord, x.name, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'left',true), p_fillId => l_fillId);
    else
      XLSX_BUILDER_PKG.cell( 1, x.ord, x.pn, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
      XLSX_BUILDER_PKG.cell( 2, x.ord, x.name, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'left',true));
    end if;

        l_3 := null; l_4 := null; l_5 := null; l_6 := null; l_7 := null; l_8 := null; l_9 := null; l_10 := null; l_11 := null; l_12 := null;

     Case when DBMS_LOB.GETLENGTH (x.txt_sql) >0 then
       begin
          execute immediate x.txt_sql into l_3, l_4, l_5, l_6, l_7, l_8, l_9,l_10, l_11, l_12; --using IDF_, DAT_, OKPO_, FM_;
		        l_3 :=nvl(l_3,'0');  l_4 :=nvl(l_4,'0'); l_5  :=nvl(l_5,'0');  l_6  :=nvl(l_6,'0');   l_7 :=nvl(l_7,'0');
				l_8 :=nvl(l_8,'0');  l_9 :=nvl(l_9,'0'); l_10 :=nvl(l_10,'0'); l_11 :=nvl(l_11,'0');  l_12 :=nvl(l_12,'0');
          exception when NO_DATA_FOUND  THEN  null;
                    when others then
                    raise_application_error(-(20000),'/' ||'     '||'Помилка формули  ord= '||x.ord||'   '||x.txt_sql,TRUE);
					null;
         end;
     else null;
     end case;

         --L_5 := 'X';

   if not f_num(l_3) then   XLSX_BUILDER_PKG.cell( 3, x.ord, l_3, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
                             else   XLSX_BUILDER_PKG.cell( 3, x.ord, to_number(l_3), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_3)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   end if;

   if not f_num(l_4) then   XLSX_BUILDER_PKG.cell( 4, x.ord, l_4, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
                  else   XLSX_BUILDER_PKG.cell( 4, x.ord, to_number(l_4), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_4)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   end if;

   if not f_num(l_5) then   XLSX_BUILDER_PKG.cell( 5, x.ord, l_5, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
                  else   XLSX_BUILDER_PKG.cell( 5, x.ord, to_number(l_5), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_5)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   end if;

   if not f_num(l_6) then   XLSX_BUILDER_PKG.cell( 6, x.ord, l_6, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
                  else   XLSX_BUILDER_PKG.cell( 6, x.ord, to_number(l_6), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_6)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   end if;

   if not f_num(l_7) then   XLSX_BUILDER_PKG.cell( 7, x.ord, l_7, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
                  else   XLSX_BUILDER_PKG.cell( 7, x.ord, to_number(l_7), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_7)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   end if;

   if not f_num(l_8) then   XLSX_BUILDER_PKG.cell( 8, x.ord, l_8, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
                  else   XLSX_BUILDER_PKG.cell( 8, x.ord, to_number(l_8), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_8)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   end if;

   if not f_num(l_9) then   XLSX_BUILDER_PKG.cell( 9, x.ord, l_9, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
                  else   XLSX_BUILDER_PKG.cell( 9, x.ord, to_number(l_9), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_9)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   end if;

   if not f_num(l_10)  then   XLSX_BUILDER_PKG.cell( 10, x.ord, l_10, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
                   else   XLSX_BUILDER_PKG.cell( 10, x.ord, to_number(l_10), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_10)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   end if;

   if not f_num(l_11) then   XLSX_BUILDER_PKG.cell( 11, x.ord, l_11, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
                   else   XLSX_BUILDER_PKG.cell( 11, x.ord, to_number(l_11), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_11)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   end if;

   if not f_num(l_12) then   XLSX_BUILDER_PKG.cell( 12, x.ord, l_12, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
                   else   XLSX_BUILDER_PKG.cell( 12, x.ord, to_number(l_12), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_12)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   end if;

   else null;
   end if;

 end loop;





XLSX_BUILDER_PKG.set_column_width(1, 11.9);
XLSX_BUILDER_PKG.set_column_width(2, 46.76);

end;


procedure rez_table2 (p_dat date default trunc(sysdate,'MM') )
as
i int := 0;
sTmp varchar2(254);
l_3  varchar2(254);  l_4  varchar2(254); l_5  varchar2(254);
l_6  varchar2(254);  l_7  varchar2(254); l_8  varchar2(254);
l_9  varchar2(254);  l_10 varchar2(254); l_11 varchar2(254);
l_12 varchar2(254);  l_13  varchar2(254);  l_14 varchar2(254); l_15 varchar2(254);
l_fillId  pls_integer;

begin


XLSX_BUILDER_PKG.new_sheet('Таблиця2');
XLSX_BUILDER_PKG.PAGE_LAYOUT(P_PAPERSIZE => 9, P_FITTOWIDTH => 1, P_FITTOHEIGHT => 0, P_ORIENTATION => 'landscape');  -- Параметри сторінки
XLSX_BUILDER_PKG.page_definedName(p_row_tl=> 5, p_row_br=> 7);
XLSX_BUILDER_PKG.freeze_rows(p_nr_rows =>7);

XLSX_BUILDER_PKG.mergecells( 12, 1, 15, 1 );
XLSX_BUILDER_PKG.cell( 12, 1, 'Таблиця 2', p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'right') );
XLSX_BUILDER_PKG.mergecells( 12, 2, 15, 2 );
XLSX_BUILDER_PKG.cell( 12, 2, 'ТЕСТОВИЙ РЕЖИМ', p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'left') );
XLSX_BUILDER_PKG.mergecells( 1, 3, 15, 3 );
XLSX_BUILDER_PKG.SET_ROW_HEIGHT(3, 36.75);
XLSX_BUILDER_PKG.cell( 1, 3, 'Звіт про визначення банками України розміру кредитного ризику за активними банківськими операціями, що оцінюються на груповій основі
за станом на '||to_char(p_dat,'dd.mm.yyyy')||' року.', p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,14,1,false, true,true ) );
XLSX_BUILDER_PKG.cell( 15, 4, '(копійки)', p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'right') );



XLSX_BUILDER_PKG.cell( 1, 5, '№ з/п', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 1, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.mergecells( 1, 5, 1, 6 );
XLSX_BUILDER_PKG.cell( 2, 5, 'Назва показника ', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 2, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.mergecells( 2, 5, 2, 6 );

XLSX_BUILDER_PKG.cell( 3, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 3, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 4, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 4, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 5, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 5, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 6, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 6, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 7, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 7, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 8, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 8, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 9, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 9, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 10, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 10, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 11, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 11, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 12, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 12, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 13, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 13, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 14, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 14, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 15, 5, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 15, 6, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );




XLSX_BUILDER_PKG.mergecells( 3, 5, 4, 5 );
XLSX_BUILDER_PKG.cell( 3, 5, 'Борг за активом', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
XLSX_BUILDER_PKG.cell( 3, 6, 'Усього', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
XLSX_BUILDER_PKG.cell( 4, 6, 'у т.ч. нараховані доходи', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));


XLSX_BUILDER_PKG.mergecells( 5, 5, 11, 5 );
XLSX_BUILDER_PKG.cell( 5, 5, 'Рівень повернення боргу за рахунок реалізації застави ', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
XLSX_BUILDER_PKG.cell( 5, 6, 'Усього', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
XLSX_BUILDER_PKG.cell( 6, 6, 'у т.ч. із рівнем покриття боргу заставою <= 20% або за відсутності застави', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
XLSX_BUILDER_PKG.cell( 7, 6, 'у т.ч. із рівнем покриття боргу заставою від 20% до 40%', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
XLSX_BUILDER_PKG.cell( 8, 6, 'у т.ч. із рівнем покриття боргу заставою від 40% до 60%', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
XLSX_BUILDER_PKG.cell( 9, 6, 'у т.ч. із рівнем покриття боргу заставою від 60% до 80%', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
XLSX_BUILDER_PKG.cell( 10, 6, 'у т.ч. із рівнем покриття боргу заставою від 80% до 100%', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
XLSX_BUILDER_PKG.cell( 11, 6, 'у т.ч. із рівнем покриття боргу заставою >= 100%', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
XLSX_BUILDER_PKG.mergecells( 12, 5, 12, 6 );
XLSX_BUILDER_PKG.cell( 12, 5, 'Розмір кредитного ризику за активами (CR)', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
XLSX_BUILDER_PKG.mergecells( 13, 5, 13, 6 );
XLSX_BUILDER_PKG.cell( 13, 5, 'Розмір резерву за активами згідно з МСФЗ', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
XLSX_BUILDER_PKG.mergecells( 14, 5, 14, 6 );
XLSX_BUILDER_PKG.cell( 14, 5, 'Різниця між розміром кредитного ризику та розміром резерву за МСФЗ', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
XLSX_BUILDER_PKG.mergecells( 15, 5, 15, 6 );
XLSX_BUILDER_PKG.cell( 15, 5, 'Розмір кредитного ризику за активами згідно з  Положенням № 23', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));

XLSX_BUILDER_PKG.SET_ROW_HEIGHT(5, 31.75);
XLSX_BUILDER_PKG.SET_ROW_HEIGHT(6, 78.75);


XLSX_BUILDER_PKG.cell( 1, 7, '1', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 2, 7, '2', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 3, 7, '3', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 4, 7, '4', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 5, 7, '5', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 6, 7, '6', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 7, 7, '7', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 8, 7, '8', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 9, 7, '9', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 10, 7, '10', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 11, 7, '11', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 12, 7, '12', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 13, 7, '13', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 14, 7, '14', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );
XLSX_BUILDER_PKG.cell( 15, 7, '15', p_borderId => XLSX_BUILDER_PKG.get_border( 'medium', 'medium', 'medium', 'medium' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') );

XLSX_BUILDER_PKG.set_column_width(3, 7.29);
XLSX_BUILDER_PKG.set_column_width(4, 10.43);
XLSX_BUILDER_PKG.set_column_width(5, 6.9);
XLSX_BUILDER_PKG.set_column_width(6, 17.43);
XLSX_BUILDER_PKG.set_column_width(7, 16.00);
XLSX_BUILDER_PKG.set_column_width(8, 15.69);
XLSX_BUILDER_PKG.set_column_width(9, 15.43);
XLSX_BUILDER_PKG.set_column_width(10, 15.29);
XLSX_BUILDER_PKG.set_column_width(11, 15.71);
XLSX_BUILDER_PKG.set_column_width(12, 13.57);
XLSX_BUILDER_PKG.set_column_width(13, 11.14);
XLSX_BUILDER_PKG.set_column_width(14, 16.00);
XLSX_BUILDER_PKG.set_column_width(15, 13.77);


 --- Цикл по даним.
 for x in (select * from REZ_XLS_REF where sheet = 2 order by ord)
 loop

   if  x.tips = 1 then
   XLSX_BUILDER_PKG.mergecells( 1, x.ord, 12, x.ord );
   XLSX_BUILDER_PKG.cell( 1, x.ord, x.name, p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'left',true));
   XLSX_BUILDER_PKG.cell( 12, x.ord, '',p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'left',true));
   elsif x.tips = 2 then
      XLSX_BUILDER_PKG.cell( 1, x.ord, x.pn, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
      XLSX_BUILDER_PKG.cell( 2, x.ord, x.name, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'left',true), p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,12,1,false, true,true ) );
        l_3 := null; l_4 := null; l_5 := null; l_6 := null; l_7 := null; l_8 := null; l_9 := null; l_10 := null; l_11 := null; l_12 := null; l_13 := null; l_14 := null; l_15 := null;
   XLSX_BUILDER_PKG.cell( 3, x.ord, l_3, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   XLSX_BUILDER_PKG.cell( 4, x.ord, l_4, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   XLSX_BUILDER_PKG.cell( 5, x.ord, l_5, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   XLSX_BUILDER_PKG.cell( 6, x.ord, l_6, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   XLSX_BUILDER_PKG.cell( 7, x.ord, l_7, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   XLSX_BUILDER_PKG.cell( 8, x.ord, l_8, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   XLSX_BUILDER_PKG.cell( 9, x.ord, l_9, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   XLSX_BUILDER_PKG.cell( 10, x.ord, l_10, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   XLSX_BUILDER_PKG.cell( 11, x.ord, l_11, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   XLSX_BUILDER_PKG.cell( 12, x.ord, l_12, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));

   XLSX_BUILDER_PKG.cell( 13, x.ord, l_13, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   XLSX_BUILDER_PKG.cell( 14, x.ord, l_14, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   XLSX_BUILDER_PKG.cell( 15, x.ord, l_15, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));

   elsif x.tips = 0 then


    if  length(x.pn) = 3 then
	   --l_fillId :=XLSX_BUILDER_PKG.get_fill( 'solid', p_fgRGB => 'E2EFDA' );
         if x.ord in (268)     then l_fillId :=XLSX_BUILDER_PKG.get_fill( 'solid', p_fgRGB => 'FEEBA8' );
                               else l_fillId :=XLSX_BUILDER_PKG.get_fill( 'solid', p_fgRGB => 'E2EFDA' );
         end if;
      XLSX_BUILDER_PKG.cell( 1, x.ord, x.pn, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true), p_fillId => l_fillId);
      XLSX_BUILDER_PKG.cell( 2, x.ord, x.name, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'left',true), p_fillId => l_fillId);
    else
      XLSX_BUILDER_PKG.cell( 1, x.ord, x.pn, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
      XLSX_BUILDER_PKG.cell( 2, x.ord, x.name, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'left',true));
    end if;

        l_3 := null; l_4 := null; l_5 := null; l_6 := null; l_7 := null; l_8 := null; l_9 := null; l_10 := null; l_11 := null; l_12 := null; l_13 := null; l_14 := null; l_15 := null;

     Case when DBMS_LOB.GETLENGTH (x.txt_sql) >0 then
       begin
          execute immediate x.txt_sql into l_3, l_4, l_5, l_6, l_7, l_8, l_9,l_10, l_11, l_12 ,l_13, l_14, l_15;  --using IDF_, DAT_, OKPO_, FM_;
		        l_3 :=nvl(l_3,'0');  l_4 :=nvl(l_4,'0'); l_5  :=nvl(l_5,'0');  l_6  :=nvl(l_6,'0');   l_7 :=nvl(l_7,'0');
				l_8 :=nvl(l_8,'0');  l_9 :=nvl(l_9,'0'); l_10 :=nvl(l_10,'0'); l_11 :=nvl(l_11,'0');  l_12 :=nvl(l_12,'0');
				l_13 :=nvl(l_13,'0'); l_14 :=nvl(l_14,'0');  l_15 :=nvl(l_15,'0');

          exception when NO_DATA_FOUND  THEN  null;
                    when others then
                    raise_application_error(-(20000),'/' ||'     '||'Помилка формули  ord= '||x.ord||'   '||x.txt_sql,TRUE);
					null;
         end;
     else null;
     end case;

         --L_5 := 'X';

   if not f_num(l_3)  then   XLSX_BUILDER_PKG.cell( 3, x.ord, l_3, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
                  else   XLSX_BUILDER_PKG.cell( 3, x.ord, to_number(l_3), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_3)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   end if;

   if not f_num(l_4)  then   XLSX_BUILDER_PKG.cell( 4, x.ord, l_4, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
                  else   XLSX_BUILDER_PKG.cell( 4, x.ord, to_number(l_4), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_4)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   end if;

   if not f_num(l_5)  then   XLSX_BUILDER_PKG.cell( 5, x.ord, l_5, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
                  else   XLSX_BUILDER_PKG.cell( 5, x.ord, to_number(l_5), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_5)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   end if;

   if not f_num(l_6)  then   XLSX_BUILDER_PKG.cell( 6, x.ord, l_6, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
                  else   XLSX_BUILDER_PKG.cell( 6, x.ord, to_number(l_6), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_6)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   end if;

   if not f_num(l_7)  then   XLSX_BUILDER_PKG.cell( 7, x.ord, l_7, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
                  else   XLSX_BUILDER_PKG.cell( 7, x.ord, to_number(l_7), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_7)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   end if;

   if not f_num(l_8)  then   XLSX_BUILDER_PKG.cell( 8, x.ord, l_8, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
                  else   XLSX_BUILDER_PKG.cell( 8, x.ord, to_number(l_8), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_8)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   end if;

   if not f_num(l_9)  then   XLSX_BUILDER_PKG.cell( 9, x.ord, l_9, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
                  else   XLSX_BUILDER_PKG.cell( 9, x.ord, to_number(l_9), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_9)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   end if;

   if not f_num(l_10)  then   XLSX_BUILDER_PKG.cell( 10, x.ord, l_10, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
                   else   XLSX_BUILDER_PKG.cell( 10, x.ord, to_number(l_10), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_10)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   end if;

   if not f_num(l_11)  then   XLSX_BUILDER_PKG.cell( 11, x.ord, l_11, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
                   else   XLSX_BUILDER_PKG.cell( 11, x.ord, to_number(l_11), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_11)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   end if;

   if not f_num(l_12)  then   XLSX_BUILDER_PKG.cell( 12, x.ord, l_12, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
                   else   XLSX_BUILDER_PKG.cell( 12, x.ord, to_number(l_12), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_12)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   end if;

   if not f_num(l_13)  then   XLSX_BUILDER_PKG.cell( 13, x.ord, l_13, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
                   else   XLSX_BUILDER_PKG.cell( 13, x.ord, to_number(l_13), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_13)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   end if;

   if not f_num(l_14)  then   XLSX_BUILDER_PKG.cell( 14, x.ord, l_14, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
                   else   XLSX_BUILDER_PKG.cell( 14, x.ord, to_number(l_14), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_14)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   end if;

   if not f_num(l_15)  then   XLSX_BUILDER_PKG.cell( 15, x.ord, l_15, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
                   else   XLSX_BUILDER_PKG.cell( 15, x.ord, to_number(l_15), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_15)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true));
   end if;
   else null;
   end if;

 end loop;





XLSX_BUILDER_PKG.set_column_width(1, 6.43);
XLSX_BUILDER_PKG.set_column_width(2, 23.76);

end;



procedure rez_table3 (p_dat date default trunc(sysdate,'MM') )
as
i int := 0;
sTmp varchar2(254);
l_3  varchar2(254);  l_4  varchar2(254); l_5  varchar2(254);
l_6  varchar2(254);  l_7  varchar2(254); l_8  varchar2(254);
l_9  varchar2(254);  l_10 varchar2(254); l_11 varchar2(254);
l_12 varchar2(254);
l_fillId  pls_integer;
l_fontId  pls_integer;

begin


XLSX_BUILDER_PKG.new_sheet('Таблиця3');
XLSX_BUILDER_PKG.PAGE_LAYOUT(P_PAPERSIZE => 9, P_FITTOWIDTH => 1, P_FITTOHEIGHT => 0, P_ORIENTATION => 'landscape');  -- Параметри сторінки

XLSX_BUILDER_PKG.mergecells( 9, 1, 11, 1 );
XLSX_BUILDER_PKG.cell( 9, 1, 'Таблиця 3', p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'right') );
XLSX_BUILDER_PKG.mergecells( 9, 2, 11, 2 );
XLSX_BUILDER_PKG.cell( 9, 2, 'ТЕСТОВИЙ РЕЖИМ', p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'left') );
XLSX_BUILDER_PKG.mergecells( 1, 3, 11, 3 );
XLSX_BUILDER_PKG.SET_ROW_HEIGHT(3, 36.75);
XLSX_BUILDER_PKG.cell( 1, 3, 'Дані щодо економічних нормативів з урахуванням кредитного ризику за активними банківськими операціями
за станом на '||to_char(p_dat,'dd.mm.yyyy')||' року.', p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true) , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,14,1,false, true,true ) );

l_fillId :=XLSX_BUILDER_PKG.get_fill( 'solid', p_fgRGB => 'D9D9D9' );
l_fontId :=XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,9,1,false, false,false );
  for k in 4..9
  loop
   XLSX_BUILDER_PKG.cell( 1, k, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') , p_fillId => l_fillId , p_fontId=>l_fontId);
   XLSX_BUILDER_PKG.cell( 2, k, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') , p_fillId => l_fillId , p_fontId=>l_fontId);
   XLSX_BUILDER_PKG.cell( 3, k, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') , p_fillId => l_fillId , p_fontId=>l_fontId);
   XLSX_BUILDER_PKG.cell( 4, k, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') , p_fillId => l_fillId , p_fontId=>l_fontId);
   XLSX_BUILDER_PKG.cell( 5, k, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') , p_fillId => l_fillId , p_fontId=>l_fontId);
   XLSX_BUILDER_PKG.cell( 6, k, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') , p_fillId => l_fillId , p_fontId=>l_fontId);
   XLSX_BUILDER_PKG.cell( 7, k, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') , p_fillId => l_fillId , p_fontId=>l_fontId);
   XLSX_BUILDER_PKG.cell( 8, k, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') , p_fillId => l_fillId , p_fontId=>l_fontId);
   XLSX_BUILDER_PKG.cell( 9, k, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') , p_fillId => l_fillId , p_fontId=>l_fontId);
   XLSX_BUILDER_PKG.cell( 10, k, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center'), p_fillId => l_fillId , p_fontId=>l_fontId);
   XLSX_BUILDER_PKG.cell( 11, k, '', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center'), p_fillId => l_fillId , p_fontId=>l_fontId);
 end loop;
XLSX_BUILDER_PKG.SET_ROW_HEIGHT(8, 46.75);

XLSX_BUILDER_PKG.cell( 1, 4, '№ '||chr(13)||'з/п', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center', true) ,p_fillId => l_fillId , p_fontId=>l_fontId);
XLSX_BUILDER_PKG.mergecells( 1, 4, 1, 9 );

XLSX_BUILDER_PKG.cell( 2, 4, 'Розрахунки ', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') ,p_fillId => l_fillId , p_fontId=>l_fontId);
XLSX_BUILDER_PKG.mergecells( 2, 4, 2, 9 );

XLSX_BUILDER_PKG.mergecells( 3, 4, 3, 8 );
XLSX_BUILDER_PKG.cell( 3, 4, 'Загальний розмір активів, за якими здійснюється оцінка кредитного ризику  ', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true),p_fillId => l_fillId , p_fontId=>l_fontId);
XLSX_BUILDER_PKG.cell( 3, 9, 'копійки', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true), p_fillId => l_fillId ,p_fontId=>l_fontId);

XLSX_BUILDER_PKG.mergecells( 4, 5, 4, 8 );
XLSX_BUILDER_PKG.cell( 4, 4, 'КР ', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true),p_fillId => l_fillId , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,9,1,false, true,true ));
XLSX_BUILDER_PKG.cell( 4, 5, 'розмір (величина) кредитного ризику за всіма активними операціями', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true),p_fillId => l_fillId , p_fontId=>l_fontId);
XLSX_BUILDER_PKG.cell( 4, 9, 'копійки', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true),p_fillId => l_fillId , p_fontId=>l_fontId);

XLSX_BUILDER_PKG.mergecells( 5, 5, 5, 8 );
XLSX_BUILDER_PKG.cell( 5, 4, 'Резерви ', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true),p_fillId => l_fillId , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,9,1,false, true,true ));
XLSX_BUILDER_PKG.cell( 5, 5, 'резерви за МСФЗ  за всіма активними операціями', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true),p_fillId => l_fillId , p_fontId=>l_fontId);
XLSX_BUILDER_PKG.cell( 5, 9, 'копійки', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true),p_fillId => l_fillId , p_fontId=>l_fontId);

XLSX_BUILDER_PKG.mergecells( 6, 5, 6, 8 );
XLSX_BUILDER_PKG.cell( 6, 4, 'НКР ', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true),p_fillId => l_fillId , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,9,1,false, true,true ));
XLSX_BUILDER_PKG.cell( 6, 5, 'розмір (величина) непокритого кредитного ризику', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true),p_fillId => l_fillId , p_fontId=>l_fontId);
XLSX_BUILDER_PKG.cell( 6, 9, 'копійки', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true),p_fillId => l_fillId , p_fontId=>l_fontId);

XLSX_BUILDER_PKG.mergecells( 7, 4, 8, 4 );
XLSX_BUILDER_PKG.cell( 7, 4, 'Нормативи капіталу', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true),p_fillId => l_fillId , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,9,1,false, true,true ));
XLSX_BUILDER_PKG.mergecells( 7, 6, 7, 8 );
XLSX_BUILDER_PKG.cell( 7, 5, 'Н1', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true),p_fillId => l_fillId , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,9,1,false, true,true ));
XLSX_BUILDER_PKG.cell( 7, 6, 'мінімального розміру регулятивного капіталу', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true),p_fillId => l_fillId , p_fontId=>l_fontId);
XLSX_BUILDER_PKG.cell( 7, 9, 'копійки', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true),p_fillId => l_fillId , p_fontId=>l_fontId);

XLSX_BUILDER_PKG.mergecells( 8, 6, 8, 8 );
XLSX_BUILDER_PKG.cell( 8, 5, 'Н2', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true),p_fillId => l_fillId , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,9,1,false, true,true ));
XLSX_BUILDER_PKG.cell( 8, 6, 'достатності (адекватності) регулятивного капіталу', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true),p_fillId => l_fillId , p_fontId=>l_fontId);
XLSX_BUILDER_PKG.cell( 8, 9, '%', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true),p_fillId => l_fillId , p_fontId=>l_fontId);


XLSX_BUILDER_PKG.mergecells( 9, 4, 11, 4 );
XLSX_BUILDER_PKG.cell( 9, 4, 'Нормативи кредитного ризику', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true),p_fillId => l_fillId , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,9,1,false, true,true ));
XLSX_BUILDER_PKG.mergecells( 9, 6, 9, 8 );
XLSX_BUILDER_PKG.cell( 9, 5, 'Н7', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true),p_fillId => l_fillId , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,9,1,false, true,true ));
XLSX_BUILDER_PKG.cell( 9, 6, 'максимального розміру кредитного ризику на одного контрагента', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true),p_fillId => l_fillId , p_fontId=>l_fontId);
XLSX_BUILDER_PKG.cell( 9, 9, '%', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true),p_fillId => l_fillId , p_fontId=>l_fontId);

XLSX_BUILDER_PKG.mergecells( 10, 6, 10, 8 );
XLSX_BUILDER_PKG.cell( 10, 5, 'Н8', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true),p_fillId => l_fillId , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,9,1,false, true,true ));
XLSX_BUILDER_PKG.cell( 10, 6, 'великих кредитних ризиків', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true),p_fillId => l_fillId , p_fontId=>l_fontId);
XLSX_BUILDER_PKG.cell( 10, 9, '%', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true),p_fillId => l_fillId , p_fontId=>l_fontId);

XLSX_BUILDER_PKG.mergecells( 11, 6, 11, 8 );
XLSX_BUILDER_PKG.cell( 11, 5, 'Н9', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true),p_fillId => l_fillId , p_fontId=> XLSX_BUILDER_PKG.get_font( 'Times New Roman', 2,9,1,false, true,true ));
XLSX_BUILDER_PKG.cell( 11, 6, 'максимального розміру кредитного ризику за операціями з пов''язаними з банком особами', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true),p_fillId => l_fillId , p_fontId=>l_fontId);
XLSX_BUILDER_PKG.cell( 11, 9, '%', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true),p_fillId => l_fillId , p_fontId=>l_fontId);

/* ************************************************** */



XLSX_BUILDER_PKG.cell( 1, 10, '1', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') , p_fillId => l_fillId , p_fontId=>l_fontId);
XLSX_BUILDER_PKG.cell( 2, 10, '2', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') , p_fillId => l_fillId , p_fontId=>l_fontId);
XLSX_BUILDER_PKG.cell( 3, 10, '3', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') , p_fillId => l_fillId , p_fontId=>l_fontId);
XLSX_BUILDER_PKG.cell( 4, 10, '4', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') , p_fillId => l_fillId , p_fontId=>l_fontId);
XLSX_BUILDER_PKG.cell( 5, 10, '5', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') , p_fillId => l_fillId , p_fontId=>l_fontId);
XLSX_BUILDER_PKG.cell( 6, 10, '6', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') , p_fillId => l_fillId , p_fontId=>l_fontId);
XLSX_BUILDER_PKG.cell( 7, 10, '7', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') , p_fillId => l_fillId , p_fontId=>l_fontId);
XLSX_BUILDER_PKG.cell( 8, 10, '8', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') , p_fillId => l_fillId , p_fontId=>l_fontId);
XLSX_BUILDER_PKG.cell( 9, 10, '9', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') , p_fillId => l_fillId , p_fontId=>l_fontId);
XLSX_BUILDER_PKG.cell( 10, 10, '10', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') , p_fillId => l_fillId , p_fontId=>l_fontId);
XLSX_BUILDER_PKG.cell( 11, 10, '11', p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center') , p_fillId => l_fillId , p_fontId=>l_fontId);


XLSX_BUILDER_PKG.set_column_width(3, 13.80);
XLSX_BUILDER_PKG.set_column_width(4, 10.57);
XLSX_BUILDER_PKG.set_column_width(5, 13.29);
XLSX_BUILDER_PKG.set_column_width(6, 12.90);
XLSX_BUILDER_PKG.set_column_width(7, 12.90);
XLSX_BUILDER_PKG.set_column_width(8, 15.86);

XLSX_BUILDER_PKG.set_column_width(9, 10.75);
XLSX_BUILDER_PKG.set_column_width(10, 17.57);
XLSX_BUILDER_PKG.set_column_width(11, 9.43);



 --- Цикл по даним.
 for x in (select * from REZ_XLS_REF where sheet = 3 order by ord)
 loop

   if  x.tips = 1 then
   XLSX_BUILDER_PKG.mergecells( 1, x.ord, 12, x.ord );
   XLSX_BUILDER_PKG.cell( 1, x.ord, x.name,p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'left',true));
   XLSX_BUILDER_PKG.cell( 12, x.ord, '',p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'left',true));
   elsif x.tips = 0 then



    if x.ord in (11, 13)   then l_fillId :=XLSX_BUILDER_PKG.get_fill( 'solid', p_fgRGB => 'D9D9D9' );
                           else l_fillId :=null;
    end if;

     XLSX_BUILDER_PKG.cell( 1, x.ord, x.pn, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true), p_fillId => l_fillId , p_fontId=>l_fontId);
     XLSX_BUILDER_PKG.cell( 2, x.ord, x.name, p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'left',true), p_fillId => l_fillId , p_fontId=>l_fontId);


        l_3 := null; l_4 := null; l_5 := null; l_6 := null; l_7 := null; l_8 := null; l_9 := null; l_10 := null; l_11 := null; l_12 := null;
   		  		l_3 :=nvl(l_3,'0');  l_4 :=nvl(l_4,'0'); l_5  :=nvl(l_5,'0');  l_6  :=nvl(l_6,'0');   l_7 :=nvl(l_7,'0');
				l_8 :=nvl(l_8,'0');  l_9 :=nvl(l_9,'0'); l_10 :=nvl(l_10,'0'); l_11 :=nvl(l_11,'0');
     Case when DBMS_LOB.GETLENGTH (x.txt_sql) >0 then
       begin
          execute immediate x.txt_sql into l_3, l_4, l_5, l_6, l_7, l_8, l_9,l_10, l_11; --using IDF_, DAT_, OKPO_, FM_;
		  		l_3 :=nvl(l_3,'0');  l_4 :=nvl(l_4,'0'); l_5  :=nvl(l_5,'0');  l_6  :=nvl(l_6,'0');   l_7 :=nvl(l_7,'0');
				l_8 :=nvl(l_8,'0');  l_9 :=nvl(l_9,'0'); l_10 :=nvl(l_10,'0'); l_11 :=nvl(l_11,'0');
          exception when NO_DATA_FOUND  THEN  null;
                    when others then
                    raise_application_error(-(20000),'/' ||'     '||'Помилка формули  Sheet="'||x.name_sheet||'" ord= '||x.ord||'   '||x.txt_sql,TRUE);
					null;
         end;
     else null;
     end case;

         --L_5 := 'X';

   if not f_num(l_3)  then   XLSX_BUILDER_PKG.cell( 3, x.ord, l_3, p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( '#0'), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true), p_fillId => l_fillId , p_fontId=>l_fontId);
                  else   XLSX_BUILDER_PKG.cell( 3, x.ord, to_number(l_3), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_3)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true), p_fillId => l_fillId , p_fontId=>l_fontId);
   end if;

   if not f_num(l_4)  then   XLSX_BUILDER_PKG.cell( 4, x.ord, l_4, p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( '#0'), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true), p_fillId => l_fillId , p_fontId=>l_fontId);
                  else   XLSX_BUILDER_PKG.cell( 4, x.ord, to_number(l_4), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_4)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true), p_fillId => l_fillId , p_fontId=>l_fontId);
   end if;

   if not f_num(l_5)  then   XLSX_BUILDER_PKG.cell( 5, x.ord, l_5, p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( '#0'), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true), p_fillId => l_fillId , p_fontId=>l_fontId);
                  else   XLSX_BUILDER_PKG.cell( 5, x.ord, to_number(l_5), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_5)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true), p_fillId => l_fillId , p_fontId=>l_fontId);
   end if;

   if not f_num(l_6)  then   XLSX_BUILDER_PKG.cell( 6, x.ord, l_6, p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( '#0'), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true), p_fillId => l_fillId , p_fontId=>l_fontId);
                  else   XLSX_BUILDER_PKG.cell( 6, x.ord, to_number(l_6), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_6)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true), p_fillId => l_fillId , p_fontId=>l_fontId);
   end if;

   if not f_num(l_7)  then   XLSX_BUILDER_PKG.cell( 7, x.ord, l_7, p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( '#0'), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true), p_fillId => l_fillId , p_fontId=>l_fontId);
                  else   XLSX_BUILDER_PKG.cell( 7, x.ord, to_number(l_7), p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0',length(l_7)+2,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true), p_fillId => l_fillId , p_fontId=>l_fontId);
   end if;

   if not f_num(l_8)  then   XLSX_BUILDER_PKG.cell( 8, x.ord, l_8, p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( '0.00%'), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true), p_fillId => l_fillId , p_fontId=>l_fontId);
                  else   XLSX_BUILDER_PKG.cell( 8, x.ord, to_number(l_8)/100, p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0.0#%',length(l_8)+5,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true), p_fillId => l_fillId , p_fontId=>l_fontId);
   end if;

   if not f_num(l_9)  then   XLSX_BUILDER_PKG.cell( 9, x.ord, l_9, p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( '0.00%'), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true), p_fillId => l_fillId , p_fontId=>l_fontId);
                  else   XLSX_BUILDER_PKG.cell( 9, x.ord, to_number(l_9)/100, p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0.0#%',length(l_9)+5,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true), p_fillId => l_fillId , p_fontId=>l_fontId);
   end if;

   if not f_num(l_10)  then   XLSX_BUILDER_PKG.cell( 10, x.ord, l_10, p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( '0.00%'), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true), p_fillId => l_fillId , p_fontId=>l_fontId);
                   else   XLSX_BUILDER_PKG.cell( 10, x.ord, to_number(l_10)/100, p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0.0#%',length(l_10)+5,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true), p_fillId => l_fillId , p_fontId=>l_fontId);
   end if;

   if not f_num(l_11)  then   XLSX_BUILDER_PKG.cell( 11, x.ord, l_11, p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( '0.00%'), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true), p_fillId => l_fillId , p_fontId=>l_fontId);
                   else   XLSX_BUILDER_PKG.cell( 11, x.ord, to_number(l_11)/100, p_numFmtId => XLSX_BUILDER_PKG.get_numFmt( lpad('#0.0#%',length(l_11)+5,'#') ), p_borderId => XLSX_BUILDER_PKG.get_border( 'thin', 'thin', 'thin', 'thin' ),p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT('center', 'center',true), p_fillId => l_fillId , p_fontId=>l_fontId);
   end if;


   else null;
   end if;

 end loop;





XLSX_BUILDER_PKG.set_column_width(1, 2.99);
XLSX_BUILDER_PKG.set_column_width(2, 32.76);

end;



procedure rez_rep (p_dat date default trunc(sysdate,'MM') )
as
l_blob blob;
begin
pul.Set_Mas_Ini('sFdat1', to_char(p_dat,'dd.mm.yyyy'), '');

delete from rez_xls_gt;
insert into rez_xls_gt (  TIPA, ACC, NLS, KV, FIN, EAD, EADQ, BV, BVQ, ND, EAD_SN, EAD_SNQ, EAD_CCF, EAD_CCFQ, ZAL, ZALQ, RC, RCQ, CR, CRQ, REZ39, REZQ39, REZ23, REZQ23, ISTVAL, CCF, G6, DEL, S250, CUSTTYPE, DD, DDD, NBS, RZ, pd_0,RPB, X6, X7, X8, X9, X10, X11)
select  TIPA, ACC, NLS, KV, FIN, EAD, EADQ, BV, BVQ, ND, EAD_SN, EAD_SNQ, EAD_CCF, EAD_CCFQ, ZAL, ZALQ, RC, RCQ, CR, CRQ, REZ39, REZQ39, REZ23, REZQ23, ISTVAL, CCF, G6, DEL, S250, CUSTTYPE, DD, DDD, NBS, RZ, pd_0, RPB, X6, X7, X8, X9, X10, X11 from v_tab_1;
rez_table1(p_dat);
rez_table2(p_dat);
rez_table3(p_dat);
commit;
end;

procedure rez_rep_dir (p_dat date default trunc(sysdate,'MM') )
as
l_blob blob;
begin
pul.Set_Mas_Ini('sFdat1', to_char(p_dat,'dd.mm.yyyy'), '');
delete from rez_xls_gt;
insert into rez_xls_gt (  TIPA, ACC, NLS, KV, FIN, EAD, EADQ, BV, BVQ, ND, EAD_SN, EAD_SNQ, EAD_CCF, EAD_CCFQ, ZAL, ZALQ, RC, RCQ, CR, CRQ, REZ39, REZQ39, REZ23, REZQ23, ISTVAL, CCF, G6, DEL, S250, CUSTTYPE, DD, DDD, NBS, RZ, pd_0,RPB, X6, X7, X8, X9, X10, X11)
select  TIPA, ACC, NLS, KV, FIN, EAD, EADQ, BV, BVQ, ND, EAD_SN, EAD_SNQ, EAD_CCF, EAD_CCFQ, ZAL, ZALQ, RC, RCQ, CR, CRQ, REZ39, REZQ39, REZ23, REZQ23, ISTVAL, CCF, G6, DEL, S250, CUSTTYPE, DD, DDD, NBS, RZ, pd_0, RPB, X6, X7, X8, X9, X10, X11 from v_tab_1;

rez_table1(p_dat);
rez_table2(p_dat);
rez_table3(p_dat);
XLSX_BUILDER_PKG.save( 'FIN351', 'my_'||to_char(p_dat,'yyyymmdd')||'.xlsx' );
commit;

end;


function  export_to_script  return blob
  is
       nlchr      char(2) := chr(13)||chr(10);
       l_txt      varchar2(32000);
       l_REZ_XLS_REF  REZ_XLS_REF%rowtype;
       l_clob     blob;
       p_clob_scrpt blob;
       l_ number;

   TYPE EmpCurTyp IS REF CURSOR;
   emp_cv   EmpCurTyp;

begin

       p_clob_scrpt:= null;
       dbms_lob.createtemporary(l_clob,  FALSE);


       l_txt:=       'prompt ===================================== '||nlchr ;
       l_txt:=l_txt||'prompt == REZ_XLS_REF'                        ||nlchr ;
       l_txt:=l_txt||'prompt ===================================== '||nlchr||nlchr;

       l_txt:=l_txt||'set serveroutput on'||nlchr ;
       l_txt:=l_txt||'set feed off       '||nlchr ;

       l_txt:=l_txt||'declare                               '||nlchr ;
       l_txt:=l_txt||nlchr ;

       l_txt:=l_txt||'   nlchr           char(2):=chr(13)||chr(10);'||nlchr ;
       l_txt:=l_txt||'   l_REZ_XLS_REF   REZ_XLS_REF%rowtype;    '||nlchr ;

       l_txt:=l_txt||'procedure get_date (p_REZ_XLS_REF REZ_XLS_REF%rowtype)'||nlchr ;
       l_txt:=l_txt||'as'||nlchr ;
       l_txt:=l_txt||'begin'||nlchr ;
       l_txt:=l_txt||'insert into REZ_XLS_REF values p_REZ_XLS_REF;'||nlchr ;
       l_txt:=l_txt||'exception when dup_val_on_index then'||nlchr ;
       l_txt:=l_txt||'    update REZ_XLS_REF'||nlchr ;
       l_txt:=l_txt||'       set row = p_REZ_XLS_REF'||nlchr ;
       l_txt:=l_txt||'     where sheet = p_REZ_XLS_REF.sheet'||nlchr ;
       l_txt:=l_txt||'       and ord   = p_REZ_XLS_REF.ord;  '||nlchr ;
       l_txt:=l_txt||'end; '||nlchr ;
       l_txt:=l_txt||'  '||nlchr ;
       l_txt:=l_txt||'Begin  '||nlchr ;



       dbms_lob.append(l_clob, UTL_RAW.CAST_TO_RAW(l_txt));
       l_txt:='';


   OPEN emp_cv FOR 'SELECT * FROM REZ_XLS_REF    order by sheet, ord';
   LOOP

      FETCH emp_cv INTO l_REZ_XLS_REF;
      EXIT WHEN emp_cv%NOTFOUND;
          l_REZ_XLS_REF.txt_sql :=  (replace((l_REZ_XLS_REF.txt_sql), chr(39), chr(39)||chr(39)));
          l_REZ_XLS_REF.txt_sql :=   replace (l_REZ_XLS_REF.txt_sql, nlchr, '''||nlchr||'||nlchr||'                           ''' );

          l_REZ_XLS_REF.name :=  (replace((l_REZ_XLS_REF.name), chr(39), chr(39)||chr(39)));
          l_REZ_XLS_REF.name :=   replace (l_REZ_XLS_REF.name, nlchr, '''||nlchr||'||nlchr||'                           ''' );

       l_txt:=l_txt||'l_REZ_XLS_REF.sheet := '||l_REZ_XLS_REF.sheet||';'||nlchr ;
       l_txt:=l_txt||'l_REZ_XLS_REF.ord := '||l_REZ_XLS_REF.ord||';'||nlchr ;

       l_txt:=l_txt||'l_REZ_XLS_REF.pn := '''||l_REZ_XLS_REF.pn||''';'||nlchr ;
       l_txt:=l_txt||'l_REZ_XLS_REF.name := '''||l_REZ_XLS_REF.name||''';'||nlchr ;
       l_txt:=l_txt||'l_REZ_XLS_REF.name_sheet := '''||l_REZ_XLS_REF.name_sheet||''';'||nlchr ;
       l_txt:=l_txt||'l_REZ_XLS_REF.fin := '||nvl(to_char(l_REZ_XLS_REF.fin),'null')||';'||nlchr ;
       l_txt:=l_txt||'l_REZ_XLS_REF.tips := '||nvl(to_char(l_REZ_XLS_REF.tips),'null')||';'||nlchr ;
       l_txt:=l_txt||'l_REZ_XLS_REF.txt_sql := '''||l_REZ_XLS_REF.txt_sql||''';'||nlchr ;
       l_txt:=l_txt||'get_date(l_REZ_XLS_REF);'||nlchr ;
	   l_txt:=l_txt||' '||nlchr ;
	   l_txt:=l_txt||' '||nlchr ;

       dbms_lob.append(l_clob, UTL_RAW.CAST_TO_RAW(l_txt));
       l_txt:='';


   END LOOP;

       l_txt:=l_txt||'end;                                        '||nlchr;
       l_txt:=l_txt||'/                                           '||nlchr;
       l_txt:=l_txt||'                                            '||nlchr;
       l_txt:=l_txt||'commit;                                     '||nlchr;

       dbms_lob.append(l_clob, UTL_RAW.CAST_TO_RAW(l_txt));
       p_clob_scrpt:=l_clob;
       return p_clob_scrpt;

end;


procedure trace (p_mod varchar2, p_msg varchar2)
as
begin

 if user_id in( 1, 20094) then   logger.info  (p_mod||' '||p_msg);
                                 --dbms_output.put_line(p_mod||' '||p_msg);
                          else   logger.trace (p_mod||' '||p_msg);
 end if;

end;

FUNCTION  bars_instr(str_ VARCHAR2, p_s varchar2) RETURN varchar2 IS
l_list varchar2(2000);
BEGIN
   IF str_ IS NULL THEN RETURN null; END IF;
   FOR i IN 1..LENGTH(str_) LOOP
      IF SUBSTR(str_,i,1) = p_s  THEN
         l_list := l_list || TO_CHAR(i) || ',';
      END IF;
   END LOOP;
   RETURN substr(l_list,1,length(l_list)-1);
END;

function load_rnk (l_rnk number) return number
as
n_rnk number;
l_okpo customer.okpo%type;
l_clas fin_rnk.s%type;
l_ipb  fin_rnk.s%type;
l_date_open date;
l_custtype customer.custtype%type;
l_fdat date;
begin

  for s in 1 .. t_deal.rnk.count()
    loop
          if t_deal.rnk(s).rnk = l_rnk
		    then n_rnk := s;
			     return n_rnk;
          end if;
    end loop;


   Select okpo   , date_on, custtype
     into l_okpo , l_date_open, l_custtype
	 from customer
	 where rnk = l_rnk;


  If l_custtype = 2 then

           select max(fdat)
		     into l_fdat
			 from fin_fm
			where okpo = l_okpo;

		   begin
			   select s
				 into l_clas
				 from fin_rnk
				where okpo = l_okpo
				  and kod = 'CLAS'
				  and idf = 6
				  and fdat = l_fdat;
		   exception when no_data_found then
			  null;
		   end;

		    begin
			   select s
				 into l_ipb
				 from fin_rnk
				where okpo = l_okpo
				  and kod = 'PIPB'
				  and idf = 6
				  and fdat = l_fdat;
		   exception when no_data_found then
			  null;
		   end;

  end if;



   n_rnk :=t_deal.rnk.count()+1;
   t_deal.rnk(n_rnk).rnk := l_rnk;
   t_deal.rnk(n_rnk).okpo := l_okpo;
   t_deal.rnk(n_rnk).clas := l_clas;
   t_deal.rnk(n_rnk).ipb  := l_ipb;
   t_deal.rnk(n_rnk).date_open := l_date_open;





   return n_rnk;


end;

	procedure get_nd_fin_param (p_rnk   number
							  , p_nd    number
							  , P_RW    VARCHAR2
							  , p_ovkr  out varchar2
							  , p_p_def out varchar2
							  , p_ovd   out varchar2
							  , p_opd   out varchar2
							  , p_kol23 out varchar2
							  , p_kol24 out varchar2
							  , p_kol25 out varchar2
							  , p_kol26 out varchar2
							  , p_kol27 out varchar2
							  , p_kol28 out varchar2
							  , p_kol29 out varchar2
							  , p_kol30 out varchar2
							  , p_fin_z out varchar2
							  , p_ipb   out number
							  , p_cls1  out varchar2
							  , p_cls2  out varchar2
								)
	as
	n_rnk number;
	n_nd number;
	l_col tr_col;
	l_    tr_p;
	l_tmp varchar2(500);
	l_rz number;
	l_kol number;
	l_kv number;
	l_custtype number;
	l_nbs varchar2(4); l_fin number; l_tipa number; l_idf number; l_pd_0 number;
	l_25  varchar2(1);
	l_24  varchar2(3);
	l_mod varchar2(32) := 'LOAD_ND';
	l_fdat date := nvl(g_fdat,trunc(sysdate,'MM'));
	l_p165_7_nr  pls_integer;
	begin

	 n_rnk := load_rnk (p_rnk);
     
     Select RZ, kol, kv, custtype, nbs, fin , tipa, idf, pd_0
		 into l_rz, l_kol , l_kv, l_custtype, l_nbs, l_fin, l_tipa, l_idf, l_pd_0
		 from rez_cr
		where ROWID = P_RW;

	 for s in 1 .. t_deal.rnk(n_rnk).nd.count()
		loop
		  if t_deal.rnk(n_rnk).nd(s).nd = p_nd then n_nd := s;
					  --trace(L_MOD, ' Дані є в колекції ND='||p_nd);
					  goto  get_update;
			  end if;
		end loop;
   
	   --trace(L_MOD, ' Вичитуємо дані ND='||p_nd);
	   n_nd :=t_deal.rnk(n_rnk).nd.count()+1;
	   t_deal.rnk(n_rnk).nd(n_nd).nd := p_nd;

   
    
	   
	 Begin


	 if l_custtype = 2 and  l_idf  = 50  then
		   Select --nd, rnk,
			  max(case when idf = 52  and kod = 'SKK'  then s else null end) p162_1,
			  max(case when idf = 52  and kod = 'KVZK' then s else null end) p162_3,
			  max(case when idf = 52  and kod = 'PVKZ' then s else null end) p162_4,
			  max(case when idf = 5   and kod = 'KP61'  then s else null end) p163_1,
			  --
			  max(case when idf = 52  and kod = 'KIKK' and s = 1 then s else 0 end) k25,
			  --
			  max(case when idf = 51  and kod = 'NGRK' and s = 1 then s else 0 end)||'0'||
			  max(case when idf = 51  and kod = 'NGRP' and s = 1 then s else 0 end) k24,
			  --
			  max(case when idf = 53  and kod = 'PD1'  then s else null end) p165_1,
			  max(case when idf = 53  and kod = 'PD2'  then s else null end) p165_2,
			  max(case when idf = 53  and kod = 'PD3'  then s else null end) p165_3,
			  max(case when idf = 53  and kod = 'PD4'  then s else null end) p165_4,
			  max(case when idf = 53  and kod = 'PD5'  then s else null end) p165_5,
			  max(case when idf = 53  and kod = 'PD6'  then s else null end) p165_6,
			  max(case when idf = 53  and kod = 'PD7'
								 and (s = 1 or s = 11) then 1 else    0 end) p165_7,
			  max(case when idf = 53  and kod = 'PD8'  then s else null end) p165_8,
			  max(case when idf = 53  and kod = 'PD9'  then s else null end) p165_9,
			  max(case when idf = 53  and kod = 'PD10' then s else null end) p165_10,
			  max(case when idf = 53  and kod = 'PD11' then s else null end) p165_11,
			  max(case when idf = 53  and kod = 'PD12' then s else null end) p165_12,
			  max(case when idf = 53  and kod in ('PD13','PD14') then s else null end) p165_13,
			  max(case when idf = 53  and kod = '' then s else null end) p165_14,
			  max(case when idf = 53  and kod = 'PD15' then s else null end) p165_15,
			  max(case when idf = 53  and kod = 'PD16' then s else null end) p165_16,
			  max(case when idf = 53  and kod in ('PD17','PD18','PD20','PD21')
													   then greatest(s) else null end) p165_17,
			  max(case when idf = 53  and kod = 'PD19' then s else null end) p165_18,
			  --
			  max(case when idf = 54  and kod = 'VD1'  then s else null end) p166_1,
			  max(case when idf = 54  and kod = 'VD2'  then s else null end) p166_2,
			  max(case when idf = 54  and kod = 'VD3'  then s else null end) p166_3,
			  max(case when idf = 54  and kod = 'VD4'  then s else null end) p166_4,
			  max(case when idf = 54  and kod = 'VD5'  then s else null end) p166_5,
			  max(case when idf = 54  and kod = 'VD6'  then s else null end) p166_6,
			  max(case when idf = 54  and kod = 'VD7'  then s else null end) p166_7,
			  max(case when idf = 54  and kod = 'VD8'  then s else null end) p166_8,
			  max(case when idf = 54  and kod = 'VD9'  then s else null end) p166_9,
			  max(case when idf in (54,53) and s = 1   then s else    0 end) p164_2,

			  max(case when idf = 55  and kod = 'ZD1'  then s else null end) p167_1,
			  max(case when idf = 55  and kod = 'ZD2'  then s else null end) p167_2,
			  max(case when idf = 55  and kod = 'ZD3'  then s else null end) p167_3,

			  max(case when idf = 56  and kod = 'VD0'  then s else null end) pVD0

			  , max(case when idf = 56  and kod = 'CLS1'  then s else null end) pCLS1
			  , max(case when idf = 56  and kod = 'CLS2'  then s else null end) pCLS1
			  , max(case when idf = 53  and kod = 'PD7'   then s else null end) p165_7nr
		into  l_.p162_1,  l_.p162_3,  l_.p162_4,  l_.p163_1,
			  ----
			   l_25, l_24,
			  ----
			  l_.p165_1,  l_.p165_2,  l_.p165_3,  l_.p165_4,  l_.p165_5,
			  l_.p165_6,  l_.p165_7,  l_.p165_8,  l_.p165_9,  l_.p165_10,
			  l_.p165_11, l_.p165_12, l_.p165_13, l_.p165_14, l_.p165_15,
			  l_.p165_16, l_.p165_17, l_.p165_18,
			  ---
			  l_.p166_1,  l_.p166_2,  l_.p166_3,  l_.p166_4,  l_.p166_5,
			  l_.p166_6,  l_.p166_7,  l_.p166_8,  l_.p166_9,
			  l_.p164_2,
			  --
			  l_.p167_1,  l_.p167_2,  l_.p167_3
			  ,  l_.pVD0
			  ,  l_.pCLS1
			  ,  l_.pCLS2
			  ,  l_p165_7_nr
		 from fin_nd
		where nd = p_nd
		  and rnk = p_rnk
		  and s != -99
		group by nd, rnk;

        
		--t_deal.rnk(n_rnk).nd(n_nd).kol25 := '['||l_25||']';
		-- NOT!!!
		-- функціонування боржника – юридичної особи менше одного року з дати державної реєстрації (не застосовується в разі реорганізації боржника; належності боржника до групи; оцінки боржника за кредитом під інвестиційний проект);
		l_.p161_2 := 0;


		if l_kv != 980 and  l_.p163_1 = 2 then   l_.p163_1 := 1;
		else                                     l_.p163_1 := 0;
		end if;



	 elsif l_custtype = 2 and l_idf  = 70  then
				Select --nd, rnk,
			  max(case when idf = 72  and kod = 'KR3'  then s else null end) p162_1,
			  max(case when idf = 72  and kod = 'KR5'  then s else null end) p162_3,
			  max(case when idf = 72  and kod = ''     then s else null end) p162_4,
			  max(case when idf = 72  and kod = 'KP61'  then s else null end) p163_1,
			  --
			  max(case when idf = 74  and kod = 'RK4' and s = 1 then s else 0 end) k25,
			  --
			  max(case when idf = 73  and kod = 'BO2'  then s else null end) p165_1,
			  max(case when idf = 73  and kod = 'BO3'  then s else null end) p165_2,
			  max(case when idf = 73  and kod = 'BO4'  then s else null end) p165_3,
			  max(case when idf = 73  and kod = ''     then s else null end) p165_4,
			  max(case when idf = 73  and kod = ''     then s else null end) p165_5,
			  max(case when idf = 73  and kod = ''     then s else null end) p165_6,
			  max(case when idf = 73  and kod = 'BO5'  then s else    0 end) p165_7,
			  max(case when idf = 73  and kod = 'BO6'  then s else null end) p165_8,
			  max(case when idf = 73  and kod = 'BO7'  then s else null end) p165_9,
			  max(case when idf = 73  and kod = 'BO8'  then s else null end) p165_10,
			  max(case when idf = 73  and kod = 'BO9'  then s else null end) p165_11,
			  max(case when idf = 73  and kod = 'BO10' then s else null end) p165_12,
			  max(case when idf = 73  and kod = 'BO11' then s else null end) p165_13,
			  max(case when idf = 73  and kod = ''     then s else null end) p165_14,
			  max(case when idf = 73  and kod = 'BO12' then s else null end) p165_15,
			  max(case when idf = 73  and kod = 'BO13' then s else null end) p165_16,
			  max(case when idf = 73  and kod in ('BO14','BO15')
													   then greatest(s) else null end) p165_17,
			  max(case when idf = 73  and kod = 'BO16' then s else null end) p165_18,
			  --
			  max(case when idf = 74  and kod = 'VD1'  then s else null end) p166_1,
			  max(case when idf = 74  and kod = 'VD2'  then s else null end) p166_2,
			  max(case when idf = 74  and kod = 'VD3'  then s else null end) p166_3,
			  max(case when idf = 74  and kod = 'VD4'  then s else null end) p166_4,
			  max(case when idf = 74  and kod = 'VD5'  then s else null end) p166_5,
			  max(case when idf = 74  and kod = 'VD6'  then s else null end) p166_6,
			  max(case when idf = 74  and kod = 'VD6'  then s else null end) p166_7,
			  max(case when idf = 74  and kod = 'VD7'  then s else null end) p166_8,
			  max(case when idf = 74  and kod = 'VD8'  then s else null end) p166_9,

			  max(case when idf in (74,73) and s = 1   then s else    0 end) p164_2,

			  max(case when idf = 75  and kod = 'ZD1'  then s else null end) p167_1,
			  max(case when idf = 75  and kod = 'ZD2'  then s else null end) p167_2,
			  max(case when idf = 75  and kod = 'ZD3'  then s else null end) p167_3 ,

			  max(case when idf = 74  and kod = 'VD0'  then s else null end) pVD0


		into  l_.p162_1,  l_.p162_3,  l_.p162_4,  l_.p163_1,
			  ----
			   l_25,
			  ----
			  l_.p165_1,  l_.p165_2,  l_.p165_3,  l_.p165_4,  l_.p165_5,
			  l_.p165_6,  l_.p165_7,  l_.p165_8,  l_.p165_9,  l_.p165_10,
			  l_.p165_11, l_.p165_12, l_.p165_13, l_.p165_14, l_.p165_15,
			  l_.p165_16, l_.p165_17, l_.p165_18,
			  ---
			  l_.p166_1,  l_.p166_2,  l_.p166_3,  l_.p166_4,  l_.p166_5,
			  l_.p166_6,  l_.p166_7,  l_.p166_8,  l_.p166_9,
			  l_.p164_2,
			  --
			  l_.p167_1,  l_.p167_2,  l_.p167_3, l_.pVD0
		 from fin_nd
		where nd = p_nd
		  and rnk = p_rnk
		  and s != -99
		group by nd, rnk;


		--t_deal.rnk(n_rnk).nd(n_nd).kol25 := '['||l_25||']';

		if l_kv != 980 and  l_.p163_1 = 1 then   l_.p163_1 := 1;
		else                                     l_.p163_1 := 0;
		end if;

	 end if;





			  l_.p162_1 :=nvl(l_.p162_1,0);  l_.p162_3:=nvl(l_.p162_3,0);   l_.p162_4:= nvl(l_.p162_4,0);  l_.p163_1:=nvl(l_.p163_1,0);

			  l_.p165_1 :=nvl(l_.p165_1,0);  l_.p165_2:=nvl(l_.p165_2,0);   l_.p165_3:=nvl(l_.p165_3,0);   l_.p165_4:=nvl(l_.p165_4,0);   l_.p165_5 :=nvl(l_.p165_5,0);
			  l_.p165_6 :=nvl(l_.p165_6,0);  l_.p165_7:=nvl(l_.p165_7,0);   l_.p165_8:=nvl(l_.p165_8,0);   l_.p165_9:=nvl(l_.p165_9,0);   l_.p165_10:=nvl(l_.p165_10,0);
			  l_.p165_11:=nvl(l_.p165_11,0); l_.p165_12:=nvl(l_.p165_12,0); l_.p165_13:=nvl(l_.p165_13,0); l_.p165_14:=nvl(l_.p165_14,0); l_.p165_15:=nvl(l_.p165_15,0);
			  l_.p165_16:=nvl(l_.p165_16,0); l_.p165_17:=nvl(l_.p165_17,0); l_.p165_18:=nvl(l_.p165_18,0);
	--
			  l_.p166_1:= nvl(l_.p166_1,0);  l_.p166_2 := nvl(l_.p166_2,0); l_.p166_3 := nvl(l_.p166_3,0); l_.p166_4 := nvl(l_.p166_4,0); l_.p166_5 := nvl(l_.p166_5,0);
			  l_.p166_6:= nvl(l_.p166_6,0);  l_.p166_7 := nvl(l_.p166_7,0); l_.p166_8 := nvl(l_.p166_8,0); l_.p166_9 := nvl(l_.p166_9,0);
	---
			  l_.p167_1:= nvl(l_.p167_1,1);  l_.p167_2:=nvl(l_.p167_2,1);  l_.p167_3 :=nvl(l_.p167_3,1);

		-- надання кредиту боржнику – юридичній особі, що є нерезидентом, рейтинг якого не підтверджений жодним із провідних світових рейтингових агентств
		if l_rz = 2 and  l_p165_7_nr = 0 then l_.p161_1 := 1;
									     else l_.p161_1 := 0;
		end if;





		l_.p162_5 := 0;



		l_.p163_2 := 0;

		--Для НБУ


	/*
		If    l_kol between 31 and 60   then   t_deal.rnk(n_rnk).nd(n_nd).kol24 := '[100]';   l_.p161_3 := 1;
		elsIf l_kol between 61 and 90   then   t_deal.rnk(n_rnk).nd(n_nd).kol24 := '[010]';   l_.p161_3 := 0; l_.p162_2 := 1;
		elsIf l_kol >= 91               then   t_deal.rnk(n_rnk).nd(n_nd).kol24 := '[001]';   l_.p161_3 := 0; l_.p162_2 := 0; l_.p164_1:= 1;
		else                                   t_deal.rnk(n_rnk).nd(n_nd).kol24 := '[000]';   l_.p162_2 := 0; l_.p161_3 := 0;
		end if;
	*/

		If    l_kol between 31 and 60  then   t_deal.rnk(n_rnk).nd(n_nd).kol27 := '591';   l_.p161_3 := 1;
		elsIf l_kol between 61 and 90  then   t_deal.rnk(n_rnk).nd(n_nd).kol27 := '592';   l_.p161_3 := 0; l_.p162_2 := 1;
		elsIf l_kol >= 91              then   t_deal.rnk(n_rnk).nd(n_nd).kol27 := '593';   l_.p161_3 := 0; l_.p162_2 := 0; l_.p164_1:= 1; l_.p165_14 := 1;
		else                                  t_deal.rnk(n_rnk).nd(n_nd).kol27 := '000';   l_.p162_2 := 0; l_.p161_3 := 0;
		end if;

		if not regexp_like(l_nbs,'^20[23]')
		    then l_.p161_3 := 0; l_.p162_2 := 0; l_.p165_14 := 0;
		end if;


		if l_tipa in(3,9,10,4, 30, 90, 92) then

	/*
		t_deal.rnk(n_rnk).nd(n_nd).kol23 :='['||l_.p161_1||l_.p161_2||l_.p161_3||'/'||
												l_.p162_1||l_.p162_2||l_.p162_3||l_.p162_4||l_.p162_5||'/'||
												l_.p163_1||l_.p163_2||']';

		t_deal.rnk(n_rnk).nd(n_nd).kol27 :='['||l_.p164_1 ||'/'||l_.p164_2 ||'/'||
												l_.p165_1 ||l_.p165_2 ||l_.p165_3 ||l_.p165_4 ||l_.p165_5||
												l_.p165_6 ||l_.p165_7 ||l_.p165_8 ||l_.p165_9 ||l_.p165_10||
												l_.p165_11||l_.p165_12||l_.p165_13||l_.p165_14||l_.p165_15||
												l_.p165_16||l_.p165_17||l_.p165_18||'/'||
												l_.p166_1 ||l_.p166_2 ||l_.p166_3 ||l_.p166_4 ||l_.p166_5||l_.p166_6||l_.p166_7 ||l_.p166_8||l_.p166_9||']';


		t_deal.rnk(n_rnk).nd(n_nd).kol28 :=  '[0'||
											  case when regexp_like(t_deal.rnk(n_rnk).nd(n_nd).kol24,'1') then '1' else '0' end||
											  case when regexp_like(t_deal.rnk(n_rnk).nd(n_nd).kol23,'1') then '1' else '0' end||
											  case when regexp_like(t_deal.rnk(n_rnk).nd(n_nd).kol25,'1') then '1' else '0' end||
											  case when regexp_like(t_deal.rnk(n_rnk).nd(n_nd).kol26,'1') then '1' else '0' end||
											  case when regexp_like(t_deal.rnk(n_rnk).nd(n_nd).kol27,'1') then '1' else '0' end||']';

			  if 1=0 then
					t_deal.rnk(n_rnk).nd(n_nd).kol29 :='['||'-'||'/'||'-' ||'/'||
														'-'||'-'||'-'||'-'||'-'||
														'-'||'-'||'-'||'-'||'-'||
														'-'||'-'||'-'||'-'||'-'||
														'-'||'-'||'-'||'/'||
														l_.p166_1 ||l_.p166_2 ||l_.p166_3 ||l_.p166_4 ||l_.p166_5||l_.p166_6||l_.p166_7 ||l_.p166_8||l_.p166_9||']';

			  else
					t_deal.rnk(n_rnk).nd(n_nd).kol29 :='['||'-'||'/'||'-' ||'/'||
														'-'||'-'||'-'||'-'||'-'||
														'-'||'-'||'-'||'-'||'-'||
														'-'||'-'||'-'||'-'||'-'||
														'-'||'-'||'-'||'/'||
														'0'||'0'||'0'||'0'||'0'||'0'||'0'||'0'||'0'||']';
			  end if;
	*/

	    --  24 Код щодо належності до групи юридичних осіб під спільним контролем/групи пов'язаних контрагентів
	    case when l_24 = '101'
		 then   t_deal.rnk(n_rnk).nd(n_nd).kol24 := '100';
		 else  	t_deal.rnk(n_rnk).nd(n_nd).kol24 := l_24;
		end case;

	    --  25 Код щодо наявності ознаки, що свідчить про високий кредитний ризик
		 l_tmp := null;
		 l_tmp :=   f_conct('1611',l_.p161_1)
		          ||f_conct('1612',l_.p161_2)
				  ||f_conct('1613',l_.p161_3)
				  ||f_conct('1621',l_.p162_1)
				  ||f_conct('1622',l_.p162_2)
				  ||f_conct('1623',l_.p162_3)
				  ||f_conct('1624',l_.p162_4)
				  ||f_conct('1625',l_.p162_5)
				 -- ||f_conct('1631',l_.p163_1)
				  ||f_conct('1632',l_.p163_2)
		          ;
		 t_deal.rnk(n_rnk).nd(n_nd).kol25 :=  nvl(substr(l_tmp,2),'0000');
	    --  26 Код щодо події дефолту
		 l_tmp := null;
		 l_tmp :=   f_conct('164100000',l_.p164_1)
		          ||f_conct('164216501',l_.p165_1)
				  ||f_conct('164216502',l_.p165_2)
				  ||f_conct('164216503',l_.p165_3)
				  ||f_conct('164216504',l_.p165_4)
				  ||f_conct('164216505',l_.p165_5)
				  ||f_conct('164216506',l_.p165_6)
				  ||f_conct('164216507',l_.p165_7)
				  ||f_conct('164216508',l_.p165_8)
				  ||f_conct('164216509',l_.p165_9)
				  ||f_conct('164216510',l_.p165_10)
				  ||f_conct('164216511',l_.p165_11)
				  ||f_conct('164216512',l_.p165_12)
				  ||f_conct('164216513',l_.p165_13)
				  ||f_conct('164216514',l_.p165_14)
				  ||f_conct('164216515',l_.p165_15)
				  ||f_conct('164216516',l_.p165_16)
				  ||f_conct('164216517',l_.p165_17)
				  ||f_conct('164216518',l_.p165_18)
				  ||f_conct('164216601',l_.p166_1)
				  ||f_conct('164216602',l_.p166_2)
				  ||f_conct('164216603',l_.p166_3)
				  ||f_conct('164216604',l_.p166_4)
				  ||f_conct('164216605',l_.p166_5)
				  ||f_conct('164216606',l_.p166_6)
				  ||f_conct('164216607',l_.p166_7)
				  ||f_conct('164216608',l_.p166_8)
				  ||f_conct('164216609',l_.p166_9)
		          ;
		 t_deal.rnk(n_rnk).nd(n_nd).kol26 :=  nvl(substr(l_tmp,2),'000000000');


		--  27 Код щодо своєчас-ності сплати боргу
		    --
		--  28 Код щодо додаткових характе-ристик
		    --
		--  29 Код фактору на підставі якого скоригова-ний клас контраген- та/пов’яза-ної з банком особи

		                            l_tmp:=  f_conct('01',case when regexp_like(t_deal.rnk(n_rnk).nd(n_nd).kol24,'[1234567896]')  then '1' else '0' end)
		                                   ||f_conct('02',case when regexp_like(t_deal.rnk(n_rnk).nd(n_nd).kol25,'[1234567896]')  then '1' else '0' end)
										   ||f_conct('03',case when regexp_like(t_deal.rnk(n_rnk).nd(n_nd).kol26,'[1234567896]')  then '1' else '0' end)
										   ||f_conct('04',case when regexp_like(t_deal.rnk(n_rnk).nd(n_nd).kol27,'[1234567896]')  then '1' else '0' end)
										   ||f_conct('05',case when regexp_like(t_deal.rnk(n_rnk).nd(n_nd).kol28,'[1234567896]')  then '1' else '0' end)
		 ;
		 t_deal.rnk(n_rnk).nd(n_nd).kol29 :=  substr(l_tmp,2);
		--  30 Код ознаки дефолту контраген-та/пов'язаної з банком особи щодо якої банком доведено відсутність дефолту
		 if '1' = l_.pVD0 then
		                               l_tmp := f_conct('164216601',l_.p166_1)
											  ||f_conct('164216602',l_.p166_2)
											  ||f_conct('164216603',l_.p166_3)
											  ||f_conct('164216604',l_.p166_4)
											  ||f_conct('164216605',l_.p166_5)
											  ||f_conct('164216606',l_.p166_6)
											  ||f_conct('164216607',l_.p166_7)
											  ||f_conct('164216608',l_.p166_8)
											  ||f_conct('164216609',l_.p166_9);
            t_deal.rnk(n_rnk).nd(n_nd).kol30 :=  substr(l_tmp,2);
		 end if;


		end if;
	   -- Для Ощадбанка
        t_deal.rnk(n_rnk).nd(n_nd).CLS1 :=  l_.pCLS1;
		t_deal.rnk(n_rnk).nd(n_nd).CLS2 :=  l_.pCLS2;



		t_deal.rnk(n_rnk).nd(n_nd).ovkr  := bars_instr( str_ =>l_.p161_1||l_.p161_2||l_.p161_3||l_.p162_1||l_.p162_2||l_.p162_3||l_.p162_4||l_.p162_5||l_.p163_1||l_.p163_2,
														p_s =>'1');

		t_deal.rnk(n_rnk).nd(n_nd).p_def  := bars_instr( str_ => l_.p165_1 ||l_.p165_2 ||l_.p165_3 ||l_.p165_4 ||l_.p165_5||
																 l_.p165_6 ||l_.p165_7 ||l_.p165_8 ||l_.p165_9 ||l_.p165_10||
																 l_.p165_11||l_.p165_12||l_.p165_13||l_.p165_14||l_.p165_15||
																 l_.p165_16||l_.p165_17||'0'||'0'||'0'||l_.p165_18,
														 p_s =>'1');

		t_deal.rnk(n_rnk).nd(n_nd).ovd  := bars_instr( str_ => l_.p164_1||'0'||l_.p166_1 ||l_.p166_2 ||l_.p166_3 ||l_.p166_4 ||l_.p166_5||l_.p166_6||l_.p166_7 ||l_.p166_8||l_.p166_9,
													   p_s =>'1');

		t_deal.rnk(n_rnk).nd(n_nd).opd  := bars_instr( str_ => l_.p167_1 ||l_.p167_2 ||l_.p167_3,
													   p_s =>'1');
	  exception when no_data_found then
	   null;
	   l_tmp := null;
	   	If    l_kol between 31 and 60   then   t_deal.rnk(n_rnk).nd(n_nd).kol27 := '591';
		elsIf l_kol between 61 and 90   then   t_deal.rnk(n_rnk).nd(n_nd).kol27 := '592';
		elsIf l_kol >= 91               then   t_deal.rnk(n_rnk).nd(n_nd).kol27 := '593';
		else                                   t_deal.rnk(n_rnk).nd(n_nd).kol27 := '000';
		end if;
	   t_deal.rnk(n_rnk).nd(n_nd).kol25 :=  nvl(substr(l_tmp,2),'0000');
	   t_deal.rnk(n_rnk).nd(n_nd).kol26 :=  nvl(substr(l_tmp,2),'000000000');
	                                l_tmp:=  f_conct('01',case when regexp_like(t_deal.rnk(n_rnk).nd(n_nd).kol24,'[1234567896]')  then '1' else '0' end)
		                                   ||f_conct('02',case when regexp_like(t_deal.rnk(n_rnk).nd(n_nd).kol25,'[1234567896]')  then '1' else '0' end)
										   ||f_conct('03',case when regexp_like(t_deal.rnk(n_rnk).nd(n_nd).kol26,'[1234567896]')  then '1' else '0' end)
										   ||f_conct('04',case when regexp_like(t_deal.rnk(n_rnk).nd(n_nd).kol27,'[1234567896]')  then '1' else '0' end)
										   ||f_conct('05',case when regexp_like(t_deal.rnk(n_rnk).nd(n_nd).kol28,'[1234567896]')  then '1' else '0' end)
		 ;
		 t_deal.rnk(n_rnk).nd(n_nd).kol29 :=  substr(l_tmp,2);
	   trace(L_MOD, ' Незнайдено допреквізитів ND='||p_nd);
	  end;

	/*	If    l_kol between 31 and 60   then   t_deal.rnk(n_rnk).nd(n_nd).kol27 := '591';
		elsIf l_kol between 61 and 90   then   t_deal.rnk(n_rnk).nd(n_nd).kol27 := '592';
		elsIf l_kol >= 91               then   t_deal.rnk(n_rnk).nd(n_nd).kol27 := '593';
		else                                   t_deal.rnk(n_rnk).nd(n_nd).kol27 := '000';
		end if;
    */
		if l_tipa = 15 then

		 case
			 when (l_custtype = 2 and l_fin in(1,2) )  or (l_custtype != 2 and l_fin = 1 )  then t_deal.rnk(n_rnk).nd(n_nd).kol28 := '10000';
			 when (l_custtype = 2 and l_fin in(3,4) )  or (l_custtype != 2 and l_fin = 2 )  then t_deal.rnk(n_rnk).nd(n_nd).kol28 := '01000';
			 when (l_custtype = 2 and l_fin in(5,6) )  or (l_custtype != 2 and l_fin = 3 )  then t_deal.rnk(n_rnk).nd(n_nd).kol28 := '00100';
			 when (l_custtype = 2 and l_fin in(7,8) )  or (l_custtype != 2 and l_fin = 4 )  then t_deal.rnk(n_rnk).nd(n_nd).kol28 := '00010';
			 when (l_custtype = 2 and l_fin in(9,10) ) or (l_custtype != 2 and l_fin = 5 )  then t_deal.rnk(n_rnk).nd(n_nd).kol28 := '00001';
			                                                                                else t_deal.rnk(n_rnk).nd(n_nd).kol28 := '00000';
		 end case;

		end if;

	<<get_update>>
	null;
	/*
	   trace(l_mod, ' kol23='||t_deal.rnk(n_rnk).nd(n_nd).kol23||
					' kol24='||t_deal.rnk(n_rnk).nd(n_nd).kol24||
					' kol25='||t_deal.rnk(n_rnk).nd(n_nd).kol25||
					' kol26='||t_deal.rnk(n_rnk).nd(n_nd).kol26||
					' kol27='||t_deal.rnk(n_rnk).nd(n_nd).kol27||
					' kol28='||t_deal.rnk(n_rnk).nd(n_nd).kol28||
					' kol29='||t_deal.rnk(n_rnk).nd(n_nd).kol29);

	 */

			   p_OVKR    := t_deal.rnk(n_rnk).nd(n_nd).ovkr;
			   p_P_DEF   := t_deal.rnk(n_rnk).nd(n_nd).p_def;
			   p_ovd     := t_deal.rnk(n_rnk).nd(n_nd).ovd;
			   p_opd     := t_deal.rnk(n_rnk).nd(n_nd).opd;
			   p_kol23   := t_deal.rnk(n_rnk).nd(n_nd).kol23;
			   p_kol24   := t_deal.rnk(n_rnk).nd(n_nd).kol24;
			   p_kol25   := t_deal.rnk(n_rnk).nd(n_nd).kol25;
			   p_kol26   := t_deal.rnk(n_rnk).nd(n_nd).kol26;
			   p_kol27   := t_deal.rnk(n_rnk).nd(n_nd).kol27;
			   p_kol28   := t_deal.rnk(n_rnk).nd(n_nd).kol28;
			   p_kol29   := t_deal.rnk(n_rnk).nd(n_nd).kol29;
			   p_kol30   := t_deal.rnk(n_rnk).nd(n_nd).kol30;

			   -- ДЛЯ БЮДЖЕТНИХ УСТАНОВ НЕМАЄ КЛАСУ ПО ІНТЕГРАЛЬНОМУ ПОКАЗНИКУ
	             if l_custtype = 2 and l_idf  = 70 then p_fin_z   := null;
				                                   else p_fin_z   := t_deal.rnk(n_rnk).clas;
				 end if;

			   p_ipb     := t_deal.rnk(n_rnk).ipb;
			   p_cls1    := t_deal.rnk(n_rnk).nd(n_nd).cls1;
			   p_cls2    := t_deal.rnk(n_rnk).nd(n_nd).cls2;

   case when l_nbs in ('9129','9122','9023') and l_fin = 1 and l_pd_0 = 1
        then p_fin_z   := 1;
		else null;
   end case;



	end;

	procedure t_deal_del
	as
	begin
	t_deal := null;
	end;

procedure kol_rezcr (p_dat date)
as
	L_OVKR   VARCHAR2(500);
	L_P_DEF  VARCHAR2(500);
	L_OVD    VARCHAR2(500);
	L_OPD    VARCHAR2(500);
	L_KOL23  VARCHAR2(500);
	L_KOL24  VARCHAR2(500);
	L_KOL25  VARCHAR2(500);
	L_KOL26  VARCHAR2(500);
	L_KOL27  VARCHAR2(500);
	L_KOL28  VARCHAR2(500);
	L_KOL29  VARCHAR2(500);
	L_KOL30  VARCHAR2(500);
	L_FIN_Z  VARCHAR2(50);
	L_ipb    number;
	L_cls1   VARCHAR2(50);
	L_cls2   VARCHAR2(50);
	l_kol17  VARCHAR2(50);
	l_kol31  VARCHAR2(50);
	l_dat date := trunc(p_dat,'MM');
	c0    SYS_REFCURSOR;
	l_c0  tb_row;
	l_sql varchar2(4000);
        l_fin_p  number;
        l_fin_d  number;
        l_idf    number;
	BEGIN

    g_fdat :=  l_dat;

   for k in (
             select rnk from (select  rnk,sum (eadq) s from rez_cr where fdat = l_dat and custtype=2 group by rnk) where s>2000000
             )
   LOOP
      update rez_cr set T4 = 1 where rnk=k.rnk and fdat = l_dat;
   end LOOP;


   for k in ( select  r.rnk  from rez_cr r,customer c where r.custtype=3 and r.fdat = l_dat and r.rnk=c.rnk and nvl(c.prinsider,0)<>99  )
    LOOP
      update rez_cr set T4 = 1 where rnk=k.rnk and fdat = l_dat;
   end LOOP;


   for k in ( select  r.rnk , max(fin) fin  from rez_cr r where  r.fdat = l_dat group by rnk )
    LOOP
		begin
		  update customer set crisk = k.fin where rnk=k.rnk and crisk != k.fin ;
		 exception when others then
			null;
		end;
    end LOOP;


	l_sql := 'Select  rowid RoW_id,  a.rnk, a.nd, a.acc , a.pawn, a.tipa, a.custtype
		 from rez_cr a
		where fdat = to_date('''||to_char(l_dat,'dd/mm/yyyy')||''',''dd/mm/yyyy'') order by rnk, nd, tipa';

  OPEN c0 FOR l_sql;
    LOOP
      FETCH c0 BULK COLLECT INTO l_c0 LIMIT 500;
      EXIT WHEN l_c0.COUNT = 0;

      /* Обработка пакета из (p_limit_size) записей... */
      FOR i IN 1 .. l_c0.COUNT
        LOOP

	       l_kol17 := '[]';
	    if nvl(l_c0(i).PAWN, 0) != 0  then
			begin
				 select '['||ConcatStr(C.KOD_351)||']'
				   into l_kol17
				   from rez_cr R, CC_PAWN C
				  where acc=l_c0(i).acc
					AND R.PAWN=C.PAWN
					and fdat =  l_dat
			   order by C.KOD_351;
			exception when no_data_found then
			  l_kol17 := '[]';
			end;
		end if;

			begin
				 select '['||ConcatStr(trim(to_char(d.pd,'99999990D00000')))||']'
				   into l_kol31
				   from rez_cr d
				  where d.acc=l_c0(i).acc
				    and fdat =  l_dat
				  order by d.pd;
			exception when no_data_found then
			  l_kol31 := null;
			end;


		 case    
	       when l_c0(i).tipa in (4)  then 
           l_idf := 76;
			   when l_c0(i).custtype = 2 then 
           l_idf := 56;
         else 
           l_idf := 60;
		 end case;

		   case    
         when l_c0(i).tipa in (17,21,12,15,6, 5,92,93,30) then 
           l_fin_p := NULL;
         else 
           l_fin_p := fin_nbu.zn_p_nd('CLSP', l_idf, p_dat, l_c0(i).nd, l_c0(i).rnk);
        end case;

       case    
         when l_c0(i).tipa in (17,21,12,15,6, 5,92,93,30) then 
           l_fin_d := NULL;
         else 
           l_fin_d := fin_nbu.zn_p_nd('CLS', l_idf, p_dat, l_c0(i).nd, l_c0(i).rnk);
		end case;
                 
		if l_fin_p = 0 THEN l_fin_p := NULL; end if;
        if l_fin_d = 0 THEN l_fin_d := NULL; end if;
				 
	 fin_rep.get_nd_fin_param (P_RNK    => l_c0(i).rnk,
							   P_ND     => l_c0(i).nd,
							   P_RW     => l_c0(i).RoW_id,
							   P_OVKR   => L_OVKR   ,
							   P_P_DEF  => L_P_DEF  ,
							   P_OVD    => L_OVD    ,
							   P_OPD    => L_OPD    ,
							   P_KOL23  => L_KOL23  ,
							   P_KOL24  => L_KOL24  ,
							   P_KOL25  => L_KOL25  ,
							   P_KOL26  => L_KOL26  ,
							   P_KOL27  => L_KOL27  ,
							   P_KOL28  => L_KOL28  ,
							   P_KOL29  => L_KOL29  ,
							   P_KOL30  => L_KOL30  ,
							   P_FIN_Z  => L_FIN_Z  ,
							   P_ipb    => L_ipb    ,
							   p_cls1   => L_cls1   ,
							   p_cls2   => L_cls2    );


	   update  rez_cr
		  set  OVKR    = L_OVKR   ,
         	       P_DEF   = L_P_DEF  ,
                       ovd     = L_OVD    ,
                       opd     = L_OPD    ,
                       kol23   = L_KOL23  ,
                       kol24   = L_KOL24  ,
                       kol25   = L_KOL25  ,
                       kol26   = L_KOL26  ,
                       kol27   = L_KOL27  ,
                       kol28   = L_KOL28  ,
                       kol29   = L_KOL29  ,
                       kol30   = L_KOL30  ,
                       fin_z   = L_FIN_Z  ,
                       kol17   = l_kol17  ,
                       kol31   = l_kol31  ,
                       z       = L_ipb,
                       RNK_SK  = case when regexp_like(L_KOL24,'^1') then 1 else null end,
                       FIN_SK  = L_cls1,
                       FIN_PK  = L_cls2,
                       FIN_KOL = l_fin_p,
                       FIN_KOR = l_fin_d
		where rowid = l_c0(i).RoW_id;

	  end loop;
	  fin_rep.t_deal_del;
	  commit;
	END LOOP;

  CLOSE c0;


	--p_nbu23_cr_dp(p_dat);   перенесли в резерв.

	fin_rep.t_deal_del;
	commit;
end;


function f_rep_nbu_351( p_sFdat1 date
                       ,p_sFdat2 date
					   ,p_nd     number
					   ,p_rnk    number
                       )
                        RETURN t_rep_nbu_351 PIPELINED  PARALLEL_ENABLE
as

  l_rep      t_col_rep_nbu_351;
  l_rep_null t_col_rep_nbu_351;

PRAGMA AUTONOMOUS_TRANSACTION;
begin

 for x in ( select nd,
				   rnk,
				   kv, --concatstr(kv) kv,
				   fdat,
				   sum(case when tip  in ('SS ','SP ','SN ','SPN') then bv else 0 end) bv,
				   max(fin_z) fin_z,
				   max(fin_351) fin_351,
				   sum(zalq_351) zal_351,
				   sum(zal_bl)  zal_bl,
				   sum(rezq) rez,
				   sum(crq) cr,
				   max(kol_351) kol_351,
				   okpo
			from nbu23_rez
			where fdat between  p_sFdat1 and p_sFdat2
			  and rnk = p_rnk
              and nd  = p_nd
			Group by nd, rnk, fdat, kv , okpo
			)
	loop
    l_rep :=  l_rep_null;
	l_rep.nd   := x.nd;
	l_rep.rnk  := x.rnk;
	l_rep.fdat := to_char(x.fdat,'dd.mm.yyyy')||chr(13)||chr(10)||'('||to_char(x.kv)||')';
	l_rep.kv   := x.kv;

	/*
	  select  to_char(D.LIMIT,  g_number_format, g_number_nlsparam)
	    into  l_rep.s
        from cc_deal d, customer c
       where d.nd = x.nd and d.rnk = x.rnk
         and d.rnk = c.rnk;
    */

			BEGIN

			  select sum(abs(s.OSTf - s.DOS + s.KOS))/100 as limit --sum(gl.p_icurval(a.kv,abs(s.OSTf - s.DOS + s.KOS),x.fdat-1))/100 as limit
				into l_rep.s
				from nd_acc n,
				     accounts a,
					 saldoa s
				where n.acc = a.acc
				  and a.acc = s.acc
				  and tip in ('LIM1', 'CR9','SS ','SP ')
				  AND (a.acc, s.fdat) = (  SELECT c.acc, MAX (c.fdat)
												 FROM saldoa c
												WHERE a.acc = c.acc AND c.fdat < x.fdat
											 GROUP BY c.acc)
				 and n.nd = x.nd
				 and a.kv = x.kv;
				exception when NO_DATA_FOUND
							 THEN  l_rep.s := 0;

			END;




	l_rep.rv    := 1;
	l_rep.sort := '1000';
	l_rep.kod  := 'LIMIT';
	l_rep.name := 'Сума (ліміт) кредиту/кредитної лінії';
	l_rep.s    := to_char(l_rep.s,  g_number_format, g_number_nlsparam);
	PIPE ROW(l_rep);

	l_rep.rv    := null;
	l_rep.sort := '1001';
	l_rep.kod  := 'KV';
	l_rep.name := 'Валюта кредиту';
	l_rep.s    := x.kv;
	PIPE ROW(l_rep);

	l_rep.rv    := 2;
	l_rep.sort := '2000';
	l_rep.kod  := 'BV';
	l_rep.name := 'Фактична сума боргу за кредитом';
	l_rep.s    := to_char(x.bv,  g_number_format, g_number_nlsparam);
	PIPE ROW(l_rep);


	   begin
			   select s
				 into x.fin_z
				 from fin_rnk
				where okpo = x.okpo
				  and kod = 'CLAS'
				  and idf = 6
				  and fdat in (select max(fdat)
								 from fin_fm
								where okpo = x.okpo
								  and fdat <= x.fdat);
		   exception when no_data_found then
			  null;
	   end;

	l_rep.rv    := 3;
	l_rep.sort := '3000';
	l_rep.kod  := 'FIN_Z';
	l_rep.name := 'Клас боржника, визначений на підставі оцінки фінансового стану';
	l_rep.s    := x.fin_z;
	PIPE ROW(l_rep);

	l_rep.rv    := 4;
	l_rep.sort := '4000';
	l_rep.kod  := 'FIN_351';
	l_rep.name := 'Скоригований клас боржника:';
	l_rep.s    := x.fin_351;
	PIPE ROW(l_rep);

	l_rep.rv    := null;
	l_rep.sort := '4001';
	l_rep.kod  := '';
	l_rep.name := 'Фактори, за якими скоригований клас боржника:';
	l_rep.s    := null;
	PIPE ROW(l_rep);

	l_rep.sort := '4100';
	l_rep.kod  := 'KOL_351';
	l_rep.name := 'Кількість календарних днів прострочення';
	l_rep.s    := x.kol_351;
	PIPE ROW(l_rep);

	l_rep.rv    := 5;
	l_rep.sort := '5000';
	l_rep.kod  := 'ZAL_351';
	l_rep.name := 'Забезпечення, яке Банк враховує з метою зменшення кредитного ризику';
	l_rep.s    := to_char(x.zal_351,  g_number_format, g_number_nlsparam);
	PIPE ROW(l_rep);

	l_rep.rv    := null;
	l_rep.sort := '6000';
	l_rep.kod  := 'ZAL_BL';
	l_rep.name := 'Ринкова вартість забезпечення, яке Банк враховує з метою зменшення кредитного ризику';
	l_rep.s    := to_char(x.zal_bl,  g_number_format, g_number_nlsparam);
	PIPE ROW(l_rep);

	l_rep.rv    := 6;
	l_rep.sort := '7000';
	l_rep.kod  := 'PD';
	l_rep.name := 'Значення коефіцієнтів PD контрагента Банку ';
	--l_rep.s    := to_char(x.rez,  g_number_format, g_number_nlsparam);
	Begin
  	     Select to_char(max(pd),  g_number_format, g_number_nlsparam)
		   into l_rep.s
		   from rez_cr
		  where fdat between  x.fdat and x.fdat
			  and rnk = l_rep.rnk
              and nd  = l_rep.nd;
		exception when no_data_found then
	  l_rep.s := '-';
	end;


	PIPE ROW(l_rep);

	-- COBUSUPABS-7190 1.5
	l_rep.rv    := null;
	l_rep.sort := '7010';
	l_rep.kod  := null;
	l_rep.name := '- показники коригування PD :';
	l_rep.s := null;
	
	PIPE ROW(l_rep);
	
	l_rep.rv    := null;
	For p_pd in (select '71'||lpad(q.ord,2,'0') ord, q.kod, q.name, R.NAME as repl
					from FIN_QUESTION q, fin_nd_hist h, FIN_QUESTION_REPLY r
				   where q.idf in (50) 
					 and q.idf = h.idf       and q.kod = h.kod
					 and q.idf = r.idf  	 and q.kod = r.kod
					 and h.s = R.VAL 		 
					 and h.nd = x.nd    	 and h.rnk = x.rnk
					 and h.fdat = x.fdat
			   )
	loop
	l_rep.sort := p_pd.ord;
	l_rep.kod  := p_pd.kod;
	l_rep.name := p_pd.name;
	l_rep.s    := p_pd.repl;
	PIPE ROW(l_rep);
    end loop;
	
	
	
	

	l_rep.rv    := 7;
	l_rep.sort := '8000';
	l_rep.kod  := 'REZ';
	l_rep.name := 'Обсяг сформованогго резерву, який Банк враховує з метою зменшення кредитного ризику';
	l_rep.s    := to_char(x.rez,  g_number_format, g_number_nlsparam);
	PIPE ROW(l_rep);

	l_rep.rv    := 8;
	l_rep.sort := '9000';
	l_rep.kod  := 'CR';
	l_rep.name := 'Розмір кредитного ризику';
	l_rep.s    := to_char(x.cr,  g_number_format, g_number_nlsparam);
	PIPE ROW(l_rep);

	l_rep.rv    := null;
	l_rep.sort := '4200';
	l_rep.kod  := '';
	l_rep.name := '- ознаки високого кредитного ризику';
	l_rep.s    := null;
	PIPE ROW(l_rep);

	For Ovkr in (select '42'||lpad(q.ord,2,'0') ord, q.kod, q.name, R.NAME as repl
					from FIN_QUESTION q, fin_nd_hist h, FIN_QUESTION_REPLY r
				   where q.idf in (52, 5) and q.kod in ('SKK','KVZK','PVKZ','KP612')
					 and q.idf = h.idf       and q.kod = h.kod
					 and q.idf = r.idf  	 and q.kod = r.kod
					 and h.s = R.VAL 		 --and ( (h.s = 1 and q.kod != 'KP61') or (h.s = 0 and q.kod = 'KP61') )
					 and h.nd = x.nd    	 and h.rnk = x.rnk
					 and h.fdat = x.fdat
					 and (h.kod, h.idf) in (select kod, idf from fin_nd_hist where nd = x.nd and rnk = x.rnk and idf in (52,5) and  ( (s = 1 and kod != 'KP61') or (s = 0 and kod = 'KP61') ) and fdat between p_sFdat1 and p_sFdat2  )
			   )
	loop
	l_rep.sort := Ovkr.ord;
	l_rep.kod  := Ovkr.kod;
	l_rep.name := Ovkr.name;
	l_rep.s    := Ovkr.repl;
	PIPE ROW(l_rep);
    end loop;

	l_rep.sort := '4300';
	l_rep.kod  := '';
	l_rep.name := '- ознаки дефолту боржника';
	l_rep.s    := null;
	PIPE ROW(l_rep);

	For Ovkr in (select '43'||lpad(q.ord,2,'0') ord, q.kod, q.name, R.NAME as repl
					from FIN_QUESTION q, fin_nd_hist h, FIN_QUESTION_REPLY r
				   where q.idf in (53)
					 and q.idf = h.idf       and q.kod = h.kod
					 and q.idf = r.idf  	 and q.kod = r.kod
					 and h.s = R.VAL 		 --and h.s = 1
					 and h.nd = x.nd    	 and h.rnk = x.rnk
					 and h.fdat = x.fdat
					  and (h.kod, h.idf) in (select kod, idf from fin_nd_hist where nd = x.nd and rnk = x.rnk and idf = 53 and s = 1 and fdat between p_sFdat1 and p_sFdat2  )
			   )
	loop
	l_rep.sort := Ovkr.ord;
	l_rep.kod  := Ovkr.kod;
	l_rep.name := Ovkr.name;
	l_rep.s    := Ovkr.repl;
	PIPE ROW(l_rep);
    end loop;

	l_rep.sort := '4400';
	l_rep.kod  := '';
	l_rep.name := '- подія дефолту, що настала';
	l_rep.s    := null;
	PIPE ROW(l_rep);

	For Ovkr in (select '44'||lpad(q.ord,2,'0') ord, q.kod, q.name, R.NAME as repl
					from FIN_QUESTION q, fin_nd_hist h, FIN_QUESTION_REPLY r
				   where q.idf in (54)
					 and q.idf = h.idf       and q.kod = h.kod
					 and q.idf = r.idf  	 and q.kod = r.kod
					 and h.s = R.VAL 		 --and h.s = 1
					 and h.nd = x.nd    	 and h.rnk = x.rnk
					 and h.fdat = x.fdat
					 and (h.kod, h.idf) in (select kod, idf from fin_nd_hist where nd = x.nd and rnk = x.rnk and idf = 54 and s = 1 and fdat between p_sFdat1 and p_sFdat2  )
			   )
	loop
	l_rep.sort := Ovkr.ord;
	l_rep.kod  := Ovkr.kod;
	l_rep.name := Ovkr.name;
	l_rep.s    := Ovkr.repl;
	PIPE ROW(l_rep);
    end loop;

	l_rep.sort := '4500';
	l_rep.kod  := '';
	l_rep.name := '- ознаки, за якими Банк припинив визнання дефолту боржника';
	l_rep.s    := null;
	PIPE ROW(l_rep);

	For Ovkr in (select '45'||lpad(q.ord,2,'0') ord, q.kod, q.name, R.NAME as repl
					from FIN_QUESTION q, fin_nd_hist h, FIN_QUESTION_REPLY r
				   where q.idf in (55)
					 and q.idf = h.idf       and q.kod = h.kod
					 and q.idf = r.idf  	 and q.kod = r.kod
					 and h.s = R.VAL 		-- and h.s = 0
					 and h.nd = x.nd    	 and h.rnk = x.rnk
					 and h.fdat = x.fdat
					 and (h.kod, h.idf) in (select kod, idf from fin_nd_hist where nd = x.nd and rnk = x.rnk and idf = 55 and s = 0 and fdat between p_sFdat1 and p_sFdat2  )
			   )
	loop
	l_rep.sort := Ovkr.ord;
	l_rep.kod  := Ovkr.kod;
	l_rep.name := Ovkr.name;
	l_rep.s    := Ovkr.repl;
	PIPE ROW(l_rep);
    end loop;



	end loop;

end f_rep_nbu_351;


function f_rep_z1 ( p_sFdat1 date
                   ,p_kl_m   number
				   ,p_nd     number
				   ,p_rnk    number
                       )
                        RETURN t_rep_nbu_351_1 PIPELINED  PARALLEL_ENABLE
as

  l_rep      t_col_rep_nbu_351_1;
  l_rep_null t_col_rep_nbu_351_1;
  l_okpo     varchar2(12);
  l_dat      date;

PRAGMA AUTONOMOUS_TRANSACTION;
begin

   select okpo
     into l_okpo
     from fin_customer
    where rnk = p_rnk;



 for x in (    select min(add_months(p_sFdat1,-num+1)) fdat , FIN_NBU.ZN_P_ND_DATE_HIST('ZVTP', 51, add_months(p_sFdat1,-num+1), p_nd, p_rnk) zdat
                 from conductor
                where num <= p_kl_m
				  and FIN_NBU.ZN_P_ND_DATE_HIST('ZVTP', 51, add_months(p_sFdat1,-num+1), p_nd, p_rnk) is not null
				  group by FIN_NBU.ZN_P_ND_DATE_HIST('ZVTP', 51, add_months(p_sFdat1,-num+1), p_nd, p_rnk)
		  )
	loop
			l_rep :=  l_rep_null;
			l_rep.nd   := p_nd;
			l_rep.rnk  := p_rnk;
			l_rep.fdat := x.zdat;



			l_rep.rv    := 1;             l_rep.sort := '1000'; 	l_rep.kod  := 'VNKRO'; 			l_rep.name := 'ВКР операції';
			l_rep.s    := fin_obu.GET_VNKR(x.zdat, p_rnk, p_nd);

               if f_get_osbb_k110_type (p_rnk) = 1 and l_rep.s is null then
                l_rep.s    := CCK_APP.GET_ND_TXT( p_nd, 'VNCRR');
               end if;
			PIPE ROW(l_rep);

			l_rep.rv    := 2;            l_rep.sort := '2000';   	l_rep.kod  := 'VNCRP';  		l_rep.name := 'Попередній ВКР контрагента';
			--l_rep.s    := cck_app.Get_ND_TXT_ex( p_nd, 'VNCRP' );
  		    Begin
              Select txt
			    into l_rep.s
				from (
			   Select t.txt, r.ord, ROW_NUMBER() OVER(ORDER BY ord desc) num
				 from nd_txt_update t, cc_deal c, CCK_RATING r, nd_acc n, accounts a
				where tag =  'VNCRP'
                  and (T.CHGDATE, t.nd)  in ( select max(CHGDATE), nd from nd_txt_update where CHGDATE < x.zdat+10 and nd = c.nd and tag =  'VNCRP' group by nd )
				  and c.nd = t.nd
				  and c.rnk = p_rnk
				  and T.CHGDATE <   x.zdat+10 -- fin_nbu.ZN_P_ND_date('DAP', 32, x.fdat, p_nd, p_rnk)+10    -- дата видачі КД
				  and t.txt = R.CODE
                  and n.nd = c.nd
                  AND n.acc = a.acc
                  AND tip = 'LIM'
                  AND nls LIKE '8999%'
                  AND (dazs IS NULL OR dazs > x.zdat)				  )
				Where num = 1;
            exception when no_data_found then
			  l_rep.s := null;
			end;

			PIPE ROW(l_rep);

			l_rep.rv    := 3; 			 l_rep.sort := '3000';		l_rep.kod  := 'VNCRR';			l_rep.name := 'Поточний ВКР контрагента';
			l_rep.s    := null; --fin_obu.GET_VNKR(x.zdat, p_rnk, p_nd);

			Begin
			   Select txt
			    into l_rep.s
				from (
			   Select R.CODE txt, r.ord, ROW_NUMBER() OVER(ORDER BY ord desc) num
				 from cc_deal c, CCK_RATING r, nd_acc n, accounts a
				where c.rnk = p_rnk
				  and fin_obu.GET_VNKR(x.zdat, p_rnk, c.nd) = R.CODE
                  and n.nd = c.nd
                  AND n.acc = a.acc
                  AND tip = 'LIM'
                  AND nls LIKE '8999%'
                  AND (dazs IS NULL OR dazs > x.zdat)  				  )
				Where num = 1;
            exception when no_data_found then
              l_rep.s := null;
              if f_get_osbb_k110_type (p_rnk) = 1 and l_rep.s is null   then
              l_rep.s := CCK_APP.GET_ND_TXT( p_nd, 'VNCRR');
              end if;
             end;
			PIPE ROW(l_rep);


			l_rep.rv    := 4; 			 l_rep.sort := '4000';		l_rep.kod  := 'PIPB';			l_rep.name := 'Інтегралальний показник';
			l_rep.s    :=  to_char(fin_nbu.ZN_P('PIPB', 6, x.zdat,  l_okpo, null),  g_number_format, g_number_nlsparam);
			PIPE ROW(l_rep);

			l_rep.rv    := 5; 			 l_rep.sort := '5000';		l_rep.kod  := 'CLAS';			l_rep.name := 'Клас боржника за інтегральним показником';
			l_rep.s    :=  to_char(fin_nbu.ZN_P('CLAS', 6, x.zdat,  l_okpo, null));
			PIPE ROW(l_rep);

			l_rep.rv    := 6; 			 l_rep.sort := '6000';		l_rep.kod  := 'GRKL';			l_rep.name := 'Клас групи під спільним контролем';
			l_rep.s    :=  fin_nbu.ZN_P_ND_HIST( 'GRKL', 51, x.fdat, p_nd, p_rnk);
			PIPE ROW(l_rep);

			l_rep.rv    := 7; 			 l_rep.sort := '7000';		l_rep.kod  := 'CLS1';			l_rep.name := 'Скоригований клас боржника на клас групи під спільним контролем або групи пов''язаних контрагентів';
			l_rep.s    :=  nvl(fin_nbu.ZN_P_ND_HIST( 'CLS2', 56, x.fdat, p_nd, p_rnk),fin_nbu.ZN_P_ND_HIST( 'CLS1', 56, x.fdat, p_nd, p_rnk));
			PIPE ROW(l_rep);

			l_rep.rv    := 8; 			 l_rep.sort := '8000';		l_rep.kod  := 'CLSP';			l_rep.name := 'Скоригований клас боржника на високий кредитний ризик, події/ознаки дефолту';
			l_rep.s    :=  fin_nbu.ZN_P_ND_HIST( 'CLSP', 56, x.fdat, p_nd, p_rnk);
			PIPE ROW(l_rep);

			For Ovkr in (select '90'||lpad(q.ord,2,'0') ord, q.kod, q.name, R.NAME as repl
							from FIN_QUESTION q, fin_nd_hist h, FIN_QUESTION_REPLY r
						   where q.idf in (50)
							 and q.idf = h.idf       and q.kod = h.kod
							 and q.idf = r.idf  	 and q.kod = r.kod
							 and h.s = R.VAL
							 and h.nd = p_nd    	 and h.rnk = p_rnk
							 and h.fdat = x.fdat
					   )
			loop
			l_rep.rv    := 9;
			l_rep.sort := Ovkr.ord;
			l_rep.kod  := Ovkr.kod;
			l_rep.name := Ovkr.name;
			l_rep.s    := Ovkr.repl;
			PIPE ROW(l_rep);
			end loop;

			l_rep.rv    := 10; 			 l_rep.sort := '9999';		l_rep.kod  := 'PD';			l_rep.name := 'Значення PD на дату оцінки';
			l_rep.s    :=  to_char(fin_nbu.ZN_P_ND_HIST( 'PD', 56, x.fdat, p_nd, p_rnk),  g_number_format, g_number_nlsparam);
			PIPE ROW(l_rep);
	end loop;
end;

function f_entry (p_indic varchar2, p_value varchar2) return varchar2
as
begin
if regexp_like(p_indic, p_value)
   then return 'Так';
   else return 'Ні';
end if;

end;


function get_indicator(  p_okpo  number
						,p_dat  date
						,p_kod  varchar2
						) return number
is
l_tmp number;
FZ_  varchar2(1)  := fin_nbu.F_FM (p_okpo, p_dat ) ;
dat_   date   :=  p_dat;
okpo_  number :=  p_okpo;
begin

 case  p_kod
   when  'SALES'  then
        IF FZ_ = 'N'
		    THEN  l_tmp := fin_nbu.ZN_F2('2000',4,dat_, okpo_) + fin_nbu.ZN_F2('2010',4,dat_, okpo_);
			ELSE  l_tmp := fin_nbu.ZN_F2('2000',4,dat_, okpo_);
		END IF;

   when  'EBIT'  then
        IF FZ_ = 'N'
		    THEN  l_tmp := fin_nbu.ZN_F2('2190',4,dat_, okpo_) - fin_nbu.ZN_F2('2195',4,dat_, okpo_);
			ELSE  l_tmp := fin_nbu.ZN_F2('2000',4,dat_, okpo_) - fin_nbu.ZN_F2('2050',4,dat_, okpo_);
		END IF;

   when  'EBITDA'  then
        IF FZ_ = 'N'
		    THEN  l_tmp := fin_nbu.ZN_F2('2190',4,dat_, okpo_) - fin_nbu.ZN_F2('2195',4,dat_, okpo_) +  fin_nbu.ZN_F2('2515',4,dat_, okpo_);
			ELSE  l_tmp := null;
		END IF;

   when  'TOTAL_NET_DEBT'  then
        IF FZ_ = 'N'
		    THEN  l_tmp := fin_nbu.ZN_F1('1510',4,dat_, okpo_) + fin_nbu.ZN_F1('1515',4,dat_, okpo_) + fin_nbu.ZN_F1('1600',4,dat_, okpo_) + fin_nbu.ZN_F1('1610',4,dat_, okpo_) - fin_nbu.ZN_F1('1165',4,dat_, okpo_);
			ELSE  l_tmp := fin_nbu.ZN_F1('1595',4,dat_, okpo_) + fin_nbu.ZN_F1('1600',4,dat_, okpo_) + fin_nbu.ZN_F1('1610',4,dat_, okpo_) - fin_nbu.ZN_F1('1165',4,dat_, okpo_);
		END IF;


   else l_tmp := null;
 end case;

   return l_tmp;
exception when no_data_found then
      return null;
end;

procedure indicator_601 ( p_rnk     number
                         ,p_nd      number
                         ,p_dat 	date
                         ,p_601     out t_601_kol
						 )
is
l_okpo  customer.okpo%type;
z_dat date;  --дата звітності яка береться до разрахунку 351
l_okpo_grp number;
begin
/*
                              rnk      cc_deal.rnk%type   --
                            , nd       cc_deal.nd%type    --
							, column7  fin_fm.ved%type    --  (K110) – вид економічної діяльності
							, column8  varchar2(4)        -- (ec_year) – період, за який визначено вид економічної діяльності (календарний рік).
							, column9  number             -- (sales) – показник сукупного обсягу реалізації (SALES);
							, column10 number             -- (ebit) – показник фінансового результату від операційної діяльності (EBIT);
							, column11 number             -- (ebitda) – показник фінансового результату від звичайної діяльності до оподаткування фінансових витрат і нарахування амортизації (EBITDA);
							, column12 number             -- (totalDebt)– показник концентрації залучених коштів (TOTAL NET DEBT).
							, column13 number             -- (isMember)– зазначається приналежність боржника до групи юридичних осіб, що перебувають під спільним контролем (так/ні) – 1 знак: 1 – так; 2 – ні
							, column17 number             --  під спільним контролем(sales) – показник сукупного обсягу реалізації (SALES);
							, column18 number             --  під спільним контролем(ebit) – показник фінансового результату від операційної діяльності (EBIT);
							, column19 number             --  під спільним контролем(ebitda) – показник фінансового результату від звичайної діяльності до оподаткування фінансових витрат і нарахування амортизації (EBITDA);
							, column20 number             --  під спільним контролем(totalDebt)– показник концентрації залучених коштів (TOTAL NET DEBT).
							, column21 number             --  під спільним контролем  (classGr) – зазначається клас групи, визначений на підставі консолідованої/комбінованої фінансової звітності
*/

g_601.rnk :=  p_rnk;
g_601.nd  :=  p_nd;

  Begin
     Select okpo
	   into l_okpo
	   from customer
      where rnk =  g_601.rnk;
   exception when no_data_found then
      return;
  end;

  begin
   Select ved, to_char(trunc(fdat-1,'YEAR'),'YYYY')
     into g_601.column7,  g_601.column8
     from fin_fm f
    where okpo = l_okpo
	  and fdat in (select max(fdat)
	                 from fin_fm
					where okpo =  f.okpo
                      and ved is not null);
   exception when no_data_found then
      g_601.column7 := null;
	  g_601.column8 := null;
  end;

  z_dat :=  FIN_NBU.ZN_P_ND_DATE_HIST('ZVTP', 51, p_dat, p_nd, p_rnk);

  g_601.column9   :=  get_indicator(l_okpo,z_dat,'SALES');
  g_601.column10  :=  get_indicator(l_okpo,z_dat,'EBIT');
  g_601.column11  :=  get_indicator(l_okpo,z_dat,'EBITDA');
  g_601.column12  :=  get_indicator(l_okpo,z_dat,'TOTAL_NET_DEBT');
  g_601.column13  :=  FIN_NBU.ZN_P_ND_HIST('NGRK', 51, p_dat, p_nd, p_rnk);
  g_601.column21  :=  FIN_NBU.ZN_P_ND_HIST('GRKL', 51, p_dat, p_nd, p_rnk);


  if g_601.column13 = 1  then


	 Begin
	  Select okpo
		into l_okpo_grp
		from fin_cust
		where okpo like '_'||lpad(lpad(FIN_NBU.ZN_P_ND_HIST('NUMG', 51, p_dat, p_nd, p_rnk),10,'0'),11,'9')
		  and  custtype = 5
		  and rownum = 1;



		Select max(fdat)
		  into z_dat
		  from fin_fm
		 where okpo = l_okpo_grp;

		-- dbms_output.put_line('OkpoGrp='||l_okpo_grp||' ZdatGrp='||to_char(z_dat));


		g_601.column17  :=  get_indicator(l_okpo_grp,z_dat,'SALES');
		g_601.column18  :=  get_indicator(l_okpo_grp,z_dat,'EBIT');
		g_601.column19  :=  get_indicator(l_okpo_grp,z_dat,'EBITDA');
		g_601.column20  :=  get_indicator(l_okpo_grp,z_dat,'TOTAL_NET_DEBT');

	  exception when no_data_found then
		  null;
	  end;

   end if;


   p_601 :=  g_601;
 exception when others then
   p_601 :=  g_601;
end;


END fin_rep;
/
 show err;
 
PROMPT *** Create  grants  FIN_REP ***
grant EXECUTE                                                                on FIN_REP         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FIN_REP         to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/fin_rep.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 