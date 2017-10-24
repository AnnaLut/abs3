
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_ttsadm.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_TTSADM is

  -- Author  : OLEG.MUZYKA
  -- Created : 27.11.2015 11:37:04
  -- Purpose : Адміністрування операцій

  -- Public constant declarations
  G_HEADER_VERSION constant varchar2(32767) := '$Ver$';

  -- Фукція отримання версії заголовка пакету
  function header_version return varchar2;

  -- Фукція отримання версії тіла пакету
  function body_version return varchar2;

  --Прив'язка операції до папки
  procedure set_folder_tts(p_tt   folders_tts.tt%type,
                           p_idfo folders_tts.idfo%type);

  --Відкріплення папки від операції
  procedure remove_folder_tts(p_tt   folders_tts.tt%type,
                              p_idfo folders_tts.idfo%type);

  --Привязка груп контролю до операції(візи)
  procedure set_chklist_tts(p_tt       chklist_tts.tt%type,
                            p_idchk    chklist_tts.idchk%type,
                            p_priority chklist_tts.priority%type,
                            p_sql      chklist_tts.sqlval%type,
                            p_charge   chklist_tts.f_in_charge%type,
                            p_respond  varchar2);

  --Відкріплення груп контролю від операції
  procedure remove_chklist_tts(p_tt    chklist_tts.tt%type,
                               p_idchk chklist_tts.idchk%type);

  --Привязка видів документів до операції
  procedure set_tts_vob(p_tt  tts_vob.tt%type,
                        p_vob tts_vob.vob%type,
                        p_ord tts_vob.ord%type);

  --Відкріплення виду документу від операції
  procedure remove_tts_vob(p_tt tts_vob.tt%type, p_vob tts_vob.vob%type);

  -- Привязка балансових рахунків до операції
  procedure set_ps_tts(p_tt   ps_tts.tt%type,
                       p_nbs  ps_tts.nbs%type,
                       p_dk   ps_tts.dk%type,
                       p_ob22 ps_tts.ob22%type);

  --Процедура відкріплення балансових рахунків від операцій
  procedure remove_ps_tts(p_tt   ps_tts.tt%type,
                          p_nbs  ps_tts.nbs%type,
                          p_dk   ps_tts.dk%type,
                          p_ob22 ps_tts.ob22%type);

  -- Процедура привязки звязаних операцій
  procedure set_ttsap(p_tt   ttsap.tt%type,
                      p_ttap ttsap.ttap%type,
                      p_dk   ttsap.dk%type);

  --Прицедуре відкріплення звязаних операцій
  procedure remove_ttsap(p_tt ttsap.tt%type, p_ttap ttsap.ttap%type);

  --Процедура додавання/зміни додаткових реквізитів
  procedure set_rules(p_tag  op_rules.tag%type,
                      p_tt   op_rules.tt%type,
                      p_opt  op_rules.opt%type,
                      p_used op_rules.used4input%type,
                      p_ord  op_rules.ord%type,
                      p_val  op_rules.val%type);

  --Процедуре відкріплення додаткового параметра
  procedure remove_rules(p_tt op_rules.tt%type, p_tag op_rules.tag%type);

  --Процедура створення/редагування операції
  procedure set_tt(p_tt    tts.tt%type,
                   p_name  tts.name%type,
                   p_dk    tts.dk%type default 1,
                   p_nlsm  tts.nlsm%type default null,
                   p_kv    tts.kv%type default null,
                   p_nlsk  tts.nlsk%type default null,
                   p_kvk   tts.kvk%type default null,
                   p_nlss  tts.nlss%type default null,
                   p_nlsa  tts.nlsa%type default null,
                   p_nlsb  tts.nlsb%type default null,
                   p_mfob  tts.mfob%type default null,
                   p_flc   tts.flc%type default null,
                   p_fli   tts.fli%type default null,
                   p_flv   tts.flv%type default null,
                   p_flr   tts.flr%type default null,
                   p_s     tts.s%type default null,
                   p_s2    tts.s2%type default null,
                   p_sk    tts.sk%type default null,
                   p_proc  tts.proc%type default null,
                   p_s3800 tts.s3800%type default null,
                   p_s6201 tts.s6201%type default 0,
                   p_s7201 tts.s7201%type default 0,
                   p_rang  tts.rang%type default null,
                   p_flags tts.flags%type default '0100000000000000000000000000000000000000000000000000000000000000',
                   p_nazn  tts.nazn%type default null);

  -- Функція для встановлення флага у вказану позицію
  procedure set_flag_on_index
  ( p_tt             in     varchar2,
    p_index          in     number,
    p_value          in     varchar2
  );

  -- Вигрузка операцій в SQL сценарій ---------

  bl BLOB;
  TYPE array IS VARRAY(30) OF VARCHAR2(1024);
  nFlIns NUMBER; -- Флаги вигрузки базових довідників
  bOB22  BOOLEAN := FALSE; -- флаг наявності об22

  PROCEDURE SG_ExportOpers(
  -- Description: Экспорт операций в BLOB
  strTT    VARCHAR2, --! Код операции
  nOptions NUMBER,   --! Опции экспорта
  --!    1 - Выдавать сообщения о несуществующих счетах или валютах
  --!    2 - Подменять T00
  --!    4 - Флаги
  --!    8 - Доп. реквизиты
  --!   16 - Включать связанные операции
  --!   32 - Бал. счета
  --!   64 - Группы контроля
  --!  128 - Виды документов
  --!  256 - Распределение по папкам
  --!  512 - Резерв
  --! 1024 - Резерв
  --! 2047 - Все!
  nBas     NUMBER --Добавлять в базовий справ
  );

