
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/loro.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.LORO IS

 G_HEADER_VERSION  CONSTANT VARCHAR2(64)  :=  'ver.1 27.06.2014' ;
 ern CONSTANT POSITIVE := 203;  erm VARCHAR2(250);  err EXCEPTION;
 aBic varchar2(15);
------------------------------------------------------------------
-- Олексій Климентьєв Tel.:+38 044 247-8403 klimentevov@oschadbank.ua
--        | Хихлуха Дима + Макаренко Игорь|       247-85-78
---===============================================================
/*
   Переадресация входящих СФИФТ-103 на ФЛ в РУ ОБ
   на базе предварительно накопленного фильта
   интелектуальное зачисление повторяющихся платежей.
Х-3) База значень <50 K> для МТ-103 (О)	                FunNSIEditF("TEST_50K", 0)
Х-1) Фільтр по переадресації СВІФТ-повідомлень на /262*	FunNSIEditF("VEST_SWT_RU[PROC=>LORO.SWIFT_RU ( 99,0,:P)][PAR=>:P(SEM=1/0=Форм/Без)][EXEC=>BEFORE][MSG=>ОК !]",1)
Х-2) Авто-Переадресацiя СВIФТ-повiдомлень на /262*	FunNSIEdit("[PROC=>LORO.SWIFT_RU ( 0,:N,:P)][PAR=>:P(SEM=Поле_50K,REF=TEST_50K),:N(SEM=SWREF_или_ПУСТО,TYPE=N)][QST=>Виконати переадресацiю SWT-103 на /262* ?][MSG=>ОК!]")

*/
procedure SWIFT_RU ( p_mode int, p_num number, p_chr varchar2 )  ;
---==================================================================
--L1) Грн-Лоро : SWIFT -> СЕП	N/A	FunNSIEditF("LORO_SWT_SEP", 2)
  Function F_NLSB ( p_swref number)  return varchar2       ;
  ------------------
procedure SWT_SEP   -- L-1
 ( p_mode int,
   p_SWREF number   ,
   P_MFOB  varchar2 ,
   p_NLSB  varchar2 ,
   p_IDB   varchar2 ,
   p_NAMB  varchar2 ,
   P_NAZN  varchar2 ,
   KODN_   varchar2 ,
   P40_    varchar2,
   P_N      varchar2


  ) ;

---==================================================================
--L2) Вал-Лоро : SWIFT -> SWIFT	N/A	FunNSIEditF("LORO_SWT_SWT", 2)
  Function F_NLSk ( p_swref number)  return varchar2       ;
  -----------------
  procedure SWT_SWT
 ( p_mode int,
   p_SWREF number   ,
   p_NLSK  varchar2 ,
   KODN_   varchar2
  ) ;

---==================================================================
/*
    Приходит Грн-пл. из СЭП/ВПС на 1600. Согласно бизнес-правил  он попадает на спец-транзитный счет 3720.
    СЕЙЧАС  ТАК :Существующее приложение по разбору этого транзитника просто делает  проводку Д.3720 – К.1600 – и все.
    Необходимо - дополнительно генерировать МТ-103 (если этот банк имеет БИК-код). Сейчас это делается вручну на СВИФТЕ.
*/
--L3) Грн-Лоро : СЕП -> SWIFT	N/A	FunNSIEditF("LORO_SEP_SWT", 2)
  Function F_TXT2 ( p_In operw.value%type )  return sw_operw.value%type ;
  --------
  procedure SEP_SWT
 ( p_mode int,
   p_REF_SEP number,
   P50_ varchar2   , -----------  50K: Ordering Customer-Name + Address
                  -- /1919301            Счет отправителя из первичного документа
                  -- OOO TDLK-UKRAINA    Название отправителя из назначения платежа  первичного документа
   p57_   varchar2 , ------------ 57D: Account With Inst -Name + Addr
                  -- /16004201040
                  -- OAO ASB BELARUSBANK
                  -- FIL.413 G.LIDA
                  -- BELARUSX            ЛОРО счет и название отделения из первички
   p59_1_ varchar2 , -----------  59: Beneficiary Customer-Name + Addr
                  -- /3012216250740/980 Счет получателя из назначения платежа  из первички
                  -- ....
                  -- .....
   p59_2_ varchar2 , -----------  59: Beneficiary Customer-Name + Addr
                  --......
                  -- OAO LAKOKRASKA     Hазвание получателя из назначения платежа  из первички

   p70_ varchar2 , -----------  70: Remittance Information
                  -- OPLATA FTAL.ANGID DOG.94/792 OT
                  -- 09.02.11. DS70 OT 251113 BEZ NDS.   Назначение платежа из первички
   KODN_ varchar2  -- 'KOD_N' , nvl(p4_,'1222')
  ) ;

---==================================================================

/** * header_version - возвращает версию заголовка пакета */
function header_version return varchar2;

/** * body_version - возвращает версию тела пакета  */
function body_version return varchar2;
-------------------

