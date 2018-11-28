prompt PACKAGE STO_ALL
create or replace package sto_all is
/*
    created 06-02-2012 Sta Регулярные платежи (STO)
*/

    G_HEADER_VERSION  CONSTANT VARCHAR2(64)  :=  ' version 2.2  01.10.2018';
    
    G_DET_STATUS_ACCEPTED constant pls_integer := 1;
    
    G_DET_STATUS_CANCELED constant pls_integer := -1;

    -- header_version - возвращает версию заголовка пакета STO_ALL
    function header_version return varchar2;
    -- body_version - возвращает версию тела пакета STO_ALL
    function body_version   return varchar2;

    PROCEDURE generate_stoschedules (p_stoid     IN sto_det.idd%TYPE,
                                     p_stodat0   IN sto_det.dat0%TYPE,
                                     p_stodat1   IN sto_det.dat1%TYPE,
                                     p_stodat2   IN sto_det.dat2%TYPE,
                                     p_stofreq   IN sto_det.freq%TYPE,
                                     p_stowend   IN sto_det.wend%TYPE,
                                     p_acceptdat IN sto_det.status_date%TYPE);

    PROCEDURE generate_stoschedules_reg (p_stoid     IN sto_det.idd%TYPE,
                                         p_stodat0   IN sto_det.dat0%TYPE,
                                         p_stodat1   IN sto_det.dat1%TYPE,
                                         p_stodat2   IN sto_det.dat2%TYPE,
                                         p_stofreq   IN sto_det.freq%TYPE,
                                         p_stowend   IN sto_det.wend%TYPE,
                                         p_tt        IN sto_det.tt%TYPE,
                                         p_acceptdat IN sto_det.status_date%TYPE);

    PROCEDURE setdefault_stodetails (p_ids    IN     sto_det.ids%TYPE,
                                     p_vob       OUT sto_det.vob%TYPE,
                                     p_dk        OUT sto_det.dk%TYPE,
                                     p_tt        OUT sto_det.tt%TYPE,
                                     p_nlsa      OUT sto_det.nlsa%TYPE,
                                     p_kva       OUT sto_det.kva%TYPE,
                                     p_nlsb      OUT sto_det.nlsb%TYPE,
                                     p_kvb       OUT sto_det.kvb%TYPE,
                                     p_mfob      OUT sto_det.mfob%TYPE,
                                     p_polu      OUT sto_det.polu%TYPE,
                                     p_nazn      OUT sto_det.nazn%TYPE,
                                     p_fsum      OUT sto_det.fsum%TYPE,
                                     p_okpo      OUT sto_det.okpo%TYPE,
                                     p_dat1      OUT sto_det.dat1%TYPE,
                                     p_dat2      OUT sto_det.dat2%TYPE,
                                     p_freq      OUT sto_det.freq%TYPE,
                                     p_dat0      OUT sto_det.dat0%TYPE,
                                     p_wend      OUT sto_det.wend%TYPE,
                                     p_ord       OUT sto_det.ord%TYPE);

    PROCEDURE validate_stodetails (p_ids      IN     sto_det.ids%TYPE,
                                   p_vob      IN     sto_det.vob%TYPE,
                                   p_dk       IN     sto_det.dk%TYPE,
                                   p_tt       IN     sto_det.tt%TYPE,
                                   p_nlsa     IN     sto_det.nlsa%TYPE,
                                   p_kva      IN     sto_det.kva%TYPE,
                                   p_nlsb     IN     sto_det.nlsb%TYPE,
                                   p_kvb      IN     sto_det.kvb%TYPE,
                                   p_mfob     IN     sto_det.mfob%TYPE,
                                   p_polu     IN     sto_det.polu%TYPE,
                                   p_nazn     IN     sto_det.nazn%TYPE,
                                   p_fsum     IN     sto_det.fsum%TYPE,
                                   p_okpo     IN     sto_det.okpo%TYPE,
                                   p_dat1     IN     sto_det.dat1%TYPE,
                                   p_dat2     IN     sto_det.dat2%TYPE,
                                   p_freq     IN     sto_det.freq%TYPE,
                                   p_dat0     IN     sto_det.dat0%TYPE,
                                   p_wend     IN     sto_det.wend%TYPE,
                                   p_ord      IN     sto_det.ord%TYPE,
                                   p_idd      IN     sto_det.idd%TYPE DEFAULT NULL,
                                   p_dr       IN     sto_det.dr%TYPE,
                                   p_errmsg      OUT VARCHAR2);

    -- Inna 06.02.2009

    /* Baa 29.09.2011
           додано перев_рку:
           для для випадку коли код ОКПО отримувача = 10 нулям,
           необх_дно буде вказати номер та сер_ю паспорта.
           Небх_дно:
           patchZ37.sql
    */
    PROCEDURE restore_stodate (p_ref IN oper.REF%TYPE);

    PROCEDURE add_det (IDS      IN sto_det.ids%TYPE,
                       ord      IN sto_det.ord%TYPE,
                       tt       IN sto_det.tt%TYPE,
                       vob      IN sto_det.vob%TYPE,
                       dk       IN sto_det.dk%TYPE,
                       nlsa     IN sto_det.nlsa%TYPE,
                       kva      IN sto_det.kva%TYPE,
                       nlsb     IN sto_det.nlsb%TYPE,
                       kvb      IN sto_det.kvb%TYPE,
                       mfob     IN sto_det.mfob%TYPE,
                       polu     IN sto_det.polu%TYPE,
                       nazn     IN sto_det.nazn%TYPE,
                       fsum     IN sto_det.fsum%TYPE,
                       okpo     IN sto_det.okpo%TYPE,
                       DAT1     IN sto_det.dat1%TYPE,
                       DAT2     IN sto_det.dat2%TYPE,
                       FREQ     IN sto_det.freq%TYPE,
                       DAT0     IN sto_det.dat0%TYPE,
                       WEND     IN sto_det.wend%TYPE,
                       DR       IN sto_det.dr%TYPE,
                       branch   IN sto_det.branch%TYPE,
                       idd      IN sto_det.idd%TYPE DEFAULT NULL);

    PROCEDURE Add_RegularTreaty (IDS             IN     sto_det.ids%TYPE DEFAULT NULL,
                                 ord             IN     sto_det.ord%TYPE,
                                 tt              IN     sto_det.tt%TYPE,
                                 vob             IN     sto_det.vob%TYPE,
                                 dk              IN     sto_det.dk%TYPE,
                                 nlsa            IN     sto_det.nlsa%TYPE,
                                 kva             IN     sto_det.kva%TYPE,
                                 nlsb            IN     sto_det.nlsb%TYPE,
                                 kvb             IN     sto_det.kvb%TYPE,
                                 mfob            IN     sto_det.mfob%TYPE,
                                 polu            IN     sto_det.polu%TYPE,
                                 nazn            IN     sto_det.nazn%TYPE,
                                 fsum            IN     sto_det.fsum%TYPE,
                                 okpo            IN     sto_det.okpo%TYPE,
                                 DAT1            IN     sto_det.dat1%TYPE,
                                 DAT2            IN     sto_det.dat2%TYPE,
                                 FREQ            IN     sto_det.freq%TYPE,
                                 DAT0            IN     sto_det.dat0%TYPE,
                                 WEND            IN     sto_det.wend%TYPE,
                                 DR              IN     sto_det.dr%TYPE,
                                 branch          IN     sto_det.branch%TYPE,
                                 p_nd            IN     cc_deal.nd%TYPE,
                                 p_sdate         IN     cc_deal.sdate%TYPE,
                                 p_idd              OUT sto_det.idd%TYPE,
                                 p_status           OUT NUMBER,
                                 p_status_text      OUT VARCHAR2);

    PROCEDURE del_RegularTreaty (p_agr_id IN NUMBER);

    --
    -- Удаление / закрытие макета регулярного платежа
    --
    procedure remove_det (p_idd in sto_det.idd%type);

    --
    -- Создание нового договора на регулярные платежи
    --
    procedure set_lst (p_ids  out    sto_lst.ids%type, -- null (out) - создание
                       p_idg  in     sto_lst.idg%type,
                       p_rnk  in     sto_lst.rnk%type,
                       p_name in     sto_lst.name%type,
                       p_sdat in     sto_lst.sdat%type);
                       
    --
    -- Обновление договора на рег. платежи
    --
    procedure update_lst ( p_ids  in     sto_lst.ids%type,
                           p_idg  in     sto_lst.idg%type,
                           p_rnk  in     sto_lst.rnk%type,
                           p_name in     sto_lst.name%type,
                           p_sdat in     sto_lst.sdat%type);

    --
    -- Удаление договора на рег. платежи - или закрытие, если по нему уже были порождены документы
    --
    procedure remove_lst (p_ids       in  sto_lst.ids%type,
                          p_resultMsg out varchar2);
    
    -- Редактирование предустановленных допреквизитов макета платежа (создание, обновление, удаление при пустом value)
    procedure add_operw (p_idd      IN    STO_operw.IDD%type,
                         p_tag      IN    STO_operw.TAG%type,
                         p_value    IN    STO_operw.VALUE%type);

    --
    -- Подтвердить / отклонить макет платежа
    --
    procedure claim_idd (p_IDD          in     sto_det.idd%type,
                         p_statusid     in     sto_det.status_id%type,  -- статус (1 - подтвержден, -1 - отклонен)
                         p_disclaimid   in     sto_det.disclaim_id%type,-- причина отклонения (если статус -1)
                         p_status       out    int,                     -- статус выполнения (1 - ОК, -1 - ошибка)
                         p_resultMsg    out    varchar2);               -- результирующее сообщение
    --
    -- Подтвердить / отклонить макет платежа (бросает ошибку вместо статуса)
    --
    procedure claim_idd (p_IDD          in     sto_det.idd%type,
                         p_statusid     in     sto_det.status_id%type,   -- статус (1 - подтвержден, -1 - отклонен)
                         p_disclaimid   in     sto_det.disclaim_id%type);-- причина отклонения (если статус -1)

    /*todo: rewrite*/
    function get_AvaliableNPP(p_IDS in number) RETURN number;

    --
    -- Оплата документов - "Виконання регулярних платежів"
    --
    procedure pay_docs(p_idd in sto_det.idd%type,
                       p_dat in date);
    
    --
    -- Проверить формулу суммы; Возвращает текст ошибки или null (если формула корректна)
    --
    function check_fsumFunction(fSum in varchar2, 
                                kva  in int, 
                                kvb  in int, 
                                nlsa in varchar2, 
                                nlsb in varchar2, 
                                tt   in varchar2)
    return varchar2;
    
    --
    -- Формула суммы платежа
    --
    function fsumFunction(fSum        in varchar2, 
                          KVA         in int, 
                          KVB         in int, 
                          NLSA        in varchar2, 
                          NLSB        in varchar2, 
                          tt          in varchar2,
                          raise_error in number default 0)
    return number;