---------------------------------------------------

end bars_ttsadm;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_TTSADM is

  -- Private constant declarations
  G_BODY_VERSION constant varchar2(32767) := 'version: 1.4  2016.11.10';
  CR             CONSTANT VARCHAR2(2) := CHR(13)||CHR(10);

  -- Фукція отримання версії заголовка пакету
  function header_version return varchar2 is
  begin
    return G_HEADER_VERSION;
  end;

  -- Фукція отримання версії тіла пакету
  function body_version return varchar2 is
  begin
    return 'Package body BARS_TTSADM ' || G_BODY_VERSION;
  end;

  --Прив'язка операції до папки
  procedure set_folder_tts(p_tt   folders_tts.tt%type,
                           p_idfo folders_tts.idfo%type) is
  begin
    INSERT INTO folders_tts (tt, idfo) VALUES (p_tt, p_idfo);
  exception
    when dup_val_on_index then
      null;
  end set_folder_tts;

  --Відкріплення папки від операції
  procedure remove_folder_tts(p_tt   folders_tts.tt%type,
                              p_idfo folders_tts.idfo%type) is
  begin
    delete from folders_tts f
     where f.tt = p_tt
       and f.idfo = p_idfo;
  end remove_folder_tts;

  -- Привязка груп контролю до операції(візи)
  procedure set_chklist_tts
  ( p_tt        in    chklist_tts.tt%type,
    p_idchk     in    chklist_tts.idchk%type,
    p_priority  in    chklist_tts.priority%type,
    p_sql       in    chklist_tts.sqlval%type,
    p_charge    in    chklist_tts.f_in_charge%type,
    p_respond   in    varchar2
  ) is

  begin

    begin

      update BARS.CHKLIST_TTS
         set priority    = p_priority,
             sqlval      = p_sql,
             f_in_charge = case p_charge
                             when 4 then
                              null
                             else
                              p_charge
                           end,
             flags       = NVL(bitand(flags, 14), 0) + p_respond
       where tt    = p_tt
         and idchk = p_idchk;

      if ( sql%rowcount = 0 )
      then
        INSERT INTO chklist_tts
          (tt, idchk, priority, sqlval, f_in_charge, flags)
        VALUES
          (p_tt,
           p_idchk,
           p_priority,
           p_sql,
           case p_charge when 4 then null else p_charge end,
           p_respond);
      end if;

    exception
      when DUP_VAL_ON_INDEX then
        if ( instr(sqlerrm,'UK_CHKLISTTTS') > 0 )
        then

          -- зсуваємо пріорітети існуючих віз
          update BARS.CHKLIST_TTS
             set PRIORITY = PRIORITY + 1
           where TT = p_tt
             and PRIORITY >= p_priority
          ;
          -- повторний виклик
          SET_CHKLIST_TTS
          ( p_tt       => p_tt
          , p_idchk    => p_idchk
          , p_priority => p_priority
          , p_sql      => p_sql
          , p_charge   => p_charge
          , p_respond  => p_respond
          );

        else
          null;
        end if;
    end;

  end set_chklist_tts;

  --Відкріплення груп контролю від операції
  procedure remove_chklist_tts(p_tt    chklist_tts.tt%type,
                               p_idchk chklist_tts.idchk%type) is
  begin
    DELETE FROM chklist_tts
     WHERE tt = p_tt
       AND idchk = p_idchk;
  end remove_chklist_tts;

  --Привязка видів документів до операції
  procedure set_tts_vob(p_tt  tts_vob.tt%type,
                        p_vob tts_vob.vob%type,
                        p_ord tts_vob.ord%type) is
  begin

    UPDATE tts_vob
       SET ord = p_ord
     WHERE tt = p_tt
       AND vob = p_vob;

    if sql%rowcount = 0 then
      INSERT INTO tts_vob (tt, vob, ord) VALUES (p_tt, p_vob, p_ord);
    end if;

  end set_tts_vob;

  --Відкріплення виду документу від операції
  procedure remove_tts_vob(p_tt tts_vob.tt%type, p_vob tts_vob.vob%type) is
  begin
    DELETE FROM tts_vob
     WHERE tt = p_tt
       AND vob = p_vob;
  end remove_tts_vob;

  -- Привязка балансових рахунків до операції
  procedure set_ps_tts(p_tt   ps_tts.tt%type,
                       p_nbs  ps_tts.nbs%type,
                       p_dk   ps_tts.dk%type,
                       p_ob22 ps_tts.ob22%type) is
  begin
    insert into ps_tts
      (tt, nbs, dk, ob22)
    values
      (p_tt, p_nbs, p_dk, p_ob22);
  exception
    when dup_val_on_index then
      raise_application_error(-20000,
                              'Такі дані вже існують!');
  end set_ps_tts;

  --Процедура відкріплення балансових рахунків від операцій
  procedure remove_ps_tts(p_tt   ps_tts.tt%type,
                          p_nbs  ps_tts.nbs%type,
                          p_dk   ps_tts.dk%type,
                          p_ob22 ps_tts.ob22%type) is
  begin
    delete from ps_tts
     where tt = p_tt
       and nbs = p_nbs
       and dk = p_dk
       and nvl(ob22,'0') = nvl(p_ob22, '0');
  end remove_ps_tts;

  -- Процедура привязки звязаних операцій
  procedure set_ttsap(p_tt   ttsap.tt%type,
                      p_ttap ttsap.ttap%type,
                      p_dk   ttsap.dk%type) is
  begin
    update ttsap
       set dk = p_dk
     where tt = p_tt
       and ttap = p_ttap;
    if sql%rowcount = 0 then
      insert into ttsap (ttap, tt, dk) values (p_ttap, p_tt, p_dk);
    end if;
  end set_ttsap;

  --Прицедуре відкріплення звязаних операцій
  procedure remove_ttsap(p_tt ttsap.tt%type, p_ttap ttsap.ttap%type) is
  begin
    delete from ttsap
     where tt = p_tt
       and ttap = p_ttap;
  end remove_ttsap;

  --Процедура додавання/зміни додаткових реквізитів
  procedure set_rules(p_tag  op_rules.tag%type,
                      p_tt   op_rules.tt%type,
                      p_opt  op_rules.opt%type,
                      p_used op_rules.used4input%type,
                      p_ord  op_rules.ord%type,
                      p_val  op_rules.val%type) is
  begin

    UPDATE op_rules
       SET opt = p_opt, used4input = p_used, ord = p_ord, val = p_val
     WHERE tt = p_tt
       AND tag = p_tag;
    if sql%rowcount = 0 then
      INSERT INTO op_rules
        (tag, tt, opt, used4input, ord, val)
      VALUES
        (p_tag, p_tt, p_opt, p_used, p_ord, p_val);
    end if;

  end set_rules;

  --Процедуре відкріплення додаткового параметра
  procedure remove_rules(p_tt op_rules.tt%type, p_tag op_rules.tag%type) is
  begin
    delete from op_rules
     where tt = p_tt
       AND tag = p_tag;
  end remove_rules;

  --Процедура створення/редагування операції
  procedure set_tt(p_tt    tts.tt%type,
                   p_name  tts.name%type,
                   p_dk    tts.dk%type default 1,
                   p_nlsm  tts.nlsm%type default null,
                   p_kv    tts.kv%type default null,
                   p_nlsk  tts.nlsk%type default null,
                   p_kvk   tts.kvk%type default null,
                   p_nlss  tts.nlss%type default null,
                   p_nlsa  tts.nlsa%type default null,
                   p_nlsb  tts.nlsb%type default null,
                   p_mfob  tts.mfob%type default null,
                   p_flc   tts.flc%type default null,
                   p_fli   tts.fli%type default null,
                   p_flv   tts.flv%type default null,
                   p_flr   tts.flr%type default null,
                   p_s     tts.s%type default null,
                   p_s2    tts.s2%type default null,
                   p_sk    tts.sk%type default null,
                   p_proc  tts.proc%type default null,
                   p_s3800 tts.s3800%type default null,
                   p_s6201 tts.s6201%type default 0,
                   p_s7201 tts.s7201%type default 0,
                   p_rang  tts.rang%type default null,
                   p_flags tts.flags%type default '0100000000000000000000000000000000000000000000000000000000000000',
                   p_nazn  tts.nazn%type default null) is
  begin
    update tts
       set name  = p_name,
           dk    = p_dk,
           nlsm  = p_nlsm,
           kv    = p_kv,
           nlsk  = p_nlsk,
           kvk   = p_kvk,
           nlss  = p_nlss,
           nlsa  = p_nlsa,
           nlsb  = p_nlsb,
           mfob  = p_mfob,
           flc   = p_flc,
           fli   = p_fli,
           flv   = p_flv,
           flr   = p_flr,
           s     = p_s,
           s2    = p_s2,
           sk    = p_sk,
           proc  = p_proc,
           s3800 = p_s3800,
           s6201 = p_s6201,
           s7201 = p_s7201,
           rang  = p_rang,
           flags = p_flags,
           nazn  = p_nazn
     where tt = p_tt;

    if ( sql%rowcount = 0 )
    then
      insert
        into BARS.TTS
           ( tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr
           , s, s2, sk, proc, s3800, s6201, s7201, rang, flags, nazn )
      values
           ( p_tt, p_name, p_dk, p_nlsm, p_kv, p_nlsk, p_kvk, p_nlss, p_nlsa, p_nlsb, p_mfob, p_flc, p_fli, p_flv, p_flr
           , p_s, p_s2, p_sk, p_proc, p_s3800, p_s6201, p_s7201, p_rang, p_flags, p_nazn );
    end if;

  end set_tt;

