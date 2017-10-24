
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/sto_all.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.STO_ALL IS

/*
    06-02-2012 Sta Регулярные платежи.
    Разрозненные процедуры собраны в один пакедж.

    Отдельные процедуры убиты:
     drop procedure restore_stodate;
     drop procedure validate_stodetails;
     drop procedure setdefault_stodetails;
     drop procedure generate_stoschedules ;

    TRIGGER bars.taiu_sto_det - исправлен

    Библиотека Bin\Bars002.apd - мсправлена.

*/

G_BODY_VERSION  CONSTANT VARCHAR2(64)  :=  'version 1.2.5  31.08.2015';


 /*
 * header_version - возвращает версию заголовка пакета DKU_REPORTS
 */
function header_version return varchar2;

/*
 * body_version - возвращает версию тела пакета DKU_REPORTS
 */
function body_version   return varchar2;


--------------------------------------------------------------
procedure opl1 ( p_idd sto_det.idd%type,
                 p_Ref oper.ref%type
                 );

--06-02-2012 Sta Дополнительные сопутствующие действия при оплате 1 детали рег пл.
--------------------------------------------------------------------
procedure generate_stoschedules
 (p_stoid    in  sto_det.idd%type,
  p_stodat0  in  sto_det.dat0%type,
  p_stodat1  in  sto_det.dat1%type,
  p_stodat2  in  sto_det.dat2%type,
  p_stofreq  in  sto_det.freq%type,
  p_stowend  in  sto_det.wend%type);

--Inna 17.11.2008


--inga 07/11/2014
procedure generate_stoschedules_reg
 (p_stoid    in  sto_det.idd%type,
  p_stodat0  in  sto_det.dat0%type,
  p_stodat1  in  sto_det.dat1%type,
  p_stodat2  in  sto_det.dat2%type,
  p_stofreq  in  sto_det.freq%type,
  p_stowend  in  sto_det.wend%type,
  p_tt in   sto_det.tt%type);

--------------------------------------------------------------------

procedure setdefault_stodetails
 (p_ids    in  sto_det.ids%type,
  p_vob    out sto_det.vob%type,
  p_dk     out sto_det.dk%type,
  p_tt     out sto_det.tt%type,
  p_nlsa   out sto_det.nlsa%type,
  p_kva    out sto_det.kva%type,
  p_nlsb   out sto_det.nlsb%type,
  p_kvb    out sto_det.kvb%type,
  p_mfob   out sto_det.mfob%type,
  p_polu   out sto_det.polu%type,
  p_nazn   out sto_det.nazn%type,
  p_fsum   out sto_det.fsum%type,
  p_okpo   out sto_det.okpo%type,
  p_dat1   out sto_det.dat1%type,
  p_dat2   out sto_det.dat2%type,
  p_freq   out sto_det.freq%type,
  p_dat0   out sto_det.dat0%type,
  p_wend   out sto_det.wend%type,
  p_ord    out sto_det.ord%type);

--Inna 22.04.2010

--------------------------------------------------------------------
procedure validate_stodetails
 (p_ids    in sto_det.ids%type,
  p_vob    in sto_det.vob%type,
  p_dk     in sto_det.dk%type,
  p_tt     in sto_det.tt%type,
  p_nlsa   in sto_det.nlsa%type,
  p_kva    in sto_det.kva%type,
  p_nlsb   in sto_det.nlsb%type,
  p_kvb    in sto_det.kvb%type,
  p_mfob   in sto_det.mfob%type,
  p_polu   in sto_det.polu%type,
  p_nazn   in sto_det.nazn%type,
  p_fsum   in sto_det.fsum%type,
  p_okpo   in sto_det.okpo%type,
  p_dat1   in sto_det.dat1%type,
  p_dat2   in sto_det.dat2%type,
  p_freq   in sto_det.freq%type,
  p_dat0   in sto_det.dat0%type,
  p_wend   in sto_det.wend%type,
  p_ord    in sto_det.ord%type,
  p_idd    in sto_det.idd%type default null,
  p_dr     in sto_det.dr%type,
  p_errmsg out varchar2) ;


-- Inna 06.02.2009

/* Baa 29.09.2011
       додано перев_рку:
       для для випадку коли код ОКПО отримувача = 10 нулям,
       необх_дно буде вказати номер та сер_ю паспорта.
       Небх_дно:
       patchZ37.sql
*/