END loro;
/
CREATE OR REPLACE PACKAGE BODY BARS.LORO IS
--!!!!!!!!!!!!!!!!!!
-- Раскоментарить  DATE_PAY
----!!!!!!!!!!!!!!!!!!!!!!!!!!!

 G_BODY_VERSION  CONSTANT VARCHAR2(64)  :=   'ver.3 от 23.11.2017 ';

/*
23.11.2017 Сухова  Трансфер-2017

19.01.2017 Щебнєв О.
           В SWT_SWT введеня доп.реквізивіт переведено на SET_OPERW, для уникнення помилки на OPERW_PK,
           оскільки при оплаті документу, D_REC розладався в доп.реквізити.
27.09.2016 Литвин С.
           Изменение условия поиска BIC в процедуре SWIFT_RU1 ->     b.bic like xx.value||'%'
           Было "b.bic = xx.value", что приводило к вываливанию из процедуры по DATA_NOT_FOUND из-за того,
           что в свифтовке указан НЕполный код
05.09.2016 Sta  COBUSUPABS-4771 = Х-2) Авто-Переадресацiя СВIФТ-повiдомлень на /262*
   FunNSIEdit("[PROC=>LORO.SWIFT_RU(0,:N,:P)]
               [PAR=>:P(SEM=Поле_50K,REF=TEST_50K),:N(SEM=SWREF_или_ПУСТО,TYPE=N)]
               [QST=>Виконати переадресацiю SWT-103 на /262* ?]
               [MSG=>ОК!]")

   3.1 АРМ.SWIFT. Обробка повідомлень. X-2) Авто-Переадресація СВІФТ-повідомлень на/262*.
       Останнім часом збільшилась кількість переказів(МТ103) від банку CITI/London в EUR
       з покриттям МТ910 або МТ202 по іншим банкам-кореспондентам.
       При автоматичній обробці SWIFT повідомлення МТ103 перекази проходять по рахунку банка-кореспондента,
       від якого прийшли платіжні інструкції, тобто МТ103.

       Прохання зробити:
       • Якщо в МТ103 присутнє поле 53А або 54А, такі перекази не повині зараховуватись на балансовий рахунок 1500 банку-кореспондента від якого поступив МТ103.
       • Вище зазначені перекази мають зараховуватись на рахунок банка-кореспондента зазначеного в полі 53А або 54А.

   3.2 АРМ.SWIFT. Обробка повідомлень. X-2) Авто-Переадресація СВІФТ-повідомлень на/262*.
       • Систематичні перекази поступають с полем 50К або 50F (реквізити відправника).
       • Просимо внести додатково параметр «Поле_50F» для можливості вибору по даним випадкам.
  ----------------------------------------------------------------------------------



   Переадресация входящих СФИФТ-103 на ФЛ в РУ ОБ
   на базе предварительно накопленного фильта
   интелектуальное зачисление повторяющихся платежей.
*/

