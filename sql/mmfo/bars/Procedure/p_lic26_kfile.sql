

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_LIC26_KFILE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_LIC26_KFILE ***

  CREATE OR REPLACE PROCEDURE BARS.P_LIC26_KFILE 
             (p_s      date,           -- дата по
              p_corpc  varchar2 )      -- код корпорации
is
--======================================================================================
-- Module      : REP
-- Author      : ANNY(copy A.Yurchenko)
-- Description : Процедура для выписки с еквивалентами (файл К для Ощадбанка) по корпоративным NEW
--               клиентам
--
-- 24/12/2016 Serednii Serhii
--      - при вибірці по всім клієнтам прагнуло OB_CORPORATION_DATA.CORPORATION_ID := '%', змінив на KOD_CORP
--      - було OB_CORPORATION_DATA.FILE_DATE:=SYSDATE, змінив на TRUNC(P_S)
--      - змінив виклик KFILE_SYNC.GET_SYNC_ID на виклик з параметрами для коректного заповнення OB_CORPORATION_SESSION.FILE_DATE
--      - у випадку ORA-00054: resource busy на truncate table TMP_LICCORPC_KFILE') виконую delete from TMP_LICCORPC_KFILE
--
-- Version     : v1.0 19-01-2016
--======================================================================================

   l_mfo      varchar2(12);
   l_nb       varchar2(38);
   l_okpo     varchar2(160);
   l_time     varchar2(50);
   l_nlsa     varchar2(14);
   l_nlsb     varchar2(14);
   l_nama     varchar2(38);
   l_namb     varchar2(38);
   l_okpoa    varchar2(19);
   l_okpob    varchar2(19);
   l_nazn     varchar2(160);
   l_ostqp    number;
   l_prevcur  number;
   l_currcur  number;
   l_ostfq    number;
   l_ostq     number;
   l_sq       number;
   l_s        number;
   l_psum     number;
   l_bdat_prv date;
   l_dk       number;
   l_lcv      char(3);


   l_sumdbq   number;  -- общая сумма дебет  в эквиваленте по всем платежам ждя данного счета
   l_sumkrq   number;  -- общая сумма кредит в эквиваленте по всем платежам ждя данного счета
   l_postdat  date;

   l_sync     number;

   type t_kontr is record( mfo  varchar2(6),
                           nls  varchar2(14),
                           nam  varchar2(70),
                           okpo varchar2(16),
                           kv   number
                         );

   l_kontrA    t_kontr;
   l_kontrB    t_kontr;
   l_kontr     t_kontr;
   l_kontrdocB t_kontr;
   l_kontrdocA t_kontr;

   l_whoiam  number;   -- 0-плательщик, 1- получатель


   G_ROWTYPE_DOC   number := 1;
   G_ROWTYPE_ACC   number := 0;
   G_ROWTYPE_TOTAL number := 2;


   -- таблица символов для преобразования win -> уергост, непечатаемых символов в пробелы, символа | в пробел
   -- 32 символа непечатные,  1 символ  '|', 75 буквы = 108

/*
   G_WIN  constant varchar2(108) := sep.WIN_||
                                    chr(00)||chr(01)||chr(02)||chr(03)||chr(04)||chr(05)||chr(06)||chr(07)||
                                    chr(08)||chr(09)||chr(10)||chr(11)||chr(12)||chr(13)||chr(14)||chr(15)||
                    chr(16)||chr(17)||chr(18)||chr(19)||chr(20)||chr(21)||chr(22)||chr(23)||
                    chr(24)||chr(25)||chr(26)||chr(27)||chr(28)||chr(29)||chr(30)||chr(31)||
                    chr(124);

   G_DOS  constant varchar2(108) := sep.DOS_||
                                    rpad(' ',32)||
                                    ' ';
*/

   -- по операции дает назнчение
   --function get_nazn (p_tt varchar2, p_tto varchar2, p_txt varchar2, p_nazn varchar2) return varchar2
   --is
   --begin
   --end;
