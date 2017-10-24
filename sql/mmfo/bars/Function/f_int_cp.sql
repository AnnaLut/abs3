
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_int_cp.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_INT_CP (p_metr   IN     INT, -- код методики
                                             p_acc    IN     INT, -- для передачи в
                                             p_id     IN     INT, -- acrn.p_int(nAcc,nId,dDat1,dDat2,nInt,nOst,nMode)
                                             p_dat1   IN     DATE,          --
                                             p_dat2   IN     DATE,          --                                             
                                             p_ost    IN     NUMBER,
                                             p_mode   IN     INT) return NUMBER
IS
   pragma autonomous_transaction;
   G_TITLE    CONSTANT VARCHAR2 (20) := 'INT_CP_P_I: ';
   G_MODULE   CONSTANT VARCHAR2 (20) := 'CP_INT';
   p_int      number :=0;

   TYPE t_acrrow IS RECORD
   (
      acr_dat   int_accn.ACR_DAT%TYPE,
      daos      accounts.daos%TYPE,
      nls       accounts.nls%TYPE,
      nbs       accounts.nbs%TYPE,
      acra      int_accn.ACRA%TYPE,
      stpdat    int_accn.stp_dat%TYPE,
      ost       accounts.ostc%TYPE,
      ostaf     accounts.ostf%TYPE,
      pap       accounts.pap%TYPE,
      io        int_accn.IO%TYPE,
      apl_dat   int_accn.apl_dat%TYPE
   );

   TYPE t_cprow IS RECORD
   (
      ID           cp_deal.ID%TYPE,
      cena         cp_kod.cena%TYPE,
      de           cp_kod.DAT_EM%TYPE,      -- дата эмиссии ЦП
      dp           cp_kod.DATP%TYPE,        -- дата погашения номинала
      IR           cp_kod.IR%TYPE,
      REF          cp_deal.REF%TYPE,
      pr1_kup      cp_kod.pr1_kup%TYPE,
      tip          cp_kod.tip%TYPE,         -- Размещение(чужие), Привлечение(свои)
      ISIN         cp_kod.cp_id%TYPE,
      accr         cp_deal.accr%TYPE,
      accr2        cp_deal.accr2%TYPE,
      idt          cp_type.idt%TYPE,
      kv           cp_kod.kv%TYPE,
      ky           cp_kod.KY%TYPE,
      cena_kup     cp_kod.cena%TYPE,
      cena_kup0    cp_kod.cena_kup0%TYPE,
      metr         cp_kod.metr%TYPE,
      cena_start   cp_kod.cena_start%TYPE,
      io_k         cp_kod.IO%TYPE,
      dok          cp_kod.DOK%TYPE,
      dnk          cp_kod.DNK%TYPE
   );   
    
    l_cprow             t_cprow;        -- набор данных по пакету ЦП
    l_acrrow            t_acrrow;       -- набор данных по процентной карточке счета
    CURSOR C_ACC IS
                 SELECT i.acc, i.basey, i.basem, nvl(i.io, 0) io, 
                        DECODE (i.acr_dat,
                                NULL, s.daos - 1,
                                TO_DATE ('01.01.1900', 'dd.mm.yyyy'), s.daos - 1,
                                i.acr_dat) dat, 
                        s.kv,  decode(i.metr, 96, 0, i.metr) metr, s.pap, i.s, i.stp_dat
                   FROM int_accn i, accounts s
                  WHERE s.acc = i.acc
                    AND i.acc = p_acc 
                    AND i.id  = p_id 
                    AND i.metr = p_metr;
                    
    CURSOR C_SALO IS
           select distinct * from (
             SELECT greatest(fdat,p_dat1)   fdat, 
                    ostf - dos + kos        ostf, 
                    round(abs (fost (p_acc, greatest(fdat,p_dat1)))/100/ f_cena_cp (l_cprow.id, greatest(fdat,p_dat1), 0),0) paper_count,
                    f_cena_cp (l_cprow.id, greatest(fdat,p_dat1), 0) cena
               FROM saldoa
              WHERE acc = p_acc 
                AND (    fdat <= p_dat2 
                     AND fdat > p_dat1 
                     OR
                     fdat = (SELECT MAX(fdat)
                               FROM saldoa 
                              WHERE fdat <= p_dat1 
                                AND acc = p_acc))
            union
             select p_dat1,
                    fost (p_acc, p_dat1),
                    round(abs (fost (p_acc, p_dat1))/100/ f_cena_cp (l_cprow.id, p_dat1, 0),0),
                    f_cena_cp (l_cprow.id, p_dat1, 0)
              from dual 
            union 
             select p_dat2,
                    fost (p_acc, p_dat2),
                    round(abs (fost (p_acc, p_dat2))/100/ f_cena_cp (l_cprow.id, p_dat2, 0),0),
                    f_cena_cp (l_cprow.id, p_dat2, 0)
              from dual);  
                    
   l_int               number           := 0;
   l_nd                VARCHAR2 (10)    := '';
   l_nazn              VARCHAR2 (160);

   l_dat_begin         DATE;                                -- дата начала начисления 
   l_dat_end           DATE;                                -- дата окончания начисления
   l_dat_tmp           DATE             := p_dat1;          -- for loops

   l_days              INT;                                 -- количество дней в купонном периоде
   l_kup               number;
   l_has_awry_period   int := 0; -- есть ли "кривой" купон для бумаги - при наличии укороченного 1го или последнего купонного периода
   l_npp               int;
   l_normal            int;
   l_awry_first        int;
   l_awry_last         int;  
 
   PROCEDURE LOG (p_info    CHAR,
                  p_lev     CHAR DEFAULT 'TRACE',
                  p_reg     INT DEFAULT 0)
   IS
   BEGIN
     MON_U.to_log (p_reg, p_lev, G_MODULE, G_TITLE || p_info);
   END;

   PROCEDURE INIT (p_Id       IN     int_accn.id%TYPE,
                   p_Acc      IN     accounts.acc%TYPE,
                   p_acrrow      OUT t_acrrow,
                   p_cprow       OUT t_cprow)
   IS
   BEGIN
    p_int := 0;
    l_int := 0;  
     -- инициализация коллекций
     BEGIN
        SELECT d.id,
               k.cena,
               k.dat_em,
               k.datp,
               k.ir,
               d.REF,
               NVL (k.PR1_KUP, DECODE (k.kv, gl.baseval, 2, 1)),
               k.tip,
               k.cp_id,
               d.accr,
               d.accr2,
               k.idt,
               k.kv,
               k.ky,
               cena_kup,
               cena_kup0,
               k.metr,
               cena_start,
               NVL (k.io, l_acrrow.io),
               NVL (k.dok, k.dat_em),
               NVL (k.dnk, k.datp)
          INTO l_cprow
          FROM cp_deal d, cp_kod k
         WHERE d.acc = p_Acc AND k.id = d.ID;      
     EXCEPTION
        WHEN NO_DATA_FOUND
        THEN bars_audit.trace(G_TITLE|| 'По указанному АСС = %s не найдено пакетов ЦБ' || to_char(p_acc));
             RETURN;
     END;
     -- ЗНАЧЕНИЯ, ВЫБИРАЕМЫЕ 1 РАЗ
     -- читаем номер договора из представления, равный oper.ND 
     BEGIN
        SELECT min(nd)
          INTO l_nd
          FROM cp_v
         WHERE REF = l_cprow.REF;
     EXCEPTION
        WHEN NO_DATA_FOUND
        THEN l_nd := '';
     END;
     -- p_acrrow := l_acrrow;
     p_cprow  := l_cprow;
      DELETE FROM acr_intN
             WHERE acc = p_Acc AND id = p_id;      
   END;

   PROCEDURE CHECK_DATES (p_dat1     IN     DATE,
                          p_dat2     IN     DATE,
                          p_datn1       OUT DATE,
                          p_daten2      OUT DATE)
   IS
   BEGIN
     -- валидации дат
     IF p_Dat2 < p_Dat1
     THEN                                                /* явная глупость */
        bars_audit.trace(G_TITLE ||' p_Dat2 < p_Dat1 : ' || to_char(p_Dat2) || '<'|| to_char(p_Dat1));
        RETURN;
     END IF;
     l_dat_begin   := p_dat1;
     l_dat_end     := p_dat2;
     IF p_dat1 = TO_DATE ('02.01.1900', 'dd.mm.yyyy')
     THEN
        l_dat_begin := l_acrrow.daos;
     END IF;
 
     IF (l_dat_begin <= l_acrrow.acr_dat OR l_dat_begin >= l_cprow.dnk)
     THEN
        bars_audit.trace(G_TITLE|| ' Не актуальний купонный период: ' || to_char(l_cprow.dok, 'dd.mm.yyyy')|| ' - ' || to_char(l_cprow.dnk, 'dd.mm.yyyy'));
        RETURN;
     END IF;
   END;
    
    function check_cp_dat(p_id cp_dat.id%type) return char 
    is
     l_exists char(1) := '';
    begin
        begin 
          select 'Y'
            into l_exists
            from cp_dat
           where id = p_id
             and rownum = 1;
        exception when no_data_found then l_exists := 'N';
        end;        
    return l_exists;
    end check_cp_dat;