procedure SWIFT_RU ( p_mode int, p_num number, p_chr varchar2 ) is

   nlchr char(2) := chr(13)||chr(10);
   l_ref number  ;
   jj  sw_journal%rowtype;
   s_Sql varchar2(1000) ;
   TabFil_ varchar2 (15) := 'TEST_SWT_RU'; -- таблица фильтров вход.свифтовок
   --------------------------------------------------------------------------------------------------------------

   procedure SWIFT_RU1 ( jj sw_journal%rowtype,  p_ref  OUT oper.ref%type, p_50k varchar2 ) is
      aa    accounts%rowtype;       oo    oper%rowtype  ;   w50 sw_operw%rowtype ;  xx sw_operw%rowtype ;
      nlchr char(2) := chr(13)||chr(10);
      n_ref number;  c_ref number;  t59_  varchar2(250) ;   n_Kom number  := 0  ;  flg37_ char(1);
   begin
      p_ref := null;

      begin   -- Проверим на заданный параметр 50К / F
        select * into w50 from sw_operw where tag ='50' and opt in ('F', 'K') and value like p_50k||'%' and swref= jj.swref and rownum = 1 ;

        begin select * into xx from (select * from sw_operw where tag in ('53','54') and swref= jj.swref order by tag desc) where rownum=1;
              begin select a.* into aa from bic_acc b, accounts a, tabval t
                    where a.kv=t.kv and a.acc= b.acc and b.bic like xx.value||'%' and t.LCV= jj.currency;
              EXCEPTION WHEN NO_DATA_FOUND THEN  Return;
              end;
        EXCEPTION WHEN NO_DATA_FOUND THEN

              begin select * into aa from accounts where acc = jj.accd ; ---- корсчет 1500
              EXCEPTION WHEN NO_DATA_FOUND THEN  Return;
              end;

        END;
        ----------------------------
        -- формируем ключ поиска в фильтре передшественников
        select substr(replace(value,nlchr,'*'),1,200) into t59_ from SW_OPERW   where tag like '59%' and swref=jj.swref;
        t59_ := ''''|| t59_ ||'''';

        --ищем в фильтре референсы-предшественники (прообразы) для нахождения  рекв.получателя (МФО-Б и Сч-Б) и пар.отчетности
        EXECUTE IMMEDIATE 'select ref, ref_cli from '|| TabFil_ ||' where vm =' || t59_  into n_ref, c_ref ;

        IF INSTR(w50.value, 'CLAIMS') > 0 THEN    n_ref := c_ref;
           BEGIN
             SELECT NVL(tar,0) INTO n_Kom FROM TARIF WHERE kod=199 AND kv=aa.kv;
           EXCEPTION WHEN NO_DATA_FOUND THEN null;
           END;
        end if ;

        select * into oo from oper where ref= n_ref;
        oo.s := jj.amount - n_Kom ; oo.ref := null ; oo.kv := aa.kv; oo.NLSA := aa.nls; oo.sos := null; oo.NAM_A := substr(aa.nms,1,38);

      EXCEPTION WHEN NO_DATA_FOUND THEN Return;
      end;

      gl.ref(oo.REF);
      oo.nd := trim(substr('          '|| oo.ref , -10 ));
      gl.in_doc3(ref_   => oo.REF   , tt_   => oo.TT   , vob_  => oo.VOB  , nd_   => oo.nd   , pdat_ => SYSDATE,
                 vdat_  => gl.BDATE , dk_   => oo.dk   , kv_   => oo.kv   ,  s_   => oo.S    , kv2_  => oo.kv  ,
                 s2_    => oo.S     , sk_   => null    , data_ => gl.bdate, datp_ => gl.bdate,
                 nam_a_ => oo.nam_a , nlsa_ => oo.nlsa , mfoa_ => gl.aMfo ,
                 nam_b_ => oo.nam_b , nlsb_ => oo.nlsb , mfob_ => oo.mfob , nazn_ => oo.nazn ,
                 d_rec_ => oo.d_rec , id_a_ => oo.id_a , id_b_ => oo.id_b , id_o_ => null    ,
                 sign_  => null     , sos_  => 1       , prty_ => null    , uid_  => null  ) ;
      -- 37 - Оплата по факт.залишку = 1 / По план.залишку = 0 / Не платити = 2
      select substr(flags,38,1) into flg37_  from tts   where tt = oo.tt;
      gl.dyntt2 (sos_   => oo.sos  , --- IN OUT NUMBER,
                 mod1_  => flg37_  , --- NUMBER, 0 - Booked  payment
                                    ---          1 - Cleared payment
                                    ---          2 -      No payment
                                    ---          8 - Формула суммы по главной операции
                                    ---          9 - Cleared payment (dynamic tts linkage)
                 mod2_  =>  0      , --- NUMBER, 0 - Deferred clearing
                 ref_   => oo.ref  , --- NUMBER,
                 vdat1_ => gl.bdate, --- DATE  ,
                 vdat2_ => gl.bdate, --- DATE  ,
                 tt0_   => oo.tt   , --- CHAR  ,
                 dk_    => oo.dk   , --- NUMBER,
                 kva_   => oo.kv   , --- NUMBER,
                 mfoa_  => gl.aMfo , --- VARCHAR2,
                 nlsa_  => oo.nlsa , --- VARCHAR2,
                 sa_    => oo.s    , --- NUMBER,
                 kvb_   => oo.kv   , --- NUMBER,
                 mfob_  => oo.mfob , --- VARCHAR2,
                 nlsb_  => oo.nlsb , --- VARCHAR2,
                 sb_    => oo.s    , --- NUMBER,
                 sq_    => null    , --- NUMBER,
                 nom_   => null      --- NUMBER
                ) ;

      insert into sw_oper ( ref, swref ) values ( oo.ref, jj.swref ) ;
      update SW_JOURNAL set date_pay = gl.bd where swref= jj.swref   ;

      for k in ( select 'N' PR, SUBSTR(tag||opt||'     ',1,5) TAG, Substr(value,1,200) VALUE   --   реквизиты от свифтовки из нового документа
                 from sw_operw where SWREF=jj.swref
       union all select 'O' PR,                               TAG, substr(value,1,200) VALUE   --   реквизиты для отчетности от старого док
                 from operw where ref= n_ref and (substr(tag,1,1)<'0' or substr(tag,1,1)>'9') and oo.tt <> 'CLI'
                )
      loop
         If k.pr = 'O' and k.tag ='n' then  update  oper set D_REC = '#fMT '|| jj.mt|| '#n'||k.value||'#' where ref = oo.ref ; end if;

--       K.TAG := SUBSTR(K.TAG ||'     ',1,5) ;
         update operw set value = value || nlchr || k.value where ref = oo.ref and tag = k.tag ;
         if SQL%rowcount = 0 then insert into operw(ref,tag,value) values (oo.ref,k.tag,k.value); end if;

      end loop;
      p_ref :=  oo.ref;

   end  SWIFT_RU1 ;

