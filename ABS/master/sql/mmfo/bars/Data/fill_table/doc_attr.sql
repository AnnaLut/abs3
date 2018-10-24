PROMPT =====================================================================================
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/doc_attr_cust.sql ==========*** Run ***
PROMPT =====================================================================================

Begin
  INSERT INTO DOC_ATTR(ID,NAME,FIELD,SSQL)
  VALUES ('CUST_FMPOS','Анкета ФМ: Висновок щодо наявн.у кл-та потенц. та реал. фін.можл.для провед. опер.','',
  'select nvl(trim(substr(f_get_custw_h(:ND,''FMPOS'',f_get_cust_fmdat(:ADDS)),1,2000)),''Вiдповiдає'') from dual');
exception
  when dup_val_on_index then
    null;
end;
/

COMMIT;

begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_ACC_NLS', 'Номер зарезервованого рахунку'
         , 'select SubStr(a.NLS,1,14) into :sValue from ACCOUNTS_RSRV a where a.RSRV_ID=:ND' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select SubStr(a.NLS,1,14) into :sValue from ACCOUNTS_RSRV a where a.RSRV_ID=:ND'
         , NAME = 'Номер зарезервованого рахунку'
     where ID   = 'RSRV_ACC_NLS';
end;
/

begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_ACC_KV', 'Валюта зарезервованого рахунку'
         , 'select t.NAME into :sValue from ACCOUNTS_RSRV a, TABVAL$GLOBAL t where a.RSRV_ID=:ND and t.KV=a.KV' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select t.NAME into :sValue from ACCOUNTS_RSRV a, TABVAL$GLOBAL t where a.RSRV_ID=:ND and t.KV=a.KV'
         , NAME = 'Валюта зарезервованого рахунку'
     where ID   = 'RSRV_ACC_KV';
end;
/

begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_ACC_NBS', 'Номер бал. рах. зарезервованого рахунку'
         , 'select SubStr(a.NLS,1,4) into :sValue from ACCOUNTS_RSRV a where a.RSRV_ID=:ND' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select SubStr(a.NLS,1,4) into :sValue from ACCOUNTS_RSRV a where a.RSRV_ID=:ND'
         , NAME = 'Номер бал. рах. зарезервованого рахунку'
     where ID   = 'RSRV_ACC_NBS';
end;
/

begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_ACC_OPN_DT', 'Дата вiдкриття зарезервованого рахунку (планова)'
         , 'select to_char(a.CRT_DT,''DD/MM/YYYY'') into :sValue from ACCOUNTS_RSRV a where a.RSRV_ID=:nd' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select to_char(a.CRT_DT,''DD/MM/YYYY'') into :sValue from ACCOUNTS_RSRV a where a.RSRV_ID=:nd'
         , NAME = 'Дата вiдкриття зарезервованого рахунку'
     where ID   = 'RSRV_ACC_OPN_DT';
end;
/

begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_ACC_VID_NM', 'Вид зарезервованого рахунку'
         , 'select Substr(v.NAME,1,16) into :sValue from ACCOUNTS_RSRV a, VIDS v where a.VID = v.VID and a.RSRV_ID=:ND' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select Substr(v.NAME,1,16) into :sValue from ACCOUNTS_RSRV a, VIDS v where a.VID = v.VID and a.RSRV_ID=:ND'
         , NAME = 'Вид зарезервованого рахунку'
     where ID   = 'RSRV_ACC_VID_NM';
end;
/

begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_CST_CODE', 'ОКПО власника зарезервованого рахунку'
         , 'select c.OKPO into :sValue from ACCOUNTS_RSRV a, CUSTOMER c where a.RNK=c.RNK AND a.RSRV_ID=:ND' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select c.OKPO into :sValue from ACCOUNTS_RSRV a, CUSTOMER c where a.RNK=c.RNK AND a.RSRV_ID=:ND'
         , NAME = 'ОКПО власника зарезервованого рахунку'
     where ID   = 'RSRV_CST_CODE';
end;
/

begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_CST_NM', 'Назва власника зарезервованого рахунку'
         , 'select c.NMK into :sValue from ACCOUNTS_RSRV a, CUSTOMER c where a.RNK=c.RNK AND a.RSRV_ID=:ND' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select c.NMK into :sValue from ACCOUNTS_RSRV a, CUSTOMER c where a.RNK=c.RNK AND a.RSRV_ID=:ND'
         , NAME = 'Назва власника зарезервованого рахунку'
     where ID   = 'RSRV_CST_NM';
