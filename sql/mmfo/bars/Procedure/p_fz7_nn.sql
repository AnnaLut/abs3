CREATE OR REPLACE PROCEDURE BARS.P_FZ7_NN (
   pdat_    IN  DATE,
   pmode_   IN  NUMBER DEFAULT 1,
   type_    IN  NUMBER DEFAULT 1,
   pnd_     IN  NUMBER DEFAULT NULL, 
   flag_    OUT NUMBER
)
IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :  Процедура формирования #Z7 для КБ (универсальная)
% COPYRIGHT   :  Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.18.00  03/12/2018 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%/%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
               pmode_ = режим (0 - для отчетности, 1 - для ANI-отчетов, 2 - для @77)
               type_ = тип разбивки (0 - без разбивки по графику гашения,
                                     1 - разбивка по графику гашения всех счетов,
                                         по которым есть графики
                                     2 - не разбиваются по графикам только некоторые
                                         счета (только для Демарка), НП: счета ФЛ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%/%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   Структура показателя    D BBBB Z P X L R I VVV

 1     D          1/2  (остаток ДТ/КТ)
 2     BBBB       R020 балансовый счет
 6     Z          R011
 7     P          R013
 8     X          S181 начальный срок погашения
 9     L          S240 срок к погашению
10     R          K030 резидентность  (1/2)
11     I          S190 код срока просрочки погашения
12     VVV        R030 код валюты

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   kodf_           VARCHAR2 (2)           := 'Z7';
   sheme_          Varchar2(1) := 'G';

   ret_            NUMBER;
   add_            NUMBER;
   acc_            NUMBER;
   acc_proc_sna    NUMBER := 0;
   nbs_            VARCHAR2 (4);
   nbs1_           VARCHAR2 (4);
   nls_            VARCHAR2 (15);
   rnls_           VARCHAR2 (15);
   rez_            VARCHAR2 (1);
   kv_             SMALLINT;
   r011_           VARCHAR2 (1);
   r011_1419       VARCHAR2 (1);
   r013_           VARCHAR2 (1);
   r013_1          VARCHAR2 (1);
   r013_30         NUMBER;
   dk_             VARCHAR2 (1);
   dk_k            VARCHAR2 (1);
   tips_           VARCHAR2 (3);
   r030_           VARCHAR2 (3);
   r031_           CHAR (1);
   datn_           DATE;
   data_           DATE;
   daos_           DATE;
   dapp_           DATE;
   mdate_          DATE;
   sdate_          DATE;
   d_open_         DATE;
   s_              NUMBER;
   freq_           NUMBER;
   apl_dat_        DATE;
   sn_             DECIMAL (24);
   se_             DECIMAL (24);
   se1_            DECIMAL (24);
   min_sum_        NUMBER;
   fZ7d_           NUMBER;
   fZ7k_           NUMBER;
   fZ7p_           NUMBER;
   s180_           VARCHAR2 (1);
   s180_k          VARCHAR2 (1);
   s181_           VARCHAR2 (1);
   s190_           VARCHAR2 (1);
   s190p_          VARCHAR2 (1);
   s240_           VARCHAR2 (1);
   s242_           VARCHAR2 (1);
   p240_           VARCHAR2 (1);
   p240r_          VARCHAR2 (1);
   p242_           VARCHAR2 (1);
   s260_           VARCHAR2 (2);
   x_              VARCHAR2 (1);
   x1_             VARCHAR2 (1);
   kodp_           VARCHAR2 (20);
   userid_         NUMBER;
   sql_            VARCHAR2 (3000);
   mfo_            NUMBER;
   dc_             NUMBER;
   rnk_            NUMBER;
   isp_            NUMBER;
   nd_             NUMBER;
   ndg_            NUMBER;
   zm_date_        DATE                  := TO_DATE ('01072006', 'ddmmyyyy');
   zm_date2_       DATE                  := TO_DATE ('21122012', 'ddmmyyyy');
   zm_date3_       DATE                  := TO_DATE ('30092013', 'ddmmyyyy');
   zm_date4_       DATE                  := TO_DATE ('26122017', 'ddmmyyyy');
   zm_date5_       DATE                  := TO_DATE ('10012019', 'ddmmyyyy');
   dp_date_        DATE                  := TO_DATE ('06062015', 'ddmmyyyy');
   dat23_          date;

   kol_nd_         number;
   kol_351_        number;
   ap_             NUMBER;
   comm_           rnbu_trace.comm%TYPE;
   comm1_          rnbu_trace.comm%TYPE;
   mfou_           NUMBER;
   exists_         NUMBER;
   mdater_         DATE;
   commb_          rnbu_trace.comm%TYPE;
   pr_             VARCHAR2 (1);
   dat_            DATE                   := pdat_;
   typ_            NUMBER;
   nbuc1_          accounts.tobo%TYPE;
   nbuc_           accounts.tobo%TYPE;

   -- наличие дополнительных модулей
   -- наличие графика погашения субординированного долга
   exist_fakt      NUMBER                 := 0;
  -- наличие установленного модуля факторинга
   exist_sbb       NUMBER                 := 0;
   -- наличие модуля ведения траншей
   exist_trans     NUMBER                 := 0;
   -- наличие графика погашения субординированного долга по даному счету
   exist_sbb_acc   NUMBER                 := 0;
   exist_trans_acc NUMBER                 := 0;
   exist_dop       NUMBER                 := 0;
   exist_cp        NUMBER                 := 0;
   exist_cp_acc    NUMBER                 := 0;
   exist_sno_gr    NUMBER                 := 0;
   exist_cclim_acc      NUMBER                 := 0;
   exist_msb_acc   NUMBER                 := 0;

   tobo_           accounts.tobo%TYPE;
   branch_         accounts.tobo%TYPE;
   branch_bars     accounts.tobo%TYPE;
   -- ДО 30 ДНЕЙ
   o_r013_1        VARCHAR2 (1);
   o_se_1          DECIMAL (24);
   o_comm_1        rnbu_trace.comm%TYPE;
   -- ПОСЛЕ 30 ДНЕЙ
   o_r013_2        VARCHAR2 (1);
   o_se_2          DECIMAL (24);
   o_comm_2        rnbu_trace.comm%TYPE;
   pr_accc         NUMBER;

   o_se_all        DECIMAL (24);
   o_se_1z         DECIMAL (24);
   o_se_2z         DECIMAL (24);

   pr_graf         varchar2(1) := F_Get_Params ('OTC_GRAF', '1');
   tp_graf         BOOLEAN
      := (CASE
             WHEN type_ = 0 or pr_graf = '0'
                THEN FALSE             -- формирование без разбивки по графику
             ELSE TRUE        -- формирование с разбивкой по графику погашения
          END
         );

   fl_mode_ char(9);
   pr_01    Number;

   sql_doda_ varchar2(2000);
   sql_acc_ clob;
   datz_    date := Dat_Next_U(dat_, 1);
   TP_REZ   BOOLEAN := false;
   TP_SND   BOOLEAN := false;
   znap_    rnbu_trace.znap%type;

   type     t_otcn_log is table of number index by pls_integer;
   table_otcn_log3_ t_otcn_log;

   TYPE     t_otcn IS TABLE OF NUMBER(1) INDEX BY VARCHAR2(5);

   table_otcn_c5    t_otcn;
   table_otcn_Z7    t_otcn;

   table_R011      t_otcn;
   table_R013_1    t_otcn;
   table_r013_2    t_otcn;

   cnt_     number;
   datr_    date;
   datb_    date;
   sum_     number;
   sumc_    number := 0;
   srez_    number := 0;
   srezp_   number := 0;
   sakt_    number := 0;

   nbs_r013_    varchar2(5);

   -- балансовые счета премии
   nbspremiy_      VARCHAR2 (2000)
      := '2065,2075,2085,2105,2115,2125,2135,2205,2215,2235,';

   discont_ number := 0;
   premiy_  number := 0;

   -- признак исключения консолидированнных счетов дебит. задолженности и осн.средств
   FL_DO_   number;
   FL_D8_   number := F_Get_Params('DPULINE8', -1);

   datp_    date;
   kodp1_   varchar2(100);
   codc_    number;

   dathb_   date;
   dathe_   date;
   fl_cp_   number:=0;

   id_      NUMBER;
   accr_    number;
   nkd_     varchar2(100);

   s#_              NUMBER;
   freq#_           NUMBER;
   apl_dat#_        DATE;

   sum_zal          number:=0;
   sum_dk           number:=0;

----------------------------------------------------------------------------
   TYPE ref_type_curs IS REF CURSOR;

   saldo        ref_type_curs;
   cursor_sql   clob;

   type rec_type is record
        (acc_   number,
         nls_   varchar2(15),
         kv_    integer,
         data_  date,
         nbs_   varchar2(4),
         tips_  varchar2(3),
         p240_  char(1),
         s180_  char(1),
         s181_  char(1),
         r011_  char(1),
         r013_  char(1),
         r031_  varchar2(2),
         mdate_ date,
         sn_    number,
         se_    number,
         rnk_   number,
         isp_   number,
         rez_   char(1),
         ap_    char(1),
         daos_  date,
         dapp_  date,
         pr_    VARCHAR2 (1),
         tobo_  accounts.tobo%TYPE,
         s260_  varchar2(2),
         r030_  number,
         codc_  number,
         nkd_   varchar2(100),
         s190_  varchar2(1),
         nd_    number,
         sdate_ date,
         freq#           NUMBER,
         s#              NUMBER,
         apl_dat#        DATE,
         ndg_            NUMBER
        );

   TYPE rec_t IS TABLE OF rec_type;
   l_rec_t      rec_t := rec_t();

   TYPE rnbu_trace_t IS TABLE OF rnbu_trace%rowtype;
   l_rnbu_trace rnbu_trace_t := rnbu_trace_t();

   type rec_type8 is record
        (acc_   number,
         r013_1 char(1),
         ost_1  number,
         r013_2 char(1),
         ost_2  number
        );

   TYPE rec_t8 IS TABLE OF rec_type8;
   l_rec_t8      rec_t8 := rec_t8();

    procedure p_add_rec(p_recid rnbu_trace.recid%type, p_userid rnbu_trace.userid%type, p_nls rnbu_trace.nls%type,
                        p_kv rnbu_trace.kv%type, p_odate rnbu_trace.odate%type, p_kodp rnbu_trace.kodp%type,
                        p_znap rnbu_trace.znap%type, p_acc rnbu_trace.acc%type, p_rnk rnbu_trace.rnk%type,
                        p_isp rnbu_trace.isp%type, p_mdate rnbu_trace.mdate%type, p_comm rnbu_trace.comm%type,
                        p_nd rnbu_trace.nd%type, p_nbuc rnbu_trace.nbuc%type, p_tobo rnbu_trace.tobo%type)
    is
        lr_rnbu_trace rnbu_trace%rowtype;
    begin
       lr_rnbu_trace.RECID := p_recid;
       lr_rnbu_trace.USERID := p_userid;
       lr_rnbu_trace.NLS := p_nls;
       lr_rnbu_trace.KV := p_kv;
       lr_rnbu_trace.ODATE := p_odate;
       lr_rnbu_trace.KODP := p_kodp;
       lr_rnbu_trace.ZNAP := p_znap;
       lr_rnbu_trace.NBUC := p_nbuc;
       lr_rnbu_trace.ISP := p_isp;
       lr_rnbu_trace.RNK := p_rnk;
       lr_rnbu_trace.ACC := p_acc;
       lr_rnbu_trace.ref := null;
       lr_rnbu_trace.COMM := p_comm;
       lr_rnbu_trace.ND := p_nd;
       lr_rnbu_trace.mdate := p_mdate;
       lr_rnbu_trace.TOBO := p_tobo;

       l_rnbu_trace.Extend;
       l_rnbu_trace(l_rnbu_trace.last) := lr_rnbu_trace;

       if l_rnbu_trace.COUNT >= 100000 then
          FORALL i IN 1 .. l_rnbu_trace.COUNT
               insert /*+ append */ into rnbu_trace values l_rnbu_trace(i);

          l_rnbu_trace.delete;
       end if;
    end;

-------------------------------------------------------------------
   PROCEDURE pp_doda
   IS
   BEGIN
      -- ОАВ добавил 05.05.2009
      IF nbs_ IN ('2608')
      THEN
         s180_ := '1';
         x_ := '1';
         s242_ := '1';
         comm_ :=
                SUBSTR (comm_ || ' +Замена (S180=1, s181=1, s242=1)', 1, 200);
      END IF;

      IF mfou_ IN (300465)
           AND SUBSTR (nbs_, 1,3) IN ('140', '301')
      THEN
         IF  s180_ ='0'  THEN
             s180_ := '1';
         END IF;

         IF  s242_ ='0'  THEN
             s242_ := '1';
         END IF;
      END IF;

      IF 333368 IN (mfo_, mfou_)
      THEN                             --  11/09/2009 для Сбербанк Ровно (Оля)
         IF nbs_ IN ('2628') AND x_ = '0'
         THEN
            x_ := '1';
            comm_ := SUBSTR (comm_ || ' +Замена (s181=1)', 1, 200);
         END IF;
      END IF;

      -- Virko добавила 18/08/2010
      IF mfou_ = 300465
      THEN         -- згідно листа №31/5-05/171=1612 від 12/03/2009 по системі
         IF nbs_ LIKE '254%'
         THEN
            s242_ := '1';
         END IF;
      END IF;

      -- для Одеського СБЕРа 21/08/2012
      IF mfo_ = 328845
      THEN
         IF nbs_ in ('2620', '2628')
         THEN
            declare
                ob22_ varchar2(2);
            begin
                sql_doda_ := 'select ob22 from specparam_int where acc = '||to_char(acc_);
                execute immediate sql_doda_ into ob22_;

                if nbs_ = '2620' and ob22_ in ('15','23','24','25') or
                   nbs_ = '2628' and ob22_ in ('17','25','26','27')
                then
                    x_ := '1';
                    s242_ := '1';
                end if;
            exception
                when no_data_found then null;
            end;
         END IF;
      END IF;

      -- згідно листа №14/2-04/ ID 1259 від 28.02.2014
      if    ( nbs_ in ('1600','2600','2605','2620','2625','2650','2655') and sn_ < 0
           or nbs_ = '1500' )
         and (x_ <> '1' or s242_ <> '1')
      then
        if x_ <> '1' then
           x_ := '1';
        end if;

        if s242_ <> '1' then
           s242_ := '1';
        end if;

        comm_ := SUBSTR (comm_ || ' +Заміна (Контроль 1 НБУ)', 1, 200);
      end if;

      if (nbs_ in ('1600', '2600', '2605', '2620', '2625', '2650', '2655') and sn_ > 0)
      then
         if (nbs_||r011_ in ('16001', '16081') or
             nbs_||r013_ in ('26001', '26051', '26201', '26251', '26501', '26551')) and
            daos_ >= to_date('06062015','ddmmyyyy')
         then
            if x_ <> '1' then
               x_ := '1';
            end if;

            if s242_ not in ('1','2','3','4','5','I') then
                s242_ := 'I';
                comm_ := SUBSTR (comm_ || ' +Заміна (Контроль 2 НБУ)', 1, 200);
            end if;
         elsif nbs_||r011_ in ('26001', '26051', '26201', '26251', '26501', '26551') then
            if x_ <> '1' then
               x_ := '1';
            end if;

            if s242_ <> '1' then
               s242_ := '1';
            end if;

            comm_ := SUBSTR (comm_ || ' +Поточні рахунки', 1, 200);
         end if;
      end if;

      if s242_ = '0' then
         s242_ := 'I';
         x_ := '1';
      end if;

      if s242_ in ('9', 'C', 'D', 'E', 'F', 'G', 'H','K','L','M') then
         x_ := '2';
      end if;

      if s242_ is null
      then
         s242_ := '0';
      end if;
   END pp_doda;

-------------------------------------------------------------------
   PROCEDURE p_exist_fakt
   IS
   BEGIN
      SELECT COUNT (*)
        INTO exist_fakt
        FROM all_tables
       WHERE owner = 'BARS' AND table_name LIKE 'FAK_INVOICE%';
   END;

-------------------------------------------------------------------
   PROCEDURE p_exist_sbb
   IS
   BEGIN
      SELECT COUNT (*)
        INTO exist_sbb
        FROM all_tables
       WHERE owner = 'BARS' AND table_name LIKE 'OTCN_LIM_SB%';
   END;

   PROCEDURE p_exist_trans
   IS
   BEGIN
      SELECT COUNT (*)
        INTO exist_trans
        FROM all_tables
       WHERE owner = 'BARS' AND table_name LIKE 'CC_TRANS';
   END;

   PROCEDURE p_exist_cp
   IS
   BEGIN
      SELECT COUNT (*)
        INTO exist_cp
        FROM all_tables
       WHERE owner = 'BARS' AND table_name LIKE 'CP_DEAL';

      if exist_cp = 0 then return; end if;

      SELECT COUNT (*)
        INTO exist_cp
        FROM all_tables
       WHERE owner = 'BARS' AND table_name LIKE 'CP_DAT';

      if exist_cp = 0 then return; end if;

      SELECT COUNT (*)
        INTO exist_cp
        FROM all_tables
       WHERE owner = 'BARS' AND table_name LIKE 'CP_KOD';
   END;

   PROCEDURE p_exist_sno_gr
   IS
   BEGIN
      SELECT COUNT (*)
        INTO exist_sno_gr
        FROM all_views
       WHERE owner = 'BARS' AND view_name LIKE 'VC_SNO';
   END;

   FUNCTION f_exist_sbb_acc (pacc_ IN NUMBER)
      RETURN NUMBER
   IS
      sql_   VARCHAR2 (100);
      cnt_   NUMBER;
   BEGIN
      sql_ := 'select count(*) ' || 'from OTCN_LIM_SB ' || 'where acc=:acc_';

      EXECUTE IMMEDIATE sql_
                   INTO cnt_
                  USING pacc_;

      RETURN cnt_;
   END;

   FUNCTION f_exist_cclim_acc (pacc_ IN NUMBER)
      RETURN NUMBER
   IS
      sql_   VARCHAR2 (100);
      cnt_   NUMBER;
   BEGIN
      sql_ := 'select count(*) ' || 'from CC_LIM ' || 'where acc=:acc_';

      EXECUTE IMMEDIATE sql_
                   INTO cnt_
                  USING pacc_;

      RETURN cnt_;
   END;

   FUNCTION f_exist_trans_acc (pacc_ IN NUMBER, pdat_ in date)
      RETURN NUMBER
   IS
      sql_   VARCHAR2 (1000);
      cnt_   NUMBER;
   BEGIN
      sql_ := 'select count(*)
               from OTC_ARC_CC_TRANS
               where dat_otc = :dat_
                 and acc=:acc_
                 and (d_fakt is null or sv<>sz) ';

      EXECUTE IMMEDIATE sql_
                   INTO cnt_
                  USING pdat_, pacc_;

      RETURN cnt_;
   END;

   FUNCTION f_exist_cp_acc (pacc_ IN NUMBER, pdat_ in date)
      RETURN NUMBER
   IS
      sql_   VARCHAR2 (1000);
      cnt_   NUMBER;
   BEGIN
      sql_ := 'select count(*) ' ||
              'from cp_deal d, cp_dat c, cp_kod k '||
              'where d.acc = :acc_ and d.id = c.id and d.id = k.id and'||
                    ' c.nom <> 0 and c.dok >= :dat_ and k.cena <> k.cena_start ';

      EXECUTE IMMEDIATE sql_
                   INTO cnt_
                  USING pacc_, pdat_;

      RETURN cnt_;
   END;

   -- депозити МСБ
   FUNCTION  f_exist_msb_acc (pacc_ IN NUMBER, pdat_ in date)
      RETURN NUMBER
   IS
      sql_   VARCHAR2 (1000);
      cnt_   NUMBER;
   BEGIN
      sql_ := 'select count(distinct a.acc) ' ||
              'from accounts a, deal_account da, object o  '||
              'where a.acc = :acc_ 
                 and o.object_type_id = (select ot.id from object_type ot where ot.type_code = ''SMB_DEPOSIT_TRANCHE'')
                 and o.id = da.deal_id
                 and da.account_type_id = (select ak.id from attribute_kind ak where ak.attribute_code = ''DEPOSIT_PRIMARY_ACCOUNT'')
                 and da.account_id = a.acc ';

      EXECUTE IMMEDIATE sql_
                   INTO cnt_
                  USING pacc_;

      RETURN cnt_;
   END;
   
   BEGIN
    -- фктична дата кінця декади
    dc_ := extract( day from dat_ );

    case
      when dc_ <= 10
      then datn_ := trunc(dat_,'MM') + 9;
      when dc_ <= 20
      then datn_ := trunc(dat_,'MM') + 19;
      else datn_ := last_day(dat_);
    end case;

    --
    select max(FDAT)
      into datr_
      from FDAT
     where FDAT <= datn_;
   
   -- ьеремо дані з #А7 файлу
   if datr_ = dat_ then
      flag_ := 0;
      
      return; 
   else
      flag_ := 1;  
   end if;
   
   datp_ := dat_;
   datn_ := dat_;

   p_arc_otcn (dat_, pmode_);
   commit;

   EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
-------------------------------------------------------------------
   logger.info ('P_FZ7_NN: Begin ');

   userid_ := user_id;

   EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';

   EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_FA7_REZ1';

   EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_FA7_REZ2';

   EXECUTE IMMEDIATE 'TRUNCATE TABLE TMP_KOD_R020';

   EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_FA7_DAPP';
-------------------------------------------------------------------
-- свой МФО
   mfo_ := f_ourmfo ();

-- МФО "родителя"
   BEGIN
      SELECT mfou
        INTO mfou_
        FROM banks
       WHERE mfo = mfo_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         mfou_ := mfo_;
   END;

   if 300465 in (mfo_, mfou_) then
      sheme_ := 'C';
   end if;

   -- определение кода области для выбранного файла и схемы
   P_Proc_Set (kodf_, sheme_, nbuc1_, typ_);

   p_exist_fakt ();
   p_exist_sbb ();
   p_exist_cp ();
   p_exist_sno_gr();

   p_exist_trans ();

   -- признак исключения консолидированнных счетов дебит. задолженности и осн.средств
   FL_DO_ := F_Get_Params ('FLDO_A7', -1);

   --  дата рсчета рзервов
    Dat23_ := TRUNC(add_months(Dat_,1),'MM');

   --  робоча дата початку декади
   select min(fdat), max(fdat)
   into datp_, datb_
   from fdat
   where  fdat between datp_ and datn_;

   datz_ := datn_ + 1;

   insert /*+append */
   into TMP_KOD_R020
   SELECT r020
      FROM kod_r020
     WHERE a010 = 'A7'
       AND trim(prem) = 'КБ'
       AND d_open between TO_DATE ('01011997', 'ddmmyyyy') and datz_
       and (d_close is null or
            d_close >= datz_);
    commit;

    insert/*+append */
    into otcn_fa7_dapp
    select s.acc, max(s.fdat) dapp
     from saldoa s
     where s.fdat <= dat_ and
           s.kos <> 0 and
           (s.ostf >= 0 or s.ostf-s.dos+s.kos >= 0) and
           s.acc in (select acra
                    from int_accn
                    where ID = 1 and acra is not null
                    group by acra
                    having count(*) >1)
   group by s.acc;
   commit;

   declare
      cnt_ number;
   begin
       select count(*)
       into cnt_
       from holiday
       where holiday = datn_;

       dathb_ := null;
       dathe_ := null;

       if cnt_ > 0 then
          select max(fdat) + 1
          into dathb_
          from fdat
          where fdat < datn_;

          select min(fdat) - 1
          into dathe_
          from fdat
          where fdat > datn_;
       else
          select max(fdat) + 1
          into dathe_
          from fdat
          where fdat < datn_;

          if datn_ <> dathe_ then
             dathb_ := dathe_;

             select max(holiday)
             into dathe_
             from holiday
             where holiday < datn_;
          else
             dathb_ := null;
             dathe_ := null;
          end if;
       end if;
   end;

   for k in (SELECT r020
        FROM kl_r020
       WHERE trim(prem) = 'КБ'
         AND (LOWER (txt) LIKE '%нарах%доход%'
              OR LOWER (txt) LIKE '%нарах%витр%')
         AND d_open between TO_DATE ('01011997', 'ddmmyyyy') and datz_
         and (d_close is null or
              d_close >= datz_))
   loop
       table_otcn_Z7(k.r020) := 1;
   end loop;

   for k in (SELECT r020
              FROM kod_r020
                 WHERE trim(prem) = 'КБ'
                   AND a010 = 'C5'
                   AND r020 NOT IN ('2628')
                   and (d_open between TO_DATE ('01011997', 'ddmmyyyy') and datz_
                        and (d_close is null or d_close >= datz_)))
   loop
       table_otcn_c5(k.r020) := 1;
   end loop;

   for k in (select distinct r020||r011 pok
             from kl_r011
             where trim(prem)='КБ'
                  and (d_close is null or
                       d_close >= datz_))
   loop
       table_r011(k.pok) := 1;
   end loop;

   for k in (select distinct r020||r013 pok
             from kl_r013
             where trim(prem)='КБ'
                  and (d_close is null or
                       d_close >= datz_))
   loop
       table_r013_1(k.pok) := 1;
   end loop;

   for k in (select distinct r020||r013 pok
             from kl_r013
             where trim(prem)='КБ'
                   and d_close is not null and d_close <= datz_)
   loop
       table_r013_2(k.pok) := 1;
   end loop;

   if mfo_ = 300465 then
         pul_dat(to_char(Dat_,'dd-mm-yyyy'), '');

         EXECUTE IMMEDIATE 'delete from otcn_f42_cp';

         sql_acc_ :=
                'insert into otcn_f42_cp (fdat, acc, nls, kv, sum_zal, dat_zal, rnk, kodp) '
              ||'select c.fdat, a.acc, a.nls, a.kv, nvl(c.sum_zal, 0), c.dat_zal, a.rnk, null '
              ||'from accounts a, cp_v_zal_acc c '
              ||'where a.acc = c.acc '
              ||'  and c.fdat = :dat_ '
              ||'  and substr(a.nls,1,4) like ''14__%''' ;

            EXECUTE IMMEDIATE sql_acc_ USING dat_;
   end if;

   if pnd_ is null then
      sql_acc_ := ' SELECT  /*+ parallel(a, 8) */ a.ACC, a.KF, 
                        (case when to_date('''||to_char(dat_, 'ddmmyyyy')||''', ''ddmmyyyy'') < a.dat_alt 
                                         then a.nlsalt 
                                         else a.nls 
                                    end) as nls,
                        a.KV, a.BRANCH, a.NLSALT, 
                        (case when to_date('''||to_char(dat_, 'ddmmyyyy')||''', ''ddmmyyyy'') < a.dat_alt 
                                         then substr(a.nlsalt, 1, 4) 
                                         else a.nbs 
                                    end) as NBS, a.NBS2,
                        a.DAOS, a.DAPP, a.ISP, a.NMS, a.LIM, a.OSTB, a.OSTC, a.OSTF, a.OSTQ, a.DOS, a.KOS, a.DOSQ,
                        a.KOSQ, a.PAP, a.TIP, a.VID, a.TRCN, a.MDATE, a.DAZS, a.SEC, a.ACCC, a.BLKD, a.BLKK, a.POS,
                        a.SECI, a.SECO, a.GRP, a.OSTX, a.RNK, a.NOTIFIER_REF, a.TOBO, a.BDATE, a.OPT, a.OB22, a.DAPPQ,
                        a.SEND_SMS, a.DAT_ALT
                    FROM ACCOUNTS a
                    WHERE ( '||to_char(mfou_)||' = 324805
                              AND (a.nbs LIKE ''262%'' OR a.nbs LIKE ''263%'')
                              AND NOT EXISTS (SELECT 1
                                               FROM kf91 K
                                              WHERE TRIM(K.NLS) = A.NBS AND
                                                    K.KV = A.KV AND
                                                    K.RNK = A.RNK AND
                                                    nms LIKE ''Z7%'')
                          OR
                              '||to_char(mfou_)||' = 324805
                              AND (a.nbs NOT LIKE ''262%'' AND a.nbs NOT LIKE ''263%'')
                          OR
                             '||to_char(mfou_)||' <> 324805
                         )
                     AND  nvl(a.nbs, SUBSTR (a.nls, 1, 4)) in (
                            SELECT r020
                              FROM tmp_kod_r020
                              ) '||
                     (case when FL_D8_ = '8' then  ' and tip <> ''NL8'' ' else '' end)||
                     (case  when FL_DO_ = 1
                      then ' and nvl(a.nbs, SUBSTR (a.nls, 1, 4)) not in '||
                           '(select BBBB from A_TPK_Z7ADD where fdat = '||
                           ' to_date('''||to_char(dat_,'ddmmyyyy')||''',''ddmmyyyy'')) '
                      else ''
                      end)  ||
                     (case when FL_D8_ = '8' then
                         ' union all
                            SELECT s.ACC, s.KF, s.NLS, s.KV, s.BRANCH, s.NLSALT, a.NBS, s.NBS2, s.DAOS,
                                s.DAPP, s.ISP, s.NMS, s.LIM, s.OSTB, s.OSTC, s.OSTF, s.OSTQ, s.DOS, s.KOS,
                                s.DOSQ, s.KOSQ, s.PAP, s.TIP, s.VID, s.TRCN, s.MDATE, s.DAZS, s.SEC, s.ACCC,
                                s.BLKD, s.BLKK, s.POS, s.SECI, s.SECO, s.GRP, s.OSTX, s.RNK, s.NOTIFIER_REF,
                                s.TOBO, s.BDATE, s.OPT, s.OB22, s.DAPPQ, s.SEND_SMS, s.DAT_ALT
                             FROM ACCOUNTS a, V_DPU_REL_ACC_ALL v, accounts s
                             where a.nbs IN (
                                SELECT r020
                                  FROM tmp_kod_r020 ) and
                                   a.tip = ''NL8''  and
                                   a.acc = v.GEN_ACC and
                                   v.DEP_ACC = s.acc  '
                       else '' end);
   else
      sql_acc_ := 'SELECT a.ACC, a.KF, a.NLS, a.KV, a.BRANCH, a.NLSALT, a.NBS, a.NBS2,
                        a.DAOS, a.DAPP, a.ISP, a.NMS, a.LIM, a.OSTB, a.OSTC, a.OSTF, a.OSTQ, a.DOS, a.KOS, a.DOSQ,
                        a.KOSQ, a.PAP, a.TIP, a.VID, a.TRCN, a.MDATE, a.DAZS, a.SEC, a.ACCC, a.BLKD, a.BLKK, a.POS,
                        a.SECI, a.SECO, a.GRP, a.OSTX, a.RNK, a.NOTIFIER_REF, a.TOBO, a.BDATE, a.OPT, a.OB22, a.DAPPQ,
                        a.SEND_SMS, a.DAT_ALT
                    FROM ACCOUNTS a
                    WHERE acc in (select acc from nd_acc where nd = '||to_char(pnd_)|| ' ) and
                        ( '||to_char(mfo_)||' in ( 322669,324805,380764)
                              AND (a.nbs LIKE ''262%'' OR a.nbs LIKE ''263%'')
                              AND NOT EXISTS (SELECT TRIM (nls), rnk
                                               FROM kf91 K
                                              WHERE TRIM(K.NLS) = A.NBS AND
                                                    K.KV = A.KV AND
                                                    K.RNK = A.RNK AND
                                                    nms LIKE ''Z7%'')
                          OR
                              '||to_char(mfou_)||' in( 324805,380764)
                              AND (a.nbs NOT LIKE ''262%'' AND a.nbs NOT LIKE ''263%'')
                          OR
                             '||to_char(mfou_)||' not in (324805,380764)
                         )
                     AND  nvl(a.nbs, SUBSTR (a.nls, 1, 4)) in (
                            SELECT r020
                              FROM tmp_kod_r020
                             )  and tip <> ''NL8'' ';
   end if;

   begin
      if pmode_ <> 2
      then
         ret_ := BARS.F_POP_OTCN( dat_, 1, sql_acc_, null, 0, 1);
      else
         -- для месячного файла с учетом корректирующих
         if to_char(dat_, 'mm') = '12' then
            ret_ := BARS.F_POP_OTCN( dat_, 4, sql_acc_, null, 1, 1);
         else
            ret_ := BARS.F_POP_OTCN( dat_, 2, sql_acc_, null, 0, 1);
         end if;
      end if;
   end;

   select count(*)   into kol_nd_
    from kol_nd_dat
   where dat =pdat_;

   if kol_nd_ =0  then
       P_KOL_ND_OTC(pdat_);    -- заполнение табл. дней просрочки по дате
       commit;
   end if;

   cursor_sql := 'select t.*
                  from (select a.*, d.nd, d.sdate, v.freq, v.s, v.apl_dat, d.ndg
                       from (
                       SELECT a.acc, a.nls, a.kv, a.fdat, a.nbs, a.tip, p.s240, p.s180, p.s181,
                             p.r011, nvl(trim(p.r013), ''0'') r013, l.r031, a.mdate, a.ost, a.ostq, a.rnk, a.isp,
                             DECODE(f_ourmfo, 380764, 2-MOD(c.codcagent,2), NVL (DECODE (c.country, 804, ''1'', ''2''), ''1'')) k041,
                             a.pap, a.daos, a.dapp, a.pr, a.tobo, LPAD (NVL (TRIM (p.s260), ''00''), 2, ''0'') s260,
                             lpad(l.r030, 3, ''0'') r030,
                             (case when c.codcagent = 5 and sed = ''91'' then 3 else c.codcagent end) codcagent,
                             p.nkd, nvl(p.s190, ''0'') s190
                        FROM (SELECT /*+ use_hash(aa) full(aa) full(s) */
                                     s.acc, s.nls, s.kv, s.mdate, aa.fdat, s.nbs, s.tip,
                                     aa.dos, aa.kos, s.rnk, s.isp, s.pap, s.daos,
                                     DECODE(:pmode_, 2, aa.ost - aa.dos96 + aa.kos96, aa.ost) ost,
                                     DECODE(:pmode_, 2,
                                         decode(aa.kv, 980, aa.ost - aa.dos96 + aa.kos96,
                                                            aa.ostq - aa.dosq96 + aa.kosq96),
                                         decode(aa.kv, 980, aa.ost, aa.ostq)) ostq,
                                     s.dapp, ''0'' pr, s.tobo
                                FROM otcn_saldo aa, otcn_acc s
                               WHERE aa.acc = s.acc and
                                     s.tip not in (''REZ'', ''SNA'') and
                                     not ((s.nls like ''204%'' or s.nls like ''239%'') and s.tip = ''SDF'')) a,
                             kl_r030 l,
                             specparam p,
                             customer c
                       WHERE a.ost <> 0
                         AND a.kv = TO_NUMBER (l.r030)
                         AND a.acc = p.acc(+)
                         AND a.rnk = c.rnk) a
                         left outer join (select n.acc, max(n.nd) nd, max(c.sdate) sdate, max(c.ndg) ndg
                                              from nd_acc n, cc_deal c
                                              where n.nd = c.nd and
                                                        c.sdate <= :dat_
                                               group by n.acc) d
                         on (a.acc = d.acc)
                         left outer join (SELECT i.freq, NVL (i.s, 0) s, i.apl_dat, n8.nd nd
                                           FROM nd_acc n8, accounts a8, int_accn i
                                           WHERE n8.acc = a8.acc
                                             AND a8.nls LIKE ''8999%''
                                             AND a8.acc = i.acc
                                             AND i.ID = 0) v
                         on (d.nd = v.nd) ) t
                         order by t.tobo ' ;

   OPEN saldo FOR cursor_sql USING pmode_, pmode_, Dat_;
   LOOP
      FETCH saldo BULK COLLECT INTO l_rec_t LIMIT 100000;
      EXIT WHEN l_rec_t.count = 0;

      for i in 1..l_rec_t.count loop
          acc_   :=     l_rec_t(i).acc_;
          nls_   :=     l_rec_t(i).nls_;
          kv_    :=     l_rec_t(i).kv_;
          data_  :=     l_rec_t(i).data_;
          nbs_   :=     l_rec_t(i).nbs_;
          tips_  :=     l_rec_t(i).tips_;
          p240_  :=     l_rec_t(i).p240_;
          s180_  :=     l_rec_t(i).s180_;
          s181_  :=     l_rec_t(i).s181_;
          r011_  :=     l_rec_t(i).r011_;
          r013_  :=     l_rec_t(i).r013_;
          r031_  :=     l_rec_t(i).r031_;
          mdate_ :=     l_rec_t(i).mdate_;
          sn_    :=     l_rec_t(i).sn_;
          se_    :=     l_rec_t(i).se_;
          rnk_   :=     l_rec_t(i).rnk_;
          isp_   :=     l_rec_t(i).isp_;
          rez_   :=     l_rec_t(i).rez_;
          ap_    :=     l_rec_t(i).ap_;
          daos_  :=     l_rec_t(i).daos_;
          dapp_  :=     l_rec_t(i).dapp_;
          pr_    :=     l_rec_t(i).pr_;
          tobo_  :=     l_rec_t(i).tobo_;
          s260_  :=     l_rec_t(i).s260_;
          r030_  :=     l_rec_t(i).r030_;
          codc_  :=     l_rec_t(i).codc_;
          nkd_   :=     l_rec_t(i).nkd_;
          s190p_  :=    l_rec_t(i).s190_;
          nd_    :=     l_rec_t(i).nd_;
          sdate_  :=    l_rec_t(i).sdate_;
          freq#_  :=    l_rec_t(i).freq#;
          s#_     :=    l_rec_t(i).s#;
          apl_dat#_ :=  l_rec_t(i).apl_dat#;
          ndg_      :=  l_rec_t(i).ndg_;

          -- для @77 потрібно брати дату з архіву
          if pmode_ = 2 then
             mdate_ := nvl(f_mdate_hist(acc_, dat_), mdate_);
          end if;

          p240_ := NVL (TRIM (p240_), '0');
          s180_ := NVL (TRIM (s180_), '0');
          s181_ := NVL (TRIM (s181_), '0');
          r011_ := NVL (TRIM (r011_), '0');

          if nls_ like '29%' or nbs_ ='3648'  then
             r011_ := '0';
          end if;

          r013_ := NVL (TRIM (r013_), '0');

          r030_ := LPAD(r030_, 3, '0');

          s190_ :='0';

          tips_ := TRIM (tips_);

          -- для того, щоб по гарантіях не брати графік
          if tips_ = 'SS' and nls_ like '9000%' then
             tips_ := 'ODB';
          end if;

          ap_ := (case when ap_ = 3 then (case when sign(sn_) = -1 then 1 else 2 end) else ap_ end);

          pr_accc := 0;
          dk_k := null;

          IF typ_ > 0 THEN
             nbuc_ := NVL (F_Codobl_branch (tobo_, typ_), nbuc1_);
          ELSE
             nbuc_ := nbuc1_;
          END IF;

          if r013_ <> '0' then
             BEGIN
                if table_r013_1(nbs_||r013_) = 1 then
                   r013_1 := r013_;
                end if;
             EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                BEGIN
                   if table_r013_2(nbs_||r013_) = 1 then
                      r013_1 := r013_;
                   end if;

                   r013_ := '0';
                EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN
                   null;
                END;
             END;
          end if;

          IF mfou_ IN (300465)
             AND (SUBSTR (nls_, 1, 3) IN
                    ('140', '141', '142', '143', '144', '300', '301', '310',
                     '311', '312', '313', '321', '330', '331') or SUBSTR (nls_, 1, 4) in ('3541', '4203'))
          THEN
             -- добавил для банка ОПЕРУ СБ обработку дочерних счетов по ЦБ
             -- вместо консолидированных
             IF     nbs_ IS NOT NULL
                AND (mfo_ = 300465 and nbs_ NOT IN ('1435', '3007', '3107') or
                     mfo_ <> 300465)
             THEN
                BEGIN
                   SELECT COUNT (*)
                     INTO pr_accc
                     FROM otcn_saldo a, accounts s
                    WHERE a.fdat = dat_
                      AND s.accc = acc_
                      AND s.accc = a.acc
                      AND s.nbs IS NULL;
                EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN
                      pr_accc := 0;
                END;
             END IF;
          END IF;

--------------------------------------- S190
          begin
              select nvl(kol,0)  into kol_351_
                from kol_nd_dat
               where dat =pdat_
                 and nd = nvl(ndg_, nd_)
                 and rownum = 1;

          exception
             when others  then  kol_351_ :=0;
          end;

          if kol_351_ = 0
          then
             s190_ := '0';
          elsif kol_351_ > 0 and kol_351_ < 8
          then
             s190_ := 'A';
          elsif kol_351_ < 31
          then
             s190_ := 'B';
          elsif kol_351_ < 61
          then
             s190_ := 'C';
          elsif kol_351_ < 91
          then
             s190_ := 'D';
          elsif kol_351_ < 181
          then
             s190_ := 'E';
          elsif kol_351_ < 361
          then
             s190_ := 'F';
          else
             s190_ := 'G';
          end if;

          if s190p_ <> '0' and s190p_ in ('A', 'B', 'C', 'D', 'E', 'F', 'G')  then
             s190_ := s190p_;
          end if;
---------------------------------------
          IF    (    mfou_ IN (300465)
                 AND (   (    nbs_ IS NULL
                          AND (mfo_ = 300465 and SUBSTR (nls_, 1, 4) NOT IN
                                 ('1435', '3007', '3107') or
                               mfo_ <> 300465)
                         )
                      OR (pr_accc = 0 AND nbs_ IS NOT NULL)
                     )
                )
             OR mfou_ NOT IN (300465)
          THEN

             BEGIN
                SELECT a.ost
                  INTO se1_
                  FROM snap_balances a, accounts s
                 WHERE a.fdat = dat_
                   AND s.acc = acc_
                   AND s.accc = a.acc
                   AND nbs_ IS NOT NULL;

                dk_k := iif_n (se1_, 0, '1', '2', '2');
             EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                     null;
             END;

             IF nbs_ IS NULL
             THEN
                nbs_ := SUBSTR (nls_, 1, 4);
             END IF;

             BEGIN
                if table_otcn_c5(nbs_) = 1 then
                   pr_ := '1';
                else
                   pr_ := '0';
                end if;
             EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                   pr_ := '0';
             END;

             exist_sbb_acc := 0;

             p240r_ := fs240 (datn_, acc_, dathb_, dathe_, mdate_, p240_);

             IF s180_ = '0'
             THEN
                s180_ := fs180 (acc_, SUBSTR (nbs_, 1, 1), dat_);
             END IF;

             IF s181_ = '0'
             THEN
                s181_ := fs181 (acc_, dat_, s180_);
             END IF;

             freq_ := NULL;
             x_ := s181_;
             fZ7p_ := 0;
             s242_ := NULL;

             -- Счет начисленных процентов?
             BEGIN
                 if table_otcn_Z7(nbs_) = 1 then
                    fZ7p_ := 1;
                 else
                    fZ7p_ := 0;
                 end if;
             EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                   fZ7p_ := (case when substr(nls_,1,1) in ('1','2', '3') and
                        (substr(nls_,4,1) in ('8') or substr(nls_,1,4) in ('2607', '2627'))
                        then 1 else 0 end);
             END;

             IF fZ7p_ > 0 and upper(nkd_) like '%БПК%' and nvl(trim(p240_), '0') <> '0' then
                mdate_ := null;
                s242_ := p240_;
                p240r_ := p240_;
             end if;

             comm_ :=
                   ' s180 = '
                || s180_
                || ' s181 = '
                || s181_
                || ' s240 = '
                || p240_
                || ' mdate='''
                || TO_CHAR (mdate_, 'dd/mm/yyyy')
                || ''' '
                || ' (r240 = '
                || p240r_
                || ') ';

             if exist_trans = 1 then
                exist_trans_acc := f_exist_trans_acc (acc_, datn_);
             else
                exist_trans_acc := 0;
             end if;

             if exist_cp = 1 and
                SUBSTR (nls_, 1, 4) IN ('3110','3111','3112','3113','3114',
                        '3210','3211','3212','3213','3214','3315')
             then
                exist_cp_acc := f_exist_cp_acc (acc_, dat_);
             else
                exist_cp_acc := 0;
             end if;

             -- депозити МСБ
             if nbs_ in ('2600', '2610', '2650', '2651') and se_ > 0 then
                exist_msb_acc := f_exist_msb_acc (acc_, dat_);
             else
                exist_msb_acc := 0;
             end if;

             IF fz7p_ = 0                                     -- депоз./кред. счет
             THEN
                IF mdate_ IS NOT NULL OR p240_ = '0'
                THEN
                   p240_ := p240r_;
                END IF;
             ELSE                                        -- счет начисл. процентов
                IF p240_ = '0'
                THEN
                   p240_ := p240r_;
                END IF;
             END IF;

             if tips_ in ('SDI', 'SDM', 'SDF', 'SDA') or
                instr(nbspremiy_, nbs_) > 0 or
                tips_ = 'SNA'
             then
                if nd_ is null and nls_ like '3%'  then

                begin
                   select cp_ref   into nd_
                     from cp_accounts
                    where cp_acc = acc_;
                exception
                   when others  then NULL;
                end;

                end if;

                insert into OTCN_FA7_REZ2(ND, ACC, PR, SUM)
                values(nd_, acc_, (case when tips_ in ('SDI', 'SDM', 'SDF', 'SDA') then 1
                                        when instr(nbspremiy_, nbs_) > 0 then 2
                                        else 3 end), se_);
             end if;

             -- счета начисленных процентов
             IF fZ7p_ > 0 and tips_ <> 'SNO'
             THEN
                BEGIN
                   IF ap_ = 1
                   THEN
                      if nd_ is not null then  -- кредиты
                          freq_:=freq#_;
                          s_:=s#_;
                          apl_dat_:=apl_dat#_;

                          -- ищем в доп. реквизитах: возможно по пгашению разделяются дни
                          -- погашения основного долга и %%-в
                          -- выбираем первую дату гашения %%-в
                          BEGIN
                             SELECT TO_DATE (TRIM (txt), 'dd/mm/yyyy')
                               INTO apl_dat_
                               FROM nd_txt
                              WHERE nd = nd_ AND tag = 'DATSN';
                          EXCEPTION
                             WHEN NO_DATA_FOUND
                             THEN
                                NULL;
                          END;

                          -- выбираем число гашения %%-в
                          BEGIN
                             SELECT TO_NUMBER (TRIM (txt))
                               INTO s_
                               FROM nd_txt
                              WHERE nd = nd_ AND tag = 'DAYSN';
                          EXCEPTION
                             WHEN NO_DATA_FOUND
                             THEN
                                NULL;
                          END;
                      else
                          freq_ := null;
                          s_ := null;
                          apl_dat_ := null;
                      end if;
                   ELSE
                      -- депозиты
                      declare
                         dapp_ date;
                      BEGIN
                         select max(dapp)
                         into dapp_
                         from otcn_fA7_dapp
                         where acc = acc_;

                         if codc_ in (5, 6) then
                             -- депозиты ФЛ
                             if dapp_ is not null then
                                 SELECT NVL (c.freq, v.freq_k), 0, c.dat_begin
                                   INTO freq_, s_, apl_dat_
                                   FROM int_accn i, dpt_deposit c, dpt_vidd v
                                  WHERE i.acra = acc_
                                    AND i.ID = 1
                                    AND i.acc = c.acc
                                    AND c.vidd = v.vidd
                                    and nvl(i.ACR_DAT, i.apl_DAT) >= dapp_
                                    and i.ACR_DAT = (select min(ACR_DAT)
                                                       from int_accn
                                                       where acra=acc_ and
                                                             nvl(ACR_DAT, apl_DAT) >= dapp_)
                                    and rownum = 1;
                             else
                                 SELECT NVL (c.freq, v.freq_k), 0, c.dat_begin
                                   INTO freq_, s_, apl_dat_
                                   FROM int_accn i, dpt_deposit c, dpt_vidd v
                                  WHERE i.acra = acc_
                                    AND i.ID = 1
                                    AND i.acc = c.acc
                                    AND c.vidd = v.vidd
                                    and rownum = 1;
                             end if;

                             comm_ := comm_ || ' (ДП ФЛ)';
                         else
                            -- депозиты ЮЛ
                            if dapp_ is not null then
                                 SELECT NVL (c.freqv, v.freq_v), 0, c.dat_begin
                                 INTO freq_, s_, apl_dat_
                                 FROM int_accn i, dpu_deal c, dpu_vidd v
                                 WHERE i.acra = acc_
                                   AND i.ID = 1
                                   AND i.acc = c.acc
                                   AND c.vidd = v.vidd
                                   and nvl(i.ACR_DAT, i.apl_DAT) >= dapp_
                                   and i.ACR_DAT = (select min(ACR_DAT)
                                                    from int_accn
                                                    where acra=acc_ and
                                                          nvl(ACR_DAT, apl_DAT) >= dapp_)
                                  and rownum = 1;
                            else
                                 SELECT NVL (c.freqv, v.freq_v), 0, c.dat_begin
                                 INTO freq_, s_, apl_dat_
                                 FROM int_accn i, dpu_deal c, dpu_vidd v
                                 WHERE i.acra = acc_
                                   AND i.ID = 1
                                   AND i.acc = c.acc
                                   AND c.vidd = v.vidd
                                   and rownum = 1;
                            end if;

                            comm_ := comm_ || ' (ДП ЮЛ)';
                         end if;
                      EXCEPTION
                         WHEN NO_DATA_FOUND
                         THEN null;
                      END;
                   END IF;

                   comm_ := comm_ || ' freq=' || freq_ || ' s=' || s_;
                   comm_ :=
                         comm_
                      || ' apl_dat='''
                      || TO_CHAR (apl_dat_, 'dd/mm/yyyy')
                      || '''';
                   comm_ :=
                       comm_ || ' daos=''' || TO_CHAR (daos_, 'dd/mm/yyyy')
                       || '''';

                   IF freq_ IN (2, 5)
                   THEN
                      add_ := 1;
                   ELSIF freq_ = 7
                   THEN
                      add_ := 3;
                   ELSIF freq_ = 180
                   THEN
                      add_ := 6;
                   ELSIF freq_ = 360
                   THEN
                      add_ := 12;
                   ELSE
                      add_ := 0;
                   END IF;

                   IF mdate_ <= datn_
                   THEN
                      add_ := 0;
                   END IF;

                   comm_ := comm_ || ' add=' || TO_CHAR (add_);

                   IF freq_ IS NULL OR freq_ = 400  --  не задан или в конце срока
                   THEN
                      mdater_ := mdate_;
                   ELSIF freq_ = 1                                   --  ежедневно
                   THEN
                      mdater_ := datn_;
                   ELSE
                      IF s_ <> 0
                      THEN                                -- число гашения задано
                         IF     apl_dat_ IS NOT NULL
                            AND apl_dat_ >= datn_
                            AND apl_dat_ <= mdate_
                         THEN                      -- первая дата еще не наступила
                            mdater_ := apl_dat_;
                         ELSE    -- первая дата уже прошла или больше даты гашения
                            BEGIN
                               IF apl_dat_ IS NOT NULL AND apl_dat_ < datn_
                               THEN
                                  IF TO_NUMBER (TO_CHAR (LAST_DAY (apl_dat_),
                                                         'dd')
                                               ) < TO_NUMBER (s_)
                                  THEN
                                     s_ := TO_CHAR (LAST_DAY (apl_dat_), 'dd');
                                  END IF;

                                  mdater_ :=
                                     TO_DATE (TRIM (   LPAD (TRIM (TO_CHAR (s_)),
                                                             2,
                                                             '0'
                                                            )
                                                    || TO_CHAR (apl_dat_,
                                                                'mmyyyy')
                                                   ),
                                              'ddmmyyyy'
                                             );
                               ELSE                       -- первая дата не задана
                                  IF TO_NUMBER (TO_CHAR (LAST_DAY (daos_), 'dd')) <
                                                                   TO_NUMBER (s_)
                                  THEN
                                     s_ := TO_CHAR (LAST_DAY (daos_), 'dd');
                                  END IF;

                                  mdater_ :=
                                     TO_DATE (TRIM (   LPAD (TRIM (TO_CHAR (s_)),
                                                             2,
                                                             '0'
                                                            )
                                                    || TO_CHAR (daos_, 'mmyyyy')
                                                   ),
                                              'ddmmyyyy'
                                             );
                               END IF;
                            EXCEPTION
                               WHEN OTHERS
                               THEN
                                  raise_application_error
                                               (-20001,
                                                   SQLERRM
                                                || ' ('''
                                                || TRIM (   LPAD
                                                                (TRIM (TO_CHAR (s_)
                                                                      ),
                                                                 2,
                                                                 '0'
                                                                )
                                                         || TO_CHAR (apl_dat_,
                                                                     'mmyyyy'
                                                                    )
                                                        )
                                                || '''), acc='
                                                || TO_CHAR (acc_)
                                               );
                            END;
                         END IF;
                      ELSE                              -- число гашения не задано
                         IF apl_dat_ IS NOT NULL
                         THEN                               -- первая дата задана
                            mdater_ := apl_dat_;
                         ELSE
                            mdater_ := daos_;
                         END IF;
                      END IF;

                      IF mdater_ < datn_ AND add_ <> 0 and
                         (dathb_ is null or
                          dathb_ is not null and mdater_ < dathb_)
                      THEN
                         LOOP
                            mdater_ := ADD_MONTHS (mdater_, add_);

                            IF mdater_ >= datn_
                            THEN
                               EXIT;
                            elsif dathb_ is not null and
                                  dathe_ is not null and
                                  mdater_ between dathb_ and dathe_
                            THEN
                               mdater_ := dathe_ + 1;
                               EXIT;
                            END IF;
                         END LOOP;
                      END IF;
                   END IF;

                   IF mdater_ IS NOT NULL and mdate_ IS NOT NULL AND
                      mdater_ < mdate_ AND
                      mdater_ >= datn_
                      OR
                      mdater_ IS NOT NULL AND mdate_ IS NULL
                   THEN
                      mdate_ := mdater_;
                   END IF;

                   comm_ :=
                         comm_
                      || ' mdateR_='''
                      || TO_CHAR (mdate_, 'dd/mm/yyyy')
                      || '''';

                   ret_ :=
                      fs_180_242 (SUBSTR (nls_, 1, 4),
                                  -1,
                                  datn_,
                                  mdate_,
                                  daos_,
                                  x_,
                                  s242_,
                                  dathb_,
                                  dathe_
                                 );

                   IF NVL (s181_, '0') <> '0'
                   THEN
                      x_ := s181_;
                   END IF;

                   IF NVL (s242_, '0') = '0'
                   THEN
                      s242_ := p240_;
                   END IF;
                EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN
                     if p240_ <> '0' then
                        s242_ := p240_;
                     else
                        begin
                            select nvl(trim(s240), '0')
                            into  s242_
                            from w4_acc a, specparam s
                            where a.acc_2208 = acc_ and
                                 a.acc_ovr = s.acc and
                                 rownum = 1;

                            comm_ := comm_ || ' (счет из модуля BPK)';
                        exception
                            when no_data_found then
                                  comm_ := comm_ || ' (счет не из модуля)';

                                  IF datn_ < zm_date_
                                  THEN
                                     s242_ := NVL (fs242 (NULL, NULL, p240_), '0');
                                  ELSE
                                     s242_ := p240_;
                                  END IF;
                        end;
                    end if;
                END;

                IF x_ NOT IN ('1', '2')
                THEN
                   x_ := fs181 (acc_, dat_, s180_);

                   IF NVL (x_, '0') = '0'
                   THEN
                      x_ := '1';
                   END IF;
                END IF;

                if x_ = '1' and s242_ > 'B' and s242_ <> 'Z' and
                   mdate_ is not null and nkd_ like '%БПК%'
                then
                   s242_ := 'B';
                end if;

                if tips_ in ('SK9','SP','SPN','XPN','OFR','KSP','KK9','KPN', 'SNA') then
                   s242_ :='Z';
                end if;

                if s242_ ='Z' and s190_ ='0'  then  s190_ :='A';  end if;

    ------- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                IF    pr_ = '1' AND nbs_ LIKE '2%'
                   OR nbs_ IN ('1408','1418','1428','1438','1448','1508','1518','1528','3108','3118','3570','3578')
                      and not (mfo_ = 300465 and rnk_ = 907973 and nbs_ in ('1418', '3118'))
                      and not (nbs_ in ('1408', '1418', '1428') and nvl(r011_, '0') in ('C','D','E'))
                      and not (nbs_ in ('3118') and nvl(r011_, '0') in ('2', 'A'))
                THEN
                   IF     dat_ >= TO_DATE ('01112008', 'ddmmyyyy')
                      AND nbs_ IN ('1518', '1528')
                   THEN
                      declare
                         dapp_ date;
                      BEGIN
                         select dapp
                         into dapp_
                         from otcn_fA7_dapp
                         where acc = acc_;

                         SELECT a.nbs
                           INTO nbs1_
                           FROM accounts a, int_accn i
                          WHERE i.acra = acc_
                            AND i.acc = a.acc
                            AND i.ID = 0
                            AND a.daos = daos_
                            and nvl(i.ACR_DAT, i.apl_DAT) >= dapp_
                            and i.ACR_DAT = (select min(ACR_DAT)
                                             from int_accn
                                             where acra=acc_ and
                                                   nvl(ACR_DAT, apl_DAT) >= dapp_);

                         IF     nbs_ = '1518'
                            AND nbs1_ IN ('1510', '1512')
                            AND r013_ NOT IN ('5', '7')
                         THEN
                            r013_ := '5';
                         END IF;

                         IF     nbs_ = '1518'
                            AND nbs1_ NOT IN ('1510', '1512')
                            AND r013_ NOT IN ('6', '8')
                         THEN
                            r013_ := '6';
                         END IF;

                         IF     nbs_ = '1528'
                            AND nbs1_ = '1521'
                            AND r013_ NOT IN ('5', '7')
                         THEN
                            r013_ := '5';
                         END IF;

                         IF     nbs_ = '1528'
                            AND nbs1_ <> '1521'
                            AND r013_ NOT IN ('6', '8')
                         THEN
                            r013_ := '6';
                         END IF;
                      EXCEPTION
                         WHEN NO_DATA_FOUND
                         THEN
                            NULL;
                      END;
                   END IF;

                   comm_ := comm_ || ' R013=' || r013_;

                   IF  se_ < 0
                   THEN
                      IF se_ <> 0
                      THEN
                         p_analiz_r013_calc ((case when pmode_ = 2 then 2 else 1 end),
                                            mfo_,
                                            mfou_,
                                            dat_,
                                            acc_,
                                            tips_,
                                            nbs_,
                                            kv_,
                                            r013_,
                                            se_,
                                            nd_,
                                            freq_,
                                            --------
                                            o_r013_1,
                                            o_se_1,
                                            o_comm_1,
                                            --------
                                            o_r013_2,
                                            o_se_2,
                                            o_comm_2
                                           );

                         -- до 30 дней
                         IF o_se_1 <> 0
                         THEN
                            dk_ := iif_n (o_se_1, 0, '1', '2', '2');

                               pp_doda;

                               kodp_ :=
                                       dk_
                                    || nbs_
                                    || r011_
                                    || o_r013_1
                                    || x_
                                    || s242_
                                    || rez_
                                    || s190_
                                    || r030_;

                            p_add_rec(s_rnbu_record.NEXTVAL, userid_,
                                        nls_, kv_, data_, kodp_,
                                        TO_CHAR (ABS (o_se_1)), acc_,
                                        rnk_, isp_, mdate_,
                                        SUBSTR (tobo_ || '  ' || comm_ || o_comm_1, 1, 200),
                                        nd_, nbuc_, tobo_);
                         END IF;

                         -- свыше 30 дней
                         IF o_se_2 <> 0
                         THEN
                            dk_ := iif_n (o_se_2, 0, '1', '2', '2');

                            pp_doda;

                            kodp_ :=
                                       dk_
                                    || nbs_
                                    || r011_
                                    || o_r013_2
                                    || x_
                                    || s242_
                                    || rez_
                                    || s190_
                                    || r030_;

                            p_add_rec(s_rnbu_record.NEXTVAL, userid_,
                                        nls_, kv_, data_, kodp_,
                                        TO_CHAR (ABS (o_se_2)), acc_,
                                        rnk_, isp_, mdate_,
                                        SUBSTR (tobo_ || '  ' || comm_ || o_comm_1, 1, 200),
                                        nd_, nbuc_, tobo_);
                         END IF;

                         se_ := 0;
                      END IF;
                   END IF;

                   sum_zal := 0;
                else
                   if nls_ like '14%'
                   then
                      select nvl(sum(sum_zal), 0)
                      into sum_zal
                      from otcn_f42_cp
                      where fdat = dat_
                        and acc = acc_;
                   else
                      sum_zal := 0;
                   end if;
                END IF;

                dk_ := iif_n (se_, 0, '1', '2', '2');
                sum_zal := gl.p_icurval(kv_, sum_zal, dat_);

                pp_doda;

                -- обтяжені
                IF sum_zal <> 0
                THEN
                   kodp_ :=
                           dk_
                        || nbs_
                        || (case r011_ when 'C' then '1' when 'D' then '2' when 'E' then '3' else r011_ end)
                        || r013_
                        || x_
                        || s242_
                        || rez_
                        || s190_
                        || r030_;
                   sum_dk := abs(sum_zal);

                         if dk_k is not null and dk_ <> dk_k 
                         then
                             kodp_ := dk_k || nbs_ || (case r011_ when 'C' then '1' when 'D' then '2' when 'E' then '3' else r011_ end)
                                           ||r013_ || x_ || s242_ ||rez_ || s190_ || r030_ ;
                             sum_dk := 0 -sum_dk;
                          end if;

                    p_add_rec(s_rnbu_record.NEXTVAL, userid_, nls_, kv_,
                                data_, kodp_, TO_CHAR (sum_dk), acc_, rnk_,
                                isp_, mdate_, substr(tobo_ || '  ' || comm_,1,200), nd_, nbuc_, tobo_
                               );
                END IF;

                -- немає обтяження
                IF se_ <> 0
                THEN
                   kodp_ :=
                           dk_
                        || nbs_
                        || r011_
                        || r013_
                        || x_
                        || s242_
                        || rez_
                        || s190_
                        || r030_;
                   sum_dk := abs(se_ - sum_zal);

                         if dk_k is not null and dk_ <> dk_k 
                         then
                             kodp_ := dk_k || nbs_ || r011_
                                           ||r013_ || x_ || s242_ ||rez_ || s190_ || r030_ ;
                             sum_dk := 0 -sum_dk;
                          end if;

                    p_add_rec(s_rnbu_record.NEXTVAL, userid_, nls_, kv_,
                                data_, kodp_, TO_CHAR (sum_dk), acc_, rnk_,
                                isp_, mdate_, substr(tobo_ || '  ' || comm_,1,200), nd_, nbuc_, tobo_
                               );
                END IF;
             ELSE
                IF     SUBSTR (nls_, 1, 4) IN
                          ('1410', '1413', '1414', '1418', '2701', '3112', '3113', '3114', '3660', '3648')
                   AND exist_sbb = 1
                THEN
                   BEGIN
                      EXECUTE IMMEDIATE 'begin cp_Z7(:pdat_,9); end;'
                                  USING pdat_;
                   EXCEPTION
                      WHEN OTHERS
                      THEN
                         null;
                   END;

                   exist_sbb_acc := f_exist_sbb_acc (acc_);
                ELSE
                   exist_sbb_acc := 0;
                END IF;
             END IF;

             exist_cclim_acc := 0;

             if substr(nls_,1,4) in ('1623','1624','2701','3660')  then
                exist_cclim_acc := f_exist_cclim_acc( acc_ );
             end if;

             -- не кредиты и не счета начисленных процентов кредитного модуля
             IF tips_ NOT IN ('SS', 'XS')
                   and not (tips_ = 'DEP' and nls_ like '132%')
                   AND fZ7p_ = 0
                   AND exist_sbb_acc =0
                   and exist_cclim_acc =0
                   and exist_cp_acc =0
                   and exist_msb_acc =0
                OR                                -- обычный режим
                       pmode_ = 1
                   AND tips_ IN ('SS', 'XS')
                   AND NOT tp_graf
                   AND fZ7p_ = 0
                OR
                   pmode_  in (0, 2) AND
                   tips_ IN ('SS', 'XS') and
                   exist_trans_acc = 0 and
                   NOT tp_graf
             THEN
                IF datn_ < zm_date_
                THEN
                   s242_ := NVL (fs242 (NULL, NULL, p240_), '0');
                ELSE
                   s242_ := p240_;
                END IF;

                if trim(tips_) in ('SK9','SP','SPN','XPN','OFR','KSP','KK9','KPN', 'SNA')
                then
                   s242_ :='Z';
                   comm_ := comm_ || ' тип '||trim(tips_);
                end if;

                IF tips_ = 'NL8'
                THEN
                   SELECT COUNT (*)
                     INTO fZ7k_
                     FROM accounts
                    WHERE accc = acc_;
                END IF;

                IF tips_ = 'NL8' AND fZ7k_ > 0
                THEN
                   FOR k IN (SELECT a.acc acc, a.nls nls, a.kv kv, s.dapp fdat,
                                    s.nbs nbs, s.tip tip,
                                    DECODE (s.mdate,
                                            NULL, NVL (TRIM (p.s240), '0'),
                                            fs240 (datn_, a.acc, dathb_, dathe_, s.mdate, p.s240)
                                           ) s240,
                                    DECODE (TRIM (p.s180),
                                            NULL, fs180 (a.acc),
                                            p.s180
                                           ) s180,
                                    NVL (p.s181, '0') s181,
                                    NVL (p.r011, '0') r011, NVL (p.r013, '0') r013, l.r031 r031,
                                    s.mdate mdate,
                                    DECODE (pmode_, 2,
                                    decode(s.kv, 980, a.ost - a.dos96 + a.kos96,
                                                      a.ostq - a.dosq96 + a.kosq96),
                                    decode(s.kv, 980, a.ost, a.ostq)) ost,
                                    s.rnk rnk, s.isp isp, s.branch
                               FROM otcn_saldo a,
                                    accounts s,
                                    kl_r030 l,
                                    specparam p
                              WHERE s.accc = acc_
                                AND a.acc = s.acc
                                AND a.fdat = dat_
                                AND a.kv = TO_NUMBER (l.r030)
                                AND a.acc = p.acc(+)
                                AND a.ost <> 0)
                   LOOP
                      -- для мыячного файлу @77
                      if pmode_ = 2 then
                         mdate_ := nvl(f_mdate_hist(k.acc, dat_), k.mdate);
                      else
                         mdate_ := k.mdate;
                      end if;

                      x_ := k.s181;

                      IF     x_ <> '2'
                         AND k.s180 IN ('9', 'C', 'D', 'E', 'F', 'G', 'H')
                      THEN
                         x_ := '2';
                      END IF;

                      IF     x_ <> '1'
                         AND (    k.s180 IS NOT NULL
                              AND k.s180 NOT IN
                                              ('9', 'C', 'D', 'E', 'F', 'G', 'H')
                             )
                      THEN
                         x_ := '1';
                      END IF;

                      min_sum_ := 0;

                      BEGIN
                         SELECT gl.p_icurval (v.kv, a.min_sum, dat_)
                           INTO min_sum_
                           FROM dpu_deal a, dpu_vidd v
                          WHERE a.acc = k.acc
                            AND a.vidd = v.vidd
                            AND a.dpu_id IN (SELECT MAX (dpu_id)
                                               FROM dpu_deal
                                              WHERE acc = k.acc);
                      EXCEPTION
                         WHEN NO_DATA_FOUND
                         THEN
                            min_sum_ := 0;
                      END;

                      IF datn_ < zm_date_
                      THEN
                         s242_ := fs242 (NULL, NULL, k.s240);
                      ELSE
                         s242_ := k.s240;
                      END IF;


                      IF typ_ > 0 THEN
                         nbuc_ := NVL (F_Codobl_branch (k.branch, typ_), nbuc1_);
                      ELSE
                         nbuc_ := nbuc1_;
                      END IF;

                      se_ := k.ost;

                      dk_ := iif_n (se_, 0, '1', '2', '2');

                      IF x_ = '3'
                      THEN
                         x_ := '1';
                      END IF;

                      rnls_ := k.nls;

                      IF s242_ IN ('9', 'C', 'D', 'E', 'F', 'G', 'H','K','L','M')
                         AND x_ = '1'
                      THEN
                         x_ := '2';
                      END IF;

             if s242_ ='Z' and s190_ ='0'  then  s190_ :='A';  end if;

                      pp_doda;

                      kodp_ :=
                           dk_
                        || nbs_
                        || r011_
                        || r013_
                        || x_
                        || s242_
                        || rez_
                        || s190_
                        || r030_;

                      IF se_ <> 0
                      THEN
                         -- добавлено 30.10.2008 для разбивки залишку
                         -- на суму незнижувального залишку i
                         -- рiзницi залишку на рахунку мiнус незнижувальний залишок
                         IF     dat_ >= TO_DATE ('31102008', 'ddmmyyyy')
                            AND min_sum_ <> 0
                            AND se_ - min_sum_ > 0
                         THEN
                            comm1_ :=
                                  comm_
                               || 'сума незнижувального залишку'
                               || TO_CHAR (min_sum_);

                            p_add_rec (s_rnbu_record.NEXTVAL, userid_, rnls_,
                                         k.kv, k.fdat, kodp_,
                                         TO_CHAR (ABS (min_sum_)), k.acc, k.rnk,
                                         k.isp, mdate_, substr(tobo_ || '  ' || comm1_,1,200), nd_, nbuc_, tobo_
                                        );

                            se_ := se_ - min_sum_;

                            kodp_ := SUBSTR (kodp_, 1, 8) || '1'|| SUBSTR (kodp_, 10);
                         END IF;

                         p_add_rec (s_rnbu_record.NEXTVAL, userid_, rnls_,
                                      k.kv, k.fdat, kodp_, TO_CHAR (ABS (se_)),
                                      k.acc, k.rnk, k.isp, mdate_, substr(tobo_ || '  ' || comm_,1,200), nd_, nbuc_, tobo_
                                     );
                      END IF;
                   END LOOP;
                ELSE
                   min_sum_ := 0;

                   BEGIN
                      -- депозиты ФЛ
                      IF mfo_ = 300465
                      THEN
                         SELECT gl.p_icurval (v.kv, v.min_summ * 100, dat_)
                           INTO min_sum_
                           FROM dpt_deposit c, dpt_vidd v
                          WHERE c.acc = acc_
                            AND c.vidd = v.vidd
                            AND v.vidd IN (272, 338)
                            AND ROWNUM = 1;
                      END IF;
                   EXCEPTION
                      WHEN NO_DATA_FOUND
                      THEN
                         BEGIN
                            SELECT gl.p_icurval (v.kv, a.min_sum, dat_)
                              INTO min_sum_
                              FROM dpu_deal a, dpu_vidd v
                             WHERE a.acc = acc_
                               AND a.vidd = v.vidd
                               AND a.dpu_id IN (SELECT MAX (dpu_id)
                                                  FROM dpu_deal
                                                 WHERE acc = acc_);
                         EXCEPTION
                            WHEN NO_DATA_FOUND
                            THEN
                               min_sum_ := 0;
                         END;
                   END;

                   IF nbs_ = '9129'
                   THEN
                      BEGIN
                         FOR i IN (SELECT   DECODE (TRIM (s.s240),
                                                    NULL, fs240 (datn_, a.acc, dathb_, dathe_, a.mdate, s.s240),
                                                    s.s240
                                                   ) s240,
                                            a.mdate, o.nd, o.datd2 mdate_acco,
                                            nvl(fostq(o.acco, dat_), 0) ostq
                                       FROM acc_over o, accounts a, specparam s
                                      WHERE o.acc_9129 = acc_
                                        AND o.acco = a.acc
                                        AND a.acc = s.acc(+)
                                   ORDER BY a.mdate DESC)
                         LOOP
                            x_ := '1';
                            nd_ := i.nd;

                            if i.ostq <0  then
                                mdate_ := i.mdate;
                                s242_ := i.s240;
                            else
                                mdate_ := i.mdate_acco;
                                s242_ := f_srok(pdat_,mdate_,2);
                            end if;
                            EXIT;
                         END LOOP;
                      EXCEPTION
                         WHEN NO_DATA_FOUND
                         THEN
                            NULL;
                      END;

                      if r013_ = '1'  then
                         x_ := '1';
                         s242_ := '1';
                      end if;
                   END IF;

--   определение s240 для счетов 2924 по ob22 (Киевгород)
                   if mfo_ =322669  and nbs_ ='2924'  then

                     declare
                         ob22_ varchar2(2);
                     begin
                         sql_doda_ := 'select ob22 from specparam_int where acc = '||to_char(acc_);
                         execute immediate sql_doda_ into ob22_;

                         if ob22_ = '23'
                         then
                             s242_ := '3';
                         elsif ob22_ in ('07','08','09','10')
                         then
                             s242_ := '7';
                         else
                             s242_ := '1';
                         end if;
                     exception
                         when no_data_found then s242_ :='1';
                     end;
                     x_ :='1';

                   end if;

                   dk_ := iif_n (se_, 0, '1', '2', '2');

                   IF x_ = '3'
                   THEN
                      x_ := '1';
                   END IF;

                   rnls_ := nls_;

                   IF     x_ = '1'
                      AND (   s180_ IN ('9', 'C', 'D', 'E', 'F', 'G', 'H')
                           OR s242_ IN ('9', 'C', 'D', 'E', 'F', 'G', 'H','K','L','M')
                          )
                   THEN
                      rnls_ := nls_;
                   END IF;

                   IF x_ = '2'
                      AND s180_ NOT IN ('9', 'C', 'D', 'E', 'F', 'G', 'H')
                   THEN
                      rnls_ := nls_;
                   END IF;

                   IF     (x_ IS NULL OR x_ <> '2')
                      AND s180_ IN ('9', 'C', 'D', 'E', 'F', 'G', 'H')
                   THEN
                      x_ := '2';
                   END IF;

                   IF     x_ = '0'
                      AND (   s180_ IS NULL
                           OR s180_ = '0'
                           OR s180_ NOT IN ('9', 'C', 'D', 'E', 'F', 'G', 'H')
                          )
                   THEN
                      x_ := '1';
                   END IF;


                   IF s242_ IN ('9', 'C', 'D', 'E', 'F', 'G', 'H','K','L','M') AND x_ = '1'
                   THEN
                      x_ := '2';
                   END IF;

                   IF (nbs_ IN ('1819', '2900', '2902', '2903', '2909') or
                       nbs_ IN ('2600', '2605', '2608', '2620', '2625', '2650') and sn_ < 0)
                      AND (s242_ = '0' OR NVL (x_, '0') = '0' OR x_ = '2')
                   THEN
                      x_ := '1';

                      IF datn_ < zm_date_
                      THEN
                         s242_ := '5';
                      ELSE
                         s242_ := '1';
                      END IF;
                   END IF;

                   IF nbs_ = '2620' AND r013_ = '0' and sn_ < 0
                   THEN
                      r013_ := '9';
                   END IF;

                   IF nbs_ = '2903' AND r013_ not in ('1','9')
                   THEN
                      r013_ := '1';
                   END IF;

                   pp_doda;

                   -- обтяження по ЦП
                   if nls_ like '14%'
                   then
                        select nvl(sum(sum_zal), 0)
                        into sum_zal
                          from otcn_f42_cp
                          where fdat = dat_
                            and substr(nls,4,1)<>'8'
                            and acc = acc_;
                   else
                       sum_zal := 0;
                   end if;

                   sum_zal := gl.p_icurval(kv_, sum_zal, dat_);

                   if s242_ ='Z' and s190_ ='0'  then  s190_ :='A';  end if;

                   kodp_ := dk_ || nbs_ || r011_||r013_ || x_ || s242_ ||rez_ || s190_ || r030_ ;

                   se_ := TO_CHAR (ABS (se_ - sum_zal));

                   IF (nbs_ = '1500' AND se_ > 0)
                      OR (    nbs_ NOT IN ('1500')
                          AND se_ <> 0
                         )
                   THEN
                      -- добавлено 30.10.2008 для разбивки залишку
                      -- на суму незнижувального залишку i
                      -- рiзницi залишку на рахунку мiнус незнижувальний залишок
                      IF     dat_ >= TO_DATE ('30102008', 'ddmmyyyy')
                         AND min_sum_ <> 0
                         AND se_ - min_sum_ > 0
                      THEN
                         comm1_ :=
                               comm_
                            || 'сума незнижувального залишку'
                            || TO_CHAR (min_sum_);

                         p_add_rec (s_rnbu_record.NEXTVAL, userid_, rnls_, kv_,
                                      data_, kodp_, TO_CHAR (ABS (min_sum_)),
                                      acc_, rnk_, isp_, mdate_, substr(tobo_ || '  ' || comm1_,1,200), nd_, nbuc_, tobo_
                                     );

                         se_ := se_ - min_sum_;

                         kodp_ :=
                                SUBSTR (kodp_, 1, 8) || '1'
                                || SUBSTR (kodp_, 10);
                      END IF;

                      znap_ := TO_CHAR (ABS (se_));

                      if dk_k is not null and dk_ <> dk_k 
                      then
                         kodp_ := dk_k || nbs_ || r011_||r013_ || x_ || s242_ ||rez_ || s190_ || r030_ ;
                         znap_ := 0 - znap_;
                      end if;

                      p_add_rec (s_rnbu_record.NEXTVAL, userid_, rnls_, kv_,
                                   data_, kodp_, znap_, acc_, rnk_,
                                   isp_, mdate_, substr(tobo_ || '  ' || comm_,1,200), nd_, nbuc_, tobo_
                                  );

                      if sum_zal <> 0 then
                         kodp_ := dk_ || nbs_ || (case r011_ when 'C' then '1' when 'D' then '2' when 'E' then '3' else r011_ end) ||r013_ || x_ || s242_ ||rez_ || s190_ || r030_ ;
                         sum_zal := abs(sum_zal);

                         if dk_k is not null and dk_ <> dk_k 
                         then
                             kodp_ := dk_k || nbs_ || (case r011_ when 'C' then '1' when 'D' then '2' when 'E' then '3' else r011_ end) ||r013_ || x_ || s242_ ||rez_ || s190_ || r030_ ;
                             sum_zal := 0 - sum_zal;
                          end if;

                         p_add_rec (s_rnbu_record.NEXTVAL, userid_, rnls_, kv_,
                                       data_, kodp_, TO_CHAR (sum_zal), acc_, rnk_,
                                       isp_, mdate_, substr(tobo_ || '  ' || comm_,1,200), nd_, nbuc_, tobo_
                                      );
                      end if;
                   else
                      if sum_zal <> 0 then
                         kodp_ := dk_ || nbs_ || (case r011_ when 'C' then '1' when 'D' then '2' when 'E' then '3' else r011_ end) ||r013_ || x_ || s242_ ||rez_ || s190_ || r030_ ;
                         sum_zal := abs(sum_zal);

                         if dk_k is not null and dk_ <> dk_k 
                         then
                             kodp_ := dk_k || nbs_ || (case r011_ when 'C' then '1' when 'D' then '2' when 'E' then '3' else r011_ end) ||r013_ || x_ || s242_ ||rez_ || s190_ || r030_ ;
                             sum_zal := 0 - sum_zal;
                          end if;

                         p_add_rec (s_rnbu_record.NEXTVAL, userid_, rnls_, kv_,
                                       data_, kodp_, TO_CHAR (sum_zal), acc_, rnk_,
                                       isp_, mdate_, substr(tobo_ || '  ' || comm_,1,200), nd_, nbuc_, tobo_
                                      );
                      end if;

                   END IF;
                END IF;
             END IF;

             IF pmode_ = 1
                   AND tips_ IN ('SS', 'XS')
                   AND tp_graf      -- с разбивкой по графику
                   AND type_ = 1
                OR     tips_ NOT IN ('SS', 'XS', 'SP', 'SL')
                   AND SUBSTR (nls_, 1, 4) IN
                          ('1410', '1413', '1414', '1418', '1623', '1624', '2701',
                           '3112', '3113', '3114', '3660', '3648')
                   AND ( exist_sbb_acc > 0 or exist_cclim_acc >0 )
                OR     pmode_ in (0, 2)
                   AND tips_ IN ('SS', 'XS')
                   AND (exist_trans_acc > 0 or tp_graf)
                or
                    SUBSTR (nls_, 1, 4) IN ('1410','1412','1413','1414','1420','1422','1423',
                            '1424','1430','3110','3111','3112','3113','3114',
                            '3210','3211','3212','3213','3214','3315') and
                    exist_cp_acc > 0
                OR
                   fZ7p_ > 0 and tips_ = 'SNO'
                OR
                   tips_ = 'DEP' and nls_ like '132%'
                OR
                   exist_msb_acc > 0 -- депозити МСБ
             THEN
                -- наличие доп. модулей
                -- flag 1
                IF exist_fakt = 0 then
                   fl_mode_ := '0';
                else
                   fl_mode_ := '1';
                end if;

                -- flag 2
                if exist_sbb_acc = 0 then
                   fl_mode_ := trim(fl_mode_)||'0';
                else
                   fl_mode_ := trim(fl_mode_)||'1';
                end if;

                -- flag 3
                if exist_trans_acc = 0 then
                   fl_mode_ := trim(fl_mode_)||'0';
                else
                   fl_mode_ := trim(fl_mode_)||'1';
                end if;

                -- flag 4
                if exist_cp_acc = 0 then
                   fl_mode_ := trim(fl_mode_)||'0';
                else
                   fl_mode_ := trim(fl_mode_)||'1';
                end if;

                -- flag 5
                if not (fZ7p_ > 0 and tips_ = 'SNO' ) or
                   exist_sno_gr = 1
                then
                   fl_mode_ := trim(fl_mode_)||'0';
                else
                   fl_mode_ := trim(fl_mode_)||'1';
                end if;

                -- flag 6
                if not (tips_ = 'DEP' and nls_ like '132%') then
                   fl_mode_ := trim(fl_mode_)||'0';
                else
                   fl_mode_ := trim(fl_mode_)||'1';
                end if;

                -- flag 7
                if not (fZ7p_ > 0 and tips_ = 'SNO' and
                        exist_sno_gr = 1)
                then
                   fl_mode_ := trim(fl_mode_)||'0';
                else
                   fl_mode_ := trim(fl_mode_)||'1';
                end if;

                -- flag 8
                if exist_cclim_acc = 0 then
                   fl_mode_ := trim(fl_mode_)||'0';
                else
                   fl_mode_ := trim(fl_mode_)||'1';
                end if;

                -- flag 9
                if exist_msb_acc = 0 then
                   fl_mode_ := trim(fl_mode_)||'0';
                else
                   fl_mode_ := trim(fl_mode_)||'1';
                end if;
                
                IF fz7p_ > 0 and se_ < 0 and
                   not (substr(nbs_, 1, 3) in ('141','142','143','311','321''331') and
                        tips_ = 'SNO')
                THEN
                   p_analiz_r013_calc ((case when pmode_ = 2 then 2 else 1 end),
                                      mfo_,
                                      mfou_,
                                      dat_,
                                      acc_,
                                      tips_,
                                      nbs_,
                                      kv_,
                                      r013_,
                                      se_,
                                      nd_,
                                      null,
                                      --------
                                      o_r013_1,
                                      o_se_1,
                                      o_comm_1,
                                      --------
                                      o_r013_2,
                                      o_se_2,
                                      o_comm_2
                                     );

                   o_se_1z := abs(o_se_1);
                   o_se_2z := abs(o_se_2);
                else
                   o_se_1 := 0;
                   o_se_2 := 0;

                   o_se_1z := 0;
                   o_se_2z := 0;
                END IF;

                znap_ := null;
                se1_ := 0;

                FOR i IN (SELECT   s240, s242, ldate, nd,
                                   comm || DECODE (nd, null, '', ' (Реф=' || TO_CHAR (nd) || ')') comm_,
                                   SUM (ost) ost
                              FROM TABLE (CAST (f_cck_otcn (dat_,
                                                            acc_,
                                                            mdate_,
                                                            sn_,
                                                            fl_mode_,
                                                            datn_, 2,
                                                            dathb_, dathe_, nd_
                                                           ) AS tbl_240
                                               )
                                         )
                          GROUP BY s240,
                                   s242,
                                   ldate,
                                   nd,
                                   comm || DECODE (nd, null, '', ' (Реф=' || TO_CHAR (nd) || ')')
                          HAVING SUM (ost) <> 0
                          )
                LOOP
                   s240_ := i.s240;
                   s242_ := i.s242;
                   se_ := i.ost;
                   mdate_ := i.ldate;

                   if i.nd is not null then
                      nd_ := i.nd;
                   end if;

                   commb_ := substr(comm_ || TRIM (i.comm_),1,200);

                   IF datn_ < zm_date_
                   THEN
                      IF NVL (s242_, '0') = '0' AND p240_ <> '0'
                      THEN
                         s242_ := NVL (fs242 (NULL, NULL, p240_), '0');
                      END IF;
                   ELSE
                      s242_ := i.s240;

                      IF NVL (s240_, '0') = '0' AND p240_ <> '0'
                      THEN
                         s242_ := p240_;
                      END IF;
                   END IF;

                   dk_ := iif_n (se_, 0, '1', '2', '2');

                   IF x_ = '3'
                   THEN
                      x_ := '1';
                   END IF;

                   IF     x_ = '1'
                      AND (   s180_ IN ('9', 'C', 'D', 'E', 'F', 'G', 'H')
                           OR s242_ IN ('9', 'C', 'D', 'E', 'F', 'G', 'H','K','L','M')
                          )
                   THEN
                      x_ := '2';
                      rnls_ := nls_;
                   END IF;

                   IF x_ = '2'
                      AND s180_ NOT IN ('9', 'C', 'D', 'E', 'F', 'G', 'H')
                   THEN
                      x_ := '1';
                      rnls_ := nls_;
                   END IF;

                   IF x_ NOT IN ('1', '2')
                   THEN
                      x_ := fs181 (acc_, dat_, s180_);

                      IF NVL (x_, '0') = '0'
                      THEN
                         x_ := '1';
                      END IF;
                   END IF;

                   IF s242_ IN ('9', 'C', 'D', 'E', 'F', 'G', 'H','K','L','M') AND x_ = '1'
                   THEN
                      x_ := '2';
                   END IF;

                   rnls_ := nls_;

                   IF (nbs_ IN ('1819', '2601', '2900', '2902', '2903', '2909') or
                       nbs_ IN ('2600', '2605', '2608', '2620', '2625', '2650') and sn_ < 0)
                      AND (s242_ = '0' OR x_ IS NULL OR x_ = '0' OR x_ = '2')
                   THEN
                      x_ := '1';

                      IF datn_ < zm_date_
                      THEN
                         s242_ := '5';
                      ELSE
                         s242_ := '1';
                      END IF;
                   END IF;

                   pp_doda;

                   if s242_ ='Z' and s190_ ='0'  then  s190_ :='A';  end if;

                   kodp_ := dk_ || nbs_ || r011_||r013_ || x_ || s242_ || rez_ || s190_ || r030_;

                   znap_ := to_char (abs (se_));

                   commb_ :=
                         iif_n (LENGTH (commb_), 200, '', '', '!')
                      || SUBSTR (commb_, 1, 198);

                   IF (nbs_ = '1500' AND se_ > 0)
                      OR (    nbs_ NOT IN ('1500')
                          AND se_ <> 0
                         )
                   THEN
                      p_add_rec (s_rnbu_record.nextval, userid_, rnls_, kv_,
                                   data_, kodp_, znap_, acc_,
                                   rnk_, isp_, mdate_, substr(tobo_ || '  ' || commb_,1,200), nd_, nbuc_, tobo_
                                  );

                     --  договор открыт уже после расчета резервов
                     --          для расшифровки дисконтов/процентов должен быть в _REZ1
                      if (tips_ in ('SS', 'XS') and extract( day from sdate_) >1 and
                          trunc(sdate_,'mm') = trunc(pdat_,'mm') )
                                or
                          --  для расшифровки дисконтов по этим договорам
                          exist_cclim_acc >0  and
                          substr(nls_,1,4) in ('1623','1624','2701','3660')
                      then
                          insert into OTCN_FA7_REZ1
                                 ( ND, ACC, nls, kv, KODP, ZNAP, SUMA, SUMD, SUMP)
                          values (nd_, acc_, rnls_, kv_, kodp_, abs(se_), abs(se_), 0, 0);

                      end if;

                   END IF;
                END LOOP;

                if fZ7p_ > 0 and
                   not (substr(nbs_, 1, 3) in ('141','142','143','311','321','331') and
                        tips_ = 'SNO')
                then
                   if o_se_1 <> 0 or o_se_2 <> 0 then
                      l_rec_t8.Extend;

                      l_rec_t8(l_rec_t8.last).acc_ := acc_;
                      l_rec_t8(l_rec_t8.last).r013_1 := o_r013_1;
                      l_rec_t8(l_rec_t8.last).ost_1 := o_se_1;
                      l_rec_t8(l_rec_t8.last).r013_2 := o_r013_2;
                      l_rec_t8(l_rec_t8.last).ost_2 := o_se_2;
                   end if;
                end if;
             END IF;
          END IF;
      end loop;

      l_rec_t.delete;
   END LOOP;

   CLOSE saldo;

   FORALL i IN 1 .. l_rnbu_trace.COUNT
       insert /*+ append */  into rnbu_trace values l_rnbu_trace(i);
   commit;

   znap_ := null;
   se1_ := 0;

   for i in 1..l_rec_t8.count loop
      acc_      := l_rec_t8(i).acc_;
      o_r013_1  := l_rec_t8(i).r013_1;
      o_se_1    := l_rec_t8(i).ost_1;
      o_r013_2  := l_rec_t8(i).r013_2;
      o_se_2    := l_rec_t8(i).ost_2;

      o_se_1z := abs(o_se_1);
      o_se_2z := abs(o_se_2);

      if o_se_1 <> 0 and o_se_2 <> 0 then
          for k in (select rowid, kodp, znap, comm, substr(kodp,7,1) r013
                     from rnbu_trace
                     where acc = acc_
                     order by recid)
          loop
              se1_ := 0;

              if o_se_1z <> 0 and k.r013 <> o_r013_1 then
                  if abs(o_se_1z) <= to_number(k.znap) then
                     znap_ := to_char(o_se_1z);
                     se1_ := to_number(k.znap) - o_se_1z;
                     o_se_1z := 0;
                     o_se_2z := o_se_2z - se1_;

                     insert into rnbu_trace
                     select null RECID, USERID, NLS, KV, ODATE,
                        substr(kodp,1,6)||o_r013_2||substr(kodp,8), to_char(se1_), NBUC,
                        ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO
                     from rnbu_trace
                     where rowid = k.rowid;

                     update rnbu_trace
                      set kodp = substr(kodp,1,6)||o_r013_1||substr(kodp,8),
                          znap = znap_
                      where rowid = k.rowid;
                  else
                     znap_ := k.znap;
                     o_se_1z := o_se_1z - to_number(k.znap);

                     update rnbu_trace
                      set kodp = substr(kodp,1,6)||o_r013_1||substr(kodp,8)
                      where rowid = k.rowid;
                  end if;
              end if;

              if o_se_2z <> 0 and k.r013 <> o_r013_2 and se1_ = 0 then
                  if abs(o_se_2z) <= to_number(k.znap) then
                     znap_ := to_char(o_se_2z);
                     se1_ := to_number(k.znap) - o_se_2z;
                     o_se_2z := 0;

                     insert into rnbu_trace
                     select null RECID, USERID, NLS, KV, ODATE,
                        kodp, to_char(se1_), NBUC,
                        ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO
                     from rnbu_trace
                     where rowid = k.rowid;

                     update rnbu_trace
                      set kodp = substr(kodp,1,6)||o_r013_2||substr(kodp,8),
                          znap = znap_
                      where rowid = k.rowid;
                  else
                     znap_ := k.znap;
                     o_se_2z := o_se_2z - to_number(k.znap);

                     update rnbu_trace
                      set kodp = substr(kodp,1,6)||o_r013_2||substr(kodp,8)
                      where rowid = k.rowid;
                  end if;
              end if;

              exit when o_se_1z = 0 and o_se_2z = 0;
          end loop;
      else
          r013_ := (case when o_se_1 <> 0 then o_r013_1
                         when o_se_2 <> 0 then o_r013_2
                         else r013_
                    end);

          update rnbu_trace
          set kodp = substr(kodp,1,6)||r013_||substr(kodp,8)
          where acc = acc_;
      end if;
   end loop;

   declare
     sk_        number := 0;
     sz_        number := 0;
     sz0_       number := 0;
     sz1_       number := 0;
     sk_all_    number := 0;
     ostc_      number := 0;
     s02_       number := 0;
     s04_       number := 0;
   begin
       insert into otcn_f42_zalog(ACC, ACCS, ND, NBS, R013, OST)
       SELECT /*+ leading(z) */
               z.acc, z.accs, z.nd, a.nbs, nvl(p.r013, '0'),
               gl.p_icurval (a.kv, s.ost, dat_) ost
          FROM cc_accp z, snap_balances s, accounts a, specparam p
         WHERE z.acc in (select acc from rnbu_trace where substr(kodp,2,4)||substr(kodp,7,1) in ('26021','26221','90301','90311','90361','95001','95003'))
           AND z.accs = a.acc
           and s.fdat=dat_
           and s.acc = a.acc
           AND s.acc = p.acc
           AND a.nbs || p.r013 <> '91299'
           and a.nbs not in (select r020 from otcn_fa7_temp)
           and s.ost<0;

       -- сумма задолженности, кот. покрывает данный залог
       for p in (select * from rnbu_trace where substr(kodp,2,4)||substr(kodp,7,1) in ('26021','26221','90301','90311','90361','95001','95003'))
       loop
          acc_ := p.acc;
          rnk_ := p.rnk;
          sk_ := 0;
          sz_ := 0;
          sz0_ := 0;
          se_ := to_number(p.znap);

         -- сумма активов, которые обеспечивает данный залог (т.е. к которым он ""привязан")
          begin
            select sum(OST)
               into sk_all_
            from otcn_f42_zalog
            where acc=acc_;
          exception
                   WHEN NO_DATA_FOUND THEN
            sk_all_ := 0;
          end;

         -- выбираем все активы, к которым "привязан" данный залог
          For k in (select z.ACC, z.ACCS, z.ND, z.NBS, z.R013, z.OST, c.rnk
                   from OTCN_F42_ZALOG z, cust_acc ca, customer c
                   WHERE z.ACC = acc_ and
                         z.accs = ca.acc and
                         ca.rnk = c.rnk)
          loop
             ostc_:=0;
             nd_ := k.nd;

             -- вычисляем процент залога на данный актив
             if abs(k.ost) < abs(sk_all_) then -- не один актив
                sz1_ := round(abs(k.ost / sk_all_) * se_, 0);
             else
                sz1_ :=  se_;
             end if;

            -- определяем остаток счетов дисконта или премии
             BEGIN
               select SUM(NVL(Gl.P_Icurval(a.KV, s.ost, dat_) ,0))
                  INTO s04_
               from snap_balances s, accounts a
               where s.fdat=dat_
                 and s.acc = a.acc
                 AND s.acc in (select d.acc
                               from accounts s, nd_acc d, cc_deal c
                               where nvl(c.ndg, c.nd) = nd_ and
                                     c.nd = d.nd and
                                     d.acc <> acc_ and
                                     d.acc = s.acc and
                                     s.rnk = rnk_  and
                                     substr(s.nbs,4,1) in ('5','6','9')
                                     and substr(s.nbs,1,3)=substr(k.nbs,1,3));
             EXCEPTION WHEN NO_DATA_FOUND THEN
               s04_ := 0;
             END;

             ostc_ := abs(k.ost + NVL(s04_,0));

             -- депозиты, которые выступают залогами, привязаны к другим РНК
             if k.rnk <> rnk_ then
                rnk_ := k.rnk;
             end if;

             -- не включаем, т.к. дважды уменьшаются активы на эту сумму (еще в С5) - ПЕТРОКОММЕРЦ
             if nls_ like '9010%' and k.nbs='9023' and k.r013='1' then
                null;
             else
                BEGIN
                    select nvl(SUM(ost_eqv),0)
                    INTO s02_
                    from otcn_f42_temp
                    where accc=k.accs
                      AND ap=1;
                EXCEPTION WHEN NO_DATA_FOUND THEN
                    s02_ := 0;
                END;

                if s02_ < ostc_ then
                   if s02_ + sz1_ >= ostc_ then
                      sz0_ := ostc_ - s02_;
                   else
                      sz0_ := sz1_;
                   end if;

                   if sz0_ <> 0 then
                      sz_ := sz_ + sz0_;
                      sk_ := sk_ + abs(ostc_);

                      insert into otcn_f42_temp(ACC, ACCC, OST_EQV, ap, kv)
                      values(acc_, k.accs, sz0_, 1, kv_);
                   end if;
                end if;
             end if;
          end loop;

          sz0_ := se_ - sz_;

          if sz0_ > 0 then
             update rnbu_trace
             set znap = to_char(to_number(znap) - sz0_),
                 comm = substr(comm || ' + розбивка по активу (1)',1,200),
                 nd = nd_
             where recid = p.recid;

             kodp_ := SUBSTR(p.kodp, 1,6) || '9' || SUBSTR(p.kodp, 8);
             znap_ := TO_CHAR (sz0_);

             INSERT INTO RNBU_TRACE(recid, userid, nls, kv, odate, kodp, znap, rnk, acc, comm, nbuc, isp, tobo, nd)
             VALUES (s_rnbu_record.nextval, userid_, p.nls, p.kv, p.odate, kodp_, znap_, rnk_, acc_,
                'Перевищення над залишком по активу (2)', p.nbuc, p.isp, p.tobo, nd_);
          end if;
      end loop;
   end;

   logger.info ('P_FZ7_NN: End etap 1 for '||to_char(dat_,'dd.mm.yyyy'));

   -- данные по дебиторке, основным средствам и НМА
   if FL_DO_ = 1 then
      if datn_ < zm_date3_ then
          sql_doda_ := 'insert into rnbu_trace(recid, userid, nls, kv, odate, kodp, znap, '||
                                'mdate, comm, nbuc) '||
                       'select s_rnbu_record.NEXTVAL, :userid_, BBBB || ''XXX'', 980, :dat_, '||
                             ' D || BBBB || P || X || '||
                             ' (case when BBBB in (''4400'',''4409'',''4410'',''4419'',''4430'',''4431'',''4500'',''4509'')
                                          then (case when F_SROK(:dat_, MDATE,3) < ''C''
                                                        then ''C''
                                                        else F_SROK(:dat_, MDATE,3)
                                                end)
                                     else F_SROK(:dat_, MDATE,3)
                                end) || '||
                             ' R || SCHA || ''980'', to_char(suma), '||
                             ' MDATE, ''З таблиці A_TPK_Z7ADD'', :tobo_ '||
                       'from A_TPK_Z7ADD where fdat = :dat_';

          execute immediate sql_doda_ using userid_, dat_, dat_, dat_, dat_, tobo_, dat_;
      else
          NULL;
--!!   вставить  для новой структуры    З таблиці A_TPK_Z7ADD
      end if;

      execute immediate sql_doda_ using userid_, dat_, dat_, dat_, dat_, tobo_, dat_;
   end if;

--------------
--  ограничение s240 для "отзывных" депозитов после 06.06.2015
   for k in ( select /*+ parallel(r,8) */
                     r.rowid, r.kodp, r.znap, r.comm, substr(r.kodp,9,1) s240
                from rnbu_trace r,
                    (   select da.accid
                          from dpu_deal dd, dpu_vidd dv, dpu_accounts da
                         where dd.dat_begin > dp_date_
                           and dd.dpu_id = da.dpuid
                           and dd.vidd = dv.vidd
                           and nvl(dv.IRVK,0) !=1
                        union all
                        select da.accid
                          from dpt_deposit dd, dpt_accounts da,
                              ( select vidd, tag, val
                                  from dpt_vidd_params
                                 where tag like 'FORB_EARLY%'
                              ) dp
                         where dd.dat_begin > dp_date_
                           and dd.deposit_id = da.dptid
                           and dd.vidd = dp.vidd
                           and (     dp.tag = 'FORB_EARLY'
                                 and nvl(dp.val,0) !=1
                               or
                                     dp.tag = 'FORB_EARLY_DATE'
                                 and dp.val is not null
                                 and to_date(dp.val,'dd/mm/yyyy') > dd.dat_begin
                                 and to_date(dp.val,'dd/mm/yyyy') <= dat_
                               )
                        union all
                        select da.accid
                          from dpt_deposit dd, dpt_accounts da
                         where dd.dat_begin > dp_date_
                           and dd.deposit_id = da.dptid
                           and not exists
                                  ( select 1
                                      from dpt_vidd_params dp
                                     where dp.vidd = dd.vidd
                                       and dp.tag like 'FORB%' )
                    ) d
               where r.acc = d.accid
                 and substr(r.kodp,2,4) in ('2630','2635','2636','2637',
                                            '2610','2615','2616','2617',
                                            '2651','2652','2656','2657')
            )
   loop

       if k.s240 not in ('0','1','2','I','Z')  then
            update rnbu_trace
               set kodp = substr(k.kodp,1,8)||'I'||substr(k.kodp,10),
                   comm = substr(k.comm || ' заміна S240 ' || substr(k.kodp,9,1) ||
                        ' є дострок.повернення', 1, 200)
             where rowid = k.rowid;
       end if;

   end loop;

   logger.info ('P_FZ7_NN: END ');
END;
/