-----------------------------
begin

 If p_mode = 99 and p_chr = '1' then

    -- полное перенакопление фильтра
    begin  EXECUTE IMMEDIATE 'drop table ' || TabFil_ ;  exception when others then null; end;

    --Фильтр по переадресации создан для операций 830 и С14. Входят ли туда операции CLI - Кляймс Конференс???
    begin EXECUTE IMMEDIATE
           'create table ' || TabFil_ || ' as '||
           ' select substr( replace( w.value, chr(13)||chr(10), ''*'' ), 1,200)  VM, '||
           '        count(*) KOL ,
                    max(decode (o.tt,''CLI'',null,o.ref)) REF , '  ||
           '        max(decode (o.tt,''CLI'',o.ref,null)) REF_CLI '||
           ' from  oper o, sw_oper s, ' ||
           '      (select * from SW_OPERW where tag  like ''59'' ) w  '||
           ' where (o.tt = ''CLI'' or w.value like ''/262%'') and w.swref = s.swref  and s.ref= o.ref '||
           '   and o.mfoa = ''300465''  and o.tt in (''830'',''C14'',''CLI'' )  '||
           '   and O.VDAT > sysdate - 365 ' ||
           ' group by substr( replace(w.value, chr(13)||chr(10), ''*'' ), 1,200) '||
           ' having count(*) > 1 ';
    exception when others then null;
    end;

    begin EXECUTE IMMEDIATE  'CREATE INDEX I_testswtru ON '||TabFil_||' (VM) TABLESPACE BRSBIGI ';
    exception when others then null;
    end;

 ElsIf p_mode = 98 then  null;    -- До/накопление фильтра

 ElsIf p_mode = 0  then

    If NVL(p_num,0) = 0 then    ---------- обработка всех воможных свифтовок
       for j in (select *  FROM SW_JOURNAL WHERE date_pay is null AND mt='103' and io_ind='O' and accd is not null  )
       loop   SWIFT_RU1 ( j , l_ref, p_chr );  end loop;
    else                        ---------- обработка одной свифтовки
       s_Sql :=  'select * FROM SW_JOURNAL WHERE date_pay is null AND mt=''103'' and io_ind=''O'' and accd is not null and swref='||p_num;
       begin select * into jj FROM SW_JOURNAL WHERE date_pay is null AND mt='103' and io_ind='O'  and accd is not null and swref=   p_num;
          SWIFT_RU1 (jj , l_ref, p_chr );
       EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error(-20000, 'SWIFT_RU:не знайдено' || s_sql );
       end;
    end if;

 end if;

end SWIFT_RU ;

--==============================
--  L1) Грн-Лоро : SWIFT -> СЕП        FunNSIEditF("LORO_SWT_SEP", 2)   ===
--==============================
Function F_NLSB ( p_swref number)  return varchar2 is
  sTmp_  SW_OPERW.value%type;  nTmp_  number;  nlchr char(2) := chr(13)||chr(10); i1_ int; i2_ int; i3_ int ;
  l_mfob   char(6)   := ' ' ;
  l_nlsb   char(14)  := ' ' ;
  l_idb    char(10)  := ' ' ;
  l_namb   char(38)  := ' ' ;
  l_nazn   char(160) := ' ' ;

begin
  ------ MFOB
  sTmp_:= null;
  begin   select value into sTmp_ from SW_OPERW where SWREF=p_swref and TAG='57'; EXCEPTION WHEN NO_DATA_FOUND THEN null;
    begin select value into sTmp_ from SW_OPERW where SWREF=p_swref and TAG='58'; EXCEPTION WHEN NO_DATA_FOUND THEN null;  end;
  end;

  If sTmp_ like '%COSBUAUK%'                    then  l_mfob :='300465' ;
--ElsIf sTmp_ like '%'||GL.aBic||'%'            then  l_mfob := gl.aMfo ;
  elsIf sTmp_ is NOT null                       then  nTmp_  := instr  ( sTmp_, nlchr , 1 ) - 6 ;
     If nTmp_ > 0                               then  l_mfob := substr ( sTmp_, nTmp_ , 6 )     ;
        If substr(l_mfob,1,1) not in ('3','8')  then  nTmp_  := instr  ( sTmp_, 'MFO ', 1 ) + 4 ;
           If nTmp_ > 0 then                          l_mfob := substr ( sTmp_, nTmp_ , 6 )     ;
           end if;
        end if;
     end if;
  end if;
  If substr (l_mfob,1,1) not in ('3','8')       then  l_mfob := ' ';  end if;

  ------ NLSB + ID_B + NAM_B
  sTmp_:= null;
  begin   select value into sTmp_ from SW_OPERW where SWREF=p_swref and TAG='59'; EXCEPTION WHEN NO_DATA_FOUND THEN null;
    begin select value into sTmp_ from SW_OPERW where SWREF=p_swref and TAG='58'; EXCEPTION WHEN NO_DATA_FOUND THEN null;  end;
  end;
  If sTmp_  is NOT null then
     i1_    := instr ( sTmp_, nlchr ,  1    ) ;
     i2_    := instr ( sTmp_, nlchr , i1_+2 ) ;
     i3_    := instr ( sTmp_, nlchr , i2_+2 ) ;
     If i3_  = 0 then i3_ := length(sTmp_)+1  ; end   if;
     ---------------------------------------
     nTmp_  := i1_ - 2;            If nTmp_ > 4 then  l_nlsb := substr(sTmp_,2,nTmp_); end if ;
     ------------------------------------------------------------------------------------------
     If    sTmp_ like '%COSBUAUK%'              then  l_idb  := '00032129' ;
   --ElsIf sTmp_ like '%'||gl.aBic||'%'         then  l_idb  :=  gl.aOkpo  ;
     elsIf i2_ > 8                              then  l_idb  := substr( sTmp_, i2_-8, 8)      ;
     end if;
     begin nTmp_:= to_number(l_idb) ; exception when others then l_idb:=' ';             end  ;
     ------------------------------------------------------------------------------------------
     If    sTmp_ like '%COSBUAUK%'              then  l_namb := 'АТ "Ощадбанк"'               ;
   --ElsIf sTmp_ like '%'||gl.aBic||'%'         then  l_namb :=  gl.aName  ;
     ElsIf i3_ > i2_ + 2                        then  l_namb := bars_swift.SwiftToStr(substr(sTmp_, i2_+1, i3_ -i2_) );
     end if;
 end if;

 ------- NAZN
  sTmp_:= null;
 begin   select value into sTmp_ from SW_OPERW where SWREF=p_swref and TAG='70'; EXCEPTION WHEN NO_DATA_FOUND THEN null;
   begin select value into sTmp_ from SW_OPERW where SWREF=p_swref and TAG='72'; EXCEPTION WHEN NO_DATA_FOUND THEN null;  end;
 end;
 If sTmp_ is NOT null then  l_nazn := substr( bars_swift.SwiftToStr ( replace (sTmp_, nlchr,'' ) ),1,160) ;  end if;
 ------------------------------------------------------------
  l_namb := replace (l_namb , chr(13) );
  l_namb := replace (l_namb , chr(10) );
  l_nazn := replace (l_nazn , chr(13) );
  l_nazn := replace (l_nazn , chr(10) );

 Return   ( l_mfob || l_nlsb || l_idb || l_namb || l_nazn ) ;
 ------------------------------------------------------------