end;
/

begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_CST_VED', 'Код економічної діяльності клiєнта'
         , 'select Substr(c.VED,1,5) into :sValue from ACCOUNTS_RSRV a, CUSTOMER c where a.RSRV_ID=:ND and a.RNK=c.RNK' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select Substr(c.VED,1,5) into :sValue from ACCOUNTS_RSRV a, CUSTOMER c where a.RSRV_ID=:ND and a.RNK=c.RNK'
         , NAME = 'Код економічної діяльності клiєнта'
     where ID   = 'RSRV_CST_VED';
end;
/

begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_CST_VED_NM', 'Назва економічної діяльності клiєнта'
         , 'select SubStr(trim(v.NAME),1,144) into :sValue from ACCOUNTS_RSRV a, CUSTOMER c, VED v where a.RSRV_ID=:ND and a.RNK=c.RNK and c.VED=v.VED' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select SubStr(trim(v.NAME),1,144) into :sValue from ACCOUNTS_RSRV a, CUSTOMER c, VED v where a.RSRV_ID=:ND and a.RNK=c.RNK and c.VED=v.VED'
         , NAME = 'Назва економічної діяльності клiєнта'
     where ID   = 'RSRV_CST_VED_NM';
end;
/

begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_CST_DBO_AGRM_NUM', 'Номер ДБО клiєнта'
         , 'select w.VALUE into :sValue from CUSTOMERW w, ACCOUNTS_RSRV a where a.RSRV_ID=:ND and w.RNK=a.RNK and w.TAG=''NDBO''' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select w.VALUE into :sValue from CUSTOMERW w, ACCOUNTS_RSRV a where a.RSRV_ID=:ND and w.RNK=a.RNK and w.TAG=''NDBO'''
         , NAME = 'Номер ДБО клiєнта'
     where ID   = 'RSRV_CST_DBO_AGRM_NUM';
end;
/

begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_CST_DBO_AGRM_DT', 'Дата ДБО клiєнта'
         , 'select F_DAT_LIT(to_date(w.VALUE,''dd.mm.yyyy'')) into :sValue from CUSTOMERW w, ACCOUNTS_RSRV a where a.RSRV_ID=:ND and w.RNK=a.RNK and w.TAG=''DDBO''' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select F_DAT_LIT(to_date(w.VALUE,''dd.mm.yyyy'')) into :sValue from CUSTOMERW w, ACCOUNTS_RSRV a where a.RSRV_ID=:ND and w.RNK=a.RNK and w.TAG=''DDBO'''
         , NAME = 'Дата ДБО клiєнта'
     where ID   = 'RSRV_CST_DBO_AGRM_DT';
end;
/

--ACC_DATEA_LIT->RSRV_DATEA_LIT
  begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_DATEA_LIT', 'Анкета ФМ: Дата державної реєстрацiї прописом'
         , q'[select nvl(f_dat_lit(to_date(substr(f_get_cust_h((select a.rnk from accounts_rsrv a where a.rsrv_id = :ND), 'to_char(datea)', f_get_cust_fmdat ((select TO_NUMBER(TO_CHAR(c.DATEA,'ddMMyyyy')) from v_customer c, accounts_rsrv a where c.rnk = a.rnk and a.rsrv_id = :ND))), 1, 10), 'DD.MM.YYYY')), '__ ______ ____ р.') INTO :sValue from dual]' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = q'[select nvl(f_dat_lit(to_date(substr(f_get_cust_h((select a.rnk from accounts_rsrv a where a.rsrv_id = :ND), 'to_char(datea)', f_get_cust_fmdat ((select TO_NUMBER(TO_CHAR(c.DATEA,'ddMMyyyy')) from v_customer c, accounts_rsrv a where c.rnk = a.rnk and a.rsrv_id = :ND))), 1, 10), 'DD.MM.YYYY')), '__ ______ ____ р.') INTO :sValue from dual]'
         , NAME = 'Анкета ФМ: Дата державної реєстрацiї прописом'
     where ID   = 'RSRV_DATEA_LIT';
end;
/

--ACC_RGADM->RSRV_RGADM 
begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_RGADM', 'Анкета ФМ: Номер св-ва про реєстрац_ю'
         , 'select nvl(substr(f_get_cust_h((select a.rnk from accounts_rsrv a where a.rsrv_id = :ND), ''rgadm'', f_get_cust_fmdat ((select TO_NUMBER(TO_CHAR(c.DATEA,''ddMMyyyy'')) from v_customer c, accounts_rsrv a where c.rnk = a.rnk and a.rsrv_id = :ND))), 1, 30), chr(160)) INTO :sValue from dual ' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select nvl(substr(f_get_cust_h((select a.rnk from accounts_rsrv a where a.rsrv_id = :ND), ''rgadm'', f_get_cust_fmdat ((select TO_NUMBER(TO_CHAR(c.DATEA,''ddMMyyyy'')) from v_customer c, accounts_rsrv a where c.rnk = a.rnk and a.rsrv_id = :ND))), 1, 30), chr(160)) INTO :sValue from dual '
         , NAME = 'Анкета ФМ: Номер св-ва про реєстрац_ю'
     where ID   = 'RSRV_RGADM';
end;
/

--ACC_TP_NAME->RSRV_TP_NAME
begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_TP_NAME', 'РКО:Назва ТП'
         , 'SELECT name INTO :sValue FROM tarif_scheme WHERE id = (select a.trf_id from accounts_rsrv a where a.rsrv_id = :ND) ' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'SELECT name INTO :sValue FROM tarif_scheme WHERE id = (select a.trf_id from accounts_rsrv a where a.rsrv_id = :ND) '
         , NAME = 'РКО:Назва ТП'
     where ID   = 'RSRV_TP_NAME';
end;
/

--ACC_DKBO->RSRV_DKBO
begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_DKBO', 'ДБО.Розрахунок номеру договору'
         , 'select c.value from accounts_rsrv a, customerw c where a.rsrv_id = :ND and a.rnk = c.rnk AND c.tag = ''NDBO''' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select c.value from accounts_rsrv a, customerw c where a.rsrv_id = :ND and a.rnk = c.rnk AND c.tag = ''NDBO'''
         , NAME = 'ДБО.Розрахунок номеру договору'
     where ID   = 'RSRV_DKBO';
end;
/

--ACC_DDBO_LIT->--RSRV_DDBO_LIT
begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_DDBO_LIT', 'ДБО. Розрахунок дати'
         , 'SELECT F_DAT_LIT(to_date(d.value, ''dd.mm.yyyy'')) dbo_fdat FROM accounts_rsrv C, CUSTOMERW D WHERE c.rsrv_id = :ND and C.RNK = D.RNK AND D.tag = ''DDBO''' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'SELECT F_DAT_LIT(to_date(d.value, ''dd.mm.yyyy'')) dbo_fdat FROM accounts_rsrv C, CUSTOMERW D WHERE c.rsrv_id = :ND and C.RNK = D.RNK AND D.tag = ''DDBO'''
         , NAME = 'ДБО. Розрахунок дати'
     where ID   = 'RSRV_DDBO_LIT';
