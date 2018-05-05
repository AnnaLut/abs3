
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/value_paper.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE PACKAGE VALUE_PAPER
IS
   
   g_header_version   CONSTANT VARCHAR2 (64) := 'version 1.18 06.03.2018';

   FUNCTION header_version
      RETURN VARCHAR2;

   FUNCTION body_version
      RETURN VARCHAR2;

   TYPE r_cp_v IS RECORD
   (
      DATD       DATE,
      ND         varchar2(20),
      SUMB       NUMBER,
      REF        NUMBER,
      ID         cp_kod.id%TYPE,
      CP_ID      cp_kod.cp_id%TYPE,
      KV         cp_kod.kv%TYPE,
      VIDD       varchar2(4),
      PFNAME     cp_pf.name%TYPE,
      RYN        cp_ryn.name%TYPE,
      DATP       DATE,
      NO_PR      NUMBER,
      BAL_VAR    NUMBER,
      KIL        NUMBER,
      CENA       NUMBER,
      ZAL        NUMBER,
      OSTA       NUMBER,
      OSTAB      NUMBER,
      OSTAF      NUMBER,
      OSTD       NUMBER,
      OST_2VD    NUMBER,
      OSTP       NUMBER,
      OST_2VP    NUMBER,
      OSTR       NUMBER,
      OSTR2      NUMBER,
      OSTR3      NUMBER,
      OSTUNREC   NUMBER,
      ostEXPN    NUMBER,
      ostEXPR    NUMBER,
      OSTS       NUMBER,
      ERAT       NUMBER,
      NO_P       NUMBER,
      ACTIVE     NUMBER
   );

   TYPE t_cp_v_set IS TABLE OF r_cp_v;

   FUNCTION get_cp (p_mode        INT,
                    p_grp         INT,
                    p_T0          INT,
                    p_filtr_id    VARCHAR2,
                    p_date        date default null,
                    p_active      INT DEFAULT 1)
      RETURN t_cp_v_set
      PIPELINED;

   TYPE r_deal_prepare IS RECORD -- окно ввода сделки ЦП, заданное параметрически
   (
      WndTitle            VARCHAR2 (50),        -- заголовок окна ввода сделки
      DDate               DATE,                     -- текущая банковская дата
      DAT_OPL             DATE,
      DAT_KOM             DATE,
      DAT_ROZ             DATE,
      DAT_UG              DATE,
      NMKA                VARCHAR2 (38),
      RNKA                NUMBER (38),
      MFOA                VARCHAR2 (12),
      OKPOA               VARCHAR2 (8),
      NLST                VARCHAR2 (15),
      NLS9                VARCHAR2 (15),
      NLS8                VARCHAR2 (15),
      KOD_NB              VARCHAR2 (100),
      s_KOD_NB            VARCHAR2 (110),
      BICA                VARCHAR2 (250),
      KOD_BA              VARCHAR2 (250),
      baseval             NUMBER,                        -- базовая валюта 980
      VDAT                DATE,                          -- дата валютирования
      SUMBK               NUMBER,                            -- сумма комиссии
      nKv                 INT,
      NLSB_visible        INT,
      cb_NO_PAY           INT,                              -- флаг без оплаты
      cb_NO_PAY_visible   INT,
      cb_NO_PAY_enable    INT,
      cb_Zo               INT,
      cb_Zo_visible       INT,
      cb_Zo_enabled       INT,
      cb_STP              INT,
      cb_STP_visible      INT,
      cb_STP_enabled      INT,
      rb_A_I              INT,
      rb_A_visible        INT,
      rb_I_visible        INT,
      rb_P_title          VARCHAR2 (50),                         --'ПОГАШЕННЯ'
      rb_K_P              INT,                                          --bool
      rb_P_visible        INT,                                          --bool
      rb_P_enabled        INT,                                          --bool
      rb_K_title          VARCHAR2 (50),                         --'ПОГАШЕННЯ'
      rb_K_visible        INT,
      rb_K_enabled        INT,
      sNLS_FXC_visible    INT,
      sNLS_FXC_enable     INT,
      sNMS_FXC_visible    INT,
      sNMS_FXC_enable     INT,
      TRASSA_PL_visible   INT,
      TRASSA_PL_title     VARCHAR2 (50),
      SSA_visible         INT,
      NBKA_visible        INT,
      BICA_visible        INT,
      BICKA_visible       INT,
      SSLA_visible        INT,
      KOD_NB_visible      INT,
      s_KOD_NB_visible    INT,
      BICB_visible        INT,
      KOD_BB_visible      INT,
      KOD_GB_visible      INT,
      NGB_visible         INT,
      BICKB_visible       INT,
      NBKB_visible        INT,
      SSB_visible         INT,
      BICB__visible       INT,
      KOD_BB__visible     INT,
      KOD_GB__visible     INT,
      NGB__visible        INT,
      BICKB__visible      INT,
      NBKB__visible       INT,
      SSB__visible        INT,
      A_                  INT,
      A__visible          INT,
      DP_                 INT,
      DP__visible         INT,
      R_                  INT,
      R__visible          INT,
      rb_AKT_PAS          INT,
      rb_AKT_visible      INT,
      rb_AKT_enabled      INT,
      nId                 NUMBER (38),
      cp_id               VARCHAR2 (20),
      NBKA_               VARCHAR2 (15),
      DAT_EMI             DATE,
      DAT_P               DATE,
      p_nameCP            cp_type.name%TYPE,
      p_nEMI              cp_kod.emi%TYPE,
      p_nameEMI           cp_kod.name%TYPE,
      p_DOX               cp_kod.dox%TYPE,
      p_CP_ID             cp_kod.cp_id%TYPE,
      p_Kv                cp_kod.kv%TYPE,
      p_DATP              cp_kod.datp%TYPE,
      p_RATE              cp_kod.ir%TYPE,
      p_Tipd              cp_kod.tip%TYPE,
      p_DAT_EM            cp_kod.dat_em%TYPE,
      p_DOK               cp_kod.dok%TYPE,
      p_Amort             cp_kod.amort%TYPE,
      p_nDCP              cp_kod.dcp%TYPE,
      p_CENA              cp_kod.CENA%TYPE,
      p_sBASEY            basey.name%TYPE,
      p_nBasey            cp_kod.BASEY%TYPE,
      p_KY                cp_kod.KY%TYPE,
      p_DAT_DNK           cp_kod.DNK%TYPE,
      p_DAT_RR            cp_kod.DAT_RR%TYPE,
      p_CENA_KUP          cp_kod.cena_kup%TYPE,
      p_nCOUNTRY          cp_kod.country%TYPE,
      s6300               accounts.nls%TYPE,
      B_4621              accounts.nls%TYPE,
      B_1819              accounts.nls%TYPE,
      B_1919              accounts.nls%TYPE,
      CB_SWIFT            INT,
      p_REPO              NUMBER
   );

   TYPE t_deal_prepare_set IS TABLE OF r_deal_prepare;

   FUNCTION prepare_wnd_deal (p_nOp         INT,
                              p_fl_END      INT,
                              p_nGrp        INT,
                              p_strPar02    VARCHAR2)
      RETURN t_deal_prepare_set
      PIPELINED;

   --function onchange_cmb_PF(pf cp_pf.pf%type, p_country country.country%type, p_DOX cp_kod.dox%type, p_EMI cp_kod.emi%type) return int;
   TYPE r_CPZ_prepare IS RECORD -- окно ввода сделки ЦП, заданное параметрически
   (
      sDAT        DATE,
      FL          INT,
      k804        INT,
      bDAT        DATE,
      IDu_        NUMBER,
      sf          VARCHAR2 (500),
      sDAT2       DATE,
      ACCS        NUMBER,
      nColumnID   NUMBER,
      Cl_         NUMBER
   );

   TYPE t_CPZ_prepare_set IS TABLE OF r_CPZ_prepare;

   FUNCTION prepare_wnd_cpz (nMode      IN NUMBER, -- = 27 (с проводками), =47 без проводок,
                             nPar       IN NUMBER,       --! методика = 0 АЖИО
                             strPar01   IN VARCHAR2,
                             strPar02   IN VARCHAR2)
      RETURN t_CPZ_prepare_set
      PIPELINED;

   FUNCTION calc_R_kupon (p_DAT_ROZ    DATE,
                          p_ID         cp_kod.id%TYPE,
                          p_SUMBN      NUMBER)
      RETURN NUMBER;


PROCEDURE F_SAVE (p_fl_END      IN     INT,
                  p_rb_K_P      IN     INT,
                  p_nOP         IN     INT,
                  p_NTIK        IN     VARCHAR2,
                  p_NBB         IN     VARCHAR2,
                  p_cb_Zo       IN     INT,
                  p_CP_AI       IN     INT,
                  p_nTipd       IN     INT,
                  p_nGrp        IN     INT,
                  p_nID         IN     NUMBER,
                  p_nVidd       IN     NUMBER,
                  p_nRYN        IN     NUMBER,
                  p_DAT_UG      IN     DATE,
                  p_DAT_OPL     IN     DATE,
                  p_DAT_ROZ     IN     DATE,
                  p_DAT_KOM     IN     DATE,
                  p_SUMBN       IN     NUMBER,
                  p_SUMB        IN     NUMBER,
                  p_RR_         IN     NUMBER,
                  p_SUMBK       IN     NUMBER,
                  p_sNazn       IN     VARCHAR2,
                  p_NLS9        IN     VARCHAR2,
                  p_B_4621      IN     VARCHAR2,
                  p_B_1819      IN     VARCHAR2,
                  p_B_1919      IN     VARCHAR2,
                  p_sREF           OUT VARCHAR2,
                  p_sErr           OUT VARCHAR2,
                  p_Nazn           OUT VARCHAR2,
                  p_REF_MAIN       OUT VARCHAR2,
                  -- вторая часть по комиссии
                  P_SK          IN     NUMBER,
                  P_SKV         IN     NUMBER, -- валюта комиссии!
                  p_BICA        IN     VARCHAR2,
                  p_BICKB_      IN     VARCHAR2,
                  p_cb_SWIFT    IN     INT,
                  p_SSA         IN     VARCHAR2,
                  p_SSB_        IN     VARCHAR2,
                  p_cb_NO_PAY   IN     INT,
                  p_cb_KS       IN     INT,
                  p_nDCP        IN     INT default 0,
                  p_MFOB_       IN     varchar2,
                  p_OKPOB_      IN     varchar2,
                  p_NLSB_       IN     varchar2,
                  p_NBB_        IN     varchar2,
                  --------
                  p_KOD_BB      IN     varchar2,
                  p_KOD_GB      IN     varchar2,
                  p_KOD_NB      IN     varchar2,
                  --------
                  p_sNLS_FXC    IN     varchar2,
                  p_sNMS_FXC    IN     varchar2,
                  p_repo        IN     number);


  PROCEDURE setNazn (p_REF_MAIN   IN     VARCHAR2,
                     p_Nazn       IN     VARCHAR2,
                     p_sErr          OUT VARCHAR2);
  procedure setSpecparam(p_REF_MAIN   IN     VARCHAR2,
                         p_COD_I      IN     VARCHAR2,
                         p_COD_M      IN     VARCHAR2,
                         p_COD_F      IN     VARCHAR2,
                         p_sErr          OUT VARCHAR2);


TYPE r_cp_cprwnd
   IS record  (p_cb_Zo_visible      int,
               p_SUMI_ALL_visible   int,
               p_pbFilter_visible   int,
               p_KV_enabled         int,
               p_nDOX_enabled       int,
               p_nEMI_enabled       int,
               p_DATP               date,
               p_RATE               number,
               p_DAT_EM             date,
               p_CENA               number,
               p_nTipD              int,
               p_KV                 number,
               p_nDOX               int,
               p_nEMI               int,
               p_id                 number);

  TYPE t_cp_cprwnd IS TABLE OF r_cp_cprwnd;
  function prepare_cpr_wnd(
                            strPar01   IN VARCHAR2,
                            strPar02   IN VARCHAR2,
                            nGrp       IN NUMBER,
                            nMode      IN NUMBER)
      RETURN t_cp_cprwnd PIPELINED;

  type r_cp_cprgrid is record (p_NLSA accounts.nls%type,
                               p_OSTA number,
                               p_NLSR accounts.nls%type,
                               p_OSTR number,
                               p_NLSR2 accounts.nls%type,
                               p_OSTR2 number,
                               p_NLSR3 accounts.nls%type,
                               p_OSTR3 number,
                               p_ACC accounts.nls%type,
                               p_ACR_DAT_INT int_accn.acr_dat%type,
                               p_OSTR_REAL number,
                               p_ACR_DAT date,
                               p_APL_DAT date,
                               p_SUMI_ALL number);

  TYPE t_cp_cprgridset IS TABLE OF r_cp_cprgrid;

  function populate_cpr_wnd (
                            strPar01   IN VARCHAR2,
                            strPar02   IN VARCHAR2,
                            nGrp       IN NUMBER,
                            nMode      IN NUMBER,
                            p_nRyn     IN NUMBER,
                            p_nPf      IN NUMBER)
  return t_cp_cprgridset pipelined;

 PROCEDURE saveCPR (p_nTipD      IN     INT,
                   p_cb_Zo      IN     INT,
                   p_nGrp       IN     INT,
                   p_nID        IN     INT,
                   p_nRYN       IN     INT,
                   p_nVidd      IN     VARCHAR2,
                   p_SUMK       IN     NUMBER,
                   p_sREF          OUT VARCHAR2,
                   p_sErr          OUT VARCHAR2,
                   p_REF_MAIN      OUT VARCHAR2);

 PROCEDURE make_amort( p_grp       IN  INT,
                       p_filtr_id  IN  VARCHAR2,
                       p_date      IN  DATE,
                       s_Err        OUT varchar2);
 function get_sumi_all (strPar01 in varchar2, kv in number, pf in number, emi in number, vidd in varchar2,  dox in number, Ryn in number) return number;


 TYPE r_cp_irrwnd
     IS record (p_nIdN int,
                p_nIdE int,
                p_PERIOD_KUP int,
                p_DOK date,
                p_DNK date,
                p_DATP date,
                p_DAT_EM date,
                p_KY int,
                p_CENA number,
                p_IR_N0 number,
                p_CENA_KUP number,
                p_vDat date,
                P_nN number,
                p_rb_NEW int,
                p_NOM_UG varchar2(10),
                p_IRR number,
                p_IRE number,
                p_ref number,
                p_id number,
                p_cp_id varchar2(30),
                p_dat_ug date);
 type t_cp_irrwnd is table of r_cp_irrwnd;

 function prepare_irr_wnd(p_nMode1 in number, p_REF in number, p_ID in number,  strPar01 in varchar2, strPar02 in varchar2, pDAT_UG in date)
      RETURN t_cp_irrwnd PIPELINED;

 type r_cp_irrgrid is record
      (p_FDAT date,
      p_SS1 number,
      p_SDP number,
      p_nDP number,
      p_SN2 number,
      p_kR2 number,
      p_KolR int,
      p_KolP int,
      p_S number);

 type t_cp_irrgrid is table of r_cp_irrgrid;

 function populate_irr_grid(p_nMode1 in number, p_REF in number,  p_ID in number,  strPar01 in varchar2, strPar02 in varchar2, pDAT_UG in date)
  RETURN t_cp_irrgrid PIPELINED;

 procedure del_iir(p_REF in number);

 TYPE r_prepare_many_wnd is record(
        IRR           number,
        IRE           number,
        NONIMAL       number,
        nAcc          number,
        nOst          number,
        nAccR2        number,
        nFixed        number,
        DAT_EM        date,
        DATP          date,
        IR            number,
        nBasey        number,
        sBasey        varchar2(50),
        sBasey1       varchar2(50),
        CENA          number,
        CENA_START    number,   
        KOL           number,
        nAccS         number,
        DAT1          date,
        DAT2          date,
        DAT_ROZ       date
 );
 TYPE t_r_prepare_many_wnd IS TABLE OF r_prepare_many_wnd;

 function prepare_many_wnd (p_ref IN NUMBER)
  return t_r_prepare_many_wnd pipelined;

TYPE r_many_grid
   IS record(FDAT date,
             NDD number,
             DNEY number,
             G1 number,
             G2 number,
             G3 number,
             G4 number,
             G5 number,
             G6 number,
             G7 number,
             G8 number,
             G9 number,
             G9A number,
             G10 number,
             G10A number,
             G11 number,
             G11A number,
             G12 number,
             G12A number,
             g13 number,
             g13A number,
             G14 number,
             color_id number);
 TYPE t_many_grid IS TABLE OF r_many_grid;
 