begin

    begin
        execute immediate('truncate table TMP_LICCORPC_KFILE');

    exception
    when others then
        if sqlcode = -54 then   -- ORA-00054: resource busy
            delete from tmp_liccorpc_kfile;
        else
            raise;
        end if;
    end;

   bars_audit.trace('p_lic26_kfile: формирование К файла за: ' ||to_char(p_s,'dd/mm/yyyy') ||' маска корпорации: '||p_corpc);
   -----------------------------
   -- по счетам
   -----------------------------
   for c0 in (select s.acc sal_acc, a.acc, nvl(s.fdat, p_s) fdat, nvl(s.ost,0) ost,
                      a.nls, a.kv, nvl(s.kos, 0) kos,
                      nvl(s.dos, 0) dos,
                      a.nms nms,
                      s.dapp, m.okpo,
                      m.nmkk nmk,
                      (s.ost+s.dos-s.kos) ostf, m.rnk, trkk_kod typnls,
                      decode(nvl(alt_corp_cod,0),  0,  a.corp_kod, alt_corp_cod )  kodk,
              ALT_USTAN_COD kodu, c.pos
                 from sal s, customer m, /*V_CORP_ACCOUNTS_KFILE*/ V_CORP_ACCOUNTS_WEB a, accounts c
                where s.acc(+)    = a.acc
                  and a.acc= c.acc
                  and s.fdat (+)  = p_s
              and a.use_invp  = 'Y'
                  and a.rnk       = m.rnk
                  --and a.corp_kod   like p_corpc
                  and decode(p_corpc,'%', decode(nvl(alt_corp_cod,0),  0,  a.corp_kod, alt_corp_cod ), p_corpc) = decode(nvl(alt_corp_cod,0),  0,  a.corp_kod, alt_corp_cod )
                  and (a.dazs is null or a.dazs >= p_s)
             )
    /*(select s.acc sal_acc, a.acc, nvl(s.fdat, p_s) fdat, nvl(s.ost,0) ost,
                      a.nls, a.kv, nvl(s.kos, 0) kos,
                      nvl(s.dos, 0) dos,
                      a.nms nms,
                      s.dapp, m.okpo,
                      m.nmkk nmk,
                      (s.ost+s.dos-s.kos) ostf, m.rnk, trkk_kod typnls,
              decode(nvl(alt_corp_cod,0),  0,  a.corp_kod, alt_corp_cod ) kodk,
              inst_kod kodu, c.pos
                 from sal s, customer m, V_CORP_ACCOUNTS_KFILE a, accounts c
                where s.acc(+)    = a.acc
                  and a.acc= c.acc
                  and s.fdat (+)  = p_s
                  and a.use_invp  = 'Y'
                  and a.rnk       = m.rnk
                  and ( (a.corp_kod   like p_corpc and alt_corp_cod is null) or
                        (alt_corp_cod like p_corpc)
                      )
                  and (a.dazs is null or a.dazs >= p_s)
             )*/
   loop



      bars_audit.trace('p_lic26_kfile: за число : ' ||to_char(c0.fdat,'dd/mm/yyyy') ||' счет '||c0.nls||'-'||c0.kv);
      bars_audit.trace('p_lic26_kfile: за число : ' ||to_char(c0.fdat,'dd/mm/yyyy') ||' счет '||c0.nls||'-'||c0.kv);


      l_sumdbq := 0;
      l_sumkrq := 0;

      l_ostq   := case  c0.kv  when  gl.baseval  then c0.ost else 0 end;

      -----------------------------
      -- по проводкам
      -----------------------------
      for c1 in ( select ref,tt, s * decode(dk,0,-1,1) s,txt, dk, stmt, f_ourmfo kf
                  from opldok where acc=c0.acc and fdat=c0.fdat and sos=5 )
      loop


         -----------------------------
         -- по документам
         -----------------------------
         for c2 in (select o.vob,
                           replace(o.nd, '|', '/') nd,
                           o.dk, o.mfoa, o.nlsa, o.nam_a, o.id_a,
                           o.mfob, o.nlsb,    o.nam_b, o.id_b,
                           o.ref, o.kv2,
                           case when o.tt = c1.tt or o.tt = 'R00' or o.tt = 'R01' or o.tt = 'ЭНД' or o.tt='ЭНК' then o.nazn
                           else t.name
               end nazn,
                           o.userid, o.sk, o.kv, o.d_rec, o.datd, o.pdat, o.vdat, o.datp,
                           to_char(pdat,'hh24mi') dtime,
                           o.tt
                    from oper o, tts t
                    where o.ref=c1.ref and c1.tt=t.tt )
         loop


               begin
                  -- исключаем технологические визы
                  select dat into l_postdat
                    from oper_visa
                   where status = 2 and ref = c1.ref and groupid not in (77,80,81,30,94,130);
               exception when no_data_found then
                  l_postdat := to_date(to_char(c0.fdat,'ddmmyyyy')||to_char(c2.pdat,'hh24miss'),'ddmmyyyyhh24miss');
               end;



               --l_postdat := c0.fdat;
               l_sq :=0;
               l_s  :=   sign(c1.s) * c1.s;

               if c0.kv <> gl.baseval then
               l_sq:= gl.p_icurval(c0.kv, l_s, c0.fdat);
               if c1.dk = 1 then
                  l_sumkrq := l_sumkrq +  l_sq;
               else
                  l_sumdbq := l_sumdbq +  l_sq;
               end if;
           else
               l_sq:= l_s;
               if c1.dk = 1 then
                  l_sumkrq := l_sumkrq +  l_s;
               else
                  l_sumdbq := l_sumdbq +  l_s;
               end if;
               end if;


            l_kontr.mfo  := c1.kf;
            l_kontr.nls  := c0.nls;
            l_kontr.nam  := c0.nms;
            l_kontr.okpo := c0.okpo;
            l_kontr.kv   := c0.kv;

            l_kontrdocA.mfo  := c1.kf;
            l_kontrdocA.nls  := c2.nlsa;
            l_kontrdocA.nam  := c2.nam_a;
            l_kontrdocA.okpo := c2.id_a;
            l_kontrdocA.kv   := c0.kv;

            l_kontrdocB.mfo  := c1.kf;
            l_kontrdocB.nls  := c2.nlsb;
            l_kontrdocB.nam  := c2.nam_b;
            l_kontrdocB.okpo := c2.id_b;
            l_kontrdocB.kv   := c0.kv;


              if c1.dk = 0 then
               l_whoiam := 0;
               -- если счет присутсвует в документе, тогда реквизиты брать из документа
               if (c0.nls = c2.nlsa or c0.nls = c2.nlsb)  then
                  l_kontrA:= case when c0.nls = c2.nlsa then l_kontrdocA else l_kontrdocB end;
               -- иначе, реквизиты счета и клиента
               else
                  l_kontrA  := l_kontr;
               end if;

            else
               l_whoiam := 1;
               if (c0.nls = c2.nlsa or c0.nls = c2.nlsb)  then
                  l_kontrB:= case when c0.nls = c2.nlsa then l_kontrdocA else l_kontrdocB end;
               else
                  l_kontrB  := l_kontr;
               end if;

            end if;




            -- найдем контр агента по OPLDOK
            if (c1.tt<>c2.tt) or
               (c2.nlsa<>c0.nls and c2.nlsb<>c0.nls ) then

               l_kontr.mfo  := c1.kf;

               -- найти вторую сторону по opldok
               select nls, kv, okpo, nmk
                 into l_kontr.nls, l_kontr.kv, l_kontr.okpo, l_kontr.nam
                 from accounts a, customer c
                where a.rnk = c.rnk
                  and acc = (select acc
                               from opldok
                              where ref = c1.ref and stmt = c1.stmt and dk<> c1.dk);
              if l_whoiam = 0 then
                 l_kontrB  := l_kontr;
              else
                 l_kontrA  := l_kontr;
              end if;

            else
               if l_whoiam = 0 then   -- мы плательщики
                  if c2.dk = 1 then
                     l_kontrB.mfo  := c2.mfob;
                     l_kontrB.nls  := c2.nlsb;
                     l_kontrB.nam  := c2.nam_b;
                     l_kontrB.okpo := c2.id_b;
                     l_kontrB.kv   := c2.kv2;
                  else
                     l_kontrB.mfo  := c2.mfoa;
                     l_kontrB.nls  := c2.nlsa;
                     l_kontrB.nam  := c2.nam_a;
                     l_kontrB.okpo := c2.id_a;
                     l_kontrB.kv   := c2.kv;
                  end if;

               else                   -- мы получатели
                  if c2.dk = 1 then
                     l_kontrA.mfo  := c2.mfoa;
                     l_kontrA.nls  := c2.nlsa;
                     l_kontrA.nam  := c2.nam_a;
                     l_kontrA.okpo := c2.id_a;
                     l_kontrA.kv   := c2.kv;
                  else
                     l_kontrA.mfo  := c2.mfob;
                     l_kontrA.nls  := c2.nlsb;
                     l_kontrA.nam  := c2.nam_b;
                     l_kontrA.okpo := c2.id_b;
                     l_kontrA.kv   := c2.kv2;
                  end if;
               end if;
            end if;




           insert into TMP_LICCORPC_KFILE(
                  rowtype,  ourmfo,kf,  nls,  kv,
                  kod_corp,  kod_ustan,  kod_analyt,
                  postdat, docdat, valdat,
                  nd,  vob,  dk,
                  mfoa,  nlsa,  kva,
                  nama,  okpoa,
                  mfob,  nlsb,  kvb,
                  namb,  okpob,
                  s,  dockv,  sq,
          nazn,
          doctype,
                  namk,  nms, tt
                 )
            values(
                  G_ROWTYPE_DOC, gl.amfo,gl.amfo, c0.nls, c0.kv,
                  c0.kodk,  c0.kodu,  c0.typnls,
                  l_postdat,  c2.datd,  c2.vdat,
                  c2.nd,    c2.vob,   1,
                  l_kontrA.mfo,  l_kontrA.nls,  l_kontrA.kv,
                  replace(l_kontrA.nam, '|',' ') , l_kontrA.okpo,
                  l_kontrB.mfo,  l_kontrB.nls,  l_kontrB.kv,
                  replace(l_kontrB.nam, '|',' '), l_kontrB.okpo,
                  l_s,     c0.kv,    l_sq,
          replace(c2.nazn,'|',' ') ,
          c1.dk,
                  c0.nmk, c0.nms, c1.tt
               );

         end loop;   -- oper
      end loop;      -- opldok



      -- для валютного счета, если вообще было движение и он требует переоценку
      if c0.kv <> gl.baseval and c0.sal_acc is not null and (c0.pos <> 2 or c0.pos is null)  then

         -- найдем исходящий остаток в эквиваленте на отчетную дату
         l_ostq  := gl.p_icurval(c0.kv,c0.ost, c0.fdat);


         -- нужно подсчитать переоценку и сформировать псевдоплатеж (это только если входящий остаток <>0)
         -- а также сформировать псевдо платеж если сумма еквивалентов док-тов <> еквиваленту оборотов по счету.

         -- найдем исходящий остаток в эквиваленте на предидущий день движения
      /*
       begin
            select ostf + kos - dos
              into l_ostqp
              from saldob
             where (fdat, acc) = (select max(fdat), acc from saldob where acc = c0.acc and fdat < c0.fdat group by acc);
            bars_audit.trace('p_lic26: остаток предидущего дня из saldob: ' ||l_ostqp);

         exception when no_data_found then
            -- по какой-то причине не заполнено saldob за этот день, расчитаем вручную
            -- предидущая банк. дата
            select max(fdat) into l_bdat_prv
              from fdat
             where fdat < c0.fdat;

            -- исходящий остаток в эквиваленте на предидущий день.
            begin
               select gl.p_icurval(c0.kv, ost, l_bdat_prv)
                 into l_ostqp
                 from sal
                where acc = c0.acc and fdat = l_bdat_prv  and rownum =1 ;
               bars_audit.trace('p_lic26: остаток предидущего дня из sal + picurval : ' ||l_ostqp||' предидущий банк день = '||to_char(l_bdat_prv,'dd/mm/yyyy'));
            exception when no_data_found then
               -- а данный счет был открыт только в данный рабочий день, в предидущий банк день
               -- его не существовало
               l_ostqp := 0;
            end;
         end;

          */

            -- найдем исходящий остаток в эквиваленте на предидущий день движения
           l_ostqp:= fostq(c0.acc,dat_next_u(c0.fdat,-1));

         --
         --  l_ostqp + l_sumkrq - l_sumdbq  + X(l_psum) = l_ostq
         --  X - переоценка, котору нужно добавить к оборотам кредитовым или дебетовым и соответсвенно содать псевдо платеж на эту сумму
         --
         l_psum  := l_ostq - l_ostqp + l_sumdbq - l_sumkrq;

         --bars_audit.trace('p_lic26: остаток предидущего дня из sal + picurval : ' ||l_ostqp);
         --2bars_audit.trace(l_ostq||' - '||l_ostqp||' + '||l_sumdbq||' - '||l_sumkrq);

         -- формируем корректирующий платеж
         if l_psum <> 0 then
            begin
               select substr(val,1,38) into l_nb from params where par = 'NAME';
            exception when no_data_found then
               l_nb := 'our bank name' ;
            end;

            bars_audit.trace('требуется платеж переоценки');

            -- курс увеличился
            if (l_psum > 0 ) then
               l_nlsa   := '3801';
               l_nlsb   := c0.nls;
               l_nama   := l_nb;
               l_namb   := c0.nmk;
               l_okpoa  := gl.aokpo;
               l_okpob  := c0.okpo;
               l_dk     := 1;
               l_sumkrq := l_sumkrq + l_psum;
            else
               l_nlsb := '3801';
               l_nlsa := c0.nls;
               l_namb := l_nb;
               l_nama := c0.nmk;
               l_okpob:= gl.aokpo;
               l_okpoa:= c0.okpo;
               l_dk   := 1;
               l_sumdbq := l_sumdbq + (-1)* l_psum;
            end if;

            -- псевдо-платеж в связи с переоценкой
            if  l_ostqp <> 0 then
                -- для назначения платежа вытянем курсы
                select lcv into l_lcv
                from tabval  where kv = c0.kv;
                l_nazn := 'Переоцiнка залишку по '||l_lcv||'. ';

            else
                l_nazn := 'Коригування при обчисленнi еквiваленту';
            end if;


            -- сформируем псевдо-платеж
            insert into TMP_LICCORPC_KFILE(
                  rowtype,  ourmfo,kf,  nls,   kv,
                  kod_corp,  kod_ustan,  kod_analyt,
                  postdat, docdat, valdat,
                  nd,  vob,  dk,  mfoa,  nlsa,  kva,
                  nama,  okpoa,
                  mfob,  nlsb,  kvb,
                  namb,  okpob,
                  s,  dockv,  sq,
                  nazn, doctype,
                  namk, nms,tt )
            values(
                  G_ROWTYPE_DOC, gl.amfo, gl.amfo, c0.nls,   c0.kv,
                  c0.kodk,  c0.kodu,  c0.typnls,
                  p_s,  p_s,    p_s,
                  to_char(sysdate,'hh24miss'),  6,  l_dk,
                  gl.amfo,  l_nlsa,      c0.kv,
                  l_nama,  l_okpoa,
                  gl.amfo,  l_nlsb,      c0.kv,
                  l_namb,  l_okpob,
                  0,   c0.kv,   sign(l_psum)*l_psum,
                  l_nazn, (case when l_psum > 0 then 1 else 0 end),
                  c0.nmk, c0.nms,'PRC' );

         end if;  -- l_psum <> 0

      end if;  -- c0.kv <> gl.baseval and c0.sal_acc is not null




      --
      -- искусственно сделаем груповую строку по счету (тип строки = 0)
      --

      insert into TMP_LICCORPC_KFILE(
          rowtype,  ourmfo,kf,  nls,  kv,  okpo,  postdat,
          obdb,  obdbq,  obkr,  obkrq,  ost,  ostq,
          kod_corp,  kod_ustan,  kod_analyt, dapp, namk, nms)
      values (  G_ROWTYPE_ACC, gl.amfo,gl.amfo,  c0.nls, c0.kv, c0.okpo, c0.fdat,
                c0.dos,  l_sumdbq, c0.kos, l_sumkrq, c0.ost, l_ostq,
                c0.kodk,  c0.kodu,  c0.typnls, c0.dapp, replace(c0.nmk,'|',' '),    replace(c0.nms,'|',' ')
             );


   end loop; -- accounts



   --
   -- информация для раздела 2
   --

   insert into TMP_LICCORPC_KFILE(kf,rowtype, nls, docdat, kod_corp)
   select gl.amfo, G_ROWTYPE_TOTAL, count(*), docdat, kod_corp
     from TMP_LICCORPC_KFILE
    where rowtype = G_ROWTYPE_ACC
    group by docdat, kod_corp;
    /*begin
          select nvl(max(id), kfile_sync.get_sync_id) into l_sync from OB_CORPORATION_SESSION; --предполагаем, что сессия уже установлена
    exception when no_data_found then l_sync := kfile_sync.get_sync_id;
    end;*/

    l_sync := kfile_sync.get_sync_id(gl.amfo, p_corpc, to_char(p_s,'DDMMYYYY'), 'DATA');