--------------------------------------------------------------------
procedure restore_stodate  (p_ref in oper.ref%type);
-- Inna 01.12.2008
-------------------------------------------


  procedure add_det (IDS    sto_det.ids%type,
                   ord    sto_det.ord%type,
                   tt     sto_det.tt%type,
                   vob    sto_det.vob%type,
                   dk     sto_det.dk%type,
                   nlsa   sto_det.nlsa%type,
                   kva    sto_det.kva%type,
                   nlsb   sto_det.nlsb%type,
                   kvb    sto_det.kvb%type,
                   mfob   sto_det.mfob%type,
                   polu   sto_det.polu%type,
                   nazn   sto_det.nazn%type,
                   fsum   sto_det.fsum%type,
                   okpo   sto_det.okpo%type,
                   DAT1   sto_det.dat1%type,
                   DAT2   sto_det.dat2%type,
                   FREQ   sto_det.freq%type,
                   DAT0   sto_det.dat0%type,
                   WEND   sto_det.wend%type,
                   DR     sto_det.dr%type,
                   branch sto_det.branch%type,
                   idd    sto_det.idd%type default null
                   );


  procedure Add_RegularTreaty (IDS    sto_det.ids%type default null,
                   ord    sto_det.ord%type,
                   tt     sto_det.tt%type,
                   vob    sto_det.vob%type,
                   dk     sto_det.dk%type,
                   nlsa   sto_det.nlsa%type,
                   kva    sto_det.kva%type,
                   nlsb   sto_det.nlsb%type,
                   kvb    sto_det.kvb%type,
                   mfob   sto_det.mfob%type,
                   polu   sto_det.polu%type,
                   nazn   sto_det.nazn%type,
                   fsum   sto_det.fsum%type,
                   okpo   sto_det.okpo%type,
                   DAT1   sto_det.dat1%type,
                   DAT2   sto_det.dat2%type,
                   FREQ   sto_det.freq%type,
                   DAT0   sto_det.dat0%type,
                   WEND   sto_det.wend%type,
                   DR     sto_det.dr%type,
                   branch sto_det.branch%type,
                   p_nd  cc_deal.nd%type,
                   p_sdate cc_deal.sdate%type,
                   p_idd  OUT  sto_det.idd%type,
                   p_status out number,
                   p_status_text OUT varchar2
                   );

procedure del_RegularTreaty(p_agr_id number);

procedure add_RegularLST (IDG  STO_LST.IDG%TYPE,
                   p_IDS  OUT STO_LST.IDS%TYPE,
                   RNK  STO_LST.RNK%TYPE,
                   NAME STO_LST.NAME%TYPE,
                   SDAT STO_LST.SDAT%TYPE
                   );

procedure add_LST (IDG  STO_LST.IDG%TYPE,
                   IDS  STO_LST.IDS%TYPE,
                   RNK  STO_LST.RNK%TYPE,
                   NAME STO_LST.NAME%TYPE,
                   SDAT STO_LST.SDAT%TYPE
                   );



procedure add_operw (IDD   STO_operw.IDD%TYPE,
                     TAG   STO_operw.TAG%TYPE,
                     VALUE STO_operw.VALUE%TYPE
                   );


END STO_ALL;
/
CREATE OR REPLACE PACKAGE BODY BARS.STO_ALL IS

/*
    06-02-2012 Sta Регулярные платежи.
    Разрозненные процедуры собраны в один пакедж.
*/
--------------------------------------------------------------

G_HEADER_VERSION  CONSTANT VARCHAR2(64)  :=  'version 1.2.2  29.07.2015';



procedure opl1 ( p_idd sto_det.idd%type,
                 p_Ref oper.ref%type
                 ) IS
--06-02-2012 Sta Дополнительные сопутствующие действия при оплате 1 детали рег пл.

  l_br3 sto_det.branch%type;