/* function populate_many_row_wnd (p_ref IN NUMBER, rb1 in int, rb2 in int, DAT_ROZ in date)
  return t_many_grid pipelined;
*/  

 function populate_many_wnd (p_ref IN NUMBER, rb1 in int, rb2 in int, DAT_ROZ in date)
  return t_many_grid pipelined;

 /*CPV*/

 TYPE r_cpv_wnd
     IS record (p_SUMRI number,
                p_SUMNI number,
                p_SUMNZ number,
                p_SUMRZ number,
                p_cb_Zo int,
                p_cb_STP int,
                p_DATP date,
                p_RATE number,
                p_DAT_EM date,
                p_CENA number,
                p_nTipd int,
                p_KV number);
 type t_cpv_wnd is table of r_cpv_wnd;

 function prepare_cpv_wnd(p_ID number, nGRP in INT)
      RETURN t_cpv_wnd PIPELINED;

 type r_cpv_grid is record (
      p_DATP date,
      p_RATE number,
      p_DAT_EM date,
      p_CENA number,
      p_nTipd int,
      p_nVidd varchar2(4),
      p_KV number,
      p_OKPO varchar2(10),
      p_NB VARCHAR2(38),
      p_MFO varchar2(6),
      p_NLS varchar2(14),
      p_NOM number,
      p_KUPON number,
      p_SERR number,
      p_OSTA number,
      p_OSTR number);

 type t_cpv_grid is table of r_cpv_grid;

  function populate_cpv_wnd(p_ID in number, nRYN in int, nGRP in INT)
  return t_cpv_grid pipelined;

  FUNCTION CONCAT_BLOB(A IN BLOB, B IN BLOB) RETURN BLOB;

  type r_int_prepare is record ( runn   number,
                                 acc    accounts.acc%type,
                                 nmsa   accounts.nms%type,
                                 nlsa   accounts.nls%type,
                                 kva    accounts.kv%type,
                                 id_a   customer.okpo%type,
                                 nmsb   accounts.nms%type,
                                 nlsb   accounts.nls%type,
                                 kvb    accounts.kv%type,
                                 id_b   customer.okpo%type,
                                 fdat   date,
                                 tdat   date,
                                 ir     number,
                                 ostt   number,
                                 int    number,
                                 ost    number,
                                 nazn   oper.nazn%type,
                                 tt     oper.tt%type);
  type t_int_prepare is table of r_int_prepare;
  function make_int_prepare return t_int_prepare pipelined;

  subtype r_nbu23_rez is nbu23_rez%rowtype;
  type t_nbu23_rez is table of r_nbu23_rez;
  function populate_nbu23_rez(p_ref in number) return t_nbu23_rez pipelined;

  procedure calc_many(p_ref cp_many.ref%type);

  procedure change_spec_cond(p_id      cp_spec_cond.id%type,
                             p_type_op number) ; --1 додати (бронь), 2-змінити (бронь), 3-видалити, 4-зняти помітку про видалення

 --Існує функція по нарахуванню купону make_int_prepare
 --Ця ж функція для можливості нарахування дивідентів (інший рахунок чим звичайне нарахування, суму вкажуть вручну)
 --Ньюанс - якщо для угоди невідкритий внесистемний рахунок дивідентів, то відкрити його та підвязати до угоди.
  procedure make_int_dividends_prepare(p_ref cp_deal.ref%type default null);

  procedure change_int_dividends_prepare(p_ref cp_int_dividents.ref%type, p_sum cp_int_dividents.sum%type, p_nazn cp_int_dividents.nazn%type);
  procedure make_oper_cp_int_dividends (p_ref cp_int_dividents.ref%type, p_sum cp_int_dividents.sum%type, p_nazn cp_int_dividents.nazn%type, p_nlsrd_6 cp_int_dividents.nlsrd_6%type);
  
  function get_cena_voprosa(p_id cp_kod.id%type, p_date date, p_cena cp_kod.cena%type, p_cena_start cp_kod.cena_start%type)   return number;
  function get_count_cp(p_id cp_kod.id%type, p_date date, p_cena cp_kod.cena%type, p_cena_start cp_kod.cena_start%type, p_acc cp_deal.acc%type) return number;

END value_paper;
/
CREATE OR REPLACE PACKAGE BODY VALUE_PAPER
IS
   g_body_version   CONSTANT VARCHAR2 (64) := 'version 1.29 06.03.2018';

   g_newline constant varchar2(5) := CHR(10)||CHR(13);
   FUNCTION body_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN 'Package body value_paper ' || g_body_version;
   END body_version;


   FUNCTION header_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN 'Package body value_paper ' || g_body_version;
   END header_version;

   FUNCTION get_cp (p_mode        INT,
                    p_grp         INT,
                    p_T0          INT,
                    p_filtr_id    VARCHAR2,
                    p_date        date default null,
                    p_active      INT DEFAULT 1)
      RETURN t_cp_v_set
      PIPELINED
   IS
      l_cp_v         r_cp_v;
      l_filtr_id    VARCHAR2(4000);

      TYPE CPVCurTyp IS REF CURSOR;

      v_cpv_cursor   CPVCurTyp;
      v_stmt_str     VARCHAR2 (14000);
      l_active       VARCHAR2 (14);
      l_date date;
   BEGIN
      bars_audit.info(p_filtr_id);

      IF (p_date IS NULL or p_date = gl.bd)
      THEN l_date := gl.bd;
      ELSE l_date := p_date;
      END IF;
      bars.pul.put('cp_v_date', to_char(l_date,'dd.mm.yyyy'));

      if (p_filtr_id is null) then l_filtr_id := ' 1=1 ';
      else l_filtr_id := p_filtr_id;
      end if;
      bars_audit.info(l_filtr_id);
      if    (p_mode = 5 ) then l_filtr_id := l_filtr_id || ' and  CP_V_NEW.tip=1 ';
      elsif (p_mode = 6 ) then l_filtr_id := l_filtr_id || ' and  CP_V_NEW.tip=2 ';
      elsif (p_mode = 7 ) then l_filtr_id := l_filtr_id || ' and  CP_V_NEW.kv=980 ';
      elsif (p_mode = 8 ) then l_filtr_id := l_filtr_id || ' and  CP_V_NEW.kv !=980 ';
      end if;
      if (p_active = 0) then l_active := '-1'; end if;
      if (p_active = 1) then l_active := '0,1';end if;
      v_stmt_str :=
            'select DATD, nvl(ND,''-'') ND, SUMB, REF, ID, CP_ID, KV, VIDD, PFNAME, RYN, MDATE as DATP, nvl(NO_PR,0.00) NO_PR, BAL_VAR, KIL, CENA, nvl(ZAL,0) ZAL, OSTA, OSTAB, OSTAF, OSTD, OST_2VD, OSTP, OST_2VP, OSTR, OSTR2, OSTR3, OSTUNREC, OSTEXPN, OSTEXPR, OSTS, ERAT, NO_P, ACTIVE from CP_V_NEW where '
         || '(' || l_filtr_id ||') '
         || ' and active in ('
         || l_active || ')';
      pul.Set_Mas_Ini('cp_filter',  l_filtr_id, 'Фільтр для нарахування за пакетами, обраними на екрані ЦП');
      BARS_AUDIT.INFO(v_stmt_str);

      OPEN v_cpv_cursor FOR v_stmt_str;

      LOOP
         FETCH v_cpv_cursor INTO l_cp_v;
         EXIT WHEN v_cpv_cursor%NOTFOUND;
         PIPE ROW (l_cp_v);
      END LOOP;

      CLOSE v_cpv_cursor;
   END;


   FUNCTION prepare_wnd_deal (p_nOp         INT,
                              p_fl_END      INT,
                              p_nGrp        INT,
                              p_strPar02    VARCHAR2)
      RETURN t_deal_prepare_set
      PIPELINED
   IS
      l_deal_prepare   r_deal_prepare;
      l_cp_kod         cp_kod%ROWTYPE;
      l_cp_deal        cp_deal%ROWTYPE;
   BEGIN
     bars_audit.info('prepare_wnd_deal starts');
    -- везде это вх параметры окна. но это дурня. надо прописать в параметры, в атрибуты (по новому). Пока так
      l_deal_prepare.B_4621 := '37392555';
      l_deal_prepare.B_1819 := '35413555';
      l_deal_prepare.B_1919 := '36412555';

      IF (TRIM (p_strPar02) IS NULL)
      THEN
         bars_audit.info (p_strPar02);
         RETURN;
      ELSE
         -- инит заголовка окна
         l_deal_prepare.WndTitle :=
            CASE
               WHEN p_nOp = 1
               THEN
                  CASE
                     WHEN p_fl_END = 0
                     THEN 'Нова угода купівлі ЦП інш.емітенту'
                     WHEN p_fl_END = 1
                     THEN 'Викуп ЦП власної емісії (по одному)'
                  END
               WHEN p_nOp = 2
               THEN
                  CASE
                     WHEN p_fl_END = 0
                     THEN 'Нова угода ПРОДАЖУ ЦП'
                     WHEN p_fl_END = 1
                     THEN 'Погашення номіналу ЦП інших емітентів'
                  END
               WHEN p_nOp = 3
               THEN 'РЕПО'
               WHEN p_nOp = -1
               THEN 'Угода продажу конкретного ВИБРАНОГО пакета ЦП'
            END;

         -- инит дат
         l_deal_prepare.DDate := gl.bd;
         l_deal_prepare.DAT_OPL := l_deal_prepare.DDate;
         l_deal_prepare.DAT_KOM := l_deal_prepare.DDate;
         l_deal_prepare.DAT_ROZ := l_deal_prepare.DDate;
         l_deal_prepare.DAT_UG := l_deal_prepare.DDate;

         -- инит общих параметров
         l_deal_prepare.NMKA := GetGlobalOption ('NAME');
         l_deal_prepare.MFOA := GetGlobalOption ('MFO');
         l_deal_prepare.OKPOA := LPAD (NVL ( (GetGlobalOption ('OKPO')), '0'), 8, '0');
         l_deal_prepare.NLST := l_deal_prepare.B_4621;
         l_deal_prepare.SUMBK := 0;

         SELECT nlsk
           INTO l_deal_prepare.NLS9
           FROM tts
          WHERE tt = 'FXN';

         SELECT nlsk
           INTO l_deal_prepare.NLS8
           FROM tts
          WHERE tt = 'FXE';

         SELECT nlsk
           INTO l_deal_prepare.s6300
           FROM tts WHERE tt='FXP';

         BEGIN
            SELECT o.val, b.TRANSDESC
              INTO l_deal_prepare.KOD_NB, l_deal_prepare.s_KOD_NB
              FROM OP_RULES o, BOPCODE b
             WHERE o.tt = 'FXC' AND o.tag = 'KOD_N' AND b.TRANSCODE = o.val;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN l_deal_prepare.KOD_NB := '';
         END;

         BEGIN
            SELECT TO_NUMBER (val)
              INTO l_deal_prepare.RNKA
              FROM params
             WHERE par = 'RNK_CP';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN l_deal_prepare.RNKA := GetGlobalOption ('OUR_RNK');
         END;

         --bars_audit.info (3);

         BEGIN
            SELECT val
              INTO l_deal_prepare.BICA
              FROM params
             WHERE par = 'BICCODE';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN l_deal_prepare.BICA := '';
         END;

         BEGIN
            SELECT val
              INTO l_deal_prepare.KOD_BA
              FROM params
             WHERE par = '1_PB';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN l_deal_prepare.KOD_BA := '';
         END;

         BEGIN
            SELECT val
              INTO l_deal_prepare.baseval
              FROM params
             WHERE par = 'BASEVAL';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN l_deal_prepare.baseval := 980;
         END;

         IF (l_deal_prepare.baseval = 980)
         THEN
            BEGIN
               SELECT CASE
                         WHEN TRIM (val) >= l_deal_prepare.DDate
                         THEN
                            (SELECT MAX (FDAT)
                               FROM fdat
                              WHERE TO_CHAR (fdat, 'yyMM') <
                                       TO_CHAR (l_deal_prepare.DDate, 'yyMM')) -- Достанем последний раб день пред мес
                         ELSE
                            l_deal_prepare.DDate
                      END
                 INTO l_deal_prepare.VDAT
                 FROM PARAMS
                WHERE UPPER (par) = 'DAY_ZO';
            EXCEPTION
               WHEN OTHERS
               THEN
                  l_deal_prepare.VDAT := l_deal_prepare.DDate;
            END;
            l_deal_prepare.cb_Zo_enabled := 1;
            l_deal_prepare.cb_Zo_visible := 1;
            l_deal_prepare.cb_STP_visible := 1;
            l_deal_prepare.cb_STP_enabled := 1;
         END IF;

         -- инит контролов общий
         l_deal_prepare.sNLS_FXC_visible := 0;
         l_deal_prepare.sNMS_FXC_visible := 0;

         bars_audit.info('p_strPar02 = ' || p_strPar02);
         -- в зависимости от входящего параметра p_strPar02 (может прити код ЦП или референс сделки для РЕПО)
         IF (UPPER (REPLACE (p_strPar02, ' ', '')) LIKE 'ID=%')
         THEN
            l_cp_kod.id :=
               safe_to_number (
                  REPLACE (UPPER (REPLACE (p_strPar02, ' ', '')), 'ID=', ''));

         ELSIF (UPPER (REPLACE (p_strPar02, ' ', '')) LIKE 'REF=%')
         THEN

            l_cp_deal.REF := safe_to_number(REPLACE (UPPER (REPLACE (p_strPar02, ' ', '')), 'REF=', ''));

            select *
              into l_cp_deal
              from cp_deal
             where ref = l_cp_deal.REF;

            SELECT id
              INTO l_cp_kod.id
              FROM cp_deal
             WHERE REF = l_cp_deal.REF;
         END IF;

         if (p_nOp = 1)
           then
            l_deal_prepare.rb_K_P := 0;
            IF (l_deal_prepare.baseval != 980)
            THEN
               l_deal_prepare.cb_STP_visible := 0;
               l_deal_prepare.cb_STP_enabled := 0;
            END IF;

            IF (p_fl_END = 1)
            THEN
               l_deal_prepare.rb_K_title := 'ПОГАШЕННЯ';
               l_deal_prepare.rb_P_title := 'ПОГАШЕННЯ';
               l_deal_prepare.rb_K_enabled := 1;
               l_deal_prepare.rb_K_visible := 1;
               l_deal_prepare.rb_P_visible := 0;
               l_deal_prepare.rb_P_enabled := 0;
            ELSE
               l_deal_prepare.rb_K_title := 'КУПІВЛІ';
               l_deal_prepare.rb_P_title := 'ПРОДАЖУ';
               l_deal_prepare.rb_K_enabled := 1;
               l_deal_prepare.rb_K_visible := 1;
               l_deal_prepare.rb_P_visible := 1;
               l_deal_prepare.rb_P_enabled := 0;
            END IF;
         elsif (p_nOp = 2)
           then
            l_deal_prepare.rb_K_P := 1;
            l_deal_prepare.cb_STP_visible := 0;
            l_deal_prepare.cb_STP_enabled := 0;
            IF (p_fl_END = 1)
            THEN
               l_deal_prepare.rb_K_title := 'ПОГАШЕННЯ';
               l_deal_prepare.rb_P_title := 'ПОГАШЕННЯ';
               l_deal_prepare.rb_K_enabled := 0;
               l_deal_prepare.rb_K_visible := 0;
               l_deal_prepare.rb_P_visible := 1;
               l_deal_prepare.rb_P_enabled := 1;
            ELSE
               l_deal_prepare.rb_K_title := 'КУПІВЛІ';
               l_deal_prepare.rb_P_title := 'ПРОДАЖУ';
               l_deal_prepare.rb_K_enabled := 1;
               l_deal_prepare.rb_K_visible := 1;
               l_deal_prepare.rb_P_enabled := 1;
               l_deal_prepare.rb_P_visible := 1;
            END IF;
         elsif (p_nOp = -1)
           then
            l_deal_prepare.rb_K_P := 1;
            l_deal_prepare.cb_STP_visible := 0;
            l_deal_prepare.cb_STP_enabled := 0;
            l_deal_prepare.rb_P_title := 'ПРОДАЖУ R.' || TO_CHAR (l_cp_deal.REF);
            l_deal_prepare.rb_P_enabled := 1;
            l_deal_prepare.rb_P_visible := 1;
         end if;

            SELECT t.name,
                   k.EMI,
                   k.name,
                   k.DOX,
                   k.CP_ID,
                   k.KV,
                   k.DATP,
                   NVL (k.IR, 0),
                   k.tip,
                   k.DAT_EM,
                   NVL (k.DOK, k.DAT_EM),
                   k.amort,
                   NVL (k.DCP, 0),
                   k.cena,
                   y.name,
                   y.basey,
                   k.KY,
                   k.DNK,
                   k.DAT_RR,
                   k.cena_kup,
                   k.COUNTRY
              INTO l_deal_prepare.p_nameCP,
                   l_deal_prepare.p_nEMI,
                   l_deal_prepare.p_nameEMI,
                   l_deal_prepare.p_DOX,
                   l_deal_prepare.p_CP_ID,
                   l_deal_prepare.p_Kv,
                   l_deal_prepare.p_DATP,
                   l_deal_prepare.p_RATE,
                   l_deal_prepare.p_Tipd,
                   l_deal_prepare.p_DAT_EM,
                   l_deal_prepare.p_DOK,
                   l_deal_prepare.p_Amort,
                   l_deal_prepare.p_nDCP,
                   l_deal_prepare.p_CENA,
                   l_deal_prepare.p_sBASEY,
                   l_deal_prepare.p_nBasey,
                   l_deal_prepare.p_KY,
                   l_deal_prepare.p_DAT_DNK,
                   l_deal_prepare.p_DAT_RR,
                   l_deal_prepare.p_CENA_KUP,
                   l_deal_prepare.p_nCOUNTRY
              FROM cp_kod k, basey y, cp_type t
             WHERE     k.id = l_cp_kod.id
                   AND k.idt = t.idt(+)
                   AND NVL (k.basey, 0) = y.basey;
         l_deal_prepare.CB_SWIFT :=
         case when  l_deal_prepare.p_Kv = l_deal_prepare.baseval and l_deal_prepare.baseval = 980
         then 1
         else 0
         end;
         /* говорят, что никода не используется. тогда нафик
         begin
            SELECT t.nlsk,
                   (SELECT SUBSTR (a.nms, 1, 38)
                      FROM accounts a
                     WHERE a.nls = t.nlsk AND a.kv = l_deal_prepare.p_Kv)
              INTO l_deal_prepare.sNLS_FXC, l_deal_prepare.sNMS_FXC
              FROM tts t
             WHERE t.tt = 'FXC';
             l_deal_prepare.sNLS_FXC_visible := 1;
             l_deal_prepare.sNLS_FXC_enable  := 0;
         EXCEPTION
           WHEN NO_DATA_FOUND
           THEN l_deal_prepare.KOD_NB := '';
           l_deal_prepare.sNLS_FXC_visible := 1;
           l_deal_prepare.sNLS_FXC_enable := 1;
         end;*/

         BEGIN
            SELECT *
              INTO l_cp_kod
              FROM cp_kod
             WHERE id = l_cp_kod.id;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               RAISE;
         END;

         l_deal_prepare.nId := l_cp_kod.ID;
         l_deal_prepare.CP_ID := l_cp_kod.CP_ID;
         l_deal_prepare.nKv := l_cp_kod.kv;
         l_deal_prepare.NLSB_visible := 1;
         IF (l_deal_prepare.nKv = l_deal_prepare.baseval)
         THEN
            IF (l_deal_prepare.rb_K_P = 0)
            THEN
               l_deal_prepare.NLSB_visible := 1;
            ELSE
               l_deal_prepare.NLSB_visible := 0;
            END IF;

            l_deal_prepare.TRASSA_PL_visible := 0;
            l_deal_prepare.SSA_visible := 0;
            l_deal_prepare.NBKA_visible := 0;
            l_deal_prepare.BICA_visible := 0;
            l_deal_prepare.BICKA_visible := 0;
            l_deal_prepare.SSLA_visible := 0;
            l_deal_prepare.KOD_NB_visible := 0;
            l_deal_prepare.s_KOD_NB_visible := 0;
            l_deal_prepare.BICB_visible := 0;
            l_deal_prepare.KOD_BB_visible := 0;
            l_deal_prepare.KOD_GB_visible := 0;
            l_deal_prepare.NGB_visible := 0;
            l_deal_prepare.BICKB_visible := 0;
            l_deal_prepare.NBKB_visible := 0;
            l_deal_prepare.SSB_visible := 0;
         ELSE
            --l_deal_prepare.TRASSA_PL_visible := 1;
            --l_deal_prepare.KOD_NB_visible := 1;
            --l_deal_prepare.s_KOD_NB_visible := 1;
            --l_deal_prepare.NLSB_visible := 1;
            --l_deal_prepare.BICB_visible := 1;
            --l_deal_prepare.KOD_BB_visible := 1;
            --l_deal_prepare.KOD_GB_visible := 1;
            --l_deal_prepare.NGB_visible := 1;
            /* отключаю за ненадобностью (Нестренко Татьяна)
            IF (l_deal_prepare.rb_K_P = 0)
            THEN
               l_deal_prepare.TRASSA_PL_title := 'Траса платежу ВИХідного';
               l_deal_prepare.SSA_visible := 1;
               l_deal_prepare.NBKA_visible := 1;
               l_deal_prepare.BICKA_visible := 1;
               l_deal_prepare.SSLA_visible := 1;
               l_deal_prepare.BICKB_visible := 1;
               l_deal_prepare.SSB_visible := 1;
               l_deal_prepare.NBKB_visible := 1;
             --  l_deal_prepare.sNLS_FXC_visible := 1;
             --  l_deal_prepare.sNMS_FXC_visible := 1;
               l_deal_prepare.A__visible := 1;
               l_deal_prepare.DP__visible := 1;
               l_deal_prepare.R__visible := 1;
            ELSE
               l_deal_prepare.TRASSA_PL_title := 'Траса платежу ВХідного';

                 SELECT SUBSTR (NMS, 1, 38)
                   INTO l_deal_prepare.NBKA_
                   FROM ACCOUNTS
                  WHERE     KV = l_deal_prepare.nKv
                        AND DAZS IS NULL
                        AND ACC IN (SELECT ACC FROM BIC_ACC)
               ORDER BY NLS;

               l_deal_prepare.SSA_visible := 1;
               l_deal_prepare.BICKA_visible := 1;
               l_deal_prepare.NBKA_visible := 1;
               l_deal_prepare.SSLA_visible := 1;
               l_deal_prepare.SSB_visible := 1;
               l_deal_prepare.NBKB_visible := 1;
               l_deal_prepare.BICKB_visible := 1;
               l_deal_prepare.A__visible := 0;
               l_deal_prepare.DP__visible := 0;
               l_deal_prepare.R__visible := 0;
            END IF;*/

            l_deal_prepare.DAT_OPL := l_deal_prepare.DAT_UG;
            l_deal_prepare.DAT_KOM := l_deal_prepare.DAT_UG;
            l_deal_prepare.DAT_ROZ := l_deal_prepare.DAT_UG;
         END IF;

         l_deal_prepare.DAT_EMI := l_cp_kod.DAT_EM;
         l_deal_prepare.DAT_P := l_cp_kod.DATP;

      END IF;
      l_deal_prepare.rb_AKT_visible := 1;
      bars_audit.info('l_deal_prepare.p_Tipd = '||l_deal_prepare.p_Tipd);
      if (l_deal_prepare.p_Tipd = 1)
      then l_deal_prepare.rb_AKT_PAS := 0;
      else l_deal_prepare.rb_AKT_PAS := 1;
      end if;
     /*
      if (p_nOp = 1 and  p_fl_END = 1)
      then l_deal_prepare.rb_AKT_PAS := 0; l_deal_prepare.rb_AKT_visible := 1;
      else l_deal_prepare.rb_AKT_PAS := 1; l_deal_prepare.rb_AKT_visible := 1;
      end if;
      */
      l_deal_prepare.rb_A_I := 0;
      if (l_deal_prepare.p_nCOUNTRY = 804 and GetGlobalOption('CP_AKC') = '1' and l_deal_prepare.rb_K_P = 1  and l_deal_prepare.rb_AKT_PAS = 1)
      then
      l_deal_prepare.rb_A_visible := 1;
      l_deal_prepare.rb_I_visible := 1;
      end if;

      PIPE ROW (l_deal_prepare);
   END;

 function prepare_wnd_cpz(nMode in number, -- = 27 (с проводками), =47 без проводок,
                        nPar in number,  --! методика = 0 АЖИО
                        strPar01 in varchar2,
                        strPar02 in varchar2) return t_CPZ_prepare_set PIPELINED
 is
  l_CPZ_prepare        r_CPZ_prepare;
 begin
  BARS_AUDIT.INFO('value_paper.prepare_wnd_cpz: starts with params: nMode= '|| to_char(nMode)|| ', nPar= ' || to_char(nPar) || ', strPar01= ' || strPar01 || ', strPar02='|| strPar02);

  begin
   SELECT to_number(val) into l_CPZ_prepare.k804
    FROM params
    where par='KOD_G';
  exception when no_data_found then l_CPZ_prepare.k804 := 840;
  end;

  pipe row(l_CPZ_prepare);
 end;

 function calc_R_kupon(p_DAT_ROZ date, p_ID cp_kod.id%type, p_SUMBN number) return number
 is
  l_DOK     date;
  l_DNK     date;
  l_CENA    number;
  l_KY      int;
  l_IR      number;
  l_DAT_RR  date;
  l_CENA_KUP number;
  l_PR1_KUP number;
  l_KUPON1  number;
  l_result  number;
  l_kol     number;
  l_DEL_KUP1 number;
  l_DEL_KUP2 number;
 begin
  begin
   SELECT nvl(DOK,DAT_EM),
                nvl(DNK, nvl(DOK,DAT_EM)+PERIOD_KUP),
                CENA,
                Nvl(KY,1),
                IR,
                DAT_RR,
                CENA_KUP,
                nvl( PR1_KUP, decode (kv, 980, 2, 1)),
                cp.KUPON1 ( id, p_DAT_ROZ, dat_em, datp)
           into  l_DOK, l_DNK, l_CENA, l_KY, l_IR, l_DAT_RR, l_CENA_KUP, l_PR1_KUP, l_KUPON1
           from cp_kod
          where id= p_ID
            and dox > 1
            and IR > 0
            and nvl(DOK,DAT_EM) < p_DAT_ROZ
            and Nvl(CENA,0)>0
            and DNK > p_DAT_ROZ;
  exception when no_data_found then l_result := 0; return l_result;
  end;

  if (nvl(l_CENA,0) != 0 )
  then l_KOL := p_SUMBN / l_CENA;
  else l_KOL := 0;
  end if;

  If l_PR1_KUP = 2
  then
    l_result := l_KOL * l_KUPON1 / 100;
    return l_result;
  end if;

  -- Рассчитать накоп купон от год % ставки или от ставки на период
  -- l_DEL_KUP1 = кол дней в купонном периоде
     l_DEL_KUP1 := l_DNK - l_DOK;
  -- l_DEL_KUP2 = кол дней уже прошло
     l_DEL_KUP2 := p_DAT_ROZ - case when p_DAT_ROZ > l_DNK then l_DNK else l_DOK end;

 If nvl(l_CENA_KUP,0) > 0
 then
    l_result := Round( l_KOL * l_CENA_KUP *100*l_DEL_KUP2/l_DEL_KUP1,0) /100;
    Return l_result;
 end if;

 If l_KY > 1
 then
    l_result := ( l_IR /l_KY ) * l_DEL_KUP2 / (100 * l_DEL_KUP1 );
    If l_PR1_KUP = 2
    then l_result := l_KOL * round(l_CENA * 100 * l_result,0)/100;
    Else l_result := round(l_KOL * l_CENA * 100 * l_result,0)/100;
    end if;

    If p_DAT_ROZ is not null and  l_DOK  is not null
     and l_DAT_RR is not null  and  l_DNK is not null
     and l_DOK <= l_DAT_RR and l_DAT_RR <= p_DAT_ROZ and p_DAT_ROZ <= l_DNK
    then
        l_DEL_KUP2 := l_DEL_KUP1 - l_DEL_KUP2;
        l_result := (l_IR/l_KY) * l_DEL_KUP2 / (100 * l_DEL_KUP1);
        If l_PR1_KUP = 2
        then l_result := -l_KOL * round( l_CENA * 100 * l_result, 0)/100;
        Else l_result := -Round( l_KOL * l_CENA * 100 * l_result, 0)/100;
        end if;
    Else
        l_result := l_IR * l_DEL_KUP2 / 36500;
        If l_PR1_KUP = 2
        then l_result := l_KOL * round(l_CENA * 100 * l_result)/100;
        Else l_result := round(l_KOL * l_CENA * 100 * l_result)/100;
        end if;
    end if;
  end if;
  Return l_result;
 end;