end;
/
--ACC_NMK1->--RSRV_NMK1
begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_NMK1', 'Найменування клієнта (повне)'
         , 'select nmku from corps a, accounts_rsrv b where b.rsrv_id = :nd and a.rnk = b.rnk' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select nmku from corps a, accounts_rsrv b where b.rsrv_id = :nd and a.rnk = b.rnk'
         , NAME = 'Найменування клієнта (повне)'
     where ID   = 'RSRV_NMK1';
end;
/

--ACC_RKO_POSFIO->--RSRV_RKO_POSFIO
begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_RKO_POSFIO', 'РКО: Посада та ПІБ(ТП)'
         , 'select nvl(f_get_rko_posfio(0, (select rnk from accounts_rsrv where rsrv_id = :ND), 1) || case when f_get_rko_posfio(0, (select rnk from accounts_rsrv where rsrv_id = :ND), 2) is null then null else '' ГѓЖ’Гўв‚¬ЛњГѓВўГўвЂљВ¬Г…ВЎГѓЖ’Г‚ВђГѓвЂљГ‚В° '' || f_get_rko_posfio(0, (select rnk from accounts_rsrv where rsrv_id = :ND), 2) end, ''__________'') posfio INTO :sValue from dual' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select nvl(f_get_rko_posfio(0, (select rnk from accounts_rsrv where rsrv_id = :ND), 1) || case when f_get_rko_posfio(0, (select rnk from accounts_rsrv where rsrv_id = :ND), 2) is null then null else '' ГѓЖ’Гўв‚¬ЛњГѓВўГўвЂљВ¬Г…ВЎГѓЖ’Г‚ВђГѓвЂљГ‚В° '' || f_get_rko_posfio(0, (select rnk from accounts_rsrv where rsrv_id = :ND), 2) end, ''__________'') posfio INTO :sValue from dual'
         , NAME = 'РКО: Посада та ПІБ(ТП)'
     where ID   = 'RSRV_RKO_POSFIO';