--------------------------------------------------------------------------------------------------------------------------------
BEGIN
  bars_audit.trace(G_TITLE|| ' ===> Старт с параметрами: '
                         || ', p_metr => '|| to_char(p_metr)
                         || ', p_acc => ' || to_char(p_acc)
                         || ', p_id => '  || to_char(p_id)
                         || ', p_dat1 => '|| to_char(p_dat1,'dd.mm.yyyy')
                         || ', p_dat2 => '|| to_char(p_dat2,'dd.mm.yyyy')
                         || ', p_ost => ' || to_char(p_ost)
                         || ', p_mode => '|| to_char(p_mode));
 ------------------------------------------------------------------------------------------------------
 -- ИНИЦИАЛИЗАЦИЯ КОЛЛЕКЦИЙ
 ------------------------------------------------------------------------------------------------------
    INIT (p_id,
          p_Acc,
          l_acrrow,
          l_cprow);  
    /*проверка на кривой купон*/
    cp.awry_period(p_id          => l_cprow.ID,          -- IN код ценной бумаги
                   p_npp         => l_npp,               -- OUT текущий купонный период
                   p_normal      => l_normal,            -- OUT количество дней в нормальном купонном периоде (втором)
                   p_awry        => l_has_awry_period,   -- OUT признак наличия укороченного купонного периода 1/0
                   p_awry_first  => l_awry_first,        -- OUT количество дней в первом купонном периоде
                   p_awry_last   => l_awry_last);        -- OUT количество дней в последнем купонном периоде 
    
    FOR cursor_acc IN C_ACC 
    LOOP
      FOR cursor_fdat IN C_SALO
      LOOP
        bars_audit.trace(g_title||' acc = '|| to_char(cursor_acc.acc)
                               ||', fdat = '|| to_char(cursor_fdat.fdat,'dd.mm.yyyy')
                               ||', paper_count on fdate = ' || to_char(cursor_fdat.paper_count)
                               ||', cena on fdate = ' || to_char(cursor_fdat.cena)
                               ||', ID =' ||to_char(l_cprow.id)
                               ||', l_normal = '|| to_char(l_normal)
                               ||', (dnk-dok) = ' || to_char(l_cprow.dnk-l_cprow.dok));
                                        
           if l_cprow.kv != 36
           then                      
                if check_cp_dat(l_cprow.id) = 'Y' 
                then
                 if (cursor_fdat.fdat - l_dat_tmp-1) > 0
                  then
                  bars_audit.trace(g_title||'  работаем по графику проспекта эмиссии: период = '|| to_char(l_dat_tmp,'dd.mm.yyyy')|| ' - ' || to_char(cursor_fdat.fdat,'dd.mm.yyyy'));           
                 end if;
                                       
                    for dates in (              
                        select distinct d1, d2, real_days, k2, k1, kup,
                        (-1) * abs(case when l_cprow.pr1_kup = 2 -- 2 округлять при рассчете на 1 штуку, 1 - на пакет
                                        then       cursor_fdat.paper_count * (k2 - k1) 
                                        else round(cursor_fdat.paper_count * (k2 - k1),0) 
                                   end)  kupon
                        from (
                          SELECT greatest(dok-1,l_dat_tmp-1) d1, 
                                 least(dnk, cursor_fdat.fdat) d2, 
                                 least(dnk, cursor_fdat.fdat) - greatest(dok-1,l_dat_tmp-1) real_days,                   
                                 case when l_cprow.pr1_kup = 2 
                                      then round(kup * ((cursor_fdat.fdat)-(dok-1))/nvl(l_normal, (l_cprow.dnk-l_cprow.dok)),0) 
                                      else       kup * ((cursor_fdat.fdat)-(dok-1))/nvl(l_normal, (l_cprow.dnk-l_cprow.dok))
                                 end k1,
                                 case when l_cprow.pr1_kup = 2 
                                      then round(kup * ((l_dat_tmp-1)-(dok-1))/nvl(l_normal, (l_cprow.dnk-l_cprow.dok)),0)
                                      else       kup * ((l_dat_tmp-1)-(dok-1))/nvl(l_normal, (l_cprow.dnk-l_cprow.dok))
                                 end k2,
                                 kup 
                            FROM (
                              SELECT case when l_cprow.tip = 1  -- 1 Розміщення (актив), 2 Залучення
                                          then dok
                                          else least(l_cprow.de, dok + 1) 
                                     end dok,
                                     case when l_cprow.tip = 1 
                                          then dnk
                                          else greatest(l_cprow.dp, dnk)                         
                                     end dnk, 
                                     nvl(case when l_cprow.tip = 1 then kup else l_cprow.cena_kup0 end,0)*100 kup
                                FROM CP_DAT_V d
                               WHERE id = l_cprow.id
                                 AND least(dnk, cursor_fdat.fdat) - greatest(dok-1,l_dat_tmp-1) > 0
                                 AND d.npp BETWEEN (SELECT min(npp)
                                                      FROM CP_DAT_V
                                                     WHERE id = d.id AND l_dat_tmp BETWEEN dok AND dnk)
                                               AND (SELECT max(npp)
                                                      FROM CP_DAT_V
                                                     WHERE id = d.id AND cursor_fdat.fdat BETWEEN dok AND dnk))))                
                     loop     
                      
                      l_int := l_int + dates.kupon;
                      bars_audit.trace(G_TITLE|| '       (' ||to_char(dates.d1,'dd.mm.yyyy')|| '-'|| to_char(dates.d2,'dd.mm.yyyy')
                                             || '), pr1_kup = '|| to_char(l_cprow.pr1_kup)
                                             || ', kup = '||to_char(dates.kup)                                    
                                             || ', k1 = '||to_char(dates.k1)
                                             || ', k2 = ' || to_char(dates.k2)
                                             || ', (k2-k1) = ' || to_char(dates.k2 - dates.k1)
                                             || ', dates p_dat2 = ' || to_char(cursor_fdat.fdat,'dd.mm.yyyy')                                   
                                             || ', real_days = ' || to_char(dates.real_days)
                                             || ', сумма начисления = '|| to_char(dates.kupon));
                        bars_audit.trace('dates.d1,dates.d2 = '|| dates.d1||','||dates.d2);    
                         IF l_int != 0 and p_mode != 0
                           THEN  
                           begin     
                            INSERT INTO acr_intN (acc, id, fdat, tdat, acrd, ir, br, osts, nazn, remi)
                                 VALUES (p_acc, p_id, dates.d1,dates.d2, dates.kupon, l_cprow.ir, 0, l_acrrow.ost, l_nazn, 0);
                           exception when dup_val_on_index then null;      
                           end;     
                         END IF;                                                                     
                     end loop;   
                         
                elsif check_cp_dat(l_cprow.id) = 'N' and coalesce(l_cprow.ir,0) > 0 
                then
                  bars_audit.trace(g_title||' работаем по процентной ставке ');
                else 
                  bars_audit.trace(g_title||' нет ни графика ни ставки.... ');
                  return 0; 
                end if;
               
           elsif l_cprow.kv = 36
           then
              bars_audit.trace(g_title||' kv = 36 !!! работаем по графику проспекта эмиссии: период = '|| to_char(l_dat_tmp,'dd.mm.yyyy')|| ' - ' || to_char(cursor_fdat.fdat,'dd.mm.yyyy'));
              for dates in ( select distinct d1, d2, real_days, k1, k2,
                                    (-1)*100*(k1 - k2)*(l_cprow.cena * cursor_fdat.paper_count) kupon 
                              from (SELECT greatest(dok-1,l_dat_tmp-1) d1, 
                                           least(dnk, cursor_fdat.fdat) d2, 
                                           least(dnk, cursor_fdat.fdat) - greatest(dok-1,l_dat_tmp-1) real_days,
                                           case when cursor_acc.metr = 515 
                                                then round(100*(l_cprow.ir/100*365) * ((cursor_fdat.fdat)-(dok-1))/l_normal,3) 
                                                when cursor_acc.metr in (8,23)
                                                then round(100*(l_cprow.ir/100*l_cprow.ky) * ((cursor_fdat.fdat)-(dok-1))/l_normal,3)
                                           end k1,
                                           case when cursor_acc.metr = 515
                                                then round(100*(l_cprow.ir/100*365) * ((l_dat_tmp-1)-(dok-1))/l_normal,3)
                                                when cursor_acc.metr in (8,23)
                                                then round(100*(l_cprow.ir/100*l_cprow.ky) * ((l_dat_tmp-1)-(dok-1))/l_normal,3)
                                           end  k2                                          
                                      FROM CP_DAT_V d
                                     WHERE id = l_cprow.id
                                       AND least(dnk, cursor_fdat.fdat) - greatest(dok-1,l_dat_tmp-1) > 0
                                       AND d.npp BETWEEN (SELECT min(npp)
                                                            FROM CP_DAT_V
                                                           WHERE id = d.id AND l_dat_tmp BETWEEN dok AND dnk)
                                                     AND (SELECT max(npp)
                                                            FROM CP_DAT_V
                                                           WHERE id = d.id AND cursor_fdat.fdat BETWEEN dok AND dnk)))
              loop                
               IF l_int != 0 and p_mode != 0
                           THEN  
                           begin     
                            INSERT INTO acr_intN (acc, id, fdat, tdat, acrd, ir, br, osts, nazn, remi)
                                 VALUES (p_acc, p_id, dates.d1,dates.d2, dates.kupon, l_cprow.ir, 0, l_acrrow.ost, l_nazn, 0);
                           exception when dup_val_on_index then null;      
                           end;     
                         END IF;     
                  l_int := l_int + dates.kupon;
                  bars_audit.trace(G_TITLE|| '       (' ||to_char(dates.d1,'dd.mm.yyyy')|| '-'|| to_char(dates.d2,'dd.mm.yyyy')                                   
                                         || ', ir = '||to_char(l_cprow.ir)                                    
                                         || ', cursor_acc.metr = '||to_char(cursor_acc.metr)
                                         || ', k1 = '||to_char(dates.k1)
                                         || ', k2 = ' || to_char(dates.k2)
                                         || ', (k2-k1) = ' || to_char(dates.k2 - dates.k1)
                                         || ', dates p_dat2 = ' || to_char(cursor_fdat.fdat,'dd.mm.yyyy')                                   
                                         || ', real_days = ' || to_char(dates.real_days)
                                         || ', сумма начисления = '|| to_char(dates.kupon));
                  
              end loop;     
           end if;      
       l_dat_tmp := cursor_fdat.fdat + 1 + nvl(cursor_acc.io, 0);   
                    
      END LOOP;   
      p_int := p_int + l_int;
      bars_audit.trace(g_title||' Cуммарно купона = ' || to_char(p_int));
    END LOOP;
      
  
   
   bars_audit.trace(G_TITLE|| ' ==============================> Финиш '|| sqlerrm);
   commit;
   return p_int;   
END;
/
 show err;
 
PROMPT *** Create  grants  F_INT_CP ***
grant EXECUTE                                                                on F_INT_CP        to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_int_cp.sql =========*** End *** =
 PROMPT ===================================================================================== 
 