-- Функції SG - вигрузка операцій в SQL сценарій

  procedure ap( buff VARCHAR2)
  IS
  begin
    dbms_lob.append( bl, UTL_RAW.CAST_TO_RAW(buff) );
  end;

  -- Функція для встановлення флага у вказану позицію
  procedure set_flag_on_index
  ( p_tt             in     varchar2,
    p_index          in     number,
    p_value          in     varchar2
  ) is
  begin
    update BARS.TTS
       set FLAGS = substr( FLAGS, 1, p_index ) || p_value || substr( FLAGS, p_index + 2 )
     where TT = p_tt;
  end;

-- Description: Генерит заголовок

  FUNCTION SG_Header(
  txt_ VARCHAR2)
  RETURN VARCHAR2
  IS
  len_ CONSTANT NUMBER      := 32;
  sym_ CONSTANT VARCHAR2(1) := '-';
  BEGIN
     RETURN
     RPAD('-',len_,sym_) || CR ||
     RPAD(LPAD(txt_, (len_+LENGTH(txt_))/2, sym_), len_, sym_) || CR ||
     RPAD('-',len_,sym_) || CR;
  END SG_Header;

-- Description: Добавление отступа в строку

  FUNCTION SG_IndentedResult(
  strValue VARCHAR2, --           ! Строка, в которую добавляется отступ
  nIndent  NUMBER )  --           ! Отступ
  RETURN VARCHAR2
  IS
  Result VARCHAR2(32767);
  BEGIN
     Result := RPAD(' ', nIndent) ||
               REPLACE( strValue, CR, CR || RPAD(' ', nIndent) );
     RETURN SUBSTR(Result,1,LENGTH(Result)-nIndent);
  END SG_IndentedResult;