PROCEDURE F_SAVE (p_fl_END      IN     INT,
                  p_rb_K_P      IN     INT,
                  p_nOP         IN     INT,
                  p_NTIK        IN     VARCHAR2,
                  p_NBB         IN     VARCHAR2,
                  p_cb_Zo       IN     INT,
                  p_CP_AI       IN     INT,
                  p_nTipd       IN     INT,
                  p_nGrp        IN     INT,
                  p_nID         IN     NUMBER,
                  p_nVidd       IN     NUMBER,
                  p_nRYN        IN     NUMBER,
                  p_DAT_UG      IN     DATE,
                  p_DAT_OPL     IN     DATE,
                  p_DAT_ROZ     IN     DATE,
                  p_DAT_KOM     IN     DATE,
                  p_SUMBN       IN     NUMBER,
                  p_SUMB        IN     NUMBER,
                  p_RR_         IN     NUMBER,
                  p_SUMBK       IN     NUMBER,
                  p_sNazn       IN     VARCHAR2,
                  p_NLS9        IN     VARCHAR2,
                  p_B_4621      IN     VARCHAR2,
                  p_B_1819      IN     VARCHAR2,
                  p_B_1919      IN     VARCHAR2,
                  p_sREF           OUT VARCHAR2,
                  p_sErr           OUT VARCHAR2,
                  p_Nazn           OUT VARCHAR2,
                  p_REF_MAIN       OUT VARCHAR2,
                  -- вторая часть по комиссии
                  P_SK          IN     NUMBER,
                  P_SKV         IN     NUMBER, -- валюта комиссии
                  p_BICA        IN     VARCHAR2,
                  p_BICKB_      IN     VARCHAR2,
                  p_cb_SWIFT    IN     INT,
                  p_SSA         IN     VARCHAR2,
                  p_SSB_        IN     VARCHAR2,
                  p_cb_NO_PAY   IN     INT,
                  p_cb_KS       IN     INT,
                  p_nDCP        IN     INT default 0,
                  p_MFOB_       IN     varchar2,
                  p_OKPOB_      IN     varchar2,
                  p_NLSB_       IN     varchar2,
                  p_NBB_        IN     varchar2,
                  --------
                  p_KOD_BB      IN     varchar2,
                  p_KOD_GB      IN     varchar2,
                  p_KOD_NB      IN     varchar2,
                  --------
                  p_sNLS_FXC    IN     varchar2,
                  p_sNMS_FXC    IN     varchar2,
                  p_repo        IN     number
                  )
IS
   o_rec oper%rowtype;
   o_rec2 oper%rowtype;
   o_reck oper%rowtype;
   o_recdcp oper%rowtype;
   l_localbankdate date;
   l_nameEMI varchar2(50);
   l_rNls  varchar2(14);
   l_sN7   varchar2(14);
   l_sNLS  varchar2(14);
   l_NLSB  varchar2(14);
   l_OKPOB varchar2(10);
   l_MFOB varchar2(6);
   l_cena number;
   L_CLOB varchar2(10000);
   L_BLOB blob;
   l_description varchar2(50);
   l_cpkod_row cp_kod%rowtype;
   l_rynname varchar2(50);
   l_pfname varchar2(50);
