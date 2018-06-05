begin
execute immediate 'alter table W4_PRODUCT
  disable constraint FK_W4PRODUCT_W4NBSOB22';

delete from w4_nbs_ob22 where nbs in('2600', '2620','2650');
end;
/
begin
execute immediate 'drop table test_w4_product';
exception when others then null;
end;
/
begin
execute immediate 'create table test_w4_product as select CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP from w4_product where 1 = 0';
exception when others then null;
end;
/

begin
    execute immediate 'insert into w4_nbs_ob22
   (nbs,
    ob22,
    ob_9129,
    ob_ovr,
    ob_2207,
    ob_2208,
    ob_2209,
    ob_3570,
    ob_3579,
    tip,
    ob_2627,
    ob_2625x,
    ob_2627x,
    ob_2625d,
    ob_2628,
    ob_6110)
 values
   (''2600'',
    ''14'',
    null,
    null,
    null,
    null,
    null,
    ''27'',
    ''43'',
    ''W4G'',
    null,
    null,
    null,
    null,
    ''23'',
    null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/

begin
    execute immediate 'insert into w4_nbs_ob22
   (nbs,
    ob22,
    ob_9129,
    ob_ovr,
    ob_2207,
    ob_2208,
    ob_2209,
    ob_3570,
    ob_3579,
    tip,
    ob_2627,
    ob_2625x,
    ob_2627x,
    ob_2625d,
    ob_2628,
    ob_6110)
 values
   (''2620'',
    ''36'',
    ''32'',
    ''D0'',
    ''D1'',
    ''01'',
    ''І3'',
    ''19'',
    ''41'',
    ''W4W'',
    ''02'',
    ''36'',
    null,
    ''36'',
    ''50'',
    null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/

begin
    execute immediate 'insert into w4_nbs_ob22
   (nbs,
    ob22,
    ob_9129,
    ob_ovr,
    ob_2207,
    ob_2208,
    ob_2209,
    ob_3570,
    ob_3579,
    tip,
    ob_2627,
    ob_2625x,
    ob_2627x,
    ob_2625d,
    ob_2628,
    ob_6110)
 values
   (''2650'',
    ''12'',
    null,
    null,
    null,
    null,
    null,
    ''28'',
    ''44'',
    ''W4S'',
    null,
    null,
    null,
    null,
    null,
    null)';
 exception when others then 
    if sqlcode = -1 then null; else raise;
    end if; 
end;
/

begin
  -- 

  update W4_PRODUCT_MASK t
     set t.nbs = '2620', t.ob22 = '36', t.tip = 'W4W';
  update newnlsdescr t
     set t.sqlval = 'select to_char(max(substr(nls,7,1))+1) from accounts where nls like substr (nls, 1, 4) || ''___%'' || to_char(rnk) and (nls like ''2620%'' or nls like ''2600%'') and rnk=:RNK'
   where t.typeid = 'P';
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_UAH_2_46'', ''Зарплатний SAL_UAH_2_46 суб''''єктів господарювання (довгостроковий)'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SOC_UNEMPL_KK_UAH'', ''Социальний для Червоного хреста'', ''SOCIAL'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SOC_UNEMPL_UAH'', ''Соціальний служби зайнятості'', ''SOCIAL'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SOC_SOCPOL_UAH'', ''Соціальний мінсоцполітики'', ''SOCIAL'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''STND_SEA_UAH'', ''Стандартний Одеса(STND_SEA_UAH довгостроковий) UAH'', ''STANDARD'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''STND_SEA_USD'', ''Стандартний Одеса(STND_SEA_USD довгостроковий) USD'', ''STANDARD'', 840, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''STND_SEA_EUR'', ''Стандартний Одеса(STND_SEA_EUR довгостроковий) EUR'', ''STANDARD'', 978, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''STND_MYCR_OBU'', ''Моя кредитка (співробітники)'', ''STANDARD'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''STND_UAH_8'', ''Стандартний (STND_UAH_8 довгостроковий) UAH'', ''STANDARD'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''STND_USD_2'', ''Стандартний (STND_USD_2 довгостроковий) USD'', ''STANDARD'', 840, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''STND_EUR_2'', ''Стандартний (STND_EUR_2 довгостроковий) EUR'', ''STANDARD'', 978, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''STND_UAH_18'', ''Стандартний (для Картаи Киянина)'', ''STANDARD'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''STND_MYCR_UAH'', ''МІЙ КРЕДИТ'', ''STANDARD'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''STND_CRIMEA_UAH_1'', ''Стандартний КРИМ(STND_CRIMEA_UAH довгостроковий) UAH'', ''STANDARD'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''STND_CRIMEA_USD_1'', ''Стандартний КРИМ(STND_CRIMEA_USD довгостроковий) USD'', ''STANDARD'', 840, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''STND_CRIMEA_EUR_1'', ''Стандартний КРИМ(STND_CRIMEA_EUR довгостроковий) EUR'', ''STANDARD'', 978, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''STND_UAH_VIP'', ''Стандартний Бізнес-Центр UAH'', ''STANDARD'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''STND_USD_VIP'', ''Стандартний Бізнес-Центр USD'', ''STANDARD'', 840, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''STND_EUR_VIP'', ''Стандартний Бізнес-Центр EUR'', ''STANDARD'', 978, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''VIRTUAL_UAH'', ''VIRTUAL UAH'', ''VIRTUAL'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''VIRTUAL_USD'', ''VIRTUAL USD'', ''VIRTUAL'', 840, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''VIRTUAL_EUR'', ''VIRTUAL EUR'', ''VIRTUAL'', 978, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''CORP_SPD_UAH_1'', ''Корпоративний CORP_SPD_UAH_1 клієнтів-фізичних осіб-підприємців'', ''CORPORATE'', 980, ''2600'', ''14'', null, null, ''W4G'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''CORP_SPD_USD_1'', ''Корпоративний CORP_SPD_USD_1 клієнтів-фізичних осіб-підприємців'', ''CORPORATE'', 840, ''2600'', ''14'', null, null, ''W4G'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''CORP_SPD_EUR_1'', ''Корпоративний CORP_SPD_EUR_1 клієнтів-фізичних осіб-підприємців'', ''CORPORATE'', 978, ''2600'', ''14'', null, null, ''W4G'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''CORP_2605_UR_UAH_1'', ''Корпоративний CORP_2605_UR_UAH_1 клієнтів-суб"єктів господарської діяльності'', ''CORPORATE'', 980, ''2600'', ''14'', null, null, ''W4G'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''CORP_2605_UR_USD_1'', ''Корпоративний CORP_2605_UR_USD_1 клієнтів-суб"єктів господарської діяльностів'', ''CORPORATE'', 840, ''2600'', ''14'', null, null, ''W4G'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''CORP_2605_UR_EUR_1'', ''Корпоративний CORP_2605_UR_EUR_1 клієнтів-суб"єктів господарської діяльності'', ''CORPORATE'', 978, ''2600'', ''14'', null, null, ''W4G'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''INSTANT_CORP_UAH'', ''Інстант ФОП 2605 ММСБ'', ''INSTANT_MMSB'', 980, ''2600'', ''14'', null, null, ''W4G'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''CORP_2655_UR_UAH_1'', ''Корпоративний CORP_2655_UR_UAH_1 - небанківські фінансові установи'', ''CORPORATE'', 980, ''2650'', ''12'', null, null, ''W4S'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''CORP_2655_UR_USD_1'', ''Корпоративний CORP_2655_UR_USD_1 - небанківські фінансові установи'', ''CORPORATE'', 840, ''2650'', ''12'', null, null, ''W4S'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''CORP_2655_UR_EUR_1'', ''Корпоративний CORP_2655_UR_EUR_1 - небанківські фінансові установи'', ''CORPORATE'', 978, ''2650'', ''12'', null, null, ''W4S'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''ECONOM_UAH_4'', ''"Экономный" (ECONOM_UAH_4) (довгостроковий)'', ''ECONOM'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''ECONOM_USD_7'', ''"Экономный" (ECONOM_USD_7) (довгостроковий)'', ''ECONOM'', 840, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''ECONOM_EUR_6'', ''"Экономный" (ECONOM_EUR_6) (довгостроковий)'', ''ECONOM'', 978, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''ECONOM_CREDIT_UAH'', ''Постійний клієнт (вкладники)'', ''ECONOM'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''INSTANT_UAH'', ''Instant UAH'', ''INSTANT'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''INSTANT_USD'', ''Instant USD'', ''INSTANT'', 840, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''INSTANT_EUR'', ''Instant EUR'', ''INSTANT'', 978, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SOC_UAH_MIGRANT'', ''Для виплати грошової допомоги переселенцям (SOC_UAH_MIGRANT)'', ''MOYA_KRAYINA'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''PENS_SOC_MIGRANT'', ''Для виплати грошової допомоги переселенцям (PENS_SOC_MIGRANT)'', ''MOYA_KRAYINA'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''PENS_ARSL_MIGRANT'', ''Для виплати грошової допомоги переселенцям (PENS_ARSL_MIGRANT)'', ''MOYA_KRAYINA'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''PENS_SOC_UAH_24'', ''Пенсійний соціальний (PENS_SOC_UAH_24)'', ''PENSION'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''PENS_ARSL_UAH_27'', ''Пенсійний Арсенал (PENS_ARSL_UAH_27)'', ''PENSION'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_UAH_2_54'', ''Зарплатний SAL_UAH_2_54 суб''''єктів господарювання (довгостроковий)'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_UAH_2_53'', ''Зарплатний SAL_UAH_2_53 суб''''єктів господарювання (довгостроковий)'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''BUDG_PACK_1'', ''"Зарплатний бюджетний" BUDG_PACK_1'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''BUDG_PACK_2'', ''"Зарплатний бюджетний" BUDG_PACK_2'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_CLASSIC'', ''"Зарплатний обычный" SAL_CLASSIC'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_PACK_1'', ''"Зарплатний обычный" SAL_PACK_1'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_PACK_2'', ''"Зарплатний обычный" SAL_PACK_2'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_PACK_3'', ''"Зарплатний обычный" SAL_PACK_3'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''OBU_SAL_UAH_2_2'', ''Зарплатний OBU_SAL_UAH_2_5 для працівників банку (довгостроковий)'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_BUDG_UAH_2_40'', ''Зарплатний SAL_BUDG_UAH_2_40 бютжетний (довгостроковий)'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_UAH_2_45'', ''Зарплатний SAL_UAH_2_45 суб''''єктів господарювання (довгостроковий)'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_BUDG_UAH_2_43'', ''Зарплатний SAL_BUDG_UAH_2_43 бютжетний (довгостроковий)'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_NBU_1'', ''Зарплатний SAL_NBU_1 суб''''єктів господарювання '', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_BUDG_UAH_2_42'', ''Зарплатний SAL_BUDG_UAH_2_42 бютжетний (довгостроковий)'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_UAH_2_1'', ''Зарплатний SAL_UAH_2_1 суб''''єктів господарювання  (довгостроковий)'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_UAH_MIN'', ''ТОВ НВП "Олавтекс"'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_UAH_UZ_28'', ''Зарплатний SAL_UAH_UZ_28 Півд.-Західна та Одеська залізниця (довгостроковий)'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_BUDG_UAH_2_25'', ''Зарплатний SAL_BUDG_UAH_2_25 бютжетний (довгостроковий)'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_BUDG_UAH_2_6_MU'', ''Зарплатн Мінюст SAL_BUDG_UAH_2_6_MU'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_BUDG_UAH_2_47'', ''Зарплатний SAL_BUDG_UAH_2_47 бютжетний (довгостроковий)'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_BUDG_UAH_2_48'', ''Зарплатний SAL_BUDG_UAH_2_48 бютжетний (довгостроковий)'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_UAH_2_55'', ''Зарплатний SAL_UAH_2_55 суб''''єктів господарювання (довгостроковий)'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''BUDG_LOYAL'', ''"Зарплатний бюджетний" BUDG_LOYAL'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_LOYAL'', ''"Зарплатний обычный" SAL_LOYAL'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_BUDG_UAH_2_54'', ''Зарплатний SAL_BUDG_UAH_2_54 бютжетний (довгостроковий)'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_BUDG_UAH_2_41'', ''Зарплатний SAL_BUDG_UAH_2_41 бютжетний (довгостроковий)'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_UAH_2_48'', ''Зарплатний SAL_UAH_2_48 суб''''єктів господарювання (довгостроковий)'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_UAH_2_49'', ''Зарплатний SAL_UAH_2_49 суб''''єктів господарювання (довгостроковий)'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_STUD_UAH_2_4'', ''Зарплатний SAL_STUD_UAH_2_4 студентський (довгостроковий)'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_UAH_2_33'', ''Зарплатний SAL_UAH_2_33 суб''''єктів господарювання (довгостроковий)'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''BUDG_PACK_4'', ''"Зарплатний бюджетний" BUDG_PACK_4'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
  
    begin
      execute immediate 'insert into test_w4_product(CODE, NAME, GRP_CODE, KV, NBS, OB22, DATE_OPEN, DATE_CLOSE, TIP)
values (''SAL_PACK_4'', ''"Зарплатний обычный" SAL_PACK_4'', ''SALARY'', 980, ''2620'', ''36'', null, null, ''W4W'')';
    exception
      when others then
        if sqlcode = -1 then
          null;
        else
          raise;
        end if;
    end;
   
  for i in (select kf from mv_kf) loop
    bc.go(i.kf);
    update w4_product t
       set t.date_close = dat_next_u(gl.bd, -1)
     where t.code not in ('CORP_2520_BUDG_EUR_1',
                          'CORP_2520_BUDG_UAH_1',
                          'CORP_2520_BUDG_USD_1',
                          'CORP_2541_BUDG_EUR_1',
                          'CORP_2541_BUDG_UAH_1',
                          'CORP_2541_BUDG_USD_1',
                          'CORP_2542_BUDG_EUR_1',
                          'CORP_2542_BUDG_UAH_1',
                          'CORP_2542_BUDG_USD_1',
                          'CORP_OBU_UAH',
                          'CORP_OBU_EUR',
                          'CORP_OBU_USD',
                          'CORP_3551_OBU_UAH');
  merge into w4_product w
  using (select * from test_w4_product) o
  on (w.code = o.code)
  when not matched then
    insert(w.CODE, w.NAME, w.GRP_CODE, w.KV, w.NBS, w.OB22, w.DATE_OPEN, w.DATE_CLOSE, w.TIP) values(o.CODE, o.NAME, o.GRP_CODE, o.KV, o.NBS, o.OB22, o.DATE_OPEN, o.DATE_CLOSE, o.TIP)
  when matched then
    update
       set w. NAME = o.name,
           w.GRP_CODE   = o.GRP_CODE,
           w.KV         = o.kv,
           w.nbs        = o.NBS,
           w.OB22       = o.ob22,
           w.DATE_OPEN  = o.date_open,
           w.DATE_CLOSE = o.date_close,
           w.TIP        = o.tip;
  commit;
  end loop;
  bc.home;
end;
/

begin
execute immediate 'drop table test_w4_product';
exception when others then null;
end;
/
begin
execute immediate 'alter table W4_PRODUCT
  enable constraint FK_W4PRODUCT_W4NBSOB22';
end;
/