-- Description: Генерация выражения на вставку, и при ошибке на обновление

  FUNCTION SG_Insert(
  nMode           NUMBER,   --! Виды исключений
                            --!   0 - when DUP_VAL_ON_INDEX then null,
                            --!   1 - when DUP_VAL_ON_INDEX then update,
                            --!   2 - when DUP_VAL_ON_INDEX then null + ORA-02291:
  strTableName    VARCHAR2, --! Имя таблицы
  strColName      array,    --! Список колонок
  nColType        array,    --! Список типов колонок
  strColValue     array,    --! Строковые значения колонок
  strUpdCond      VARCHAR2) --! Условие для обновления

  RETURN VARCHAR2
  IS
  strColList           VARCHAR2(2048);
  strColValuesList     VARCHAR2(2048);
  strUpdates           VARCHAR2(2048);

  BEGIN

  FOR i IN strColName.FIRST..strColName.LAST LOOP

        If strColList IS NOT NULL THEN
           strColList := strColList || ', ';
           strColValuesList := strColValuesList || ', ';
           strUpdates       := strUpdates       || ', ' ;
        end if;
        strColList := strColList || strColName(i);

        If nColType(i) = 2 THEN
           strColValuesList := strColValuesList || NVL( strColValue(i),'null');
        Else
           strColValuesList := strColValuesList ||
           CASE WHEN strColValue(i) IS NULL THEN 'null' ELSE ''''||
             REPLACE(strColValue(i),'''','''''')||'''' END;
        end if;

        If nColType(i) = 2 THEN
           strUpdates := strUpdates || strColName(i) || '=' || NVL(strColValue(i), 'null');
        Else
           strUpdates := strUpdates || strColName(i) || '=' ||
           CASE WHEN strColValue(i) IS NULL THEN 'null' ELSE ''''||
             REPLACE(strColValue(i),'''','''''')||'''' END;
        end if;
  END LOOP;

  RETURN
  'begin'||CR||
  '  insert into ' || strTableName || '(' || strColList || ')' || CR ||
  '  values (' || strColValuesList || ');'||CR||
  'exception' || CR ||
  CASE WHEN nMode=0 or nMode=2 THEN
  '  when dup_val_on_index then null;'||CR ELSE '' END ||
  CASE WHEN nMode=1 THEN
  '  when dup_val_on_index then '||CR||
  '    update ' || strTableName ||CR||
  '       set ' || strUpdates || CR ||
  '     where ' || strUpdCond || ';' ||CR ELSE '' END ||
  CASE WHEN nMode=2 THEN
  '  when others then'|| CR ||
  '    if ( sqlcode = -02291 ) then'|| CR ||
  '      dbms_output.put_line(''Не удалось добавить запись ('|| strTableName
       || ': ' || REPLACE(strColValuesList, '''', '''''')
       || ') - первичный ключ не найден!'');'|| CR ||
  '    else raise;'|| CR ||
  '    end if;'|| CR ELSE '' END ||
  'end;' || CR;
  END SG_Insert;

-- Description: Экспорт основных свойств

  FUNCTION SG_ExportMainProps
  ( strTT VARCHAR2,   -- Код операции
   bErrors BOOLEAN,   -- Выдавать ошибки
   bT00    BOOLEAN)   -- Подменять T00
  RETURN VARCHAR2
  IS
  Result VARCHAR2(32767);

  strColName array := array(
    'tt','name','dk','nlsm','kv','nlsk','kvk','nlss','nlsa','nlsb','mfob',
    'flc','fli','flv','flr','s','s2','sk','proc','s3800','rang','flags','nazn');
  nColType   array := array(1,1,2,1,2,1,2,1,1,1,1,2,2,2,2,1,1,2,2,1,2,1,1);

  strColValue  array  := array(
  NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
  NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);


  BEGIN

     BEGIN
        SELECT TT,NAME,DK,NLSM,KV,NLSK,KVK,NLSS,NLSA,NLSB,MFOB,
               FLC,FLI,FLV,FLR,S,S2,SK,PROC,S3800,RANG,FLAGS,NAZN
          INTO strColValue(0+1),strColValue(1+1),strColValue(2+1),strColValue(3+1),
               strColValue(4+1),strColValue(5+1),strColValue(6+1),strColValue(7+1),
               strColValue(8+1),strColValue(9+1),strColValue(10+1),strColValue(11+1),
               strColValue(12+1),strColValue(13+1),strColValue(14+1),strColValue(15+1),
               strColValue(16+1),strColValue(17+1),strColValue(18+1),strColValue(19+1),
               strColValue(20+1),strColValue(21+1),strColValue(22+1)
          FROM TTS
         WHERE TT=strTT;
     END;

     Result := Result||SG_Insert(1,'tts',strColName,nColType,strColValue,'tt='''|| strTT ||'''');

     Return SG_IndentedResult(SG_Header(' Основные свойства операции ') || Result,2);

  END SG_ExportMainProps;

-- Description: Экспорт доп. реквизитов

  FUNCTION SG_ExportAuxs(
     strTT  VARCHAR2) -- ! Код операции
  RETURN VARCHAR2
  IS
  Result VARCHAR2(32767);

  strColName  array := array('tag','name','fmt','browser','nomodify','vspo_char','chkr');
  nColType    array := array(1,1,1,1,2,1,1);
  strColValue array := array(null,null,null,null,null,null,null);

  CURSOR o1 IS
  SELECT a.tag,a.name,a.fmt,a.browser,a.nomodify,a.vspo_char,a.chkr
    FROM op_field a, op_rules b
   WHERE a.tag=b.tag AND b.tt=strTT
     AND NOT REGEXP_LIKE(b.tag,'^[C|П]\d+\s+');

  CURSOR o2 IS
  SELECT tag,tt,opt,used4input,ord,val,nomodify
    FROM op_rules
   WHERE tt=strTT
   ORDER by CASE WHEN REGEXP_LIKE(tag,'^[C|П]\d*\s+') THEN 1 ELSE 0 END,tag;

  BEGIN

--! Метаописание OP_FIELD

     IF BITAND(nFlIns,8) = 8 THEN

        strColName  := array('tag','name','fmt','browser','nomodify','vspo_char','chkr');
        nColType    := array(1,1,1,1,2,1,1);

        OPEN o1;
        LOOP
        FETCH o1 INTO strColValue(0+1),strColValue(1+1),strColValue(2+1),strColValue(3+1),
                      strColValue(4+1),strColValue(5+1),strColValue(6+1);
        EXIT WHEN o1%NOTFOUND OR LENGTH(Result)>30000;
           Result := Result ||
                     SG_Insert(0,'op_field',strColName,nColType,strColValue,'');
        END LOOP;
     END IF;

--! Метаописание OP_RULES

     strColName := array('TAG','TT','OPT','USED4INPUT','ORD','VAL','NOMODIFY');
     nColType   := array(1,1,1,2,2,1,2);

     OPEN o2;
     LOOP
     FETCH o2  INTO strColValue(0+1),strColValue(1+1),strColValue(2+1),
                    strColValue(3+1),strColValue(4+1),strColValue(5+1),strColValue(6+1);
     EXIT WHEN o2%NOTFOUND OR LENGTH(Result)>30000;

        Result := Result ||
                  SG_Insert(2,'op_rules',strColName,nColType,strColValue,'');
     END LOOP;

     RETURN SG_IndentedResult(SG_Header(' Реквизиты ')
         || 'delete from op_rules where tt=''' || strTT || ''';' || CR || Result,2) ;
  END SG_ExportAuxs;

-- Description: Экспорт связей между операциями

  FUNCTION SG_ExportCmpxs(
     strTT  VARCHAR2) -- ! Код операции
  RETURN VARCHAR2
  IS
  Result VARCHAR2(32767); -- := '';

  strColName  array := array('ttap','tt','dk');
  nColType    array := array(1,1,2);
  strColValue array := array(null,null,null);

  CURSOR o IS
  SELECT ttap,tt,dk FROM ttsap WHERE tt=strTT;

  BEGIN

     OPEN o;
     LOOP
     FETCH o INTO strColValue(0+1),strColValue(1+1),strColValue(2+1);
     EXIT WHEN o%NOTFOUND;
     Result := Result ||
               SG_Insert(2,'ttsap',strColName,nColType,strColValue,'');
     END LOOP;

     RETURN SG_IndentedResult(SG_Header(' Связанные операции ')
         || 'delete from ttsap where tt=''' || strTT || ''';' || CR || Result,2);

  END SG_ExportCmpxs;

-- Description: Экспорт бал. счетов

  FUNCTION SG_ExportBals(
     strTT  VARCHAR2) -- ! Код операции
  RETURN VARCHAR2
  IS
  Result VARCHAR2(32767);

  strColName  array := array('nbs','tt','dk');
  nColType    array := array(1,1,2);
  strColValue array := array(null,null,null);
  o  SYS_REFCURSOR;

  BEGIN

--! Метаописание PS_TTS

     If bOB22 THEN
        strColName(3+1):='ob22';
        nColType(3+1):=1;
     end if;

     OPEN o FOR
    'SELECT nbs,tt,dk'|| CASE WHEN bOB22 THEN ',ob22 ' ELSE '' END ||
    '  FROM ps_tts WHERE tt=:1' USING strTT;
     LOOP
     if bOB22 then
        FETCH o INTO strColValue(0+1),strColValue(1+1),strColValue(2+1),strColValue(3+1);
     else
        FETCH o INTO strColValue(0+1),strColValue(1+1),strColValue(2+1);
     end if;
     EXIT WHEN o%NOTFOUND;
     Result := Result ||
               SG_Insert(2,'ps_tts',strColName,nColType,strColValue, '');
     END LOOP;

     RETURN SG_IndentedResult(SG_Header(' Балансовые счета ')
         || 'delete from ps_tts where tt=''' || strTT || ''';' || CR || Result,2);

  END SG_ExportBals;

-- Description: Экспорт Видов док-тов

  FUNCTION SG_ExportVobs(
     strTT  VARCHAR2) -- ! Код операции
  RETURN VARCHAR2
  IS
  Result VARCHAR2(32767);

  strColName  array;
  nColType    array;
  strColValue array := array(null,null,null,null);

  CURSOR o1 IS
  SELECT a.vob, a.name, a.flv, a.rep_prefix
    FROM vob a, tts_vob b
   WHERE a.vob=b.vob AND b.tt=strTT;

  CURSOR o2 IS
  SELECT vob, tt, ord FROM tts_VOB WHERE TT=strTT;

  BEGIN

--! Метаописание VOB

     If BITAND(nFlIns,128) = 128 THEN
        strColName  := array('VOB','NAME','FLV','REP_PREFIX');
        nColType    := array(2,1,2,1);
        OPEN o1;
        LOOP
        FETCH o1 INTO strColValue(0+1),strColValue(1+1),strColValue(2+1),strColValue(3+1);
        EXIT WHEN o1%NOTFOUND;
           Result := Result ||
                     SG_Insert(0,'vob',strColName,nColType,strColValue,'');
        END LOOP;
     END IF;

--! Метаописание TTS_VOB

     strColName := array('vob','tt','ord');
     nColType   := array(2,1,2);

     OPEN o2;
     LOOP
     FETCH o2  INTO strColValue(0+1),strColValue(1+1),strColValue(2+1);
     EXIT WHEN o2%NOTFOUND;
        Result := Result ||
                  SG_Insert(2,'tts_vob',strColName,nColType,strColValue,'');
     END LOOP;

     RETURN SG_IndentedResult(SG_Header(' Виды документов ')
         || 'delete from tts_vob where tt=''' || strTT || ''';' || CR || Result,2);

  END SG_ExportVobs;

-- Description: Экспорт групп визирования

  FUNCTION SG_ExportChks(
     strTT  VARCHAR2) -- ! Код операции
  RETURN VARCHAR2
  IS
  Result VARCHAR2(32767);

  strColName  array;
  nColType    array;
  strColValue array := array(null,null,null,null,null,null,null);

  CURSOR o1 IS
  SELECT a.idchk, a.name, a.comm
    FROM chklist a, chklist_tts b
   WHERE a.idchk=b.idchk AND b.tt=strTT;

  CURSOR o2 IS
  SELECT idchk, tt, priority, f_big_amount, sqlval, f_in_charge
    FROM chklist_tts
   WHERE tt=strTT;

  BEGIN

--! Метаописание OP_FIELD

     IF BITAND(nFlIns,64) = 64 THEN

        strColName  := array('idchk','name','comm');
        nColType    := array(2,1,1);

        OPEN o1;
        LOOP
        FETCH o1 INTO strColValue(0+1),strColValue(1+1),strColValue(2+1);
        EXIT WHEN o1%NOTFOUND;
           Result := Result ||
                     SG_Insert(0,'chklist',strColName,nColType,strColValue,'');
        END LOOP;
     END IF;

--! Метаописание CHKLIST_TTS

     strColName := array('idchk','tt','priority','f_big_amount','sqlval','f_in_charge');
     nColType   := array(2,1,2,2,1,2);

     OPEN o2;
     LOOP
     FETCH o2  INTO strColValue(0+1),strColValue(1+1),strColValue(2+1),
                    strColValue(3+1),strColValue(4+1),strColValue(5+1);
     EXIT WHEN o2%NOTFOUND;
        Result := Result ||
                  SG_Insert(2,'chklist_tts',strColName,nColType,strColValue,'');
     END LOOP;

     RETURN SG_IndentedResult(SG_Header(' Группы контроля ')
         || 'delete from chklist_tts where tt=''' || strTT || ''';' || CR || Result,2);

  END SG_ExportChks;

-- Description: Экспорт папок

  FUNCTION SG_ExportFlds(
     strTT  VARCHAR2) -- ! Код операции
  RETURN VARCHAR2
  IS
  Result VARCHAR2(32767);

  strColName  array;
  nColType    array;
  strColValue array := array(null,null,null,null,null,null,null);

  CURSOR o1 IS
  SELECT a.idfo, a.name
    FROM folders a, folders_tts b
   WHERE a.idfo=b.idfo AND b.tt=strTT;

  CURSOR o2 IS
  SELECT idfo, tt
    FROM folders_tts
   WHERE tt=strTT;

  BEGIN

--! Метаописание OP_FIELD

     IF BITAND(nFlIns,256) = 256 THEN

        strColName  := array('idfo','name');
        nColType    := array(2,1);

        OPEN o1;
        LOOP
        FETCH o1 INTO strColValue(0+1),strColValue(1+1);
        EXIT WHEN o1%NOTFOUND;
           Result := Result ||
                     SG_Insert(0,'folders',strColName,nColType,strColValue,'');
        END LOOP;
     END IF;

--! Метаописание CHKLIST_TTS

     strColName := array('idfo','tt');
     nColType   := array(2,1);

     OPEN o2;
     LOOP
     FETCH o2  INTO strColValue(0+1),strColValue(1+1);
     EXIT WHEN o2%NOTFOUND;
        Result := Result ||
                  SG_Insert(2,'folders_tts',strColName,nColType,strColValue,'');
     END LOOP;

     RETURN SG_IndentedResult(SG_Header(' Папки ')
         || 'delete from folders_tts where tt=''' || strTT || ''';' || CR || Result, 2);

  END SG_ExportFlds;

-- Description: Проверка опции

  FUNCTION SG_CheckOption(
  nOptions Number, --! Все опции
  nOption  Number) --! Проверяемая опция
  RETURN BOOLEAN
  IS
  BEGIN
     RETURN (BITAND(nOptions,nOption)=nOption);
  END SG_CheckOption;

-- Description: Выгрузка операции в строку

  PROCEDURE SG_OperToString (
  strTT   VARCHAR2, -- 	! Код операции
  strNAME VARCHAR2, --	! Наименование операции
  nOptions  NUMBER) --	! Опции экспорта
--!    1 - Выдавать сообщения о несуществующих счетах или валютах
--!    2 - Подменять T00
--!    4 - Флаги
--!    8 - Доп. реквизиты
--!   16 - Включать связанные операции
--!   32 - Бал. счета
--!   64 - Группы контроля
--!  128 - Виды документов
--!  256 - Распределение по папкам
--!  512 - Резерв
--! 1024 - Резерв
--! 2047 - Все!
--  RETURN VARCHAR2
  IS

  BEGIN

     ap('prompt Создание / Обновление операции ' || strTT ||CR);
     ap('prompt Наименование операции: ' || strNAME ||CR);
     ap('declare'||CR);
     ap('  cnt_  number;'||CR);
     ap('begin'||CR);

     ap(SG_ExportMainProps(
                    strTT,
                    SG_CheckOption(nOptions,1),
                    SG_CheckOption(nOptions,2)));
     If SG_CheckOption(nOptions,8) then
        ap(SG_ExportAuxs(strTT));
     End if;
     If SG_CheckOption(nOptions,16) then
        ap(SG_ExportCmpxs(strTT));
     End if;
     If SG_CheckOption(nOptions,32) then
        ap(SG_ExportBals(strTT));
     end if;
     If SG_CheckOption(nOptions,128) then
        ap(SG_ExportVobs(strTT));
     end if;
     If SG_CheckOption(nOptions,64) then
        ap(SG_ExportChks(strTT));
     end if;
     If SG_CheckOption(nOptions,256) then
        ap(SG_ExportFlds(strTT));
     end if;

     ap('end;'||CR||'/'||CR);

  END SG_OperToString;

-- Description: Экспорт операций в BLOB

  PROCEDURE SG_ExportOpers(
  strTT    VARCHAR2, --! Код операции
  nOptions NUMBER,   --! Опции экспорта
  nBas     NUMBER )  --! Добавлять в базовий справ
  IS

  BEGIN

     nFlIns:=nBas;

     dbms_lob.createtemporary(bl,FALSE);
     ap('set lines 1000'||CR||
        'set trimspool on'||CR||
        'set serveroutput on size 1000000'||CR||CR);


     If SG_CheckOption(nOptions,16) then  -- есть связанные

        FOR x IN (SELECT b.tt, b.name
                    FROM ttsap a, tts b
                   WHERE a.ttap=b.tt AND a.tt=strTT)
        LOOP
           SG_OperToString(x.tt,x.name,nOptions);
        END LOOP;

     END IF;

     FOR x IN (SELECT tt, name FROM tts WHERE tt=strTT)
     LOOP
        SG_OperToString(x.tt,x.name,nOptions);
     END LOOP;

     ap('commit;'||CR);

--   dbms_lob.freetemporary(bl);
  END SG_ExportOpers;

/* Тестування вигрузки в SQL сценарій
set serveroutput on size 1000000
begin
 for x in (select tt from tts order by tt)
 loop
   deb.trace(1,'tt=',x.tt);
   bars_ttsadm.SG_ExportOpers(x.tt,2047,0);
   delete from tmp_tt where tt=x.tt;
   INSERT INTO tmp_tt (tt,bl,len)
     values  (x.tt,bars_ttsadm.bl,DBMS_LOB.GETLENGTH(bars_ttsadm.bl));
   deb.trace(1,'tt='||x.tt,DBMS_LOB.GETLENGTH(bars_ttsadm.bl));
   dbms_lob.freetemporary(bars_ttsadm.bl);
 end loop;
end;
*/
begin
  -- Initialization
  null;
end bars_ttsadm;
/
 show err;
 
PROMPT *** Create  grants  BARS_TTSADM ***
grant EXECUTE                                                                on BARS_TTSADM     to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_ttsadm.sql =========*** End ***
 PROMPT ===================================================================================== 
 