---- для можливого тестування помилки поповнення таблиці OB_CORPORATION_DATA
--commit;
--for t in (select t.* from TMP_LICCORPC_KFILE t )
--loop
--    begin
--        insert into OB_CORPORATION_DATA o
--            ( corporation_id, file_date, rowtype, ourmfo, nls, kv, okpo, obdb, obdbq, obkr, obkrq, ost, ostq, kod_corp, kod_ustan, kod_analyt, dapp,
--          postdat, docdat, valdat, nd, vob, dk, mfoa, nlsa, kva, nama, okpoa, mfob, nlsb, kvb, namb, okpob, s, dockv, sq, nazn, doctype, posttime,
--          namk, nms, tt, session_id)
--            values( t.kod_corp, trunc(p_s), t.ROWTYPE, t.ourmfo, t.nls, t.kv, t.okpo,
--                    t.obdb, t.obdbq, t.obkr, t.obkrq, t.ost, t.ostq, t.kod_corp,
--                    t.kod_ustan, t.kod_analyt, t.dapp, t.postdat, t.docdat, t.valdat,
--                    t.nd, t.vob, t.dk, t.mfoa, t.nlsa, t.kva, t.nama, t.okpoa, t.mfob,
--                    t.nlsb, t.kvb, t.namb, t.okpob, t.s, t.dockv, t.sq, t.nazn,
--                    t.doctype, t.posttime, t.namk, t.nms, t.tt, l_sync);
--    exception
--    when others then
--        raise_application_error(-20000,'p_corpc='||to_char(p_corpc)||', l_sync='||to_char(l_sync)||', nls+nd = '||t.nls||'+'||t.nd);
--    end;
--end loop;
--raise_application_error(-20000,'stopped by me');
--dbms_output.put_line('p_s='||to_char(p_s,'dd/mm/yyyy'));

    insert into OB_CORPORATION_DATA o        --insert into RD data-table for reporting purposes
    ( corporation_id,
      file_date,
      rowtype,
      KF,
      nls,
      kv,
      okpo,
      obdb,
      obdbq,
      obkr,
      obkrq,
      ost,
      ostq,
      kod_corp,
      kod_ustan,
      kod_analyt,
      dapp,
      postdat,
      docdat,
      valdat,
      nd,
      vob,
      dk,
      mfoa,
      nlsa,
      kva,
      nama,
      okpoa,
      mfob,
      nlsb,
      kvb,
      namb,
      okpob,
      s,
      dockv,
      sq,
      nazn,
      doctype,
      posttime,
      namk,
      nms,
      tt,
      session_id)
    select t.kod_corp,
           trunc(p_s),
           t.ROWTYPE,
           t.kf,
            t.nls,
            t.kv,
            t.okpo,
            t.obdb,
            t.obdbq,
            t.obkr,
            t.obkrq,
            t.ost,
            t.ostq,
            t.kod_corp,
            t.kod_ustan,
            t.kod_analyt,
            t.dapp,
            t.postdat,
            t.docdat,
            t.valdat,
            t.nd,
            t.vob,
            t.dk,
            t.mfoa,
            t.nlsa,
            t.kva,
            t.nama,
            t.okpoa,
            t.mfob,
            t.nlsb,
            t.kvb,
            t.namb,
            t.okpob,
            t.s,
            t.dockv,
            t.sq,
            t.nazn,
            t.doctype,
            t.posttime,
            t.namk,
            t.nms,
            t.tt,
            l_sync
             from TMP_LICCORPC_KFILE t;
commit;
END p_lic26_kfile;
/
show err;

PROMPT *** Create  grants  P_LIC26_KFILE ***
grant EXECUTE                                                                on P_LIC26_KFILE   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_LIC26_KFILE.sql =========*** End
PROMPT ===================================================================================== 