begin

  --отметка о последней дате выполнения
  UPDATE sto_det  SET dat0 = gl.BDATE WHERE idd = p_idd ;

  -- референс выполнения платежа в данную дату
  UPDATE sto_dat  SET ref  = p_Ref    WHERE idd = p_Idd AND dat = gl.bdate;

  -- реквизит для бюджетирования дох/рас (прежде всего, неоперационных)
  begin
    SELECT branch into l_br3 FROM sto_det WHERE idd=p_Idd and branch is not null;
    UPDATE opldok set txt  = l_br3    where ref = p_Ref ;
  exception when no_data_found then null;
  end;

  -- доп.реквизиты платежа. предусмотренные настройками данного рег.платежа
  for k in (select * from sto_operw where idd= p_Idd )
  loop
     update operw set value = k.value where tag = k.TAG and ref = p_ref;
     if SQL%rowcount = 0 then
        INSERT into operw (ref,tag,value) values (p_Ref,k.tag, k.value);
     end if;
  end loop;

end opl1;
--------------------------------------------------------------------

procedure generate_stoschedules
 (p_stoid    in  sto_det.idd%type,
  p_stodat0  in  sto_det.dat0%type,
  p_stodat1  in  sto_det.dat1%type,
  p_stodat2  in  sto_det.dat2%type,
  p_stofreq  in  sto_det.freq%type,
  p_stowend  in  sto_det.wend%type)
--Inna 17.11.2008
is
  title      constant varchar2(60)   := 'genstoschedule:';
  basecur    constant tabval.kv%type := gl.baseval;
  bankdat    constant fdat.fdat%type := gl.bdate;
  l_startdat date;
  l_stopdat  date;
  l_nextdat  date;
  l_tempdat  date;
  l_idg number;
  l_nd number;
  l_sdate date;
  l_s number;
  l_cc_id varchar2(50);
  l_CCdat date;
  ----------------
  function get_bd
   (p_date  in date,
    p_delta in number)
    return date
  is
    l_bd date;
  begin
    select dat_next_u (holiday, p_delta)
      into l_bd
      from holiday
     where kv      = basecur
       and holiday = p_date;
    return l_bd;
  exception
    when no_data_found then
      return p_date;
  end get_bd;
begin
  bars_audit.trace('%s idd = %s, (dat0, dat1, dat2, freq, wend) = (%s, %s, %s, %s, %s)',
                   title,
                   to_char(p_stoid),
                   to_char(p_stodat0,'dd/mm/yy'),
                   to_char(p_stodat1,'dd/mm/yy'),
                   to_char(p_stodat2,'dd/mm/yy'),
                   to_char(p_stofreq),
                   to_char(p_stowend));

  l_startdat := greatest(p_stodat1, nvl(p_stodat0, bankdat - 1), bankdat);
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

        l_nextdat := p_stodat1;

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

          if (l_tempdat between l_startdat and l_stopdat) then
             begin
               insert into sto_dat(idd, dat) values (p_stoid, l_tempdat);
             exception
               when dup_val_on_index then null;
             end;
          end if;

        end loop;

     end if;

    if  p_stofreq = 2-- and l_idg in (6,12)
    then

          begin

              select value
              into l_nd
              from sto_operw
              where idd = p_stoid
              and tag = 'TREAT';

              select cc_id, sdate
              into l_cc_id , l_sdate
              from cc_deal
              where nd = l_nd;

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
               when dup_val_on_index then null;
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
                                     p_tt        IN sto_det.tt%TYPE)


IS
   title     CONSTANT VARCHAR2 (60) := 'regular.genstoschedule:';
   basecur   CONSTANT tabval.kv%TYPE := gl.baseval;
   bankdat   CONSTANT fdat.fdat%TYPE := gl.bdate;
   l_startdat         DATE;
   l_stopdat          DATE;
   l_nextdat          DATE;
   l_tempdat          DATE;
   l_idg              NUMBER;
   l_nd               NUMBER;
   l_sdate            DATE;
   l_s                NUMBER;
   l_cc_id            VARCHAR2 (50);
   l_CCdat            DATE;

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
BEGIN
   bars_audit.trace (
      '%s idd = %s, (dat0, dat1, dat2, freq, wend) = (%s, %s, %s, %s, %s)',
      title,
      TO_CHAR (p_stoid),
      TO_CHAR (p_stodat0, 'dd/mm/yy'),
      TO_CHAR (p_stodat1, 'dd/mm/yy'),
      TO_CHAR (p_stodat2, 'dd/mm/yy'),
      TO_CHAR (p_stofreq),
      TO_CHAR (p_stowend));

   l_startdat := GREATEST (p_stodat1, NVL (p_stodat0, bankdate - 1), bankdate);
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
                  THEN
                     NULL;
               END;
            END IF;
         END IF;

         l_nextdat := p_stodat1;

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
                  THEN
                     NULL;
               END;
            END IF;
         END LOOP;
      END IF;
        -- and l_idg in (6,12)
      IF p_stofreq = 2
      THEN
         BEGIN
            SELECT VALUE
              INTO l_nd
              FROM sto_operw
             WHERE idd = p_stoid AND tag = 'TREAT';

            SELECT cc_id, sdate
              INTO l_cc_id, l_sdate
              FROM cc_deal
             WHERE nd = l_nd;

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
               INSERT INTO sto_dat (idd, dat)
                    VALUES (p_stoid, l_CCdat);
            EXCEPTION
               WHEN DUP_VAL_ON_INDEX
               THEN
                  bars_audit.error (title||' Для idd = '||TO_CHAR (l_CCdat, 'dd/mm/yy')||' и next date = '||TO_CHAR (p_stoid)||' график уже установлен');
            END;
         END IF;
      END IF;
   END IF;