end F_NLSB;
-----------

procedure SWT_SEP   -- L-1
 ( p_mode int,
   p_SWREF number   ,
   P_MFOB  varchar2 ,
   p_NLSB  varchar2 ,
   p_IDB   varchar2 ,
   p_NAMB  varchar2 ,
   P_NAZN  varchar2 ,
   KODN_   varchar2 ,
   P40_    varchar2 ,
   P_N      varchar2
  ) is

  LL LORO_SWT_SEP%rowtype;
  oo oper%rowtype     ;
  cc customer%rowtype ;
  bb custbank%rowtype ;
  sTmp_  SW_OPERW.value%type;  nTmp_  number;  i1_ int; i2_ int; i3_ int ;
  flg37_ char(1)      ;  nlchr  char(2)     := chr(13)||chr(10);

  nls_6100 accounts.NLS%type ;

begin
  If NVL(newnbs.g_state,0)  = 1 then  nls_6100 :='6500010201515' ;  Else nls_6100 := '6100410201515' ;  end if ; -- -- Трансфер-2017

  If not ( p_Mfob <> gl.aMfo OR p_NLSB like '1600%' )  then RETURN; end if;

-- Из СВИФТ -> СЭП
-- ТОЛЬКО ДЛЯ ЭТИХ Деб.1600 - Кр.1200-СЕП или 3901 (ВПС) или 1600 (Внутр)
   begin select * into ll from LORO_SWT_SEP  where swref = p_swREF ;
   EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error(-20000, 'Swf->Sep:не знайдено');
   end;

   If p_MFOB is null then raise_application_error( -20000, 'МФО банку отримувача') ; end if ;
   If P_NLSB is null then raise_application_error( -20000, 'Рахунок   отримувача') ; end if ;
   If p_IDB  Is null then raise_application_error( -20000, 'Iдент.код отримувача') ; end if ;
   If p_NAMB Is null then raise_application_error( -20000, 'Назва     отримувача') ; end if ;
   If p_NAZN Is null then raise_application_error( -20000, 'Призначення платежу ') ; end if ;
   If KODN_  Is null then raise_application_error( -20000, '1PB:1-ПБ~Код~Приз.пл') ; end if ;

   oo.ref := null ;
   If p_MFOB = gl.aMfo then oo.tt := '807';
   else                     oo.tt := '854';
   end if;
   gl.ref(oo.REF) ;
   oo.nd  := substr( '+'|| p_swREF,1, 10 );
   oo.kv  := 980 ;
   oo.s   := ll.s * 100;
   oo.sos := 1   ;
   oo.dk  := 1   ;
   nTmp_  := instr( ll.k50,'~' , 1)  +1;

   oo.nam_b := replace (p_namb   , chr(10) );
   oo.nam_b := replace (oo.nam_b , chr(13) );
   oo.nazn:= substr( p_nazn ||
                    '/1PB/' ||substr(KODN_,1,4)||'/804/'|| cc.country|| '/'||
                      bars_swift.SwiftToStr ( substr( ll.k50, nTmp_, 35) ),
                      1,160) ;
   --------------------------------
   oo.d_rec := '#fMT '|| ll.mt|| '#nП'||P_N||'#';
   gl.in_doc3(ref_ => oo.ref  , tt_   => oo.tt  , vob_  => 1       , nd_   => oo.nd     , pdat_  => SYSDATE,
              vdat_=> gl.BDATE, dk_   => oo.dk  , kv_   => oo.kv   , s_    => oo.S      , kv2_   => oo.kv,
              s2_  => oo.S    , sk_   => null   , data_ => ll.VDATE, datp_ => ll.DATE_IN, nam_a_ => substr(LL.nam_a,1,38),
              nlsa_=> LL.nlsa , mfoa_ => gl.aMfo, nam_b_=> oo.nam_b, nlsb_ => p_nlsb    , mfob_  => p_Mfob,
              nazn_=> oo.nazn , d_rec_=> oo.d_rec,id_a_ => cc.okpo , id_b_ => p_idb     ,
              id_o_=> null    , sign_ => null   , sos_  => oo.sos  , prty_ => null      , uid_   => null );
   -- 37 - Оплата по факт.залишку = 1  / По план.залишку = 0 / Не платити = 2
   select substr(flags,38,1) into flg37_  from tts   where tt = oo.tt;
   gl.dyntt2(sos_  => oo.sos  , mod1_ => flg37_ , mod2_ =>  0      , ref_  => oo.ref    , vdat1_ => gl.bdate,
             vdat2_=> gl.bdate, tt0_  => oo.tt  , dk_   => oo.dk   , kva_  => oo.kv     ,  mfoa_ => gl.aMfo ,
             nlsa_ => LL.nlsa , sa_   => oo.s   , kvb_  => oo.kv   , mfob_ => p_mfob    ,  nlsb_ => p_nlsb  ,
             sb_   => oo.s    , sq_   => null   , nom_  => null  ) ;
   If p_Mfob <> gl.aMfo then
      oo.s := f_tarif ( 198 , oo.kv, ll.nlsa, oo.s, 0);
      gl.PAYv ( 0, oo.ref, gl.bdate, 'D06', 1, oo.kv, ll.nlsa, oo.s, gl.baseval, nls_6100, oo.s ); 
   end if;

   INSERT INTO sw_oper (ref, swref )    values (oo.ref , p_swref              ) ;
   update sw_journal set date_pay = gl.bdate where swref = p_swref;
   insert into operw (ref, tag , value) values (oo.ref , 'n    ', 'П'||P_N ) ;
   insert into operw (ref, tag , value) values (oo.ref , 'f    ', ll.MT       ) ;
   insert into operw (ref, tag , value) values (oo.ref , 'KOD_G', ll.KOD_G    ) ;
   insert into operw (ref, tag , value) values (oo.ref , 'KOD_B', ll.KOD_B    ) ;
   insert into operw (ref, tag , value) values (oo.ref , 'KOD_N', KODN_       ) ;
   insert into operw (ref, tag , value) values (oo.ref , 'D#40 ', p40_        ) ;
   insert into operw (ref, tag , value) select  oo.ref , w.tag||w.opt , w.value from sw_operw w where w.swref = p_swref;