BEGIN
   bars_audit.info ('value_paper.F_SAVE starts. p_nTipd = ' || p_nTipd ||',p_repo='||p_repo || ', p_NTIK=' || p_NTIK);

   p_sErr := substr(cp.chek_rekv(p_nID),1,200);
   if p_sErr is not null then return;
   else

       o_rec.nd := rpad(p_NTIK,10);
       o_rec2.nd := rpad(p_NTIK,10);
       o_reck.nd := rpad(p_NTIK,10);
       o_recdcp.nd := rpad(p_NTIK,10);

       l_localbankdate := p_DAT_OPL;

       begin
        SELECT k.name, k.kv, k.cena
           INTO o_rec.nazn, o_rec.kv, l_cena
           FROM cp_kod k, basey y,cp_type t
          WHERE k.id=p_nID and k.idt=t.idt (+) and NVL(k.basey,0) = y.basey;
       exception when no_data_found then p_sErr:= 'Не знайдено емітента для коду ЦП =' || to_char(p_nID);  return;
       end;
       begin
         SELECT k.*
           INTO l_cpkod_row
           FROM cp_kod k
          WHERE k.id = p_nID;
       exception when no_data_found then p_sErr:= 'Не знайдено налаштувань коду ЦП =' || to_char(p_nID);  return;
       end;


       if p_nTipd != 1
       then  o_rec.nazn := p_NBB;
       end if;

       o_rec.nazn := o_rec.nazn || '. Розпоряждення ' || p_NTIK || ' від ' || to_char(p_DAT_UG, 'dd.mm.yyyy');

       if p_cb_Zo = 1 AND p_DAT_UG = p_DAT_ROZ
       then o_rec.vob := '96';
       else o_rec.vob := '6';
       end if;

       if (p_rb_K_P = 0)
       then
        BEGIN
         l_description := Upper('Купівлі');
         o_rec.nazn := 'Купівля '|| o_rec.nazn;
           CP.CP_KUP (p_CP_AI,
                      p_nTipd,
                      o_rec.vob,
                      p_nGrp,
                      p_nID,
                      p_nVidd,
                      p_nRYN,
                      p_DAT_UG,
                      p_DAT_OPL,
                      p_DAT_ROZ,
                      p_DAT_KOM,
                      p_SUMBN,
                      p_SUMB,
                      p_RR_,
                      p_SUMBK,
                      o_rec.nazn,
                      p_NLS9,
                      l_rNls,
                      p_B_4621,
                      p_B_1819,
                      p_B_1919,
                      p_sREF,
                      p_sErr,
                      p_REF_MAIN);
            if (UPPER(p_sErr) LIKE '%ORA-20203: \9303 %')
            then p_sErr := 'Перевірте налаштування відкритих рахунків обраного субпортфеля! (' || substr(p_sErr, 17, 20) || ')';
           end if;
        END;

         If p_nDCP = 0 and p_cb_NO_PAY = 0
         then
            if ( p_cb_Zo = 1 AND p_DAT_UG = p_DAT_OPL )
            then
             o_recdcp.vob := '96';
             SELECT max(FDAT) into o_recdcp.VDAT
              from fdat where to_char(fdat,'yyMM')< to_char(gl.bd,'yyMM');
             o_recdcp.PDAT := gl.bd;
            else
             o_recdcp.vob := '6';
             o_recdcp.VDAT := p_DAT_OPL;
             o_recdcp.PDAT := p_DAT_OPL;
            end if;
            -- дебиторы-Кредиторы или без них
            If p_DAT_OPL = p_DAT_ROZ
            then   l_sNLS :=  p_B_4621;
            elsif p_DAT_OPL < p_DAT_ROZ
            then  l_sNLS := p_B_1819;
            else  l_sNLS := p_B_1919;
            end if;

            If p_cb_KS = 1
            then
                o_recdcp.s := p_SUMB * 100;
                o_recdcp.sq := o_recdcp.s;
                gl.in_doc3(o_recdcp.ref,
                           'FXB',
                           o_recdcp.vob,
                           o_recdcp.nd,
                           SYSDATE,
                           SYSDATE,
                           1,
                           980,
                           o_recdcp.sq,
                           o_recdcp.kv,
                           o_recdcp.s,
                           null, -- sk
                           o_recdcp.pdat,
                           o_recdcp.vdat,
                           GetGlobalOption ('NAME'),
                           l_sNls,
                           GetGlobalOption ('MFO'),
                           p_NBB_,
                           p_SSB_,
                           GetGlobalOption ('MFO'),
                           o_recdcp.nazn,
                           NULL,
                           LPAD (NVL ( (GetGlobalOption ('OKPO')), '0'), 8, '0'),
                           p_OKPOB_,
                           NULL, NULL, NULL, NULL, NULL);
                gl.payv(flg_ => 0,
                        ref_ => o_recdcp.ref,
                        dat_ => o_recdcp.pdat,
                         tt_ => 'FXB',
                         dk_ => 1,
                        kv1_ => 980,
                       nls1_ => l_sNls,
                       sum1_ => o_recdcp.sq,
                        kv2_ => o_recdcp.kv,
                       nls2_ => p_SSB_,
                       sum2_ => o_recdcp.s);

            Elsif o_recdcp.Kv= 980
            then
                SELECT vob into o_recdcp.vob from tts_vob where tt='FXA';
                gl.in_doc3(o_recdcp.ref,
                           'FXA',
                           o_recdcp.vob,
                           o_recdcp.nd,
                           SYSDATE,
                           SYSDATE,
                           1,
                           980,
                           o_recdcp.sq,
                           o_recdcp.kv,
                           o_recdcp.s,
                           null, -- sk
                           o_recdcp.pdat,
                           o_recdcp.vdat,
                           GetGlobalOption ('NAME'),
                           l_sNls,
                           GetGlobalOption ('MFO'),
                           p_NBB_,
                           p_NLSB_,
                           p_MFOB_,
                           o_recdcp.nazn,
                           NULL,
                           LPAD (NVL ( (GetGlobalOption ('OKPO')), '0'), 8, '0'),
                           p_OKPOB_,
                           NULL, NULL, NULL, NULL, NULL);
                gl.payv(flg_ => 0,
                        ref_ => o_recdcp.ref,
                        dat_ => o_recdcp.pdat,
                         tt_ => 'FXA',
                         dk_ => 1,
                        kv1_ => o_recdcp.kv,
                       nls1_ => l_sNls,
                       sum1_ => o_recdcp.sq,
                        kv2_ => o_recdcp.kv,
                       nls2_ => p_NLSB_,
                       sum2_ => o_recdcp.s);

            Elsif trim(p_BICA) = trim(p_BICKB_) -- прямой КС
            then
                gl.in_doc3(o_recdcp.ref,
                           'FXB',
                           o_recdcp.vob,
                           o_recdcp.nd,
                           SYSDATE,
                           SYSDATE,
                           1,
                           980,
                           o_recdcp.sq,
                           o_recdcp.kv,
                           o_recdcp.s,
                           null, -- sk
                           o_recdcp.pdat,
                           o_recdcp.vdat,
                           GetGlobalOption ('NAME'),
                           l_sNls,
                           GetGlobalOption ('MFO'),
                           p_NBB_,
                           p_SSB_,
                           GetGlobalOption ('MFO'),
                           o_recdcp.nazn,
                           NULL,
                           LPAD (NVL ( (GetGlobalOption ('OKPO')), '0'), 8, '0'),
                           p_OKPOB_,
                           NULL, NULL, NULL, NULL, NULL);
                gl.payv(flg_ => 0,
                        ref_ => o_recdcp.ref,
                        dat_ => o_recdcp.pdat,
                         tt_ => 'FXB',
                         dk_ => 1,
                        kv1_ => o_recdcp.kv,
                       nls1_ => l_sNls,
                       sum1_ => o_recdcp.sq,
                        kv2_ => o_recdcp.kv,
                       nls2_ => p_SSB_,
                       sum2_ => o_recdcp.s);
            Else
                SELECT substr(nms,1,38) INTO o_recdcp.nam_a FROM accounts WHERE kv=o_recdcp.Kv and nls = l_sNls;

                gl.in_doc3(o_recdcp.ref,
                           'FXB',
                           o_recdcp.vob,
                           o_recdcp.nd,
                           SYSDATE,
                           SYSDATE,
                           1,
                           980,
                           o_recdcp.sq,
                           o_recdcp.kv,
                           o_recdcp.s,
                           null, -- sk
                           o_recdcp.pdat,
                           o_recdcp.vdat,
                           o_recdcp.nam_a,
                           l_sNls,
                           GetGlobalOption ('MFO'),
                           p_sNMS_FXC,
                           p_sNLS_FXC,
                           GetGlobalOption ('MFO'),
                           o_recdcp.nazn,
                           NULL,
                           LPAD (NVL ( (GetGlobalOption ('OKPO')), '0'), 8, '0'),
                           p_OKPOB_,
                           NULL, NULL, NULL, NULL, NULL);
                gl.payv(flg_ => 0,
                        ref_ => o_recdcp.ref,
                        dat_ => o_recdcp.pdat,
                         tt_ => 'FXB',
                         dk_ => 1,
                        kv1_ => o_recdcp.kv,
                       nls1_ => l_sNls,
                       sum1_ => o_recdcp.sq,
                        kv2_ => o_recdcp.kv,
                       nls2_ => p_SSB_,
                       sum2_ => o_recdcp.s);

            end if;
          p_sREF := p_REF_MAIN ||',' ||o_recdcp.ref;
         end if;

       else -- П р о д а ж а

        if (p_fl_END = 1) then l_description := Upper('Погашення емітентом'); o_rec.nazn := 'Погашення емітентом';
         else  SELECT 'Продаж '|| t.name, k.kv
                 INTO o_rec.nazn, o_rec.kv
                 FROM cp_kod k, basey y,cp_type t
                 WHERE k.id=p_nID and k.idt=t.idt (+) and NVL(k.basey,0) = y.basey;
                 l_description := Upper('Продаж');
        end if;
         o_rec.nazn := 'Продаж '|| o_rec.nazn;
         CP.CP_PROD( p_nTipd,
                     o_rec.vob,
                     p_nGrp,
                     p_nID,
                     p_nVidd,
                     p_nRYN,
                     p_DAT_UG,
                     p_DAT_OPL,
                     p_DAT_ROZ,
                     p_DAT_KOM,
                     p_SUMBN,
                     p_SUMB,
                     p_SUMBK,
                     p_RR_,
                     o_rec.nazn,
                     p_NLS9,
                     p_repo,
                     Null,
                     p_B_4621,
                     p_B_1819,
                     p_B_1919,
                     p_sREF,
                     p_sErr,
                     p_REF_MAIN);
           bars_audit.info(p_sErr);
           if (UPPER(p_sErr) LIKE '%ORA-20203: \9303 %')
            then p_sErr := 'Перевірте налаштування відкритих рахунків обраного субпортфеля! (' || substr(p_sErr, 17, 20) || ')';
           end if;
         if (p_cb_SWIFT = 0 and p_SSA is not null and  p_cb_NO_PAY != 1) --  в DAT_OPL ожидать поступления
         then
            o_rec2.s := p_SUMB * 100;
            o_rec2.sq := o_rec2.s;
            gl.ref(o_rec2.ref);
            if ( p_cb_Zo = 1 AND p_DAT_UG = p_DAT_UG )
            then
             o_rec2.vob := '96';
             SELECT max(FDAT) into o_rec2.VDAT
              from fdat where to_char(fdat,'yyMM')< to_char(gl.bd,'yyMM');
             o_rec2.PDAT := gl.bd;
            else
             o_rec2.vob := '6';
             o_rec2.VDAT := p_DAT_OPL;
             o_rec2.PDAT := p_DAT_OPL;
            end if;
            -- дебиторы-Кредиторы или без них
            If p_DAT_OPL = p_DAT_ROZ
            then   l_sNLS :=  p_B_4621;
            elsif p_DAT_OPL < p_DAT_ROZ
            then  l_sNLS := p_B_1919;
            else  l_sNLS := p_B_1819;
            end if;

                gl.in_doc3(o_rec2.ref,
                           'FXD',
                           o_rec2.vob,
                           o_rec2.nd,
                           SYSDATE,
                           SYSDATE,
                           1,
                           980,
                           o_rec2.sq,
                           o_rec2.kv,
                           o_rec2.s,
                           null, -- sk
                           o_rec2.pdat,
                           o_rec2.vdat,
                           o_rec2.nam_a,
                           p_SSA,
                           GetGlobalOption ('MFO'),
                           p_sNMS_FXC,
                           p_sNLS_FXC,
                           GetGlobalOption ('MFO'),
                           o_rec2.nazn,
                           NULL,
                           LPAD (NVL ( (GetGlobalOption ('OKPO')), '0'), 8, '0'),
                           p_OKPOB_,
                           NULL, NULL, NULL, NULL, NULL);
                gl.payv(flg_ => 0,
                        ref_ => o_rec2.ref,
                        dat_ => o_rec2.pdat,
                         tt_ => 'FXD',
                         dk_ => 1,
                        kv1_ => o_rec2.kv,
                       nls1_ => p_SSA,
                       sum1_ => o_rec2.sq,
                        kv2_ => o_rec2.kv,
                       nls2_ => l_sNLS,
                       sum2_ => o_rec2.s);

            If p_KOD_BB is not null
            then INSERT INTO operw (ref,tag,value) VALUES (o_rec2.ref, 'KOD_B', p_KOD_BB);
            end if;

            If p_KOD_GB is not null
            then
             INSERT INTO operw (ref,tag,value) VALUES (o_rec2.ref,'KOD_G', p_KOD_GB);
            end if;

            If p_KOD_NB is not null
            then
                DELETE FROM operw WHERE ref=o_rec2.ref and tag='KOD_N';
                INSERT INTO operw (ref,tag,value) VALUES (o_rec2.ref,'KOD_N', p_KOD_NB);
            end if;

            p_sREF := p_REF_MAIN ||',' ||o_rec2.ref;
        end if;
       end if;

       -- введена сумма комиссии на форме!  и для продажи и для покупки
       if nvl(p_SUMBK,0) > 0
       then
          o_reck.Kv := P_SKV;
          o_reck.nazn := 'Витрати, пов`язвні з придбанням ЦП1';
          if  p_nTipd = 1
          then
            SELECT nlsM
              INTO l_sN7
              FROM tts
             WHERE tt='FXR';
          else
            If p_DAT_KOM > p_DAT_ROZ
            then  l_sN7 := p_B_1919;
            elsif p_DAT_KOM < p_DAT_ROZ
            then  l_sN7 :=  p_B_1819;
            else  l_sN7 :=  p_B_4621;
            end if;
            o_reck.S := p_SUMBK*100;
            IF (o_reck.Kv != 980)
            THEN
            o_reck.SQ := gl.p_icurval(o_reck.Kv, p_SUMBK, gl.bd);
            ELSE
            o_reck.SQ := o_reck.S;
            END IF;
            if ( p_cb_Zo = 1 AND p_DAT_UG = p_DAT_KOM )
            then
             o_reck.vob := '96';
             SELECT max(FDAT) into o_reck.VDAT
              from fdat where to_char(fdat,'yyMM')< to_char(gl.bd,'yyMM');
             o_reck.PDAT := gl.bd;
            else
             o_reck.vob := '6';
             o_reck.VDAT := p_DAT_KOM;
             o_reck.PDAT := p_DAT_KOM;
            end if;

            gl.ref(o_reck.ref);

            If o_reck.Kv = 980
            then
             SELECT vob into o_reck.vob from tts_vob where tt='FXA';
                gl.in_doc3(o_reck.ref,
                           'FXA',
                           o_reck.vob,
                           o_reck.nd,
                           SYSDATE,
                           SYSDATE,
                           1,
                           o_reck.kv,
                           o_reck.s,
                           o_reck.kv,
                           o_reck.sq,
                           NULL,        --sk
                           o_reck.pdat,
                           o_reck.pdat,
                           GetGlobalOption ('NAME'),
                           l_rNls,
                           GetGlobalOption ('MFO'),
                           p_NBB_,
                           p_NLSB_,
                           p_MFOB_,
                           o_reck.nazn,
                           NULL,
                           LPAD (NVL ( (GetGlobalOption ('OKPO')), '0'), 8, '0'),
                           p_OKPOB_,
                           NULL, NULL, NULL, NULL, NULL);
                gl.payv(flg_ => 0,
                        ref_ => o_reck.ref,
                        dat_ => o_reck.pdat,
                         tt_ => 'FXA',
                         dk_ => 1,
                        kv1_ => o_reck.kv,
                       nls1_ => l_rNls,
                       sum1_ => o_reck.s,
                        kv2_ => o_reck.kv,
                       nls2_ => p_NLSB_,
                       sum2_ => o_reck.sq);

                       l_NLSB := p_NLSB_;

            elsif trim(p_BICA) = trim(p_BICKB_)-- ! прямой КС
            then
                 gl.in_doc3(o_reck.ref,
                           'FXB',
                           o_reck.vob,
                           o_reck.nd,
                           SYSDATE,
                           SYSDATE,
                           1,
                           980,
                           o_reck.sq,
                           o_reck.kv,
                           o_reck.s,
                           null, -- sk
                           o_reck.pdat,
                           o_reck.pdat,
                           GetGlobalOption ('NAME'),
                           l_sN7,
                           GetGlobalOption ('MFO'),
                           p_NBB_,
                           p_SSB_,
                           p_MFOB_,
                           o_reck.nazn,
                           NULL,
                           LPAD (NVL ( (GetGlobalOption ('OKPO')), '0'), 8, '0'),
                           p_OKPOB_,
                           NULL, NULL, NULL, NULL, NULL);
                gl.payv(flg_ => 0,
                        ref_ => o_reck.ref,
                        dat_ => o_reck.pdat,
                         tt_ => 'FXB',
                         dk_ => 1,
                        kv1_ => 980,
                       nls1_ => l_sN7,
                       sum1_ => o_reck.sq,
                        kv2_ => o_reck.kv,
                       nls2_ => p_SSB_,
                       sum2_ => o_reck.s);
                       l_NLSB := p_SSB_;
            else
                 o_reck.kv2 := o_rec.kv;
                 o_reck.kv :=
                    case when p_nTipd =1 then 980
                    else o_rec.kv
                    end;

                 gl.in_doc3(o_reck.ref,
                           'FXC',
                           o_reck.vob,
                           o_reck.nd,
                           SYSDATE,
                           SYSDATE,
                           1,
                           o_reck.kv,
                           o_reck.sq,
                           o_reck.kv2,
                           o_reck.s,
                           null, -- sk
                           o_reck.pdat,
                           o_reck.pdat,
                           GetGlobalOption ('NAME'),
                           l_sN7,
                           GetGlobalOption ('MFO'),
                           p_NBB_,
                           p_sNLS_FXC,
                           p_MFOB_,
                           o_reck.nazn,
                           NULL,
                           LPAD (NVL ( (GetGlobalOption ('OKPO')), '0'), 8, '0'),
                           p_OKPOB_,
                           NULL, NULL, NULL, NULL, NULL);
                           BARS_AUDIT.INFO('o_reck.kv = '||o_reck.kv);
                gl.payv(flg_ => 0,
                        ref_ => o_reck.ref,
                        dat_ => o_reck.pdat,
                         tt_ => 'FXC',
                         dk_ => 1,
                        kv1_ => o_reck.kv,
                       nls1_ => l_sN7,
                       sum1_ => o_reck.sq,
                        kv2_ => o_reck.kv2,
                       nls2_ => p_sNLS_FXC,
                       sum2_ => o_reck.s);
                       l_NLSB := p_sNLS_FXC;
            end if;
            p_sREF := p_REF_MAIN ||',' ||o_reck.ref;
          end if;
       end if;
       --------------
       p_Nazn := o_rec.nazn;
   end if; -- p_sErr;
   update oper set nd = p_NTIK where ref = p_REF_MAIN;
   -- формирование тикета
   BEGIN
   INSERT INTO bars.CP_TICKET (REF, KOL, VIDDN, NTIK, DAT_UG,DAT_OPL, DAT_ROZ, DAT_KOM, MFOB, OKPOB, NLSB, NBB, MFOB_, OKPOB_,NLSB_,NBB_)
           VALUES (p_REF_MAIN, p_SUMBN / l_CENA, p_nVIDD, p_NTIK, p_DAT_UG, p_DAT_OPL, p_DAT_ROZ, p_DAT_KOM, l_MFOB, l_OKPOB, l_NLSB, p_NBB, p_MFOB_, p_OKPOB_, p_NLSB_, p_NBB_);
    EXCEPTION
       WHEN DUP_VAL_ON_INDEX
       THEN NULL;
    END;
    /* ФОРМИРОВАНИЕ ТЕКСТА ТИКЕТА*/

    select name
      into l_rynname
      from cp_ryn
     where ryn = p_nRYN;



    L_CLOB := '                     Т I К Е Т   '||rpad(TO_CHAR(p_NTIK),10,' ')||'                    '                                              ||g_newline
            ||'              на операцiю '||rpad(l_description,15,' ') ||  '    цiнних паперiв          '                                              ||g_newline
            ||'   Емiтент                       Дата емiсiї       Дата погашення'                                                                       ||g_newline
            ||'   ' ||l_cpkod_row.name || '                  '||to_char(l_cpkod_row.dat_em,'dd/mm/yyyy')   || '          '||to_char(p_DAT_UG,'dd/mm/yyyy')  ||g_newline
            ||'   Валюта ЦП                     Iдент.код ЦП      Ном.% ставка      '                                                                   ||g_newline
            ||'   ' ||l_cpkod_row.kv || '                               '||l_cpkod_row.cp_id || '       '||lpad(l_cpkod_row.ir,15,' ')                      ||g_newline
            ||'   В портфель                    СубПортфель: '                                                                                          ||g_newline
            ||'   '||p_nVidd||'                                  '||l_rynname                                                                               ||g_newline
            ||'   Дата угоди                    Час вводу в АБС   Реф.платежу       '                                                                   ||g_newline
            ||'   '||to_char(p_DAT_UG, 'dd/mm/yyyy')||'                                                '|| p_ref_main                                       ||g_newline
            ||'   Сума номiналу:    '||to_char(p_SUMBN,'99999999999.99')||'     Дата розрахунку:   '||to_char(p_DAT_UG, 'dd/mm/yyyy')||'        '           ||g_newline
            ||'   Сума оплати:      '||to_char(p_SUMB ,'99999999999.99')||'     Дата оплати:       '||to_char(p_DAT_OPL,'dd/mm/yyyy')||'        '           ||g_newline
            ||'   Сума витрат:      '||to_char(p_SUMBK,'99999999999.99')||'     Дата оплати витрат:'||to_char(p_DAT_KOM,'dd/mm/yyyy')||'        '           ||g_newline
            ||'                  Платежi                                                               '                                                    ||g_newline
            ||'   Контрагенту  :'||p_NBB  ||'                                 '                                                                             ||g_newline
            ||'   Дата         МФО            ЗКПО           Рахунок               Сума '                                                                   ||g_newline
            ||'   '||to_char(p_DAT_OPL, 'dd/mm/yyyy') ||'   ' ||rpad(l_MFOB,15,' ') ||rpad(l_OKPOB,15,' ') ||rpad(l_NLSB,15,' ') ||to_char(p_SUMB ,'99999999999.99')              ||g_newline
            ||'   Посереднику  :'||p_NBB_ ||'                                  '                                                                            ||g_newline
            ||'   Дата         МФО            ЗКПО           Рахунок               Сума '                                                                   ||g_newline
            ||'   '||to_char(p_DAT_OPL, 'dd/mm/yyyy') ||'   ' ||rpad(p_MFOB_,15,' ') ||rpad(p_OKPOB_,15,' ') ||rpad(p_NLSB_,15,' ') ||to_char(p_SUMB ,'99999999999.99')            ||g_newline
            ||'  ------------------------------------------------------------------------------------------------'                                          ||g_newline
            ||'   Виконавець: Адміністратор АБС (BARS)'                                                                                                     ||g_newline
            ||'   Перелік транзакцій для документа #'  || p_ref_main                                                                                         ||g_newline
            ||'   Тип:  Дата  : Рахунок доч. :Вал: Рахунок конс.:    Дебет      :    Кредит     :   Еквівалент  :'                                           ||g_newline
            ||'   трн:валютув.:              :доч:              :               :               :               :'                                           ||g_newline
            ||'  ------------------------------------------------------------------------------------------------'                                           ||g_newline
            ||''                                                                                                                                            ||g_newline
            ||'  ------------------------------------------------------------------------------------------------'                                           ||g_newline
            --|| (select TT ||ACC, DK, FDAT, ID, KF, OTM, REF, S, SOS, SQ, STMT, TT, TXT from opldok where ref = p_ref_main)
            ;
        bars_audit.info(to_char(length(L_CLOB))||':L_CLOB = ' || L_CLOB);