END generate_stoschedules_reg;


procedure setdefault_stodetails
 (p_ids    in  sto_det.ids%type,
  p_vob    out sto_det.vob%type,
  p_dk     out sto_det.dk%type,
  p_tt     out sto_det.tt%type,
  p_nlsa   out sto_det.nlsa%type,
  p_kva    out sto_det.kva%type,
  p_nlsb   out sto_det.nlsb%type,
  p_kvb    out sto_det.kvb%type,
  p_mfob   out sto_det.mfob%type,
  p_polu   out sto_det.polu%type,
  p_nazn   out sto_det.nazn%type,
  p_fsum   out sto_det.fsum%type,
  p_okpo   out sto_det.okpo%type,
  p_dat1   out sto_det.dat1%type,
  p_dat2   out sto_det.dat2%type,
  p_freq   out sto_det.freq%type,
  p_dat0   out sto_det.dat0%type,
  p_wend   out sto_det.wend%type,
  p_ord    out sto_det.ord%type)
is

 --Inna 22.04.2010

  -- коммерческий банк
  modcode  char(3) := 'STO';
begin

  p_wend := 1;
  p_vob  := 1;
  p_dk   := 1;
  p_dat1 := gl.bdate;
  p_kva  := gl.baseval;
  p_kvb  := gl.baseval;

end setdefault_stodetails;
-------------------------
procedure validate_stodetails
 (p_ids    in sto_det.ids%type,
  p_vob    in sto_det.vob%type,
  p_dk     in sto_det.dk%type,
  p_tt     in sto_det.tt%type,
  p_nlsa   in sto_det.nlsa%type,
  p_kva    in sto_det.kva%type,
  p_nlsb   in sto_det.nlsb%type,
  p_kvb    in sto_det.kvb%type,
  p_mfob   in sto_det.mfob%type,
  p_polu   in sto_det.polu%type,
  p_nazn   in sto_det.nazn%type,
  p_fsum   in sto_det.fsum%type,
  p_okpo   in sto_det.okpo%type,
  p_dat1   in sto_det.dat1%type,
  p_dat2   in sto_det.dat2%type,
  p_freq   in sto_det.freq%type,
  p_dat0   in sto_det.dat0%type,
  p_wend   in sto_det.wend%type,
  p_ord    in sto_det.ord%type,
  p_idd    in sto_det.idd%type default null,
  p_dr     in sto_det.dr%type,
  p_errmsg out varchar2)
is
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

procedure add_det (IDS    sto_det.ids%type,
                   ord    sto_det.ord%type,
                   tt     sto_det.tt%type,
                   vob    sto_det.vob%type,
                   dk     sto_det.dk%type,
                   nlsa   sto_det.nlsa%type,
                   kva    sto_det.kva%type,
                   nlsb   sto_det.nlsb%type,
                   kvb    sto_det.kvb%type,
                   mfob   sto_det.mfob%type,
                   polu   sto_det.polu%type,
                   nazn   sto_det.nazn%type,
                   fsum   sto_det.fsum%type,
                   okpo   sto_det.okpo%type,
                   DAT1   sto_det.dat1%type,
                   DAT2   sto_det.dat2%type,
                   FREQ   sto_det.freq%type,
                   DAT0   sto_det.dat0%type,
                   WEND   sto_det.wend%type,
                   DR     sto_det.dr%type,
                   branch sto_det.branch%type,
                   idd    sto_det.idd%type default null
                   )