end SWT_SEP;   --- L-1

--==============================
--L2) Вал-Лоро : SWIFT -> SWIFT     FunNSIEditF("LORO_SWT_SWT", 2)
--==============================
Function F_NLSk ( p_swref number)  return varchar2       is
  sTmp_  SW_OPERW.value%type;   nlchr char(2) := chr(13)||chr(10); i1_ int; l_nlsk varchar2(15) ;
begin
  begin
    --1500
    select value into sTmp_ from SW_OPERW where SWREF = p_swref and TAG='57' ;
    If sTmp_ not like '%COSBUAUK%'  then l_nlsk := '191992';  end if;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    begin select value into sTmp_ from SW_OPERW where SWREF=p_swref and TAG='58'; EXCEPTION WHEN NO_DATA_FOUND THEN null; end;
  end;

  If l_NLSK is null then  -- 1600, 3739, 2600
     i1_    := instr ( sTmp_, nlchr, 1 ) ;
     l_NLSK := substr( sTmp_, 2, i1_-2 ) ;
  end if    ;
  Return    l_nlsk;

end F_NLSK;
----------------
procedure SWT_SWT  --- L-2
 ( p_mode int,
   p_SWREF number   ,
   p_NLSK  varchar2 ,
   KODN_   varchar2
  ) is
  aa accounts%rowtype ;
  MM LORO_SWT_SWT%rowtype;
  oo oper%rowtype     ;
  cc customer%rowtype ;
  sTmp_  SW_OPERW.value%type;  nTmp_  number;   i1_ int; i2_ int; i3_ int ;
  flg37_ char(1)      ;
  nlchr  char(2)      := chr(13)||chr(10); l_nlsk varchar2(15);