/*  Контрагенту  :Название
    Дата         МФО            ЗКПО           Рахунок                 Сума
    28/09/2016   300001         00032106       46216992704           500,00

   Посереднику  :
    Дата         МФО            ЗКПО           Рахунок                 Сума
    28/09/2016                                                         0,00

   ----------------------------------------------------------------------------
   Виконавець: Адміністратор АБС (BARS)

   Перелік транзакцій для документа # 57311052901

Тип:  Дата  : Рахунок доч. :Вал: Рахунок конс.:    Дебет      :    Кредит     :   Еквівалент  :
трн:валютув.:              :доч:              :               :               :               :
-----------------------------------------------------------------------------------------------
FX7 28/09/16 14102011052901 980 14106151               700,00                          700,00
FX7 28/09/16 37392555       980                                        700,00          700,00
FX7 28/09/16 37392555       980                        200,00                          200,00
FX7 28/09/16 14168011052901 980 14162151                               200,00          200,00
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

*/

  /* fucking ФОРМИРОВАНИЕ ТЕКСТА ТИКЕТА*/
  dbms_lob.createtemporary(L_BLOB, TRUE);
  for i in 0..(length(L_CLOB)/1000)
  loop
    bars_audit.info('L_BLOB: i=' || to_char(i));
    --L_BLOB := DBMS_LOB.CONVERTTOBLOB(l_BLOB,  utl_raw.cast_to_raw(substr(L_CLOB, i*1000, 1000)));
  end loop;


  update cp_arch
      set stiket =  utl_raw.cast_to_raw(substr(L_CLOB, 1, 2000))
    where ref = p_ref_main;

   bars_audit.info ('value_paper.F_SAVE finished with mess p_sErr =' || p_sErr);
 exception when others then
     if (sqlcode = -20203)
     then p_sErr := 'Перевірте налаштування відкритих рахунків обраного субпортфеля! '|| substr(sqlerrm, 17, instr(sqlerrm,')',1)-17+1) ;
     else p_sErr := sqlerrm;
     end if;
END;

  FUNCTION CONCAT_BLOB(A IN BLOB, B IN BLOB) RETURN BLOB IS
       C BLOB;
    BEGIN
       dbms_lob.createtemporary(c, TRUE);
       DBMS_LOB.APPEND(c, A);
       DBMS_LOB.APPEND(c, B);
       RETURN c;
    END;


  PROCEDURE setNazn (p_REF_MAIN   IN     VARCHAR2,
                     p_Nazn       IN     VARCHAR2,
                     p_sErr          OUT VARCHAR2)
  is
  begin
   p_sErr := null;
   bars_audit.info ('value_paper.setNazn started for  with p_REF_MAIN =' || p_REF_MAIN || ', new=p_Nazn ='||p_Nazn);
   begin
       update oper
          set nazn = substr(p_Nazn,1,160)
        where ref = p_REF_MAIN;
   exception when others then p_sErr := sqlerrm;
   end;

   bars_audit.info ('value_paper.setNazn finished for  with p_REF_MAIN =' || p_REF_MAIN || ', new=p_Nazn ='||p_Nazn);
  end;

  procedure setSpecparam(p_REF_MAIN   IN     VARCHAR2,
                         p_COD_I      IN     VARCHAR2,
                         p_COD_M      IN     VARCHAR2,
                         p_COD_F      IN     VARCHAR2,
                         p_sErr          OUT VARCHAR2)
  is
  begin