is
l_sto_det sto_det%rowtype;
begin

    l_sto_det.IDS     :=  IDS     ;
    l_sto_det.ord     :=  ord     ;
    l_sto_det.tt      :=  tt      ;
    l_sto_det.vob     :=  vob     ;
    l_sto_det.dk      :=  dk      ;
    l_sto_det.nlsa    :=  nlsa    ;
    l_sto_det.kva     :=  kva     ;
    l_sto_det.nlsb    :=  nlsb    ;
    l_sto_det.kvb     :=  kvb     ;
    l_sto_det.mfob    :=  mfob    ;
    l_sto_det.polu    :=  polu    ;
    l_sto_det.nazn    :=  nazn    ;
    l_sto_det.fsum    :=  fsum    ;
    l_sto_det.okpo    :=  okpo    ;
    l_sto_det.DAT1    :=  DAT1    ;
    l_sto_det.DAT2    :=  DAT2    ;
    l_sto_det.FREQ    :=  FREQ    ;
    l_sto_det.DAT0    :=  DAT0    ;
    l_sto_det.WEND    :=  WEND    ;
    l_sto_det.DR      :=  DR      ;
    l_sto_det.branch  :=  branch  ;
    l_sto_det.idd     :=  idd     ;

l_sto_det.kf      := sys_context('bars_context','user_mfo');
l_sto_det.stmp    := sysdate;





--insert/update sto_det

  update sto_det
     set    IDS    = l_sto_det.IDS       ,
            ord    = l_sto_det.ord       ,
            tt     = l_sto_det.tt        ,
            vob    = l_sto_det.vob       ,
            dk     = l_sto_det.dk        ,
            nlsa   = l_sto_det.nlsa      ,
            kva    = l_sto_det.kva       ,
            nlsb   = l_sto_det.nlsb      ,
            kvb    = l_sto_det.kvb       ,
            mfob   = l_sto_det.mfob      ,
            polu   = l_sto_det.polu      ,
            nazn   = l_sto_det.nazn      ,
            fsum   = l_sto_det.fsum      ,
            okpo   = l_sto_det.okpo      ,
            DAT1   = l_sto_det.DAT1      ,
            DAT2   = l_sto_det.DAT2      ,
            FREQ   = l_sto_det.FREQ      ,
            DAT0   = l_sto_det.DAT0      ,
            WEND   = l_sto_det.WEND      ,
            DR     = l_sto_det.DR        ,
            branch = l_sto_det.branch
   where idd = l_sto_det.idd;
  IF SQL%ROWCOUNT=0 THEN
  insert into sto_det
       values l_sto_det;
  end if;


end add_det;

procedure del_RegularTreaty(p_agr_id number)
is
p_idd sto_det.idd%type;
begin
 begin
   select idd
   into p_idd
   from sto_det_agr
   where agr_id = p_agr_id;
 exception when others then null;
 end;

 if nvl(p_idd,0) <> 0
 then
       delete from sto_dat where idd =  p_idd;
       delete from sto_det where idd =  p_idd;
 end if;


end del_RegularTreaty;

PROCEDURE Add_RegularTreaty (IDS                 sto_det.ids%TYPE DEFAULT NULL,
                             ord                 sto_det.ord%TYPE,
                             tt                  sto_det.tt%TYPE,
                             vob                 sto_det.vob%TYPE,
                             dk                  sto_det.dk%TYPE,
                             nlsa                sto_det.nlsa%TYPE,
                             kva                 sto_det.kva%TYPE,
                             nlsb                sto_det.nlsb%TYPE,
                             kvb                 sto_det.kvb%TYPE,
                             mfob                sto_det.mfob%TYPE,
                             polu                sto_det.polu%TYPE,
                             nazn                sto_det.nazn%TYPE,
                             fsum                sto_det.fsum%TYPE,
                             okpo                sto_det.okpo%TYPE,
                             DAT1                sto_det.dat1%TYPE,
                             DAT2                sto_det.dat2%TYPE,
                             FREQ                sto_det.freq%TYPE,
                             DAT0                sto_det.dat0%TYPE,
                             WEND                sto_det.wend%TYPE,
                             DR                  sto_det.dr%TYPE,
                             branch              sto_det.branch%TYPE,
                             p_nd                cc_deal.nd%TYPE,
                             p_sdate             cc_deal.sdate%TYPE,
                             p_idd           OUT sto_det.idd%TYPE,
                             p_status        OUT NUMBER,
                             p_status_text   OUT VARCHAR2)