begin
  -- ТОЛЬКО ДЛЯ ЭТИХ Деб.1600 - Кр.1500,1600 , т.е мы - транзитный банк

  l_NLSK := nvl(p_NLSK,loro.F_NLSK(p_SWREF));

  If    l_NLSK like '191992' then  oo.tt := '8C2'; -- null ; -- на подбор 1500
  ElsIf l_NLSK like '1600%'  then  oo.tt := '013'; -- null ; -- прямая проводка, но со свифтовкой
  else                                    RETURN ; -- прямая проводка, нБЕЗ свифтовки
  end if;

  -- Списание вал 103+2**
  begin select * into MM from LORO_SWT_SWT  where swref = p_swREF ;
        select * into cc from customer      where rnk   = (select rnk from accounts where acc=mm.accd);
        select * into aa from accounts      where kv = mm.kv and nls = l_nlsk ;
  EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error(-20000, 'Swf->Swt:не знайдено');
  end;


  oo.nd   := substr( '+'|| oo.nd,1,10); oo.kv := mm.kv; oo.s := mm.s * 100;
  oo.nlsa := mm.nls; oo.nam_a := substr(mm.nms,1,38)  ;
  oo.nlsb := aa.nls; oo.nam_b := substr(aa.nms,1,38)  ;
  oo.nazn := 'Списання з Лоро-рахунку на iнший банк'  ;
  oo.d_rec:= '#fMT '|| mm.mt|| '#nП'||cc.country||'#' ;

  gl.ref(oo.REF)  ;
  gl.in_doc3(ref_=> oo.ref   , tt_   => oo.tt  , vob_  => 6       , nd_   => oo.nd   , pdat_  => SYSDATE,
            vdat_=> gl.BDATE , dk_   => 1      , kv_   => oo.kv   , s_    => oo.S    , kv2_   => oo.kv,
            s2_  => oo.S     , sk_   => null   , data_ => gl.bdate, datp_ => gl.bdate, nam_a_ => oo.nam_a,
            nlsa_=> oo.nlsa  , mfoa_ => gl.aMfo, nam_b_=> oo.nam_b, nlsb_ => oo.nlsb , mfob_  => gl.aMfo,
            nazn_=> oo.nazn  , d_rec_=> oo.d_rec,id_a_ => gl.aOkpo, id_b_ => gl.aOkpo,
            id_o_=> null     , sign_ => null   , sos_  => 1       , prty_ => null    , uid_   => null );
  PAYTT  ( 0, oo.ref, gl.bdate, oo.tt, 1, oo.kv, oo.nlsa, oo.s, oo.kv, oo.nlsb, oo.s );

--gl.pay ( 0, oo.REF, gl.bDATE);
  --insert into operw (ref, tag , value) values (oo.ref,  'f'    , 'MT '|| mm.mt    ) ;
  set_operw(oo.ref, 'f', 'MT '|| mm.mt);
  If oo.nlsb like '1600%' then
     --insert into operw (ref,tag,value) values (oo.ref,  'NOS_A', to_char (aa.acc) ) ;
     set_operw(oo.ref, 'NOS_A', to_char(aa.acc));
  end if;
  ----------------------------------------------------
  bars_swift_msg.docmsg_process_document2(oo.ref, 1) ;
  ---------------------------------------------------
--insert into operw (ref, tag , value) values (oo.ref,  'KOD_G', ll.country       ) ;
  --insert into operw (ref, tag , value) values (oo.ref,  'KOD_N', KODN_            ) ;
  set_operw(oo.ref, 'KOD_N', KODN_);

end swt_swt;  -- L-2


--==============================
--L3) Грн-Лоро : СЕП -> SWIFT    FunNSIEditF("LORO_SEP_SWT", 2)
--==============================
Function F_TXT2( p_In     operw.value%type )  return sw_operw.value%type is
                 l_Out sw_operw.value%type ;    sTmp_   operw.value%type := trim(p_In);  nTmp_ number; nlchr char(2) := chr(13) || chr(10) ;
begin
   nTmp_ := length ( sTmp_ ) ; l_Out :=                    substr( sTmp_ ,  1, 35) ;           -- 1
   If nTmp_ >  35 then         l_Out := l_Out || nlchr ||  substr( sTmp_ , 36, 35) ; end if ;  -- 2
   If nTmp_ >  70 then         l_Out := l_Out || nlchr ||  substr( sTmp_ , 71, 35) ; end if ;  -- 3
   If nTmp_ > 105 then         l_Out := l_Out || nlchr ||  substr( sTmp_ ,106, 35) ; end if ;  -- 4
   Return l_Out;
end F_TXT2;
----------
procedure SEP_SWT   --- L-3
 ( p_mode int,
   p_REF_SEP number,
   P50_ varchar2   , -----------  50K: Ordering Customer-Name + Address
                  -- /1919301            Счет отправителя из первичного документа
                  -- OOO TDLK-UKRAINA    Название отправителя из назначения платежа  первичного документа
   p57_   varchar2 , ------------ 57D: Account With Inst -Name + Addr
                  -- /16004201040
                  -- OAO ASB BELARUSBANK
                  -- FIL.413 G.LIDA
                  -- BELARUSX            ЛОРО счет и название отделения из первички
   p59_1_ varchar2 , -----------  59: Beneficiary Customer-Name + Addr
                  -- /3012216250740/980 Счет получателя из назначения платежа  из первички
                  -- ....
                  -- .....
   p59_2_ varchar2 , -----------  59: Beneficiary Customer-Name + Addr
                  --......
                  -- OAO LAKOKRASKA     Hазвание получателя из назначения платежа  из первички

   p70_ varchar2 , -----------  70: Remittance Information
                  -- OPLATA FTAL.ANGID DOG.94/792 OT
                  -- 09.02.11. DS70 OT 251113 BEZ NDS.   Назначение платежа из первички
   KODN_ varchar2  -- 'KOD_N' , nvl(p4_,'1222')
  ) IS

 nlchr char(2) := chr(13)||chr(10) ; sTmp_ operw.value%type ; oo oper%rowtype; a37 accounts%rowtype; ll LORO_SEP_SWT%ROWTYPE ; nn banks%rowtype;