END STO_ALL;
/
create or replace package body sto_all is
/*
    06-02-2012 Sta Регулярные платежи.
    Разрозненные процедуры собраны в один пакедж.
*/
--------------------------------------------------------------
    
    G_BODY_VERSION  CONSTANT VARCHAR2(64)  :=  ' version 2.2  01.10.2018';

    -- header_version - возвращает версию заголовка пакета STO_ALL
    function header_version
    return varchar2
    is
    begin
       return 'Package header '|| $$PLSQL_UNIT || G_HEADER_VERSION;
    end header_version;

    -- body_version - возвращает версию тела пакета STO_ALL
    function body_version
       return varchar2
    is
    begin
       return 'Package body '|| $$PLSQL_UNIT || G_BODY_VERSION;
    end body_version;

    --06-02-2012 Sta Дополнительные сопутствующие действия при оплате 1 детали рег пл.
    PROCEDURE opl1 (p_idd IN sto_det.idd%TYPE, p_Ref IN oper.REF%TYPE)
    IS
      l_br3         sto_det.branch%type;
      l_oper_exists pls_integer;
    begin
        -- проверка на наличие порожденного платежа (т.е. ненулевая сумма, в противном случае сохраняем только референс)
        select case when exists 
                        (select 1 from oper where ref = p_ref) 
                    then 1 
                    else 0 end
        into l_oper_exists
        from dual;
        --отметка о последней дате выполнения
        update sto_det  
        set dat0 = gl.BDATE 
        where idd = p_idd;

        -- референс выполнения платежа в данную дату
        update sto_dat  
        set ref  = p_ref    
        where idd = p_idd AND dat = gl.bdate;
        
        if l_oper_exists = 1 then
            -- реквизит для бюджетирования дох/рас (прежде всего, неоперационных)
            select branch into l_br3 from sto_det where idd = p_idd;
            if l_br3 is not null then
                UPDATE opldok set txt = l_br3 where ref = p_ref;
            end if;

            -- доп.реквизиты платежа. предусмотренные настройками данного рег.платежа
            merge into operw OW
            using (select kf, idd, tag, value from sto_operw where idd = p_idd) SW 
            on (OW.ref = p_ref and OW.tag = SW.tag)
            when matched then 
                UPDATE
                set value = SW.value
            when not matched then 
                INSERT
                (ref, tag, value, kf)
                values
                (p_ref, SW.tag, SW.value, SW.kf);
        end if;
    end opl1;

    --------------------------------------------------------------------
    PROCEDURE generate_stoschedules (p_stoid     IN sto_det.idd%TYPE,
                                     p_stodat0   IN sto_det.dat0%TYPE,
                                     p_stodat1   IN sto_det.dat1%TYPE,
                                     p_stodat2   IN sto_det.dat2%TYPE,
                                     p_stofreq   IN sto_det.freq%TYPE,
                                     p_stowend   IN sto_det.wend%TYPE,
                                     p_acceptdat IN sto_det.status_date%TYPE)
    --Inna 17.11.2008
    IS
       title         CONSTANT VARCHAR2 (60) := 'genstoschedule:';
       basecur       CONSTANT tabval.kv%TYPE := gl.baseval;
       bankdat       CONSTANT fdat.fdat%TYPE := gl.bdate;
       l_startdat             DATE;
       l_stopdat              DATE;
       l_nextdat              DATE;
       l_tempdat              DATE;
       l_nd                   NUMBER;
       l_sdate                DATE;
       l_cc_id                VARCHAR2 (50);
       l_CCdat                DATE;
       l_accepted_startdate   DATE;
      ----------------
        FUNCTION get_bd (p_date IN DATE, p_delta IN NUMBER)
           RETURN DATE
        IS
           l_bd   DATE;
        BEGIN
           SELECT dat_next_u (holiday, p_delta)
             INTO l_bd
             FROM holiday
            WHERE kv = basecur AND holiday = p_date;

           RETURN l_bd;
        EXCEPTION
           WHEN NO_DATA_FOUND
           THEN
              RETURN p_date;
        END get_bd;
    begin
      bars_audit.trace('%s idd = %s, (dat0, dat1, dat2, freq, wend,p_acceptdat) = (%s, %s, %s, %s, %s, %s)',
                       title,
                       to_char(p_stoid),
                       to_char(p_stodat0,'dd/mm/yyy'),
                       to_char(p_stodat1,'dd/mm/yyyy'),
                       to_char(p_stodat2,'dd/mm/yyyy'),
                       to_char(p_stofreq),
                       to_char(p_stowend),
                       to_char(p_acceptdat,'dd/mm/yyyy'));
      l_accepted_startdate :=  p_acceptdat;
      l_startdat := greatest(p_stodat1, nvl(p_stodat0, bankdat - 1), bankdat, l_accepted_startdate);
      l_stopdat  := p_stodat2;
      bars_audit.trace('%s (start, stop) = (%s, %s)', title,
                                                      to_char(l_startdat,'dd/mm/yy'),
                                                      to_char(l_stopdat, 'dd/mm/yy'));
      if l_startdat < l_stopdat then
         -- очистка календаря перечислений
         delete from sto_dat where idd = p_stoid and dat >= l_startdat;

         -- занесение первой даты
         if p_stodat1 >= l_startdat then
            l_tempdat := get_bd (p_stodat1, sign(p_stowend));
            if (l_tempdat between l_startdat and l_stopdat) then
              begin
                insert into sto_dat(idd, dat) values (p_stoid, l_tempdat);
                bars_audit.trace('%s 1st date is %s', title,  to_char(l_tempdat,'dd/mm/yy'));
              exception
                when dup_val_on_index then null;
              end;
            end if;
         end if;

         if p_stofreq in (1, 3, 4, 5, 7, 180, 360) then

            l_nextdat := greatest(p_stodat1,l_accepted_startdate);

            while l_nextdat <= l_stopdat loop
                 if p_stofreq =   1 then  l_nextdat := l_nextdat + 1;
              elsif p_stofreq =   3 then  l_nextdat := l_nextdat + 7;
              elsif p_stofreq =   4 then  l_nextdat := l_nextdat + 14;
              elsif p_stofreq =   5 then  l_nextdat := add_months(l_nextdat, 1) ;
              elsif p_stofreq =   7 then  l_nextdat := add_months(l_nextdat, 3) ;
              elsif p_stofreq = 180 then  l_nextdat := add_months(l_nextdat, 6) ;
              elsif p_stofreq = 360 then  l_nextdat := add_months(l_nextdat,12) ;
              end if;

              l_tempdat := get_bd (l_nextdat, sign(p_stowend));

              bars_audit.trace('%s next date = %s -> %s', title,
                                                          to_char(l_nextdat,'dd/mm/yy'),
                                                          to_char(l_tempdat,'dd/mm/yy'));

              if (l_tempdat between l_startdat and l_stopdat)
              then
                 begin
                   insert into sto_dat(idd, dat) values (p_stoid, l_tempdat);
                 exception when dup_val_on_index then null;
                 end;
              end if;
            end loop;
         end if;

        if  p_stofreq = 2-- and l_idg in (6,12)
        then
              begin
                SELECT VALUE
                  INTO l_nd
                  FROM sto_operw
                 WHERE idd = p_stoid AND tag = 'TREAT';

                SELECT cc_id, sdate
                  INTO l_cc_id, l_sdate
                  FROM cc_deal
                 WHERE nd = l_nd;

               l_CCdat :=  dat_next_u(F_GET_DATE_CCK(l_cc_id, l_sdate),-1);

             exception when no_data_found
                       then l_CCdat := null;
             end;
              bars_audit.trace('%s next date = %s -> %s', title,
                                                          to_char(l_nextdat,'dd/mm/yy'),
                                                          to_char(l_tempdat,'dd/mm/yy'));
              if (l_CCdat between l_startdat and l_stopdat) then
                 begin
                   insert into sto_dat(idd, dat) values (p_stoid, l_CCdat);
                 exception
                   when dup_val_on_index
                   then null;
                 end;
              end if;
        end if;
      end if;
    end generate_stoschedules;
    --------------------------
    PROCEDURE generate_stoschedules_reg (p_stoid     IN sto_det.idd%TYPE,
                                         p_stodat0   IN sto_det.dat0%TYPE,
                                         p_stodat1   IN sto_det.dat1%TYPE,
                                         p_stodat2   IN sto_det.dat2%TYPE,
                                         p_stofreq   IN sto_det.freq%TYPE,
                                         p_stowend   IN sto_det.wend%TYPE,
                                         p_tt        IN sto_det.tt%TYPE,
                                         p_acceptdat IN sto_det.status_date%TYPE)
    IS
       title         CONSTANT VARCHAR2 (60) := 'regular.genstoschedule:';
       basecur       CONSTANT tabval.kv%TYPE := gl.baseval;
       bankdat       CONSTANT fdat.fdat%TYPE := gl.bdate;
       l_startdat             DATE;
       l_stopdat              DATE;
       l_nextdat              DATE;
       l_tempdat              DATE;
       l_nd                   NUMBER;
       l_sdate                DATE;
       l_cc_id                VARCHAR2 (50);
       l_CCdat                DATE;
       l_accepted_startdate   DATE;

       ----------------
       FUNCTION get_bd (p_date IN DATE, p_delta IN NUMBER)
          RETURN DATE
       IS
          l_bd   DATE;
       BEGIN
          SELECT dat_next_u (holiday, p_delta)
            INTO l_bd
            FROM holiday
           WHERE kv = basecur
             AND holiday = p_date;

          RETURN l_bd;
       EXCEPTION
          WHEN NO_DATA_FOUND
          THEN RETURN p_date;
       END get_bd;
    BEGIN
      bars_audit.trace('%s idd = %s, (dat0, dat1, dat2, freq, wend,p_acceptdat) = (%s, %s, %s, %s, %s, %s)',
                       title,
                       to_char(p_stoid),
                       to_char(p_stodat0,'dd/mm/yyy'),
                       to_char(p_stodat1,'dd/mm/yyyy'),
                       to_char(p_stodat2,'dd/mm/yyyy'),
                       to_char(p_stofreq),
                       to_char(p_stowend),
                       to_char(p_acceptdat,'dd/mm/yyyy'));
       l_accepted_startdate :=  p_acceptdat;

       l_startdat := GREATEST(p_stodat1, nvl(p_stodat0, bankdat - 1), bankdat, l_accepted_startdate);
       l_stopdat := p_stodat2;
       bars_audit.trace ('%s (start, stop) = (%s, %s)',
                         title,
                         TO_CHAR (l_startdat, 'dd/mm/yy'),
                         TO_CHAR (l_stopdat, 'dd/mm/yy'));

       IF l_startdat < l_stopdat
       THEN
          -- очистка календаря перечислений
          DELETE FROM sto_dat
                WHERE idd = p_stoid AND dat >= l_startdat;

          IF p_stofreq IN (1, 3, 4, 5, 7, 180, 360)
          THEN
             -- занесение первой даты
             IF p_stodat1 >= l_startdat
             THEN
                l_tempdat := get_bd (p_stodat1, 1/*SIGN (p_stowend)*/); --COBUSUPABS-3433 Первая дата всегда p_stowend = +1

                IF (l_tempdat BETWEEN l_startdat AND l_stopdat)
                THEN
                   BEGIN
                      INSERT INTO sto_dat (idd, dat)
                           VALUES (p_stoid, l_tempdat);

                      bars_audit.trace ('%s 1st date is %s',
                                        title,
                                        TO_CHAR (l_tempdat, 'dd/mm/yy'));
                   EXCEPTION
                      WHEN DUP_VAL_ON_INDEX
                      THEN NULL;
                   END;
                END IF;
             END IF;

             l_nextdat := greatest(p_stodat1,l_accepted_startdate);

             WHILE l_nextdat <= l_stopdat
             LOOP
                IF p_stofreq = 1
                THEN
                   l_nextdat := l_nextdat + 1;
                ELSIF p_stofreq = 3
                THEN
                   l_nextdat := l_nextdat + 7;
                ELSIF p_stofreq = 4
                THEN
                   l_nextdat := l_nextdat + 14;
                ELSIF p_stofreq = 5
                THEN
                   l_nextdat := ADD_MONTHS (l_nextdat, 1);
                ELSIF p_stofreq = 7
                THEN
                   l_nextdat := ADD_MONTHS (l_nextdat, 3);
                ELSIF p_stofreq = 180
                THEN
                   l_nextdat := ADD_MONTHS (l_nextdat, 6);
                ELSIF p_stofreq = 360
                THEN
                   l_nextdat := ADD_MONTHS (l_nextdat, 12);
                END IF;

                l_tempdat := get_bd (l_nextdat, SIGN (p_stowend));

                bars_audit.trace ('%s next date = %s -> %s',
                                  title,
                                  TO_CHAR (l_nextdat, 'dd/mm/yy'),
                                  TO_CHAR (l_tempdat, 'dd/mm/yy'));

                IF (l_tempdat BETWEEN l_startdat AND l_stopdat)
                THEN
                   BEGIN
                      INSERT INTO sto_dat (idd, dat)
                           VALUES (p_stoid, l_tempdat);
                   EXCEPTION
                      WHEN DUP_VAL_ON_INDEX
                      THEN NULL;
                   END;
                END IF;
             END LOOP;
          END IF;
            -- and l_idg in (6,12)
          IF p_stofreq = 2
          THEN
             BEGIN
               begin
                SELECT VALUE
                  INTO l_nd
                  FROM sto_operw
                 WHERE idd = p_stoid AND tag = 'TREAT';
               exception when others then bars_audit.error(title||' err tag = TREAT'|| sqlerrm); return;
               end;

               begin
                SELECT cc_id, sdate
                  INTO l_cc_id, l_sdate
                  FROM cc_deal
                 WHERE nd = l_nd;
               exception when others then bars_audit.error(title||' err INTO l_cc_id, l_sdate'|| sqlerrm); return;
               end;

                 bars_audit.trace ('%s idd = %s, ND = %s, cc_id = %s',
                        title,
                        TO_CHAR (p_stoid),
                        TO_CHAR (l_nd),
                        TO_CHAR (l_cc_id));

                BEGIN
                   l_CCdat := F_GET_DATE_CCK (l_cc_id, l_sdate);
                EXCEPTION
                   WHEN OTHERS
                   THEN
                      l_CCdat := NULL;
                      bars_audit.error (title||': Для idd = '||TO_CHAR (p_stoid)||' дата следующего платежа не определена (КД не найден)');
                END;

                IF (l_CCdat IS NOT NULL)
                THEN
                    l_CCdat := dat_next_u(l_CCdat,-1);
                END IF;
             END;

             IF (l_CCdat IS NOT NULL)
             THEN
             bars_audit.trace ('%s next date = %s',
                               title,
                               TO_CHAR (l_CCdat, 'dd/mm/yy'));
             END IF;

             IF (l_CCdat BETWEEN l_startdat AND l_stopdat)
             THEN
                BEGIN
                   INSERT INTO sto_dat (idd, dat, kf)
                        VALUES (p_stoid, greatest(l_CCdat,l_accepted_startdate), sys_context('bars_context', 'user_mfo'));
                EXCEPTION
                   WHEN DUP_VAL_ON_INDEX
                   THEN bars_audit.error (title||' Для idd = '||TO_CHAR ( greatest(l_CCdat,l_accepted_startdate), 'dd/mm/yy')||' и next date = '||TO_CHAR (p_stoid)||' график уже установлен');
                END;
             END IF;
          END IF;
       END IF;
    END generate_stoschedules_reg;

    PROCEDURE setdefault_stodetails (p_ids    IN     sto_det.ids%TYPE,
                                     p_vob       OUT sto_det.vob%TYPE,
                                     p_dk        OUT sto_det.dk%TYPE,
                                     p_tt        OUT sto_det.tt%TYPE,
                                     p_nlsa      OUT sto_det.nlsa%TYPE,
                                     p_kva       OUT sto_det.kva%TYPE,
                                     p_nlsb      OUT sto_det.nlsb%TYPE,
                                     p_kvb       OUT sto_det.kvb%TYPE,
                                     p_mfob      OUT sto_det.mfob%TYPE,
                                     p_polu      OUT sto_det.polu%TYPE,
                                     p_nazn      OUT sto_det.nazn%TYPE,
                                     p_fsum      OUT sto_det.fsum%TYPE,
                                     p_okpo      OUT sto_det.okpo%TYPE,
                                     p_dat1      OUT sto_det.dat1%TYPE,
                                     p_dat2      OUT sto_det.dat2%TYPE,
                                     p_freq      OUT sto_det.freq%TYPE,
                                     p_dat0      OUT sto_det.dat0%TYPE,
                                     p_wend      OUT sto_det.wend%TYPE,
                                     p_ord       OUT sto_det.ord%TYPE)
    IS
       --Inna 22.04.2010
       -- коммерческий банк
       modcode   CHAR (3) := 'STO';
    BEGIN
       p_wend := 1;
       p_vob := 1;
       p_dk := 1;
       p_dat1 := gl.bdate;
       p_kva := gl.baseval;
       p_kvb := gl.baseval;
    END setdefault_stodetails;
    -------------------------
    PROCEDURE validate_stodetails (p_ids      IN     sto_det.ids%TYPE,
                                   p_vob      IN     sto_det.vob%TYPE,
                                   p_dk       IN     sto_det.dk%TYPE,
                                   p_tt       IN     sto_det.tt%TYPE,
                                   p_nlsa     IN     sto_det.nlsa%TYPE,
                                   p_kva      IN     sto_det.kva%TYPE,
                                   p_nlsb     IN     sto_det.nlsb%TYPE,
                                   p_kvb      IN     sto_det.kvb%TYPE,
                                   p_mfob     IN     sto_det.mfob%TYPE,
                                   p_polu     IN     sto_det.polu%TYPE,
                                   p_nazn     IN     sto_det.nazn%TYPE,
                                   p_fsum     IN     sto_det.fsum%TYPE,
                                   p_okpo     IN     sto_det.okpo%TYPE,
                                   p_dat1     IN     sto_det.dat1%TYPE,
                                   p_dat2     IN     sto_det.dat2%TYPE,
                                   p_freq     IN     sto_det.freq%TYPE,
                                   p_dat0     IN     sto_det.dat0%TYPE,
                                   p_wend     IN     sto_det.wend%TYPE,
                                   p_ord      IN     sto_det.ord%TYPE,
                                   p_idd      IN     sto_det.idd%TYPE DEFAULT NULL,
                                   p_dr       IN     sto_det.dr%TYPE,
                                   p_errmsg      OUT VARCHAR2)
    IS
      -- Inna 06.02.2009
      -- Baa 29.09.2011
      -- коммерческий банк
      modcode  char(3)        := 'STO';
      l_errmsg varchar2(4000) := null;
      l_cnt    number(38);
      l_dazs   accounts.dazs%type;
      l_tip    accounts.tip%type;
      l_rnk    accounts.rnk%type;
      ------------------------------
      procedure set_errmsg
        (p_field   in     varchar2,
         p_errtype in     varchar2,
         p_errmsg  in out varchar2)
      is
      begin
         p_errmsg := p_errmsg ||' - '|| bars_msg.get_msg(modcode, p_errtype)
                              ||' <' || bars_msg.get_msg(modcode, p_field)
                              || '> '|| chr(10);
      end set_errmsg;
      ------------------------------
    begin

      if p_ids is null then
         set_errmsg ('COLNAME_STODET.IDS', 'IS_NULL', l_errmsg);
      else
         select count(*) into l_cnt from sto_lst where ids = p_ids;
         if l_cnt = 0 then
            set_errmsg ('COLNAME_STODET.IDS', 'INVALID', l_errmsg);
         end if;
      end if;

      if p_ord is null then
         set_errmsg ('COLNAME_STODET.ORD', 'IS_NULL', l_errmsg);
      else
         select count(*) into l_cnt from conductor where num = p_ord;
         if l_cnt = 0 then
            set_errmsg ('COLNAME_STODET.ORD', 'INVALID', l_errmsg);
         end if;
      end if;

      if (p_ids is not null and p_ord is not null) then
         select count(*) into l_cnt from sto_det
          where ids = p_ids and ord = p_ord and idd != nvl(p_idd, -1);
         if l_cnt > 0 then
            set_errmsg ('COLNAME_STODET.ORD', 'DUPLICATE', l_errmsg);
         end if;
      end if;

      if p_freq is null then
         set_errmsg ('COLNAME_STODET.FREQ', 'IS_NULL', l_errmsg);
      else
         select count(*) into l_cnt from freq where freq = p_freq;
         if l_cnt = 0 then
            set_errmsg ('COLNAME_STODET.FREQ', 'INVALID', l_errmsg);
         end if;
      end if;

      if p_dat1 is null then
         set_errmsg ('COLNAME_STODET.DAT1', 'IS_NULL', l_errmsg);
      else
         select count(*) into l_cnt from holiday where holiday = p_dat1 and kv = gl.baseval;
         if l_cnt > 0 then
            set_errmsg ('COLNAME_STODET.DAT1', 'IS_WEEKEND', l_errmsg);
         end if;
      end if;

      if p_dat2 is null then
         set_errmsg ('COLNAME_STODET.DAT2', 'IS_NULL', l_errmsg);
      end if;

      if p_dat1 > p_dat2 then
         set_errmsg ('COLNAME_STODET.DAT2', 'DATES_MISMATCH', l_errmsg);
      end if;

      if p_wend is null then
         set_errmsg ('COLNAME_STODET.WEND', 'IS_NULL', l_errmsg);
      else
         if p_wend not in (-1, 1) then
            set_errmsg ('COLNAME_STODET.WEND', 'INVALID', l_errmsg);
         end if;
      end if;

      if p_tt is null then
         set_errmsg ('COLNAME_STODET.TT', 'IS_NULL', l_errmsg);
      else
         select count(*) into l_cnt from tts where tt = p_tt;
         if l_cnt = 0 then
            set_errmsg ('COLNAME_STODET.TT', 'INVALID', l_errmsg);
         end if;
      end if;

      if p_vob is null then
         set_errmsg ('COLNAME_STODET.VOB', 'IS_NULL', l_errmsg);
      else
         select count(*) into l_cnt from vob where vob = p_vob;
         if l_cnt = 0 then
            set_errmsg ('COLNAME_STODET.VOB', 'INVALID', l_errmsg);
         end if;
      end if;

      if p_dk is null then
         set_errmsg ('COLNAME_STODET.DK', 'IS_NULL', l_errmsg);
      else
         select count(*) into l_cnt from dk where dk = p_dk;
         if l_cnt = 0 then
            set_errmsg ('COLNAME_STODET.DK', 'INVALID', l_errmsg);
         end if;
      end if;

      if p_kva is null then
         set_errmsg ('COLNAME_STODET.KVA', 'IS_NULL', l_errmsg);
      else
         select count(*) into l_cnt from tabval where kv = p_kva;
         if l_cnt = 0 then
            set_errmsg ('COLNAME_STODET.KVA', 'INVALID', l_errmsg);
         end if;
      end if;

      if p_nlsa is null then
         set_errmsg ('COLNAME_STODET.NLSA', 'IS_NULL', l_errmsg);
      end if;

      if (p_nlsa is not null and p_kva is not null) then
         begin
           select dazs, tip, rnk
             into l_dazs, l_tip, l_rnk
             from accounts
            where nls = p_nlsa and kv = p_kva;
         exception
           when no_data_found then
             l_dazs := null; l_tip := null; l_rnk := null;
         end;
         if l_tip is null then
            set_errmsg ('COLNAME_STODET.NLSA', 'NOT_FOUND', l_errmsg);
         elsif l_dazs is not null then
            set_errmsg ('COLNAME_STODET.NLSA', 'IS_CLOSED', l_errmsg);
         else
            begin
              select rnk into l_rnk from sto_lst where ids = p_ids and rnk = l_rnk;
            exception
              when no_data_found then
                set_errmsg ('COLNAME_STODET.NLSA', 'OWNER_DISMATCH', l_errmsg);
            end;
         end if;
      end if;

      if p_mfob is null then
         set_errmsg ('COLNAME_STODET.MFOB', 'IS_NULL', l_errmsg);
      else
         begin
           select blk into l_cnt from banks where mfo = p_mfob;
           if l_cnt != 0 then
              set_errmsg ('COLNAME_STODET.MFOB', 'BANK_IS_CLOSED', l_errmsg);
           end if;
         exception
           when no_data_found then
             set_errmsg ('COLNAME_STODET.MFOB', 'INVALID', l_errmsg);
         end;
      end if;

      if p_kvb is null then
         set_errmsg ('COLNAME_STODET.KVB', 'IS_NULL', l_errmsg);
      else
         select count(*) into l_cnt from tabval where kv = p_kvb;
         if l_cnt = 0 then
            set_errmsg ('COLNAME_STODET.KVB', 'INVALID', l_errmsg);
         end if;
      end if;

      if p_nlsb is null then
         set_errmsg ('COLNAME_STODET.NLSB', 'IS_NULL', l_errmsg);
      end if;

      if (p_mfob = gl.amfo and p_nlsb is not null and p_kvb is not null) then
         begin
           select dazs, tip
             into l_dazs, l_tip
             from accounts
            where nls = p_nlsb and kv = p_kvb;
           if l_dazs is not null then
              set_errmsg ('COLNAME_STODET.NLSB', 'IS_CLOSED', l_errmsg);
           end if;
         exception
           when no_data_found then
             set_errmsg ('COLNAME_STODET.NLSB', 'IS_CLOSED', l_errmsg);
         end;
      end if;

      if (p_mfob is not null and
          p_nlsb is not null and
          p_nlsb != vkrzn (substr(p_mfob, 1, 5), p_nlsb)) then
          set_errmsg ('COLNAME_STODET.NLSB', 'INVALID_CONTROLNUM', l_errmsg);
      end if;

      if p_okpo is null then
         set_errmsg ('COLNAME_STODET.OKPO', 'IS_NULL', l_errmsg);
      else
         if (p_okpo != v_okpo (p_okpo))
             or
            (translate(p_okpo, chr(0)||'0123456789', chr(0)) is not null)
             or
            (length(p_okpo) not in (8, 9, 10) and p_okpo != '99999')
         then
            set_errmsg ('COLNAME_STODET.OKPO', 'INVALID', l_errmsg);
         end if;
      end if;

      if ( p_dr is null AND p_okpo = '0000000000' ) then
        set_errmsg ('COLNAME_STODET.DR', 'IS_NULL', l_errmsg);
      else
        if ( length(trim(p_dr)) != 9 AND p_okpo = '0000000000' ) then
           set_errmsg ('COLNAME_STODET.DR', 'INVALID_LENGTH', l_errmsg);
        end if;
      end if;

      if p_polu is null then
         set_errmsg ('COLNAME_STODET.POLU', 'IS_NULL', l_errmsg);
      end if;

      if p_nazn is null then
         set_errmsg ('COLNAME_STODET.NAZN', 'IS_NULL', l_errmsg);
      else
         if nvl(length(trim(p_nazn)), 0) not between 4 and 160 then
            set_errmsg ('COLNAME_STODET.NAZN', 'INVALID_LENGTH', l_errmsg);
         end if;
      end if;

      if p_fsum is null then
         set_errmsg ('COLNAME_STODET.FSUM', 'IS_NULL', l_errmsg);
      end if;

      p_errmsg := l_errmsg;

    end validate_stodetails;
    ------------------------------
    procedure restore_stodate  (p_ref in oper.ref%type)
    is
    -- Inna 01.12.2008
      -- восстановление даты последнего выполнения платежной инструкции
      -- при сторнировании документа, порожденного модулем "Регулярные платежи"
      l_storow  sto_dat%rowtype;
      l_prevdat date;
    begin

      select * into l_storow from sto_dat where ref  = p_ref;

      select max(s.dat)
        into l_prevdat
        from sto_dat s, oper o
       where s.idd  = l_storow.idd
         and s.ref != l_storow.ref
         and s.ref  = o.ref
         and o.sos >= 0;

      if l_prevdat > l_storow.dat then
         -- промежуточный документ, дата не восстанавливается
         null;
      else
         -- предпоследний документ, дата восстанавливается
         update sto_det set dat0 = l_prevdat where idd = l_storow.idd;
      end if;

    exception
      when no_data_found then null;
    end restore_stodate;


    -----------------------------------
    --Процедура вставки нового регулярного платежа
    PROCEDURE add_det (IDS      IN sto_det.ids%TYPE,
                       ord      IN sto_det.ord%TYPE,
                       tt       IN sto_det.tt%TYPE,
                       vob      IN sto_det.vob%TYPE,
                       dk       IN sto_det.dk%TYPE,
                       nlsa     IN sto_det.nlsa%TYPE,
                       kva      IN sto_det.kva%TYPE,
                       nlsb     IN sto_det.nlsb%TYPE,
                       kvb      IN sto_det.kvb%TYPE,
                       mfob     IN sto_det.mfob%TYPE,
                       polu     IN sto_det.polu%TYPE,
                       nazn     IN sto_det.nazn%TYPE,
                       fsum     IN sto_det.fsum%TYPE,
                       okpo     IN sto_det.okpo%TYPE,
                       DAT1     IN sto_det.dat1%TYPE,
                       DAT2     IN sto_det.dat2%TYPE,
                       FREQ     IN sto_det.freq%TYPE,
                       DAT0     IN sto_det.dat0%TYPE,
                       WEND     IN sto_det.wend%TYPE,
                       DR       IN sto_det.dr%TYPE,
                       branch   IN sto_det.branch%TYPE,
                       idd      IN sto_det.idd%TYPE DEFAULT NULL)
    is
        l_sto_det sto_det%rowtype;
    begin
        l_sto_det.IDS       :=  IDS;
        l_sto_det.ord       :=  ord;
        l_sto_det.tt        :=  tt;
        l_sto_det.vob       :=  vob;
        l_sto_det.dk        :=  dk;
        l_sto_det.nlsa      :=  nlsa;
        l_sto_det.kva       :=  kva;
        l_sto_det.nlsb      :=  nlsb;
        l_sto_det.kvb       :=  kvb;
        l_sto_det.mfob      :=  mfob;
        l_sto_det.polu      :=  polu;
        l_sto_det.nazn      :=  nazn;
        l_sto_det.fsum      :=  fsum;
        l_sto_det.okpo      :=  okpo;
        l_sto_det.DAT1      :=  DAT1;
        l_sto_det.DAT2      :=  DAT2;
        l_sto_det.FREQ      :=  FREQ;
        l_sto_det.DAT0      :=  DAT0;
        l_sto_det.WEND      :=  WEND;
        l_sto_det.DR        :=  DR;
        l_sto_det.branch    :=  branch;
        l_sto_det.idd       :=  idd;
        l_sto_det.kf        := sys_context('bars_context','user_mfo');
        l_sto_det.stmp      := sysdate;
        l_sto_det.status_id := 0;
        l_sto_det.disclaim_id := 0;

        UPDATE sto_det
           SET IDS       = l_sto_det.IDS,
               ord       = l_sto_det.ord,
               tt        = l_sto_det.tt,
               vob       = l_sto_det.vob,
               dk        = l_sto_det.dk,
               nlsa      = l_sto_det.nlsa,
               kva       = l_sto_det.kva,
               nlsb      = l_sto_det.nlsb,
               kvb       = l_sto_det.kvb,
               mfob      = l_sto_det.mfob,
               polu      = l_sto_det.polu,
               nazn      = l_sto_det.nazn,
               fsum      = l_sto_det.fsum,
               okpo      = l_sto_det.okpo,
               DAT1      = l_sto_det.DAT1,
               DAT2      = l_sto_det.DAT2,
               FREQ      = l_sto_det.FREQ,
               DAT0      = l_sto_det.DAT0,
               WEND      = l_sto_det.WEND,
               DR        = l_sto_det.DR,
               branch    = l_sto_det.branch,
               status_id = 0,
               disclaim_id = 0
         WHERE idd = l_sto_det.idd;
      IF SQL%ROWCOUNT=0 THEN
      insert into sto_det
           values l_sto_det;
      end if;
    end add_det;

    --
    -- Удаление (закрытие) макетов рег. платежей депозитного договора (в привязке к допсоглашению)
    --
    procedure del_RegularTreaty(p_agr_id number)
    is
    l_iddToRemove sto_det.idd%type;
    begin
        begin
           select idd
             into l_iddToRemove
             from sto_det_agr
            where agr_id = p_agr_id;
        exception
           when others
           then null;
        end;

        if nvl(l_iddToRemove,0) <> 0
        then
            remove_det(l_iddToRemove);
        end if;
    end del_RegularTreaty;

    PROCEDURE Add_RegularTreaty (IDS             IN     sto_det.ids%TYPE DEFAULT NULL,
                                 ord             IN     sto_det.ord%TYPE,
                                 tt              IN     sto_det.tt%TYPE,
                                 vob             IN     sto_det.vob%TYPE,
                                 dk              IN     sto_det.dk%TYPE,
                                 nlsa            IN     sto_det.nlsa%TYPE,
                                 kva             IN     sto_det.kva%TYPE,
                                 nlsb            IN     sto_det.nlsb%TYPE,
                                 kvb             IN     sto_det.kvb%TYPE,
                                 mfob            IN     sto_det.mfob%TYPE,
                                 polu            IN     sto_det.polu%TYPE,
                                 nazn            IN     sto_det.nazn%TYPE,
                                 fsum            IN     sto_det.fsum%TYPE,
                                 okpo            IN     sto_det.okpo%TYPE,
                                 DAT1            IN     sto_det.dat1%TYPE,
                                 DAT2            IN     sto_det.dat2%TYPE,
                                 FREQ            IN     sto_det.freq%TYPE,
                                 DAT0            IN     sto_det.dat0%TYPE,
                                 WEND            IN     sto_det.wend%TYPE,
                                 DR              IN     sto_det.dr%TYPE,
                                 branch          IN     sto_det.branch%TYPE,
                                 p_nd            IN     cc_deal.nd%TYPE,
                                 p_sdate         IN     cc_deal.sdate%TYPE,
                                 p_idd              OUT sto_det.idd%TYPE,
                                 p_status           OUT NUMBER,
                                 p_status_text      OUT VARCHAR2)
    IS
       l_sto_det          sto_det%ROWTYPE;
       l_valid_mobphone   NUMBER := 0;
       l_rnk              NUMBER;
       l_mfo              varchar2(6);
	   l_nmk				  customer.nmk%type;
	   l_okpo			  customer.okpo%type;
       l_status_claim     pls_integer;
       l_status_msg       varchar2(256);
    begin
        begin
            select rnk
              into l_rnk
              from accounts
             where nls = nlsa
               and kv = kva;
        exception when no_data_found
           then raise_application_error (-20001, 'У клієнта немає рахунків в обраній валюті!', false);
        end;

        l_valid_mobphone := BARS.VERIFY_CELLPHONE_BYRNK (l_rnk);

        if l_valid_mobphone = 0
        then
            -- В картці клієнта не заповнено або невірно заповнено мобільний телефон
            bars_error.raise_nerror ('CAC', 'ERROR_MPNO');
            raise_application_error ( -20001, 'ERR:  В картці клієнта не заповнено або невірно заповнено мобільний телефон! Заповніть корректний моб.телефон в картці клієнта і спробуйте знову.', TRUE);
        else
            p_status := 0;

            l_sto_det.IDS := IDS;
            l_sto_det.ord := ord;
            l_sto_det.tt := tt;
            l_sto_det.vob := vob;
            l_sto_det.dk := dk;
            l_sto_det.nlsa := nlsa;
            l_sto_det.kva := kva;
            l_sto_det.nlsb := replace(nlsb,'_','');
            l_sto_det.kvb := kvb;
            l_sto_det.mfob := mfob;
            l_sto_det.polu := polu;
            l_sto_det.nazn := nazn;
            l_sto_det.fsum := fsum;
            l_sto_det.okpo := replace(okpo,'_','');
            l_sto_det.DAT1 := DAT1;
            l_sto_det.DAT2 := DAT2;
            l_sto_det.FREQ := FREQ;
            l_sto_det.DAT0 := DAT0;
            l_sto_det.WEND := WEND;
            l_sto_det.DR := DR;
            l_sto_det.branch := branch;
            l_sto_det.userid_made := user_id;
            l_sto_det.branch_made := SYS_CONTEXT ('bars_context', 'user_branch');
            l_sto_det.status_id := 0;
            l_sto_det.disclaim_id := 0;

            if nvl(fsum,'0')='0'
            then
                raise_application_error (-20001, 'Не корректно введено суму!', false);
            end if;

            if BARS.f_validokpo(l_sto_det.okpo) != 0
            then
                raise_application_error (-20001, 'Не корректно введено ЗКПО отримувача!', false);
            end if;

            if l_sto_det.nlsb is null
            then
                raise_application_error (-20001, 'Не корректно номер рахунку отримувача!', false);
            end if;
            begin
                select mfo into l_mfo from banks where mfo = mfob;
            exception 
                when no_data_found then
                    raise_application_error (-20001, 'Введеного МФО не існує в довіднику банків!', false);
            end;

            if nvl(polu,'0')='0'
                then raise_application_error (-20001, 'Не корректно введено найменування отримувача!', false);
            end if;
            if nvl(nazn,'0')='0'
                then raise_application_error (-20001, 'Призначення платежу не може бути пустим!', false);
            end if;

            BEGIN
               SELECT branch
                 INTO l_sto_det.branch_card
                 FROM accounts
                WHERE nls = nlsa
                  AND nbs in ('2625','2620') --8212
                  AND kv = kva;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN l_sto_det.branch_card := '';
            END;

            l_sto_det.kf := SYS_CONTEXT ('bars_context', 'user_mfo');
            l_sto_det.stmp := SYSDATE;
            l_sto_det.datetimestamp := SYSDATE;

            begin
                select idd
                  into p_idd
                  from sto_det
                 where IDS = l_sto_det.IDS
                   and ord = l_sto_det.ord
                   and nlsa = l_sto_det.nlsa
                   and nlsb = l_sto_det.nlsb
                   and nazn = l_sto_det.nazn
                   and DAT1 = l_sto_det.DAT1
                   and DAT2 = l_sto_det.DAT2;

                p_status := 1;                   --(вже існує з заданими параметрами)
                p_status_text := '';
            exception
                when NO_DATA_FOUND then
                p_status := 0;                                           --(новий)
                p_status_text := '';

              begin
                  INSERT INTO sto_det
                       VALUES l_sto_det
                       RETURNING idd into l_sto_det.idd;
                  begin
                      select upper(NMK), okpo into l_nmk, l_okpo
                      from customer
                      where rnk = (select rnk from sto_lst where ids = l_sto_det.ids);
                  exception
                      when no_data_found then null;
                  end;

                  /* автопідтвердження ф.190 на погашення кредитів Дт2625-Кт2620
                  поповнення депозитів Дт2625-Кт2630/2635 #COBUMMFO-5328 */
                  if      substr(case when l_sto_det.dk = 1 then l_sto_det.nlsa else l_sto_det.nlsb end, 1, 4) in ('2625','2620') --8212
                      and substr(case when l_sto_det.dk = 1 then l_sto_det.nlsb else l_sto_det.nlsa end, 1, 4) in ('2620','2630', '2635')
                      and upper(l_sto_det.POLU) = l_nmk
                      and l_sto_det.okpo = l_okpo
                      and l_sto_det.mfob = l_sto_det.kf
                  then
                      sto_all.claim_idd(l_sto_det.idd, 1, 0, l_status_claim, l_status_msg);
                  end if;

              exception 
                  when others then
                      if (sqlerrm like '%NLSB%') then
                          raise_application_error (-20001, 'Не корректно введено рахунок отримувача!', false);
                      elsif (sqlerrm like '%NAZN%') then
                          raise_application_error (-20001, 'Не корректно введено призначення!', false);
                      elsif (sqlerrm like '%MFOB%') then
                          raise_application_error (-20001, 'Не корректно введено МФО отримувача!', false);
                      elsif (sqlerrm like '%POLU%') then
                          raise_application_error (-20001, 'Не корректно введено найменування отримувача!', false);
                      elsif (sqlerrm like '%OKPO%') then
                          raise_application_error (-20001, 'Не корректно введено ЗКПО отримувача!', false);
                      elsif (sqlerrm like '%DATES%') then
                          raise_application_error (-20001, 'Не корректно введені дати дії договору! Перевірте дату початку і дату закінчення', false);
                      elsif (sqlerrm like '%UK_STODET%') then
                          raise_application_error (-20001, 'Не корректно введено порядковий номер виконання', false);
                      else
                          raise_application_error (-20001, sqlerrm, TRUE);
                      end if;
              end;
            end;

            begin
                select idd
                into p_idd
                from sto_det
                where     IDS = l_sto_det.IDS
                 and ord = l_sto_det.ord
                 and nlsa = l_sto_det.nlsa
                 and nlsb = l_sto_det.nlsb
                 and nazn = l_sto_det.nazn
                 and DAT1 = l_sto_det.DAT1
                 and DAT2 = l_sto_det.DAT2;

                add_operw (p_idd, 'TREAT', p_nd);
            exception 
                when no_data_found then  
                    raise_application_error ( -20001, 'Не збережено!', false);
            end;
        END IF;
    END Add_RegularTreaty;

    --
    -- Удаление / закрытие макета регулярного платежа
    --
    procedure remove_det (p_idd in sto_det.idd%type)
        is
    l_docs_exists    pls_integer;
    l_trace constant varchar2(150) := 'STO_ALL.remove_det: ';
    begin
        select
                case when exists (select 1 
                                  from sto_dat d 
                                  where d.idd = p_idd and 
                                  d.ref is not null)
                     then 1
                     else 0
                     end
        into l_docs_exists
        from dual;
        if l_docs_exists = 1 then
            -- если по макету были порождены документы - закрываем
            claim_idd(p_idd        => p_idd,
                      p_statusid   => G_DET_STATUS_CANCELED,
                      p_disclaimid => 2); -- "відмова клієнта"
            bars_audit.info(l_trace || 'CANCEL idd='||p_idd);
        else
            -- если нет - удаляем
            delete from sto_dat where idd = p_idd;
            delete from sto_det where idd = p_idd;
            bars_audit.info(l_trace || 'DELETE idd='||p_idd);
        end if;
    end remove_det;

    --
    -- Создание нового договора на регулярные платежи
    --
    procedure set_lst (p_ids  out    sto_lst.ids%type, -- null (out) - создание
                       p_idg  in     sto_lst.idg%type,
                       p_rnk  in     sto_lst.rnk%type,
                       p_name in     sto_lst.name%type,
                       p_sdat in     sto_lst.sdat%type)
    is
    l_trace constant varchar2(150) := 'STO_ALL.set_lst: ';
    l_params varchar2(250) := 'idg='||to_char(p_idg)||';rnk='||to_char(p_rnk)||';name='||p_name||';sdat='||to_char(p_sdat, 'dd.mm.yyyy')||';';
    begin
        if p_ids is null then
            insert into sto_lst (ids, rnk, name, sdat, idg)
            values (p_ids, p_rnk, p_name, p_sdat, p_idg)
            returning ids into p_ids;
            bars.bars_audit.info(l_trace||'Создан договор на рег. платеж с параметрами: ['||l_params||'ids='||to_char(p_ids)||']');
        else
            update sto_lst
            set idg = p_idg,
                rnk = p_rnk,
                name = p_name,
                sdat = p_sdat
            where ids = p_ids;
            if sql%rowcount = 0 then
                raise_application_error(-20000, 'Договора за вказаним внутрішнім ід ['||to_char(p_ids)||'] не знайдено');
            else
                bars.bars_audit.info(l_trace||'Обновлен договор на рег. платеж с параметрами: ['||l_params||'ids='||to_char(p_ids)||']');
            end if;
        end if;
    end set_lst;
    
    --
    -- Обновление договора на рег. платежи
    --
    procedure update_lst ( p_ids  in     sto_lst.ids%type,
                           p_idg  in     sto_lst.idg%type,
                           p_rnk  in     sto_lst.rnk%type,
                           p_name in     sto_lst.name%type,
                           p_sdat in     sto_lst.sdat%type)
    is
    l_trace constant varchar2(150) := 'STO_ALL.update_lst: ';
    l_params varchar2(250) := 'idg='||to_char(p_idg)||';rnk='||to_char(p_rnk)||';name='||p_name||';sdat='||to_char(p_sdat, 'dd.mm.yyyy')||';';
    begin
        update sto_lst
        set idg = p_idg,
            rnk = p_rnk,
            name = p_name,
            sdat = p_sdat
        where ids = p_ids;
        if sql%rowcount = 0 then
            raise_application_error(-20000, 'Договора за вказаним внутрішнім ід ['||to_char(p_ids)||'] не знайдено');
        else
            bars.bars_audit.info(l_trace||'Обновлен договор на рег. платеж с параметрами: ['||l_params||'ids='||to_char(p_ids)||']');
        end if;
    end update_lst;
    
    --
    -- Удаление договора на рег. платежи - или закрытие, если по нему уже были порождены документы
    --
    procedure remove_lst (p_ids       in  sto_lst.ids%type,
                          p_resultMsg out varchar2)
    is
    l_claim_status pls_integer;
    l_claim_msg    varchar2(256);
    l_docs_exists  pls_integer;
    begin
        select
                case when exists (select 1 
                                  from sto_dat d 
                                  join sto_det t on d.idd = t.idd 
                                  where t.ids = p_ids and 
                                  d.ref is not null)
                     then 1
                     else 0
                     end
        into l_docs_exists
        from dual;
        if l_docs_exists = 1 then
            /* если по договору есть макеты платежей и были порождены документы - закрываем */
            for det in (
                            select idd 
                            from sto_det
                            where ids = p_ids and nvl(status_id, 0) in (0, 1)
                        )
            loop
                /* закрываем все созданные макеты платежей */
                sto_all.claim_idd(p_IDD        => det.idd,
                                  p_statusid   => -1, -- отмена
                                  p_disclaimid => 3,  -- "скасовано за ініціативою банку"
                                  p_status     => l_claim_status,
                                  p_resultMsg  => l_claim_msg);
                if l_claim_status = -1 then
                    /* не удалось изменить статус макету - откат и выходим */
                    rollback;
                    p_resultMsg := 'Внутрішня помилка при видаленні макету idd='||to_char(det.idd)||'. Операцію скасовано';
                    return;
                end if;
            end loop;
            /* закрываем договор */
            update sto_lst
            set date_close = sysdate
            where ids = p_ids;
            p_resultMsg := 'Договір закрито';
            bars_audit.info('STO_ALL.REMOVE_LST: Закрытие договора ids='||to_char(p_ids));
        else
            /* иначе - удаляем */
            delete from sto_dat where idd in (select idd from sto_det where ids = p_ids);
            delete from sto_operw where idd in (select idd from sto_det where ids = p_ids);
            delete from sto_det where ids = p_ids;
            delete from sto_lst where ids = p_ids;
            p_resultMsg := 'Договір видалено';
            bars_audit.info('STO_ALL.REMOVE_LST: Удаление договора ids='||to_char(p_ids));
        end if;
    end remove_lst;
    
    -- Редактирование предустановленных допреквизитов макета платежа (создание, обновление, удаление при пустом value)
    procedure add_operw (p_idd      IN    STO_operw.IDD%type,
                         p_tag      IN    STO_operw.TAG%type,
                         p_value    IN    STO_operw.VALUE%type)
    is
        l_sto_operw   sto_operw%rowtype;
    begin
        l_sto_operw.IDD := p_idd;
        l_sto_operw.TAG := p_tag;
        l_sto_operw.VALUE := p_value;
        l_sto_operw.kf := sys_context('bars_context', 'user_mfo');

        if l_sto_operw.value is not null
        then
            UPDATE sto_operw
               set value = l_sto_operw.VALUE
             where idd = l_sto_operw.idd and tag = l_sto_operw.tag;
            if sql%rowcount = 0
            then
               INSERT into sto_operw values l_sto_operw;
            end if;
        else
            DELETE from sto_operw where idd = l_sto_operw.IDD and tag = l_sto_operw.TAG;
        end if;
    end add_operw;

    --
    -- Подтвердить / отклонить макет платежа
    --
    procedure claim_idd (p_IDD          in     sto_det.idd%type,
                         p_statusid     in     sto_det.status_id%type,  -- статус (1 - подтвержден, -1 - отклонен)
                         p_disclaimid   in     sto_det.disclaim_id%type,-- причина отклонения (если статус -1)
                         p_status       out    int,                     -- статус выполнения (1 - ОК, -1 - ошибка)
                         p_resultMsg    out    varchar2)                -- результирующее сообщение
    is
    l_disclaim_txt sto_disclaimer.name%type;
    begin
        p_status := G_DET_STATUS_ACCEPTED; 
        begin
            select name
            into l_disclaim_txt
            from sto_disclaimer
            where id = p_disclaimid;
        exception 
            when no_data_found then
                p_status := G_DET_STATUS_CANCELED;
                p_resultMsg := 'Помилка обробки статусу рег.платежа № '||to_char(p_idd)||' бек-офісом! Не знайдено коду причини відмови в бек-офісі з ідентифікатором '||to_char(p_disclaimid);
                bars_audit.error('sto_all.claim_idd: помилка обробки статусу рег.платежа № '||to_char(p_idd)||
                                 ' бек-офісом! Не знайдено коду причини відмови в бек-офісі з ідентифікатором '||to_char(p_disclaimid));
                return;
        end;
        p_resultMsg := case when p_statusid = G_DET_STATUS_ACCEPTED  then 'Регулярний платіж №' || to_char(p_IDD) ||' підтверджено.'
                            when p_statusid = G_DET_STATUS_CANCELED then 'Регулярний платіж №' || to_char(p_IDD) ||' відхилено зі статусом ' || l_disclaim_txt
                     end;
        begin
            update sto_det
               set status_id = p_statusid,
                   disclaim_id = p_disclaimid,
                   status_date = trunc(sysdate),
                   status_uid = user_id
             where idd = p_IDD;
        exception 
            when others then
               p_status := G_DET_STATUS_CANCELED;
               p_resultMsg := 'Помилка обробки статусу рег.платежа № '||to_char(p_idd)||' бек-офісом!';
               bars_audit.error('sto_all.claim_idd: помилка обробки статусу рег.платежа № '||to_char(p_idd)||' бек-офісом:'||
                                dbms_utility.format_error_stack||chr(10)||dbms_utility.format_error_backtrace);
        end;
    end claim_idd;
    
    --
    -- Подтвердить / отклонить макет платежа (бросает ошибку вместо статуса)
    --
    procedure claim_idd (p_IDD          in     sto_det.idd%type,
                         p_statusid     in     sto_det.status_id%type,   -- статус (1 - подтвержден, -1 - отклонен)
                         p_disclaimid   in     sto_det.disclaim_id%type)-- причина отклонения (если статус -1)
    is
    l_status    pls_integer;
    l_resultmsg varchar2(256);
    begin
        sto_all.claim_idd(p_idd, p_statusid, p_disclaimid, l_status, l_resultmsg);
        if l_status = G_DET_STATUS_CANCELED then
            raise_application_error(-20000, l_resultmsg);
        end if;
    end claim_idd;
    
    FUNCTION get_AvaliableNPP(p_IDS in number) RETURN number
    is
    l_npp number := 1;
    begin
     begin
       select nvl(max(ord)+1,1)
         into l_npp
        from sto_det
        where ids = p_IDS;
     exception when no_data_found then l_npp:=1;
     end;
     return(l_npp);
    end;
    
    --
    -- Оплата документов - "Виконання регулярних платежів"
    --
    procedure pay_docs(p_idd in sto_det.idd%type,
                       p_dat in date)
    is
        l_title   constant varchar2(17) := 'sto_all.pay_docs:';
        l_doc     oper%rowtype;
        l_ex      pls_integer;
        l_sos     pls_integer;
        l_flag    pls_integer;
    begin
        bars_audit.trace(l_title || 'start with param: ' || p_idd || ',' || to_char(p_dat, 'dd/mm/yyyy'));

        begin
            select 1
            into   l_ex
            from   sto_det
            where  idd = p_idd
            for update of dat0 nowait;
        exception
            when no_data_found then
                 raise_application_error ( -20001, 'Не обрано жодного платежа', false);
                 bars_audit.trace(l_title|| 'не обрано платежа, помилка пошуку для оновлення');
                 return;
        end;

        select v.nlsa,
               v.kva,
               v.mfob,
               v.nlsb,
               v.kvb,
               v.tt,
               v.vob,
               v.fsum,
               substr(decode(v.mfob, v.mfoa, v.nama, v.cust_name), 1, 38),
               substr(v.namb,1,38),
               substr(v.nazn,1,160),
               v.cust_code,
               v.idb,
               v.dk,
               v.mfoa
               ,to_number(substr(tts.flags,38,1))
        into   l_doc.nlsa,
               l_doc.kv,
               l_doc.mfob,
               l_doc.nlsb,
               l_doc.kv2,
               l_doc.tt,
               l_doc.vob,
               l_doc.s,
               l_doc.nam_a,
               l_doc.nam_b,
               l_doc.nazn,
               l_doc.id_a,
               l_doc.id_b,
               l_doc.dk,
               l_doc.mfoa,
               l_flag
        from   v_stoschedules_web v, tts
        where  v.tt = tts.tt and
               recid = p_idd and
               paydat = p_dat;

        l_doc.s2   := l_doc.s;
        l_doc.vdat := gl.bd;
        l_doc.pdat := sysdate;

        gl.ref(l_doc.ref);

        /*COBUMMFO-5087 Если сумма нулевая - не создаем сам документ, только пишем референс*/
        if l_doc.s != 0 then
            gl.in_doc3(l_doc.ref,
                       l_doc.tt,
                       l_doc.vob,
                       l_doc.ref,
                       l_doc.pdat,
                       l_doc.vdat,
                       l_doc.dk,
                       l_doc.kv,
                       l_doc.s,
                       l_doc.kv2,
                       l_doc.s2,
                       null,
                       gl.bd,
                       gl.bd,
                       l_doc.nam_a,
                       l_doc.nlsa,
                       l_doc.mfoa,
                       l_doc.nam_b,
                       l_doc.nlsb,
                       l_doc.mfob,
                       l_doc.nazn,
                       null,
                       l_doc.id_a,
                       l_doc.id_b,
                       null,
                       null,
                       1,
                       null,
                       null);

            gl.dyntt2(sos_   => l_sos,
                      mod1_  => l_flag,--0, --COBUMMFO-8092
                      mod2_  => 0,
                      ref_   => l_doc.ref,
                      vdat1_ => l_doc.vdat,
                      vdat2_ => null,
                      tt0_   => l_doc.tt,
                      dk_    => l_doc.dk,
                      kva_   => l_doc.kv,
                      mfoa_  => l_doc.mfoa,
                      nlsa_  => l_doc.nlsa,
                      sa_    => l_doc.s,
                      kvb_   => l_doc.kv2,
                      mfob_  => l_doc.mfob,
                      nlsb_  => l_doc.nlsb,
                      sb_    => l_doc.s2,
                      sq_    => null,
                      nom_   => null);
        else
            bars_audit.info(l_title||' документ с нулевой суммой, реф='||l_doc.ref);
        end if;
        -- сопутствующие действия при оплате
        opl1(p_idd => p_idd, p_Ref => l_doc.ref);
    end pay_docs;

    --
    -- Проверить формулу суммы; Возвращает текст ошибки или null (если формула корректна)
    --
    function check_fsumFunction(fSum in varchar2, 
                                kva  in int, 
                                kvb  in int, 
                                nlsa in varchar2, 
                                nlsb in varchar2, 
                                tt   in varchar2)
    return varchar2
        is
    l_trace          varchar2(256) := 'STO_ALL.check_fsumFunction: ';
    l_func_result    number;
    l_result_message varchar2(500);
    begin
        l_func_result := fsumFunction(fsum, kva, kvb, nlsa, nlsb, tt);
        return l_result_message;
    exception
        when others then
            l_result_message := 'Помилка перевірки формули суми: '||substr(dbms_utility.format_error_stack || chr(10) || dbms_utility.format_error_backtrace, 1, 500);
            return l_result_message;
    end check_fsumFunction;
    
    --
    -- Формула суммы платежа
    --
    function fsumFunction(fSum        in varchar2, 
                          KVA         in int, 
                          KVB         in int, 
                          NLSA        in varchar2, 
                          NLSB        in varchar2, 
                          tt          in varchar2,
                          raise_error in number default 0) 
    return number
    is
    l_trace          varchar2(256) := 'STO_ALL.fsumFunction: ';
    l_function       varchar2(500) := regexp_replace(upper(fsum), '#\(([[:alpha:]]+)\)', ':\1');
    l_tmpSql         varchar2(1000);
    l_cursor_id      pls_integer;
    rows_processed   pls_integer;
    l_func_result    number;
    begin
        begin
            l_tmpSql := 'select '||l_function||' from dual';
            bars_audit.trace(l_trace||'sql=['||l_tmpSql||']');
            l_cursor_id := dbms_sql.open_cursor;
            dbms_sql.PARSE(c => l_cursor_id, statement => l_tmpSql, language_flag => dbms_sql.native);
            dbms_sql.define_column(l_cursor_id, 1, l_func_result);
            if l_function like '%:KVA%' then 
                dbms_sql.bind_variable(l_cursor_id, ':KVA', kva); 
            end if;
            if l_function like '%:KVB%' then 
                dbms_sql.bind_variable(l_cursor_id, ':KVB', kvb);
            end if;
            if l_function like '%:NLSA%' then 
                dbms_sql.bind_variable(l_cursor_id, ':NLSA', nlsa); 
            end if;
            if l_function like '%:NLSB%' then 
                dbms_sql.bind_variable(l_cursor_id, ':NLSB', nlsb); 
            end if;
            if l_function like '%:TT%' then 
                dbms_sql.bind_variable(l_cursor_id, ':TT', tt); 
            end if;
            rows_processed := dbms_sql.execute_and_fetch(l_cursor_id);
            dbms_sql.column_value(l_cursor_id, 1, l_func_result);
            dbms_sql.CLOSE_CURSOR(l_cursor_id);
            bars_audit.trace(l_trace||'result=['||l_func_result||']');
        exception
            when others then
                dbms_sql.CLOSE_CURSOR(l_cursor_id);
                l_func_result := 0;
                if raise_error = 1 then
                    raise;
                end if;
                bars_audit.trace(l_trace||'check failed:['||substr(dbms_utility.format_error_stack || chr(10) || dbms_utility.format_error_backtrace, 1, 500)||']');
        end;
        return l_func_result;
    end fsumFunction;
    
end STO_ALL;
/
show err;

grant execute on sto_all to bars_access_defrole;
grant execute on sto_all to sto;