IS
   l_sto_det          sto_det%ROWTYPE;
   l_valid_mobphone   NUMBER := 0;
   l_rnk              NUMBER;
BEGIN
   SELECT rnk
     INTO l_rnk
     FROM accounts
    WHERE nls = nlsa AND kv = kva;

   l_valid_mobphone := BARS.VERIFY_CELLPHONE_BYRNK (l_rnk);

   IF l_valid_mobphone = 0
   THEN
      -- В картці клієнта не заповнено або невірно заповнено мобільний телефон
      bars_error.raise_nerror ('CAC', 'ERROR_MPNO');
      raise_application_error (
         -20001,
         'ERR:  В картці клієнта не заповнено або невірно заповнено мобільний телефон! Заповніть корректний моб.телефон в картці клієнта і спробуйте знову.',
         TRUE);
   ELSE
      p_status := 0;

      l_sto_det.IDS := IDS;
      l_sto_det.ord := ord;
      l_sto_det.tt := tt;
      l_sto_det.vob := vob;
      l_sto_det.dk := dk;
      l_sto_det.nlsa := nlsa;
      l_sto_det.kva := kva;
      l_sto_det.nlsb := nlsb;
      l_sto_det.kvb := kvb;
      l_sto_det.mfob := mfob;
      l_sto_det.polu := substr(polu,1,38);
      l_sto_det.nazn := nazn;
      l_sto_det.fsum := fsum;
      l_sto_det.okpo := okpo;
      l_sto_det.DAT1 := DAT1;
      l_sto_det.DAT2 := DAT2;
      l_sto_det.FREQ := FREQ;
      l_sto_det.DAT0 := DAT0;
      l_sto_det.WEND := WEND;
      l_sto_det.DR := DR;
      l_sto_det.branch := branch;
      l_sto_det.userid_made := user_id;
      l_sto_det.branch_made := SYS_CONTEXT ('bars_context', 'user_branch');

        BEGIN
           SELECT branch
             INTO l_sto_det.branch_card
             FROM accounts
            WHERE nls = nlsa AND nbs = '2625' AND kv = kva;
        EXCEPTION
           WHEN NO_DATA_FOUND
           THEN
              l_sto_det.branch_card := '';
        END;

      l_sto_det.kf := SYS_CONTEXT ('bars_context', 'user_mfo');
      l_sto_det.stmp := SYSDATE;
      l_sto_det.datetimestamp := SYSDATE;

      BEGIN
         SELECT idd
           INTO p_idd
           FROM sto_det
          WHERE     IDS = l_sto_det.IDS
                AND ord = l_sto_det.ord
                AND nlsa = l_sto_det.nlsa
                AND nlsb = l_sto_det.nlsb
                AND nazn = l_sto_det.nazn
                AND DAT1 = l_sto_det.DAT1
                AND DAT2 = l_sto_det.DAT2;

         p_status := 1;                   --(вже існує з заданими параметрами)
         p_status_text := '';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            p_status := 0;                                           --(новий)
            p_status_text := '';

            INSERT INTO sto_det
                 VALUES l_sto_det;
      END;

      SELECT idd
        INTO p_idd
        FROM sto_det
       WHERE     IDS = l_sto_det.IDS
             AND ord = l_sto_det.ord
             AND nlsa = l_sto_det.nlsa
             AND nlsb = l_sto_det.nlsb
             AND nazn = l_sto_det.nazn
             AND DAT1 = l_sto_det.DAT1
             AND DAT2 = l_sto_det.DAT2;

      add_operw (p_idd, 'TREAT', p_nd);

      generate_stoschedules_reg (p_idd,
                                 NULL,
                                 l_sto_det.DAT1,
                                 l_sto_det.DAT2,
                                 l_sto_det.FREQ,
                                 l_sto_det.wend,
                                 l_sto_det.tt);
   END IF;
END Add_RegularTreaty;