begin

 If p_mode = 3 then -- L_3)  Из СЭП в СВИФТ
    begin
      select   * into ll  from LORO_SEP_SWT         where   ref = p_REF_SEP ;
      select   * into oo  from oper                 where   ref = p_REF_SEP ;
      select a.* into a37 from accounts a, opldok o where o.ref = oo.ref and o.dk = 1 and o.acc= a.acc ;
    EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error(-20000, 'SEP-Swift:не знайдено');
    end;

    -- попутно пополним справочник.
    insert into bic_acc (acc, bic)  select ll.acc, ll.bic from dual where not exists (select 1 from  bic_acc where acc = ll.acc and bic=ll.bic);

    If P50_   is null then raise_application_error( -20000, '50 K: Ordering Customer-Name + Address') ; end if ;
    If P57_   is null then raise_application_error( -20000, '57 D: Account With Inst-Name + Addr'   ) ; end if ;
    If p59_1_ Is null then raise_application_error( -20000, '59/1: Beneficiary - Счет получателя'   ) ; end if ;
    If p59_2_ Is null then raise_application_error( -20000, '59/2: Beneficiary Customer-Name + Addr') ; end if ;
    If p70_   Is null then raise_application_error( -20000, '70  : Remittance Information')           ; end if ;
    If KODN_  Is null then raise_application_error( -20000, '1PB : 1-ПБ~Код~ Приз.пл ')               ; end if ;

    oo.ref := null ;
    oo.tt  := '902';
    oo.nd  :=substr( '+'|| oo.nd,1,10);
    gl.ref(oo.REF) ;
    gl.in_doc3(ref_ => oo.ref   , tt_   => oo.tt  , vob_  => 6       , nd_   => oo.nd   , pdat_  => SYSDATE,
               vdat_=> gl.BDATE , dk_   => 1      , kv_   => oo.kv   , s_    => oo.S    , kv2_   => oo.kv,
               s2_  => oo.S     , sk_   => null   , data_ => oo.datd , datp_ => gl.bdate, nam_a_ => substr(a37.nms,1,38),
               nlsa_=> a37.nls  , mfoa_ => gl.aMfo, nam_b_=> oo.nam_b, nlsb_ => oo.nlsb , mfob_  => gl.aMfo,
               nazn_=> oo.nazn  , d_rec_=> oo.d_rec,id_a_ => gl.aOkpo, id_b_ => gl.aOkpo,
               id_o_=> null     , sign_ => null   , sos_  => 1       , prty_ => null    , uid_   => null );
    PAYTT  ( 0, oo.ref, gl.bdate, oo.tt, 1, oo.kv, a37.nls, oo.s, oo.kv, oo.nlsb, oo.s );
--  gl.pay ( 0, oo.REF, gl.bDATE);
    bars_swift_msg.docmsg_process_document2(oo.ref, 1) ;
    ---------------------------------------------------
    insert into operw (ref, tag , value) values (oo.ref,  'KOD_G', ll.country                                           ) ;
    insert into operw (ref, tag , value) values (oo.ref,  'KOD_N', KODN_                                                ) ;
    INSERT INTO operw (ref, tag , value) select  oo.ref,  'REF92', to_char(p_REF_SEP) || ', arc_rrp.Rec= ' ||rec from arc_rrp where ref=p_REF_SEP and rownum=1;

----- delete from t902 where ref = p_REF_SEP;

-- -       20: Sender's Reference
-- +      23B: Bank Operation Code
-- +      32A: Val Dte/Curr/Interbnk  : 131203USD15259,82
-- +      33B: Currency/Instructed Amount
-- +      50K: Ordering Customer-Name + Address
-- +      52D: Ordering Institution-Name + Addr
-- +      57D: Account With Inst -Name + Addr
-- +       59: Beneficiary Customer-Name + Addr
-- +       70: Remittance Information
-- +      71A: Details of Charges            BEN
-- +      71F: Sender’s Charges
-- +      77B: Regulatory Reporting

 end if;

end SEP_SWT ; -- L_3

----------------------------------------------------------------------------
/** * header_version - возвращает версию заголовка пакета  */
function header_version return varchar2 is begin  return 'Package header LORO '||G_HEADER_VERSION; end header_version;

/** * body_version - возвращает версию тела пакета DIU  */
function body_version return varchar2 is begin   return 'Package body LORO '||G_BODY_VERSION; end body_version;
--------------

---Аномимный блок --------------
begin
  null;
END LORO;
/
 show err;
 
PROMPT *** Create  grants  LORO ***
grant EXECUTE                                                                on LORO            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on LORO            to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/loro.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 