--         raise_application_error(-(20001),  'p_ref='||p_REF_MAIN||' p_COD_I='||p_COD_I||' p_COD_M='||p_COD_M);
        INSERT INTO SPECPARAM_CP_OB (ACC, INITIATOR, MARKET)
           SELECT a.cp_acc, p_COD_I, p_COD_M
             FROM cp_accounts a, cp_deal d
            WHERE a.cp_ref = d.REF
              AND d.REF = p_REF_MAIN;
        if  p_COD_I is not null then
          insert into operw (ref, tag, value)
           values (p_REF_MAIN, 'CP_IN', p_COD_I);
        end if;
        if  p_COD_M is not null then
          insert into operw (ref, tag, value)
           values (p_REF_MAIN, 'CP_MR', p_COD_M);
        end if;
        if  p_COD_F is not null then
          insert into operw (ref, tag, value)
           values (p_REF_MAIN, 'CP_FC', p_COD_F);
        end if;
  exception when others then   p_sErr := sqlerrm;
  end;

  function prepare_cpr_wnd( strPar01   IN VARCHAR2,
                            strPar02   IN VARCHAR2,
                            nGrp       IN NUMBER,
                            nMode      IN NUMBER)
      RETURN t_cp_cprwnd PIPELINED
  is
   l_cp_cprwnd r_cp_cprwnd;
   l_baseval tabval.kv%type;
   TYPE CPRCurTyp IS REF CURSOR;
   v_cpr_cursor   CPRCurTyp;
   v_stmt_str     VARCHAR2 (14000);

  begin
    bars_audit.info('value_paper.prepare_cpr_wnd: started');

      BEGIN
        SELECT val
          INTO l_baseval
          FROM params
         WHERE par = 'BASEVAL';
      EXCEPTION
        WHEN NO_DATA_FOUND
        THEN l_baseval := 980;
      END;

    v_stmt_str :='SELECT 0,0,0,0,0,0,CP_KOD.DATP, CP_KOD.IR,CP_KOD.DAT_EM, CP_KOD.cena, CP_KOD.tip, CP_KOD.kv, CP_KOD.dox, CP_KOD.emi, cp_kod.id FROM cp_kod WHERE (' || strPar01 ||')';

      BARS_AUDIT.INFO(v_stmt_str);

      OPEN v_cpr_cursor FOR v_stmt_str;

      LOOP
         FETCH v_cpr_cursor INTO l_cp_cprwnd;
           if (l_baseval = 980 and (EXTRACT(day from gl.bd) <10 or EXTRACT(month from gl.bd) = 1))
          then l_cp_cprwnd.p_cb_Zo_visible    := 1;
          else l_cp_cprwnd.p_cb_Zo_visible    := 0;
          end if;

          if (nMode = 1)
          then
           l_cp_cprwnd.p_SUMI_ALL_visible := 0;
           l_cp_cprwnd.p_pbFilter_visible := 0;
           l_cp_cprwnd.p_KV_enabled       := 0;
           l_cp_cprwnd.p_nDOX_enabled     := 0;
           l_cp_cprwnd.p_nEMI_enabled     := 0;
           l_cp_cprwnd.p_nDOX             := 2;
           l_cp_cprwnd.p_KV               := 980;
           --l_cp_cprwnd.p_nEMI             := 1;
           --l_cp_cprwnd.id

          else
           l_cp_cprwnd.p_SUMI_ALL_visible := 1;
           l_cp_cprwnd.p_pbFilter_visible := 1;
           l_cp_cprwnd.p_KV_enabled       := 1;
           l_cp_cprwnd.p_nDOX_enabled     := 1;
           l_cp_cprwnd.p_nEMI_enabled     := 1;

          end if;

         PIPE ROW (l_cp_cprwnd);
         EXIT WHEN v_cpr_cursor%NOTFOUND;
      END LOOP;

   bars_audit.info('value_paper.prepare_cpr_wnd: finished');
   PIPE ROW (l_cp_cprwnd);
  end;

   function populate_cpr_wnd (
                            strPar01   IN VARCHAR2,
                            strPar02   IN VARCHAR2,
                            nGrp       IN NUMBER,
                            nMode      IN NUMBER,
                            p_nRyn     IN NUMBER,
                            p_nPf      IN NUMBER)
  return t_cp_cprgridset pipelined
  is
   l_cp_cprgrid r_cp_cprgrid;
   l_cp_cprwnd r_cp_cprwnd;

   TYPE CPRCurTyp IS REF CURSOR;
   v_cpr_cursor   CPRCurTyp;
   v_stmt_str     VARCHAR2 (14000);

   l_vidd         varchar2(4);
  begin
   bars_audit.info('value_paper.populate_cpr_wnd: started, strPar01 =' || strPar01 ||', strPar02='||strPar02 ||',nMode=' || nMode ||',p_nRyn=' ||p_nRyn||',p_nPf='||p_nPf);

   select distinct *
     into l_cp_cprwnd
     from table(value_paper.prepare_cpr_wnd(strPar01,strPar02,nGrp,nMode));
   bars_audit.info('l_cp_cprwnd.p_nDOX = ' || l_cp_cprwnd.p_nDOX || 'l_cp_cprwnd.p_nEMI = '|| l_cp_cprwnd.p_nEMI );
   begin
       SELECT v.VIDD
         INTO l_vidd
         FROM CP_PF p, CP_VIDD v
        WHERE p.PF = v.PF
          AND v.DOX = l_cp_cprwnd.p_nDOX AND v.EMI = l_cp_cprwnd.p_nEMI and p.pf = p_nPf;
   exception when too_many_rows then l_vidd := '';
   end;

   for k in (SELECT A.nls           p_NLSA,
                    -A.ostb/100     p_OSTA,
                    R.nls           p_NLSR,
                    -CP.CP_REAL_INTDATE (d.ACC, (CASE WHEN dnk > bankdate THEN dok ELSE dnk END)+1,1)/100 p_OSTR,
                    R2.nls          p_NLSR2,
                    -R2.ostb/100    p_OSTR2,
                    R3.nls          p_NLSR3,
                    nvl(-R3.ostb,0)/100  p_OSTR3,
                    a.acc           p_ACC,
                    CASE WHEN dnk > bankdate THEN dok ELSE dnk END p_ACR_DAT_INT,
                    -R.ostb/100     p_OSTR_REAL,
                    (select ACR_DAT from int_accn where acc= a.acc and id=0) p_ACR_DAT,
                    (select APL_DAT from int_accn where acc= a.acc and id=0) p_APL_DAT
            FROM cp_deal D,
                 accounts R,
                 accounts R2,
                 accounts R3,
                 accounts A,
                 cp_accc CA,
                 accounts AA,
                 cp_kod ck
           WHERE D.RYN = p_nRYN
                 AND D.acc = A.acc
                 AND D.accR= R.acc(+)
                 AND D.accR2=R2.acc(+)
                 AND D.accR3=R3.acc(+)
                 AND (R2.ostb <>0 or R.ostb <>0 or R3.ostb <>0)
                 AND A.accc = AA.acc
                 AND AA.kv = l_cp_cprwnd.P_KV
                 AND AA.nls = CA.NLSA
                 AND CA.PF = p_nPF
                 AND CA.RYN = D.RYN
                 AND CA.EMI = l_cp_cprwnd.p_nEMI
                 AND (aa.NBS = l_vidd or l_vidd is null)
                 AND d.id = ck.id
                 AND ck.id = l_cp_cprwnd.p_id
            ORDER BY d.ref)
   loop
    l_cp_cprgrid.p_NLSA         :=    k.p_NLSA;
    l_cp_cprgrid.p_OSTA         :=    k.p_OSTA;
    l_cp_cprgrid.p_NLSR         :=    k.p_NLSR;
    l_cp_cprgrid.p_OSTR         :=    k.p_OSTR;
    l_cp_cprgrid.p_NLSR2        :=    k.p_NLSR2;
    l_cp_cprgrid.p_OSTR2        :=    k.p_OSTR2;
    l_cp_cprgrid.p_NLSR3        :=    k.p_NLSR3;
    l_cp_cprgrid.p_OSTR3        :=    k.p_OSTR3;
    l_cp_cprgrid.p_ACC          :=    k.p_ACC;
    l_cp_cprgrid.p_ACR_DAT_INT  :=    k.p_ACR_DAT_INT;
    l_cp_cprgrid.p_OSTR_REAL    :=    k.p_OSTR_REAL;

    bars_audit.info('p_OSTR = ' || k.p_OSTR || ', sr'||l_cp_cprgrid.p_OSTR);
   pipe row(l_cp_cprgrid);
   end loop;

   bars_audit.info('value_paper.populate_cpr_wnd: finished');

  end;

  function get_sumi_all (strPar01 in varchar2, kv in number, pf in number, emi in number, vidd in varchar2,  dox in number, Ryn in number) return number
  is
   TYPE CPsumi_all IS REF CURSOR;
   v_sumi_all_cursor   CPsumi_all;
   v_stmt_str     VARCHAR2 (14000);
   l_sumi_all number := 0;
  begin
   null;
   v_stmt_str :=

        'SELECT -NVL (SUM (NVL (R.ostb, 0) + NVL (R2.ostb, 0) + NVL (R3.ostb, 0)),0)/100
          FROM cp_deal D,
               accounts R,
               accounts R2,
               accounts R3,
               accounts A,
               cp_accc CA,
               accounts AA,
               cp_kod ck
          WHERE     D.RYN = ' ||to_char(Ryn)
              || ' AND D.acc = A.acc '
              || ' AND D.accR = R.acc(+) '
              || ' AND D.accR2 = R2.acc(+) '
              || ' AND D.accR3 = R3.acc(+) '
              || ' AND (R2.ostb <> 0 OR R.ostb <> 0 OR R2.ostb <> 0) '
              || ' AND A.accc = AA.acc '
              || ' AND AA.kv = ' || to_char(KV)
              || ' AND AA.nls = CA.NLSA '
              || ' AND CA.PF = ' || to_char(PF)
              || ' AND CA.RYN = D.RYN '
              || ' AND CA.EMI = ' || to_char(EMI)
              || ' AND aa.NBS = ' || to_char(Vidd)
              || ' AND d.id = ck.id '
              || 'AND D.id IN (SELECT id FROM cp_kod WHERE '|| strPar01
                                   || ' AND emi = ' || to_char(EMI)
                                   || ' AND dox = ' || to_char(DOX)
                                   || ' AND kv = ' || to_char(KV)
                                   || ' AND tip = 1 '
                                   || ' AND IR > 0 )';

    BARS_AUDIT.INFO(v_stmt_str);

   OPEN v_sumi_all_cursor FOR v_stmt_str;

     LOOP
         FETCH v_sumi_all_cursor INTO l_sumi_all;
          EXIT WHEN v_sumi_all_cursor%NOTFOUND;
     end loop;
     return l_sumi_all;
  end;


    PROCEDURE saveCPR (p_nTipD      IN     INT,
                       p_cb_Zo      IN     INT,
                       p_nGrp       IN     INT,
                       p_nID        IN     INT,
                       p_nRYN       IN     INT,
                       p_nVidd      IN     VARCHAR2,
                       p_SUMK       IN     NUMBER,
                       p_sREF          OUT VARCHAR2,
                       p_sErr          OUT VARCHAR2,
                       p_REF_MAIN      OUT VARCHAR2)
   is
   l_SK number;
   l_vob vob.vob%type;
   l_B_4621 accounts.nls%type;
   l_cb_zo int;
   begin
     l_cb_zo := 0;
     l_B_4621 := '37392555';

     l_SK := p_SUMK * 100;
     l_vob := case when nvl(l_cb_zo,0) = 0 then '6' else '96' end;

     CP.CP_KUPON ( p_nTipD, l_Vob, p_nGrp, p_nID, p_nRYN, p_nVidd,p_SUMK, l_SK, l_B_4621, p_sREF, p_sErr, p_REF_MAIN);

   end;

 PROCEDURE make_amort( p_grp      IN  INT,
                       p_filtr_id IN  VARCHAR2,
                       p_date     IN  DATE,
                       s_Err        OUT varchar2)
 is

      TYPE CPAMORCurTyp IS REF CURSOR;
      l_cp_v         r_cp_v;
      v_cpamor_cursor   CPAMORCurTyp;
      v_stmt_str     VARCHAR2 (14000);
 begin
      v_stmt_str :=
            'select DATD, ND, SUMB, REF, ID, CP_ID, KV, VIDD, PFNAME, RYN, DATP, NO_PR, BAL_VAR, KIL, CENA, ZAL, OSTA, OSTAB, OSTAF, OSTD, OST_2VD, OSTP, OST_2VP, OSTR, OSTR2, OSTR3, OSTUNREC, OSTEXPN, OSTEXPR, OSTS, ERAT, NO_P, ACTIVE from CP_V_NEW where '
         || p_filtr_id;

      BARS_AUDIT.INFO(v_stmt_str);

      OPEN v_cpamor_cursor FOR v_stmt_str;

      LOOP
         FETCH v_cpamor_cursor INTO l_cp_v;
         CP.CP_AMOR ( l_cp_v.REF, l_cp_v.ID, p_grp, p_date, s_Err);
         IF NVL(s_Err,'')!= ''
         THEN
          BARS_AUDIT.INFO( 'value_paper.make_amort:' || TO_CHAR(l_cp_v.REF) || TO_CHAR(l_cp_v.ID) || s_Err);
          ELSE
          BARS_AUDIT.INFO( 'value_paper.make_amort:' || TO_CHAR(l_cp_v.REF) || TO_CHAR(l_cp_v.ID) || 'done');
         END IF;

         EXIT WHEN v_cpamor_cursor%NOTFOUND;
      END LOOP;

      CLOSE v_cpamor_cursor;
 end;

  function prepare_irr_wnd(p_nMode1 in number, p_REF in number,  p_ID in number,  strPar01 in varchar2, strPar02 in varchar2, pDAT_UG in date)
      RETURN t_cp_irrwnd PIPELINED
  is
  pragma autonomous_transaction;
  l_cp_irrwnd r_cp_irrwnd;
   sRet varchar2(500);
  begin
      select tip-1,
             PERIOD_KUP,
             dok,
             dnk,
             datp,
             dat_em,
             KY,
             cena,
             IR,
             CENA_KUP,
             case when (tip-1) = 0 then -2 when (tip-1) = 1 then -3 end,
             cp_id
        into l_cp_irrwnd.p_nIdN,
             l_cp_irrwnd.p_PERIOD_KUP,
             l_cp_irrwnd.p_DOK,
             l_cp_irrwnd.p_DNK,
             l_cp_irrwnd.p_DATP,
             l_cp_irrwnd.p_DAT_EM,
             l_cp_irrwnd.p_KY,
             l_cp_irrwnd.p_CENA,
             l_cp_irrwnd.p_IR_N0,
             l_cp_irrwnd.p_CENA_KUP,
             l_cp_irrwnd.p_nIdE,
             l_cp_irrwnd.p_cp_id
        from cp_kod
       where id = p_ID;

        SELECT DAT_ROZ,N/100
          INTO l_cp_irrwnd.p_vDat,
               l_cp_irrwnd.p_nN
          FROM cp_arch
         where ref = p_REF;
        -- Построены ли потоки
        begin
          select 0
            into l_cp_irrwnd.p_rb_NEW
            from cp_many
           where ref = p_REF and rownum  =1 ;
        exception when no_data_found then l_cp_irrwnd.p_rb_NEW := 1;
        end;
        --
        /*if (l_cp_irrwnd.p_rb_NEW = 1 and p_nMode1 != 2)  --Создать денежные потоки из ГПК (nMode1=2 -  только просмотр)
        then
           CP.RMany(p_REF,p_REF,l_cp_irrwnd.p_vDat,0,0,sRet);
           commit;
        end if;*/

        select o.nd,
               d.erat,
               d.erate,
               d.dat_ug
          into l_cp_irrwnd.p_NOM_UG,
               l_cp_irrwnd.p_IRR,
               l_cp_irrwnd.p_IRE,
               l_cp_irrwnd.p_dat_ug
          from cp_deal d,
               oper o
         where d.ref = o.ref
           and o.ref = p_REF;
       l_cp_irrwnd.p_ref := p_REF;
       l_cp_irrwnd.p_ID  := p_ID;

    pipe row(l_cp_irrwnd);
  end;


  function populate_irr_grid(p_nMode1 in number, p_REF in number, p_ID in number,  strPar01 in varchar2, strPar02 in varchar2, pDAT_UG in date)
    RETURN t_cp_irrgrid PIPELINED
  is
  l_cp_irrgrid r_cp_irrgrid;
  l_Dati date;
  l_cp_irrwnd r_cp_irrwnd;
  begin

   select distinct *
     into l_cp_irrwnd
     from table(value_paper.prepare_irr_wnd(p_nMode1, p_REF, p_ID, strPar01, strPar02, pDAT_UG));

      -- Вычитать денежные потоки
        l_cp_irrwnd.p_nn := 1;
        l_cp_irrgrid.p_KolR := 0;
        l_cp_irrgrid.p_KolP := 0;
        l_cp_irrgrid.p_nDP := 0;

        for k in (
         SELECT FDAT,SS1,SDP,SN2
           from CP_many
          where ref = p_REF
          ORDER BY FDAT)
        --  Параметры сделки
      loop
       l_cp_irrgrid.p_FDAT := k.FDAT;
       l_cp_irrgrid.p_SS1 := k.SS1;
       l_cp_irrgrid.p_SDP := k.SDP;
       l_cp_irrgrid.p_SN2 := k.SN2;


       if (l_cp_irrgrid.p_KolP =0)
       then
             l_Dati := l_cp_irrgrid.p_FDAT;
       else
        l_cp_irrgrid.p_KolP := l_cp_irrgrid.p_KolP + (l_cp_irrgrid.p_FDAT - l_Dati);

           If l_cp_irrgrid.p_SN2 =0 and l_cp_irrwnd.p_IR_N0 >0
           then
            l_cp_irrgrid.p_kR2 := l_cp_irrwnd.p_IR_N0 * ( l_cp_irrgrid.p_FDAT - l_Dati) / 36500;
            l_cp_irrgrid.p_SN2 := (l_cp_irrwnd.p_nN/l_cp_irrwnd.p_CENA) * Round( l_cp_irrwnd.p_CENA * 100 * l_cp_irrgrid.p_kR2) / 100;
           end if;
       end if;
       l_cp_irrgrid.p_S := (l_cp_irrgrid.p_SS1 + l_cp_irrgrid.p_SDP + l_cp_irrgrid.p_SN2 ) * 100;
       l_cp_irrgrid.p_nDP := l_cp_irrgrid.p_nDP + l_cp_irrgrid.p_SDP;
       pipe row (l_cp_irrgrid);
       l_Dati := l_cp_irrgrid.p_FDAT;
      end loop;
  end;


      procedure del_iir(p_REF in number)
      is
      begin
       Delete cp_many where ref = p_REF;
      end;


     function prepare_many_wnd (p_ref IN NUMBER)
      return t_r_prepare_many_wnd pipelined
      is
      l_prepare_many_wnd r_prepare_many_wnd;
      l_id  cp_kod.id%type;
      begin
       begin
         SELECT d.id, D.erat, Nvl(D.erate,D.erat),  A.N/100 , d.acc, -(c.ostb+c.ostf), d.accr2
           INTO l_id, l_prepare_many_wnd.IRR, l_prepare_many_wnd.IRE, l_prepare_many_wnd.NONIMAL, l_prepare_many_wnd.nAcc, l_prepare_many_wnd.nOst, l_prepare_many_wnd.nAccR2
           FROM cp_deal D, CP_ARCH A, accounts c
          WHERE c.acc = d.acc
            AND D.ref = p_REF
            AND D.erat is not null
            AND a.ref = d.ref;
       exception when no_data_found then return;
       end;

       begin
       SELECT nvl(cena_kup,0), dat_em, datp, ir , nvl(basey ,0), cena, cena_start
         INTO l_prepare_many_wnd.nFixed, l_prepare_many_wnd.DAT_EM, l_prepare_many_wnd.DATP, l_prepare_many_wnd.IR, l_prepare_many_wnd.nBasey, l_prepare_many_wnd.CENA, l_prepare_many_wnd.CENA_START
         FROM cp_kod
        WHERE id = l_id;
       exception when no_data_found then return;
       end;

       begin
         SELECT name, name_mb
           INTO l_prepare_many_wnd.sBasey, l_prepare_many_wnd.sBasey1
           FROM basey
          WHERE basey = l_prepare_many_wnd.nBasey;
       exception when no_data_found then null;
       end;

       if (nvl(l_prepare_many_wnd.CENA,0)!=0 )
       then l_prepare_many_wnd.KOL := abs(l_prepare_many_wnd.nOst/ ( l_prepare_many_wnd.CENA * 100));
       else l_prepare_many_wnd.KOL := 0;
       end if;

       begin
         SELECT accs
           INTO l_prepare_many_wnd.nAccS
           FROM cp_deal
          WHERE ref = p_ref;
       exception when no_data_found then null;
       end;

      begin
       SELECt min(fdat), max(fdat)
         INTo l_prepare_many_wnd.DAT1, l_prepare_many_wnd.DAT2
         FROm cp_many
        WHERe ref = p_REF;
      exception when no_data_found then null;
      end;
      l_prepare_many_wnd.DAT_ROZ := nvl(to_date(bars.pul.get('cp_v_date'),'dd.mm.yyyy'),gl.bd);
      PIPE ROW (l_prepare_many_wnd);
     end;

     procedure populate_many_row_wnd (p_ref IN NUMBER, rb1 in int, rb2 in int, DAT_ROZ in date, p_t_many_grid out t_many_grid, p_t_tmp_irr out t_tmp_irr, p_nIrr0 out number)
     -- return t_many_grid pipelined
     is
     l_prepare_many_wnd         r_prepare_many_wnd;
     l_many_grid                r_many_grid;
     l_t_many_grid              t_many_grid := t_many_grid();
     l_t_tmp_irr                t_tmp_irr   := t_tmp_irr();     
     l_CP_MANY                  varchar2(4000);
     l_CP_MANY30                varchar2(500);
     v_stmt_str                 varchar2 (14000);
     l_tmp                      number;
     l_id                       number;
     l_q                        number := 0;
     l_sPereoc                  varchar2(500);
     TYPE ManyType IS REF CURSOR;
     v_many_cursor ManyType;
     begin
      bars_audit.info('value_paper.populate_many_row_wnd:start with ref = '||to_char(p_ref)||', rb1='||to_char(rb1)||',rb2='||to_char(rb2)||', DAT_ROZ='||to_char(DAT_ROZ,'dd.mm.yyyy'));

      select *
        into l_prepare_many_wnd
        from table(prepare_many_wnd (p_ref));
        l_CP_MANY := 'SELECT FDAT,SS1,SN2,SDP from cp_many where ref = '||to_char(p_REF)||' and fdat > to_date('''||
        to_char(case when rb1 = 2 then l_prepare_many_wnd.DAT2 else l_prepare_many_wnd.DAT1 end, 'dd/mm/yyyy') ||''',''dd/mm/yyyy'')';

      if DAT_ROZ is null then
      l_prepare_many_wnd.DAT_ROZ := nvl(to_date(bars.pul.get('cp_v_date'),'dd.mm.yyyy'),gl.bd);
      bars_audit.info(' DAT_ROZ is null '||l_prepare_many_wnd.DAT_ROZ);
      end if;

        select id
          into l_id
          from cp_deal
         where ref = p_ref;

       if DAT_ROZ is not null
       then l_CP_MANY := l_CP_MANY || ' /*1*/ union all SELECT to_date('''||to_char(DAT_ROZ,'mm/dd/yyyy') ||''',''mm/dd/yyyy''), 0,0,0 from dual ';
       else l_CP_MANY := l_CP_MANY || ' /*2*/ union all SELECT to_date('''||to_char(l_prepare_many_wnd.DAT_ROZ,'dd/mm/yyyy') ||''',''dd.mm.yyyy''), 0,0,0 from dual ';
       end if;
       bars_audit.info('value_paper.populate_many_row_wnd:start with l_CP_MANY:' ||l_CP_MANY);

       if (DAT_ROZ != gl.bd)
       then
          l_CP_MANY := l_CP_MANY || ' union all SELECT gl.bd, 0,0,0 from dual';
       end if;

       bars_audit.info('value_paper.populate_many_row_wnd:start with l_CP_MANY:' ||l_CP_MANY);

       l_CP_MANY30 := case  when rb1 = 1 then ''
                            else  '(SELECT last_day(add_MONTHS(to_date(''' || to_char(l_prepare_many_wnd.DAT1,'dd/mm/yyyy') ||''', ''dd/mm/yyyy''),num-1 ))+1 FDAT
                     from conductor  where add_MONTHS(to_date(''' || to_char(l_prepare_many_wnd.DAT1,'dd/mm/yyyy') ||''',''dd/mm/yyyy''),num-1 ) <= to_date(''' || to_char(l_prepare_many_wnd.DAT2,'dd/mm/yyyy') ||''',''dd/mm/yyyy'')  ) q '
                     end;

       if (rb1 != 1)
       then
        l_CP_MANY := l_CP_MANY || ' union all select FDAT,0,0,0 from ' ||l_CP_MANY30 ||'where fdat not in (to_date('''|| to_char(l_prepare_many_wnd.DAT_ROZ,'dd/mm/yyyy') ||''',''dd/mm/yyyy''),to_date(gl.bd))
                        and fdat not in (select fdat from cp_many where ref='||to_char(p_REF) || ' ) ';
       end if;

       l_sPereoc := case when rb2 = 0 then ' fostzn( nvl('|| nvl(to_char(l_prepare_many_wnd.nAccS),'null') || ',-999), m.FDAT) '
                    else ' 0 '
                    end;

       v_stmt_str := ' SELECT distinct  m.FDAT, m.SS1 G3, m.SN2 G4, m.SDP G5, '
                     || ' (select SUM( (SS1+SN2) / power( 1 + ('||l_prepare_many_wnd.IRR || ')/100,(FDAT-m.FDAT)/365 ))  '
                     || ' from cp_many where ref= '||to_char(p_REF) ||' and fdat >= m.FDAT) G6, '
                     || ' (select SUM( (SS1+SN2) / power( 1 + ('||to_char(l_prepare_many_wnd.IRE) || ')/100,(FDAT-m.FDAT)/365 ))  '
                     || ' from cp_many where ref= '||to_char(p_REF) || ' and fdat >= m.FDAT) G7, '
                     || ' case when m.FDAT != to_date('''|| to_char(l_prepare_many_wnd.DATP,'dd/mm/yyyy')||''',''dd/mm/yyyy'')'
                     || ' then -cp.KUPON1 ('||to_char(l_ID)||', m.FDAT, to_date('''||to_char(l_prepare_many_wnd.DAT_EM,'dd/mm/yyyy')||''',''dd/mm/yyyy''), to_date('''|| to_char(l_prepare_many_wnd.DATP,'dd/mm/yyyy')||''',''dd/mm/yyyy''))/100  '
                     || ' else 0 end nInt, '
                     || l_sPereoc || ' /100 g11, '
                     || ' value_paper.get_cena_voprosa('||l_ID||', m.FDAT, '||l_prepare_many_wnd.CENA||','||l_prepare_many_wnd.CENA_START||') CENA,' 
                     || ' value_paper.get_count_cp('||l_ID||', m.FDAT, '||l_prepare_many_wnd.CENA||','||l_prepare_many_wnd.CENA_START||', '||l_prepare_many_wnd.nAcc||' ) KOL ' 
                     || ' FROM ( ' || l_CP_MANY || ') m '
                     || ' union ALL '
                     || ' SELECT distinct m.FDAT, m.SS1, m.SN2, m.SDP, '
                     || ' -(m.SS1+m.SN2+m.SDP) SR, '
                     || ' -(m.SS1+m.SN2      ) SE, '
                     || ' -cp.KUPON1 ('||to_char(l_ID)|| ', m.FDAT, to_date('''||to_char(l_prepare_many_wnd.DAT_EM,'dd/mm/yyyy')||''',''dd/mm/yyyy''), to_date('''||to_char(l_prepare_many_wnd.DATP,'dd/mm/yyyy')||''',''dd/mm/yyyy'')) /100, '
                     || l_sPereoc || ' /100 g11, '
                     || ' value_paper.get_cena_voprosa('||l_ID||', m.FDAT, '||l_prepare_many_wnd.CENA||','||l_prepare_many_wnd.CENA_START||') CENA,' 
                     || ' value_paper.get_count_cp('||l_ID||', m.FDAT, '||l_prepare_many_wnd.CENA||','||l_prepare_many_wnd.CENA_START||', '||l_prepare_many_wnd.nAcc||' ) KOL ' 
                     || ' FROM cp_many m where ref = '||to_char(p_REF) ||' and fdat = to_date('''||to_char(l_prepare_many_wnd.DAT1,'dd/mm/yyyy')||''',''dd/mm/yyyy'') '
                     || ' ORDER BY 1';

        v_stmt_str := ' select distinct FDAT, NDD, DNEY, G1, G2, G3, G4, G5, G6, G7, G8, G9 '
        ||' ,case when KOL = 0 then 0 else round(nvl(G9,0)/KOL,4) end as G9A '
        ||' ,case when CENA = 0 then 0 else nvl(nint*(-first_value(g3) over (order by fdat))/CENA,0) end as G10 '
        ||' ,case when CENA = 0 then 0 else nvl(round(nint*(-first_value(g3) over (order by fdat))/CENA*KOL,4),0) end as G10A '
        ||' ,G11 '
        ||' ,case when KOL = 0 then 0 else round(nvl(G11,0)/KOL,4) end as G11A '
        ||' ,sum(G3) over (order by fdat) as G12'
        ||' ,case when KOL = 0 then 0 else (sum(G3) over (order by fdat))/KOL end as G12A'
        ||' ,nvl(sum(G3) over (order by fdat),0) + G8 + case when CENA = 0 then 0 else nvl(nint*(-first_value(g3) over (order by fdat))/CENA,0) end + G11 as G13'
        ||' ,case when KOL = 0 then 0 else ((first_value(g3) over (order by fdat))+ case when NDD = 1 then 0 else G3 end + G8 + case when CENA = 0 then 0 else nvl(nint*(-first_value(g3) over (order by fdat))/CENA,0) end + G11)/KOL end as G13A'
        ||' ,0 G14, 0 color_id '
        ||' from '
        ||' (select FDAT, '
        ||' (FDAT - first_value( FDAT) OVER (ORDER BY FDAT))+1 as NDD,'
        ||' (FDAT -  lag( FDAT) OVER (ORDER BY FDAT)) DNEY, '
        ||' (G3 + G4 +G5) as G1,'
        ||' (G3 + G4) as G2, '
        ||' round(g3,2) as G3, '
        ||' round(g4,2) as G4, '
        ||' round(g5,2) as G5, '
        ||' round(g6,2) as G6, '
        ||' round(g7,2) as G7, '
        ||' round((G7-G6),2) G8, '
        ||' nvl((lag(round((G7-G6),2)) over (order by fdat)- round((G7-G6),2)),0) as G9, '
        ||' nint, case when (FDAT - first_value( FDAT) OVER (ORDER BY FDAT))+1 = 1 then 0 else g11 end as G11, '
        ||' CENA, KOL '
        ||' from ( '|| v_stmt_str
        ||' )) order by 2';
        bars_audit.info('value_paper.populate_many_row_wnd: '|| v_stmt_str);
        OPEN v_many_cursor FOR v_stmt_str;
          LOOP
             FETCH v_many_cursor INTO l_many_grid;
             EXIT WHEN v_many_cursor%NOTFOUND;
             --bars_audit.info(v_many_cursor%ROWCOUNT);
             
             l_t_many_grid.extend;
             l_t_many_grid(l_t_many_grid.last) := l_many_grid;
             
             if l_many_grid.NDD > 0 then --block G14
               l_t_tmp_irr.extend;
               l_t_tmp_irr(l_t_tmp_irr.last) := r_tmp_irr(l_many_grid.NDD, l_many_grid.g1);
               --bars_audit.info('value_paper.populate_many_row_wnd: '||l_many_grid.NDD||'|'||l_many_grid.g1);
             end if;                 --end block G14
             
          END LOOP;
          CLOSE v_many_cursor;
          p_t_many_grid := l_t_many_grid;
          p_t_tmp_irr   := l_t_tmp_irr;
          p_nIrr0       := l_prepare_many_wnd.IR;
  end;

  function populate_many_wnd (p_ref IN NUMBER, rb1 in int, rb2 in int, DAT_ROZ in date)
  return t_many_grid pipelined
  is
  --pragma autonomous_transaction;
  l_prepare_many_wnd         r_prepare_many_wnd;
  l_many_grid                r_many_grid;
  l_t_many_grid              t_many_grid;
  l_t_tmp_irr                t_tmp_irr;
  l_nIrr0                    number;
  begin

  --  execute immediate 'delete from tmp_irr';
  --  commit;
     --   l_nIrr0 := l_prepare_many_wnd.IR/100;
     
    populate_many_row_wnd(p_ref, rb1, rb2, DAT_ROZ, l_t_many_grid, l_t_tmp_irr, l_nIrr0); 
    for i in 1..l_t_many_grid.count
    loop
--     insert into tmp_irr (n,s) values (k.NDD,k.G1*100);
--     commit;
--      update tmp_irr
--              set s = k.G13*100
--            where n = k.NDD;
--      commit;
--      begin
--           select case when abs(round(xIRR (l_nIrr0),4)*100) > 100 then 0 else round(xIRR (l_nIrr0),4)*100 end into k.G14 from dual;
--           exception when others then k.G14 := 0;
--      end;
--
--      delete tmp_irr where n <= k.NDD;
--      commit;
     l_many_grid.color_id := case when l_t_many_grid(i).FDAT <= DAT_ROZ then 0
                                   when l_t_many_grid(i).FDAT <= gl.bd then 1
                                  else 2
                             end;
      l_many_grid.FDAT  := l_t_many_grid(i).FDAT;
      l_many_grid.NDD   := l_t_many_grid(i).NDD;
      l_many_grid.DNEY  := l_t_many_grid(i).DNEY;
      l_many_grid.G1    := l_t_many_grid(i).G1;
      l_many_grid.G2    := l_t_many_grid(i).G2;
      l_many_grid.G3    := l_t_many_grid(i).G3;
      l_many_grid.G4    := l_t_many_grid(i).G4;
      l_many_grid.G5    := l_t_many_grid(i).G5;
      l_many_grid.G6    := l_t_many_grid(i).G6;
      l_many_grid.G7    := l_t_many_grid(i).G7;
      l_many_grid.G8    := l_t_many_grid(i).G8;
      l_many_grid.G9    := l_t_many_grid(i).G9;
      l_many_grid.G9A   := l_t_many_grid(i).G9A;
      l_many_grid.G10   := l_t_many_grid(i).G10;
      l_many_grid.G10A  := l_t_many_grid(i).G10A;
      l_many_grid.G11   := l_t_many_grid(i).G11;
      l_many_grid.G11A  := l_t_many_grid(i).G11A;
      l_many_grid.G12   := l_t_many_grid(i).G12;
      l_many_grid.G12A  := l_t_many_grid(i).G12A;
      l_many_grid.g13   := l_t_many_grid(i).g13;
      l_many_grid.g13A  := l_t_many_grid(i).g13A;
      
--      bars_audit.info('value_paper.populate_many_wnd: i='||i||' count l_t_tmp_irr='||l_t_tmp_irr.count||' count l_t_many_grid='||l_t_many_grid.count||' l_t_tmp_irr.FIRST='||l_t_tmp_irr.FIRST||' l_t_tmp_irr.LAST='||l_t_tmp_irr.LAST);
      for j in l_t_tmp_irr.FIRST..l_t_tmp_irr.LAST loop
        if l_t_tmp_irr(j).n < l_t_many_grid(i).NDD then
--          bars_audit.info('value_paper.populate_many_wnd: удаляю i='||i||'j='||j||'('||l_t_tmp_irr(j).n||'|'||l_t_tmp_irr(j).s||')');
          l_t_tmp_irr.DELETE(j);
        elsif l_t_tmp_irr(j).n = l_t_many_grid(i).NDD then
--          bars_audit.info('value_paper.populate_many_wnd: змінюю i='||i||'j='||j||'('||l_t_tmp_irr(j).n||'|'||l_t_tmp_irr(j).s||')'||' на s '||l_t_many_grid(i).G13*100);
          l_t_tmp_irr(j).s := l_t_many_grid(i).G13;
        else
          exit;
        end if;
      end loop;  
      
--      bars_audit.info('value_paper.populate_many_wnd: розраховую'||' l_t_tmp_irr.FIRST='||l_t_tmp_irr.FIRST||' l_t_tmp_irr..LAST='||l_t_tmp_irr.LAST);          
      l_many_grid.G14   := round(xIRR (l_nIrr0/100, l_t_tmp_irr),4)*100;
              
      PIPE ROW (l_many_grid);
    end loop;
    exception
      when others then 
        bars_audit.error('value_paper.populate_many_wnd: '||dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());          
  end;

 function prepare_cpv_wnd(p_ID in number, nGRP in INT)
      RETURN t_cpv_wnd PIPELINED
 is
 l_CP_ID cp_KOD.cp_id%type;
 l_cpv_wnd r_cpv_wnd;
 l_baseval tabval.kv%type;
 begin

  SELECT k.cp_id, k.DATP, k.IR, k.DAT_EM, k.cena, k.tip, k.kv
    INTO l_CP_ID,
         l_cpv_wnd.p_DATP,
         l_cpv_wnd.p_RATE,
         l_cpv_wnd.p_DAT_EM,
         l_cpv_wnd.p_CENA,
         l_cpv_wnd.p_nTipd,
         l_cpv_wnd.p_KV
    FROM cp_kod k
   WHERE k.id = p_ID;

      BEGIN
        SELECT val
          INTO l_baseval
          FROM params
         WHERE par = 'BASEVAL';
      EXCEPTION
        WHEN NO_DATA_FOUND
        THEN l_baseval := 980;
      END;
  if (l_baseval = 980)
  then
   if (EXTRACT(day from gl.bd) <10 or EXTRACT(month from gl.bd) = 1)
          then l_cpv_wnd.p_cb_Zo    := 1;
          else l_cpv_wnd.p_cb_Zo    := 0;
   end if;
   l_cpv_wnd.p_cb_STP := 1;
  else l_cpv_wnd.p_cb_STP := 0;
       l_cpv_wnd.p_cb_Zo  := 0;
  end if;

  begin
      SELECT nvl(sum(r.ostb),0)/100, nvl(sum(a.ostb),0)/100
        INTO l_cpv_wnd.p_SUMRI, l_cpv_wnd.p_SUMNI
        FROM cp_deal d, accounts r, accounts a
       WHERE d.id = p_id
         AND d.accr=r.acc(+)
         AND d.acc=a.acc;
  exception when no_data_found then l_cpv_wnd.p_SUMRI := 0;  l_cpv_wnd.p_SUMNI := 0;
  end;

  begin
      SELECT nvl(sum(r.nom ),0)/100, nvl(sum(r.kupon),0)/100
        INTO l_cpv_wnd.p_SUMNZ, l_cpv_wnd.p_SUMRZ
        FROM CP_REE2 r
       WHERE r.CP_ID = l_CP_ID;
  exception when no_data_found then l_cpv_wnd.p_SUMNZ := 0;  l_cpv_wnd.p_SUMRZ := 0;
  end;
  pipe row (l_cpv_wnd);
 end;



 function populate_cpv_wnd(p_ID in number, nRYN in int, nGRP in INT)
  return t_cpv_grid pipelined
 is
 l_CP_ID CP_KOD.CP_ID%type;
 l_cpv_grid r_cpv_grid;
 l_cpv_wnd r_cpv_wnd;
 begin

   select distinct *
     into l_cpv_wnd
     from table(value_paper.prepare_cpv_wnd(p_ID, nGRP));

 for k in (
 SELECT k.cp_id, k.DATP, k.IR, k.DAT_EM, k.cena, k.tip, v.vidd, k.kv
    FROM cp_kod k, cp_accc v
   WHERE k.id = p_ID
     and v.ryn = nRYN)
 loop

   l_CP_ID := k.cp_id;
   l_cpv_grid.p_DATP := k.datp;
   l_cpv_grid.p_RATE := k.IR;
   l_cpv_grid.p_DAT_EM := k.DAT_EM;
   l_cpv_grid.p_CENA := k.cena;
   l_cpv_grid.p_nTipd := k.tip;
   l_cpv_grid.p_nVidd := k.vidd;
   l_cpv_grid.p_KV := k.kv;

   SELECT r.OKPO,
             b.nb,
             r.mfo,
             r.nls,
             r.nom / 100,
             r.kupon / 100,
             TO_CHAR (NVL (r.ZASTAVA, 58310))
        INTO l_cpv_grid.p_OKPO,
             l_cpv_grid.p_NB,
             l_cpv_grid.p_MFO,
             l_cpv_grid.p_NLS,
             l_cpv_grid.p_NOM,
             l_cpv_grid.p_KUPON,
             l_cpv_grid.p_SERR
        FROM CP_REE2 r, banks b
       WHERE r.mfo = b.mfo AND r.CP_ID = l_CP_ID AND r.nom > 0
    ORDER BY b.mfo;

    if  l_cpv_wnd.p_SUMNI > 0
    then l_cpv_grid.p_OSTR := l_cpv_grid.p_KUPON * (l_cpv_grid.p_NOM /l_cpv_wnd.p_SUMNI);
    else l_cpv_grid.p_OSTR := 0;
    end if;

    l_cpv_grid.p_OSTA := l_cpv_grid.p_NOM;

    /*
    If CPV.SUMNK >= CPV.NOM
        Set nRef = NUMBER_Null
        Set sNaznN = 'Iiaaoaiiy iii?iaeo OI '||CPV.CP_ID
        Call cDoc.SetDoc( nRef, 'FXA', 1, Vob_FXA, Str(nRef),
                     GetBankDate(), GetBankDate(), GetBankDate(), GetBankDate(),
                     CPV.B_4621, GetBankName(), GetBankMfo(), '', CPV.KV,
                     CPV.NOM * 100, GetBankOkpoS(),
                     sNls, CPV.NB, sMfo,'', CPV.KV, CPV.NOM * 100, CPV.OKPO,
                     sNaznN, '',GetIdOper(),'',NUMBER_Null,cb_STP )
        If not cDoc.oDoc()
            Return FALSE
        !
        Set CPV.OSTA = CPV.NOM
        Set CPV.SUMNK = CPV.SUMNK - CPV.NOM
        Set kN = kN + CPV.NOM
    ! nieaoeoe eoiii
    If CPV.SUMRK > 0
        Set CPV.OSTR = SalNumberMin( CPV.SUMRK, nKup * (CPV.NOM / CPV.SUMNI) )
        Set nRef = NUMBER_Null
        Set sNaznK = 'Iiaaoaiiy ia?aoiaaiiai eoiiio OI '||CPV.CP_ID
        Call cDoc.SetDoc( nRef, 'FXA', 1, Vob_FXA, Str(nRef),
                     GetBankDate(), GetBankDate(), GetBankDate(), GetBankDate(),
                     CPV.B_4621, GetBankName(), GetBankMfo(), '', CPV.KV,
                     CPV.OSTR * 100, GetBankOkpoS(),
                     sNls, CPV.NB, sMfo,'', CPV.KV, CPV.OSTR * 100, CPV.OKPO,
                     sNaznK, '',GetIdOper(),'',NUMBER_Null,cb_STP)
        If not cDoc.oDoc()
            Return FALSE
        Set kR = kR + CPV.OSTR
        Set CPV.SUMRK = CPV.SUMRK - CPV.OSTR
    */

     pipe row(l_cpv_grid);
  end loop;

 end;
 function make_int_prepare return t_int_prepare pipelined
 is
 pragma autonomous_transaction;
 l_int_prepare r_int_prepare;
 l_int number := 0;
 l_dat2 date;
 begin
  l_dat2 := to_date(bars.pul.get('cp_v_date'),'dd.mm.yyyy');
  bars_audit.info('value_paper.make_int_prepare:' || to_char(l_dat2,'dd.mm.yyyy'));
  for k in (     SELECT
                    (SELECT NVL (k.dok, k.dat_em)
                       FROM cp_deal d, cp_kod k
                      WHERE d.acc = x.Acc AND k.id = cpid) as dok,
                    (SELECT NVL (k.dnk, k.datp)
                       FROM cp_deal d, cp_kod k
                      WHERE d.acc = x.Acc AND k.id = cpid) as dnk,
                    (SELECT COUNT (REF)
                       FROM opldok
                      WHERE acc = x.accr AND sos > 0 AND sos < 5)
                       AS notvisa,
                    x.kv,
                    x.nls,
                    x.nms,
                    x.nbs,
                    x.ACCC,
                    x.tip,
                    x.acc,
                    x.rnk,
                    x.id,
                    x.ACR_DAT,
                    x.acra,
                    x.acrb,
                    x.stp_DAT,
                    x.METR,
                    x.BASEY,
                    x.BASEM,
                    x.tt,
                    aa.nls NLSA,
                    aa.nms NMSA,
                    aa.kv KVA,
                    bb.nls NLSb,
                    bb.nms NMSb,
                    bb.kv KVb,
                    x.ob22,
                    x.ostc / 100 ostc,
                    x.dapp,
                    x.branch,
                    x.accr,
                    x.REF
               FROM accounts aa,
                    accounts bb,
                    (SELECT a.kv,
                            a.nls,
                            a.nms,
                            a.nbs,
                            a.ACCC,
                            a.tip,
                            a.acc,
                            a.rnk,
                            a.ob22,
                            a.ostc,
                            a.dapp,
                            i.id,
                            cd.id cpid,
                            GREATEST (a.daos - 1, i.acr_dat) ACR_DAT,
                            i.acra,
                            i.acrb,
                            i.stp_DAT,
                            i.METR,
                            i.BASEY,
                            i.BASEM,
                            i.tt,
                            a.branch,
                            ca.CP_ref REF,
                            car.cp_acc accr
                       FROM int_accn i,
                            cp_accounts ca,
                            accounts a,
                            cp_deal cd,
                            cp_accounts car
                      WHERE     a.acc = i.acc
                            AND a.acc = ca.cp_acc
                            AND ca.cp_ref = car.cp_ref
                            AND car.cp_acctype = 'R'
                            AND a.acc = cd.acc
                            AND a.dazs IS NULL
                            and cd.ref in (select ref from table(value_paper.get_cp(0, 22, null, bars.pul.Get_Mas_Ini_Val('cp_filter'), l_dat2, 1)))
                            AND (   i.metr IN (0,1,2,3,4,5,7,8,10,12,23,515) OR i.metr > 90)
                            AND i.id NOT IN (10, 11)) x
              WHERE x.acra = aa.acc AND x.acrb = bb.acc)
  loop
   BARS.INT_CP_P(p_METR => k.metr, --код методики
                 p_Acc  => k.acc,  -- для передачи в
                 p_Id   => k.id,   -- acrn.p_int(nAcc,nId,dDat1,dDat2,nInt,nOst,nMode)
                 p_Dat1 => k.ACR_DAT+1,  --
                 p_Dat2 => l_dat2,  --
                 p_Int  => l_int,  -- Interest accrued
                 p_Ost  => k.ostc,
                 p_Mode => 1);
  commit;
  end loop;

  for k in (  WITH cpacc as (select cp_acc, cp_ref from cp_accounts)
            SELECT user_id, a.acc,
                   ar.nms as nmsa,
                   ar.nls as nlsa,
                   ar.kv as kva,
                   (select okpo from customer where rnk = (select rnk from accounts where acc = a.acc)) as id_a,
                   an.fdat, an.tdat, an.ir,
                   abs(fost(a.acc, an.tdat)/100) ostt,
                   abs(an.acrd/100) int,
                   abs(a.ostc/100) ost,
                   (select nls from accounts where acc = ia.acrb) nlsb,
                   (select nms from accounts where acc = ia.acrb) nmsb,
                   (select kv from accounts where acc = ia.acrb) kvb,
                   (select okpo from customer where rnk = (select rnk from accounts where acc = ia.acrb)) as id_b,
                   ia.tt,
                   case when ck.tip =  ck.tip -- 2 говорят, не правильное назначение для ДС, надо для всех такое
                   THEN
                       'Нарах.% по '
                              --||trim(case when ck.tip = 2 then 'ДС' when ck.kv = '036' then 'ЦП' else 'ОВДП' end)
                              ||(select name from cp_type where idt = ck.idt)
                              ||' '||trim(ck.cp_id)
                              ||' уг.'||(select nd from oper where ref = cd.ref)||' '||abs(a.ostc/(100*ck.cena))||'шт. купон'
                              ||(select kup from cp_dat where id = ck.id  and dok = (select min(dok) from cp_dat where dok > l_dat2 and id = ck.id))||' за період ' ||to_char(fdat,'dd.mm.yyyy')||' - '||to_char(tdat,'dd.mm.yyyy')
                   ELSE
                       'нарах.%(купон) по рах. '||a.nls||' '
                              --||trim(case when ck.tip = 2 then 'ДС' when ck.kv = '036' then 'ЦП' else 'ОВДП' end)
                              ||(select name from cp_type where idt = ck.idt)
                              ||' '||trim(ck.cp_id)
                              ||' уг.'||(select nd from oper where ref = cd.ref)||' '||abs(a.ostc/(100*ck.cena))||'шт. купон'
                              ||(select kup from cp_dat where id = ck.id  and dok = (select min(dok) from cp_dat where dok > l_dat2 and id = ck.id)) ||' за період '||to_char(fdat,'dd.mm.yyyy')||' - '||to_char(tdat,'dd.mm.yyyy')
                   END nazn
              FROM acr_intN an, cpacc c, accounts a, accounts ar, int_accn ia, cp_deal cd, cp_kod ck
             where an.acc = c.cp_acc
               and a.acc = an.acc
               and ia.acc = a.acc
               and ia.acra = ar.acc
               and ia.id = an.id
               and cd.ref = c.cp_ref
               and cd.id = ck.id
              order by a.acc, an.fdat)
  loop
      l_int_prepare.runn   := 0;
      l_int_prepare.acc    := k.acc;
      l_int_prepare.nmsa   := k.nmsa;
      l_int_prepare.nlsa   := k.nlsa;
      l_int_prepare.kva    := k.kva;
      l_int_prepare.id_a   := k.id_a;
      l_int_prepare.fdat   := k.fdat;
      l_int_prepare.tdat   := k.tdat;
      l_int_prepare.ir     := k.ir;
      l_int_prepare.ostt   := k.ostt;
      l_int_prepare.int    := k.int;
      l_int_prepare.ost    := k.ost;
      l_int_prepare.nmsb   := k.nmsb;
      l_int_prepare.nlsb   := k.nlsb;
      l_int_prepare.kvb    := k.kvb;
      l_int_prepare.id_b   := k.id_b;
      l_int_prepare.tt     := k.tt;
      l_int_prepare.nazn   := k.nazn;

      pipe row (l_int_prepare);
  end loop;
 end;

 function populate_nbu23_rez(p_ref in number) return t_nbu23_rez pipelined
 is
  l_nbu23_rez r_nbu23_rez;
  TYPE nbu23_rez_cursorCurTyp IS REF CURSOR;
  nbu23_rez_cursor  nbu23_rez_cursorCurTyp;
  v_stmt_str     VARCHAR2 (14000);
 begin

      v_stmt_str := 'select * from NBU23_REZ where ND = '||to_char(p_ref);
      OPEN nbu23_rez_cursor FOR v_stmt_str;

      LOOP
         FETCH nbu23_rez_cursor  INTO l_nbu23_rez;
         EXIT WHEN nbu23_rez_cursor %NOTFOUND;
         pipe row (l_nbu23_rez);
      END LOOP;

      CLOSE nbu23_rez_cursor;
 end;

 procedure calc_many(p_ref cp_many.ref%type) as
   title      constant varchar2(24) := 'value_paper.calc_many:';
   l_cnt      pls_integer;
   l_dat_ug   cp_deal.dat_ug%type;
   l_out      varchar2(4000);
 begin
   bars_audit.info(title || ' Start with params: ' || ' p_ref => ' || p_ref);
   if p_ref is null then
     raise_application_error(-(20000+444),  'Не заданий параметр p_ref');
   end if;
   select count(*) into l_cnt from cp_many where ref = p_ref;
   if l_cnt > 0 then
     raise_application_error(-(20000+444),  'Потоки вже побудовані. Для перебудови потрібно видалити існуючі записи.');
   end if;
   select dat_ug into l_dat_ug from cp_deal where ref = p_ref;
   --побудувати потоки без врахування продажів
   cp.RMany(p_ref, p_ref, l_dat_ug, 0, 0, l_out);
   --створити черги згідно продажів
   for cur1 in (select a.dat_opl, a.sumb, a.n, a.ref from cp_arch a where a.ref_main = p_ref and a.op = 2 order by a.dat_opl)
   loop
     cp.RMany_dat(p_ref, cur1.ref, cur1.dat_opl, cur1.sumb, cur1.n);
   end loop;
   --відпрацювати чергу(всю)
   cp.RMany_all(null);
   bars_audit.info(title || ' End');
 end;


 /*див. заявку COBUMMFO-5098
 (існує дод. параметр в cp_kodw OS_UM , по ідеї він має відмерти)
 фізичне видлаення з довідника заборонено трігером, так як користувачу надали можливість
 через БМД маніпулювати даними в довіднику
 */
 procedure change_spec_cond(p_id      cp_spec_cond.id%type,
                            p_type_op number) is --1 додати (бронь), 2-змінити (бронь), 3-видалити, 4-зняти помітку про видалення
   l_r    cp_spec_cond%rowtype;
 begin
   select * into l_r from cp_spec_cond where id = p_id;
   case p_type_op
     when 3 then
       if l_r.del_date is not null then
         raise_application_error(-20001,  'Запис вже помічений як видалено');
         else
           update cp_spec_cond set del_date = sysdate where id = p_id;
       end if;
     when 4 then
       if l_r.del_date is null then
         raise_application_error(-20001,  'Запис існує та непомічений як видалений');
         else
           update cp_spec_cond set del_date = null where id = p_id;
       end if;
   end case;
 end;

 --Існує функція по нарахуванню купону make_int_prepare
 --Ця ж функція для можливості нарахування дивідентів (інший рахунок чим звичайне нарахування, суму вкажуть вручну)
 --Ньюанс - якщо для угоди невідкритий внесистемний рахунок дивідентів, то відкрити його та підвязати до угоди.
 procedure make_int_dividends_prepare(p_ref cp_deal.ref%type default null)
 is
   l_ref           cp_deal.ref%type;

   l_grp           accounts.grp%type;
   l_nlsrd         cp_accc.nlsrd%type;
   l_nlsrd_6       cp_accc.nlsrd_6%type;  
   l_accrd_6       accounts.acc%type;
   l_kv            cp_kod.kv%type;
   l_rnk           cp_kod.rnk%type;
   l_cp_id         cp_kod.cp_id%type;
   l_basey         cp_kod.basey%type;
   l_dazs          cp_deal.dazs%type;
   l_accrd_vnesist accounts.acc%type;
   l_nlsrd_vnesist accounts.nls%type;
   l_nmsrd_vnesist accounts.nms%type;
   l_accrd_sist    accounts.acc%type;
   l_nd            oper.nd%type;

   l_p4            integer;
   l_s8            varchar2(8);
 begin
   if p_ref is null then
     l_ref := to_number(bars.pul.get('cp_ref_dividents'));
     else
       l_ref := p_ref;
   end if;
   bars_audit.info('value_paper.make_int_dividends_prepare START: REF=' || l_ref);
   if l_ref is null then
     raise_application_error(-20001,  'Вкажіть REF угоди по якій необхідно нарахувати дивіденти');
   end if;

   select a.nlsrd, k.kv, d.dazs,
          (select ac.cp_acc from cp_accounts ac where ac.cp_ref = l_ref and ac.cp_acctype = 'RD') as accrd,
          (select o.nd from oper o where o.ref = l_ref) as nd,
          k.rnk, k.cp_id, a.nlsrd_6, 
          (select acc from accounts where nls = a.nlsrd_6 and kv = 980), 
          k.basey
     into l_nlsrd, l_kv, l_dazs,
          l_accrd_vnesist,
          l_nd,
          l_rnk, l_cp_id, l_nlsrd_6, 
          l_accrd_6,
          l_basey
   from cp_kod k
   join cp_deal d on (k.id = d.id)
   left join cp_accc a on (d.ryn = a.ryn and nvl(d.pf, a.pf) = a.pf and k.emi = a.emi)
   where d.ref = l_ref;

   if l_dazs is not null then
     raise_application_error(-20001,  'Угода закрита '||l_dazs);
   end if;
   if l_nlsrd is null then
     raise_application_error(-20001,  'Невказаний консолідований рахунок дивідентів (в довіднику cp_accc)');
   end if;
   if l_nlsrd_6 is null then
     raise_application_error(-20001,  'Невказаний рахунок доходів по дивідентам 6 клас (в довіднику cp_accc)');
   end if;
   

   if l_accrd_vnesist is null then --тоді відкрити по угоді внесистемний рахунок і підвязати до угоди
     begin
       select a.dazs, a.acc,        a.grp, l_cp_id||'/'||a.nms
         into l_dazs, l_accrd_sist, l_grp, l_nmsrd_vnesist
       from accounts a
       where a.nls = l_nlsrd and a.kv = l_kv;
       exception
         when NO_DATA_FOUND then
           raise_application_error(-20001,  'Консолідований рахунок дивідентів '||l_nlsrd||' у валюті '||l_kv||' не знайдено');
     end;
     if l_dazs is not null then
       raise_application_error(-20001,  'Консолідований рахунок дивідентів '||l_nlsrd||' закритий '||l_dazs);
     end if;

     l_s8 := substr('000000000'|| l_ref, -8 );
     l_nlsrd_vnesist := substr(l_nlsrd,1,5)||'0'||l_s8;
     --відкрити
     cp.CP_REG_EX(99,0,0,l_grp,l_p4, l_rnk , l_nlsrd_vnesist,l_kv, l_nmsrd_vnesist,'ODB',gl.aUid,l_accrd_vnesist);
     update accounts
     set accc=l_accrd_sist, seci=4, pos=1
     where acc=l_accrd_vnesist;

     cp.cp_inherit_specparam (l_accrd_vnesist, l_accrd_sist, 0);

     --підвязати
     insert into cp_accounts(cp_ref, cp_acctype, cp_acc)
     values(l_ref, 'RD', l_accrd_vnesist);
     
     insert into int_accn (acc            ,id, acra           ,  acrb     ,   metr,   tt  ,    basey,      freq,   acr_dat   ,io)
          values          (l_accrd_vnesist, 0, l_accrd_vnesist,  l_accrd_6,      4,  'FX%',  l_basey,         1,   gl.BDATE-1, 0);     
   end if;

   delete from cp_int_dividents where user_id = user_id();
   insert into cp_int_dividents(ref, nazn, nlsrd_6) values(l_ref, 'Нараховані дивіденди по акціям '||l_cp_id||'уг.'||l_nd||' за період ', l_nlsrd_6);
   bars_audit.info('value_paper.make_int_dividends_prepare END');
 end;

 procedure change_int_dividends_prepare(p_ref cp_int_dividents.ref%type, p_sum cp_int_dividents.sum%type, p_nazn cp_int_dividents.nazn%type)
 is
 begin
   if p_ref is null then
     raise_application_error(-20001,  'Вкажіть REF угоди');
   end if;

   update cp_int_dividents
      set nazn = p_nazn, sum = p_sum
    where ref = p_ref and user_id = user_id();

   if sql%rowcount = 0 then
     raise_application_error(-20001,  'Оновив 0 записів!');
   end if;

 end;

  procedure make_oper_cp_int_dividends (p_ref cp_int_dividents.ref%type, p_sum cp_int_dividents.sum%type, p_nazn cp_int_dividents.nazn%type, p_nlsrd_6 cp_int_dividents.nlsrd_6%type)
  is
    oo     oper%rowtype;
    l_acc  accounts.acc%type;
  begin
    bars_audit.info('value_paper.make_oper_cp_int_dividends START: REF=' || p_ref);

    if p_ref is null then
      raise_application_error(-20001,  'Вкажіть REF угоди');
    end if;
    if nvl(p_sum, 0) = 0 then
      raise_application_error(-20001,  'Вкажіть суму нарахування дивідентів');
    end if;
    if p_nazn is null then
      raise_application_error(-20001,  'Вкажіть признаення платежу');
    end if;
    if p_nlsrd_6 is null then
      raise_application_error(-20001,  'Вкажіть рахунок доходів по дивідентам');
    end if;    

    select a.nls, a.kv, substr(a.nms, 1, 38), c.okpo, a.acc
    into   oo.nlsa, oo.kv, oo.nam_a, oo.id_a,         l_acc
    from cp_accounts ac, accounts a, customer c
    where ac.cp_ref = p_ref and ac.cp_acctype = 'RD'
      and ac.cp_acc = a.acc
      and a.rnk = c.rnk;
      
    select substr(a.nms, 1, 38), c.okpo
    into   oo.nam_b, oo.id_b
    from accounts a, customer c
    where a.nls = p_nlsrd_6 and a.kv = 980
      and a.rnk = c.rnk;     

    gl.ref (oo.REF);

    oo.nd    := trim (Substr( '          '||to_char(oo.ref) , -10));
    oo.s     := p_sum*100;
    oo.s2    := gl.p_icurval(oo.kv, p_sum*100, gl.bd);
    oo.dk    := 1;
    oo.tt    := 'FX%';
    oo.nlsb  := p_nlsrd_6;
    oo.kv2   := 980;
    oo.nazn  := substr(p_nazn,1,160);

    gl.in_doc3 (oo.REF, oo.tt, 6, oo.nd, SYSDATE, gl.bdate, oo.dk,  oo.kv, oo.S , oo.kv2 ,oo.S2, null, gl.BDATE, gl.bdate,
                  oo.nam_a, oo.nlsa,  gl.aMfo,
                  oo.nam_b, oo.nlsb,  gl.amfo,
                  oo.nazn ,null,oo.id_a, gl.Aokpo, null, null, 1, null, null);
    gl.payv(0, oo.ref, gl.bdate, oo.tt, oo.dk, oo.kv, oo.nlsa, oo.s, oo.kv2, oo.nlsb, oo.s2);
    update int_accn set acr_dat = gl.bdate where acc = l_acc and id = 0;
      --------------------
      -- Вставка записи-истории о начислении процентов, если, в будущем будет необходимость СТОРНО или персчета процентов.
    ACRN.acr_dati ( l_acc, 0, oo.REF, gl.bdate, 0);
   
    delete from cp_int_dividents where user_id = user_id(); 
    
    bars_audit.info('value_paper.make_oper_cp_int_dividends END');
end;

  --за основу функції взяті з нового пакету cp_rep_dgp
  --після устаканювання звітів, та потоків потрібно зробити єдину точку визову цих функцій, наприклад з цього пакету.
  function get_cena_voprosa(p_id cp_kod.id%type, p_date date, p_cena cp_kod.cena%type, p_cena_start cp_kod.cena_start%type)   return number is
    l_cena     cp_kod.cena%type;
  begin
    bars_audit.info('value_paper.get_cena_voprosa: p_id='||p_id||' p_date='||p_date||' p_cena='||p_cena||' p_cena_start='||p_cena_start );
    if p_cena != p_cena_start then
      begin
        select p_cena_start - nvl(sum(nvl(a.nom, 0)), 0)
          into l_cena
          from cp_dat a
         where a.id = p_id
           and a.DOK <= p_date;
         exception
           when NO_DATA_FOUND then l_cena := p_cena_start;
      end;
      else
        l_cena := p_cena_start;
    end if;
    return  l_cena;
  end;

  --за основу функції взяті з нового пакету cp_rep_dgp
  --після устаканювання звітів, та потоків потрібно зробити єдину точку визову цих функцій, наприклад з цього пакету.
  function get_count_cp(p_id cp_kod.id%type, p_date date, p_cena cp_kod.cena%type, p_cena_start cp_kod.cena_start%type, p_acc cp_deal.acc%type) 
  return number is
    l_cena     cp_kod.cena%type;
    l_cnt_cp   number :=0;
    l_nom      number;
  begin
    bars_audit.info('value_paper.get_count_cp: p_id='||p_id||' p_date='||p_date||' p_cena='||p_cena||' p_cena_start='||p_cena_start||' p_acc='||p_acc );
    l_cena := get_cena_voprosa(p_id, p_date + 1, p_cena, p_cena_start);

    if l_cena != 0 then
      select -rez.ostc96(p_acc, p_date) / 100 into l_nom from dual;

      l_cnt_cp := round(l_nom / l_cena, 0);
    end if;  

    return l_cnt_cp;
  end get_count_cp;

END value_paper;
/
 show err;
 
PROMPT *** Create  grants  VALUE_PAPER ***
grant EXECUTE                                                                on VALUE_PAPER     to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/value_paper.sql =========*** End ***
 PROMPT ===================================================================================== 
 