end;
/

--ACC_P->RSRV_P
begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_P', 'Должность повяз особи'
         , 'select position from customer_rel c, accounts_rsrv a where c.rel_id = 20 and a.rnk = c.rnk and a.rsrv_id = :ND and c.type_id in (''1'', ''2'', ''3'', ''4'')' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select position from customer_rel c, accounts_rsrv a where c.rel_id = 20 and a.rnk = c.rnk and a.rsrv_id = :ND and c.type_id in (''1'', ''2'', ''3'', ''4'')'
         , NAME = 'Должность повяз особи'
     where ID   = 'RSRV_P';
end;
/

--ACC_U1->RSRV_U1
begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'RSRV_U1', 'ПІД повяз особи(сокр)'
         , 'select last_name || '' '' || substr(first_name, 1, 1) || ''.'' || substr(middle_name, 1, 1) || ''.'' from customer_rel c, accounts_rsrv a where c.rel_id = 20 and a.rsrv_id = :ND and c.rnk = a.rnk' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'select last_name || '' '' || substr(first_name, 1, 1) || ''.'' || substr(middle_name, 1, 1) || ''.'' from customer_rel c, accounts_rsrv a where c.rel_id = 20 and a.rsrv_id = :ND and c.rnk = a.rnk '
         , NAME = 'ПІД повяз особи(сокр)'
     where ID   = 'RSRV_U1';
end;
/

-- SKRN_ZALOG_DAT update ssql
-- old ssql = select 'від '||SUBSTR(F_DAT_LIT( r.bdate ),1,25) INTO :sValue from  skrynka_nd n, skrynka_nd_ref r, opldok o, skrynka_acc s where   n.nd = :ND and o.ref = r.ref and s.acc = o.acc and N.n_sk = s.n_sk and s.tip = 'M'
begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'SKRN_ZALOG_DAT', 'Сейфы: дата документа залога',
           'SELECT ''від ''|| SUBSTR (F_DAT_LIT (max(r.bdate)), 1, 25) INTO :sValue FROM bars.skrynka_nd n, bars.skrynka_acc s, bars.skrynka_nd_ref r, bars.oper o,bars.opldok od WHERE  n.nd = :ND and s.n_sk = n.n_sk AND s.tip = ''M'' and r.nd = r.nd AND od.REF = r.REF AND od.acc = s.acc and o.ref = od.ref and o.sos = 5 and lower(o.nazn) like ''%внесення застави за%''' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = 'SELECT ''від ''|| SUBSTR (F_DAT_LIT (max(r.bdate)), 1, 25) INTO :sValue FROM bars.skrynka_nd n, bars.skrynka_acc s, bars.skrynka_nd_ref r, bars.oper o,bars.opldok od WHERE  n.nd = :ND and s.n_sk = n.n_sk AND s.tip = ''M'' and r.nd = r.nd AND od.REF = r.REF AND od.acc = s.acc and o.ref = od.ref and o.sos = 5 and lower(o.nazn) like ''%внесення застави за%'''
         , NAME = 'Сейфы: дата документа залога'
     where ID   = 'SKRN_ZALOG_DAT';
end;
/

--CUST_DATEA_LIT
begin
  Insert
    into DOC_ATTR ( ID, NAME, SSQL )
  Values ( 'CUST_DATEA_LIT', 'Анкета ФМ: Дата державної реєстрацiї прописом'
         , q'[select nvl(f_dat_lit(to_date(substr(f_get_cust_h(:ND, 'to_char(datea)', f_get_cust_fmdat(:ADDS)), 1, 10), 'DD.MM.YYYY')), '__ ______ ____ р.') INTO :sValue from dual]' );
exception
  when DUP_VAL_ON_INDEX then
    update DOC_ATTR
       set SSQL = q'[select nvl(f_dat_lit(to_date(substr(f_get_cust_h(:ND, 'to_char(datea)', f_get_cust_fmdat(:ADDS)), 1, 10), 'DD.MM.YYYY')), '__ ______ ____ р.') INTO :sValue from dual]'
         , NAME = 'Анкета ФМ: Дата державної реєстрацiї прописом'
     where ID   = 'CUST_DATEA_LIT';
end;
/
COMMIT;