procedure add_LST (IDG  STO_LST.IDG%TYPE,
                   IDS  STO_LST.IDS%TYPE,
                   RNK  STO_LST.RNK%TYPE,
                   NAME STO_LST.NAME%TYPE,
                   SDAT STO_LST.SDAT%TYPE
                   )
IS
l_sto_lst sto_lst%rowtype;
BEGIN


l_sto_lst.IDG    :=     IDG ;
l_sto_lst.IDS    :=     IDS ;
l_sto_lst.RNK    :=     RNK ;
l_sto_lst.NAME   :=     NAME;
l_sto_lst.SDAT   :=     SDAT;
--insert/update sto_lst

  update sto_lst
     set  IDG   =   l_sto_lst.IDG ,
          RNK   =   l_sto_lst.RNK ,
          NAME  =   l_sto_lst.NAME,
          SDAT  =   l_sto_lst.SDAT
   where ids = l_sto_lst.ids;
  IF SQL%ROWCOUNT=0 THEN
  insert into sto_lst ( IDG  ,         RNK,               NAME,              SDAT)
               values (l_sto_lst.IDG,  l_sto_lst.RNK,     l_sto_lst.NAME,    l_sto_lst.SDAT);
  end if;

END add_LST;



procedure add_RegularLST (IDG  STO_LST.IDG%TYPE,
                   p_IDS   OUT STO_LST.IDS%TYPE,
                   RNK  STO_LST.RNK%TYPE,
                   NAME STO_LST.NAME%TYPE,
                   SDAT STO_LST.SDAT%TYPE
                   )
IS
l_sto_lst sto_lst%rowtype;
BEGIN

bars_audit.info('>>start');
l_sto_lst.IDG    :=     IDG ;
l_sto_lst.RNK    :=     RNK ;
l_sto_lst.NAME   :=     NAME;
l_sto_lst.SDAT := SDAT;

bars_audit.info('>>sdat = '||to_char(sdat));

 begin
      select sl.IDS
      into p_IDS
      from sto_lst sl
      where sl.IDG = l_sto_lst.IDG
      and  sl.RNK = l_sto_lst.RNK;
   bars_audit.info('>>p_ids = '||to_char(p_ids));
  exception
    when no_data_found
    then
          insert into sto_lst ( IDG  ,         RNK,               NAME,              SDAT)
          values (l_sto_lst.IDG,  l_sto_lst.RNK,     l_sto_lst.NAME,    l_sto_lst.SDAT);
  end;
      select sl.IDS
      into p_IDS
      from sto_lst sl
      where sl.IDG = l_sto_lst.IDG
      and  sl.RNK = l_sto_lst.RNK;
bars_audit.info('>>p_ids = '||to_char(p_ids));

END add_RegularLST;



procedure add_operw (IDD   STO_operw.IDD%TYPE,
                     TAG   STO_operw.TAG%TYPE,
                     VALUE STO_operw.VALUE%TYPE
                   )
IS
l_sto_operw sto_operw%rowtype;
BEGIN


l_sto_operw.IDD    :=     IDD ;
l_sto_operw.TAG    :=     TAG ;
l_sto_operw.VALUE  :=     VALUE ;
l_sto_operw.kf     :=     sys_context('bars_context','user_mfo');




--insert/update sto_lst

if l_sto_operw.VALUE is not null then

              update sto_operw
                 set  VALUE  =   l_sto_operw.VALUE
               where idd = l_sto_operw.idd
                 and tag = l_sto_operw.tag;
              IF SQL%ROWCOUNT=0 THEN
              insert into sto_operw
                   values l_sto_operw;
              end if;
else

             delete from sto_operw
              where idd =  l_sto_operw.IDD
                and TAG =  l_sto_operw.TAG;

end if;



END add_operw;


/**
 * header_version - возвращает версию заголовка пакета DKU_REPORTS
 */
function header_version return varchar2 is
begin
  return 'Package header STO_ALL '||G_HEADER_VERSION;
end header_version;


/**
 * body_version - возвращает версию тела пакета DKU_REPORTS
 */
function body_version return varchar2 is
begin
  return 'Package body STO_ALL '||G_BODY_VERSION;
end body_version;


end STO_ALL;
/
 show err;
 
PROMPT *** Create  grants  STO_ALL ***
grant EXECUTE                                                                on STO_ALL         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on STO_ALL         to STO;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/sto_all.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 