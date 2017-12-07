

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ZVT_DOC.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ZVT_DOC ***

  CREATE OR REPLACE PROCEDURE BARS.P_ZVT_DOC (ss_FDAT varchar2) is

 --23-05-2012 Расчетн?й єкв
 --18.05.2012 Позор ! потеряли sos>= 4 !!!
 --16-05-2012 Замена 86* на родителя 26*

 p_FDAT date    ;
 s_FDAT char(10);
 nls_   accounts.nls%type;
 ----------------------------------------------------
 SLEEP_TIMEOUT constant number := 2;
 l_isclear boolean;

 PART_NOT_EXISTS exception;
 pragma exception_init(PART_NOT_EXISTS, -2149);

 RESOURCE_BUSY exception;
 pragma exception_init(RESOURCE_BUSY, -54 );

 CANT_DROP_LAST_PART exception;
 pragma exception_init(CANT_DROP_LAST_PART, -14758 );

begin

 If ss_FDAT is null then RETURN; end if;
 ----------------------------------------
 tuda;
 p_FDAT := nvl( to_date(ss_FDAT,'dd.mm.yyyy'), gl.bd);
 s_FDAT := to_char (p_FDAT,'dd.mm.yyyy');

logger.info ('ZVT_DOC-1 Begin s_FDAT = '|| s_FDAT);
 -----------
 execute immediate 'truncate table Tmp_zvt ';

 -- наполнить врем табл
 insert into TMP_ZVT (ref,stmt,dk,s,sq,accd,acck, tt)
   select ref,stmt,dk,s,sq,decode( dk,0,acc,null), decode(dk,1,acc, null) , tt
   from opldok  where sos >= 4   and fdat = P_FDAT ;

 -- развернуть врем табл
 update Tmp_zvt t
    set t.acck=(select acck from Tmp_zvt where dk=1 and ref=t.ref and stmt=t.stmt)
 where dk = 0 ;

 delete from Tmp_zvt where dk=1 ;
 ----------------------------------------
 commit;
 logger.info ('ZVT_DOC-2 формир.Tmp ');
 -- сбор статистики
 dbms_stats.gather_table_stats('bars', 'Tmp_zvt');
----------------------------------------------------------------------

 -- удаляем старые партиции
 for c in ( select * from iot_calendar
            where
-- отключено временно до полной ликвидации "хвостов" по своду док дня
------------------cdat between p_fdat-16 and p_fdat-6 or
                  cdat=p_fdat
            order by cdat desc
           )
 loop
   l_isclear := false;
   loop
     begin
       execute immediate
         'alter table PART_ZVT_DOC drop partition for (to_date('''||to_char(c.cdat,'dd.mm.yyyy')||''',''dd.mm.yyyy''))';
       l_isclear := true;
      exception when CANT_DROP_LAST_PART then l_isclear := true;
                when PART_NOT_EXISTS     then l_isclear := true;
                when RESOURCE_BUSY       then dbms_lock.sleep(SLEEP_TIMEOUT);
     end;

     exit when (l_isclear);

 end loop;
 logger.trace('партиция %s за дату удалена', to_char(c.cdat,'dd.mm.yyyy'));
 end loop;
--------------------------------------------------------------------

 -- наполнение проводок отч.даты
 If gl.aMfo = '380764' then
    -- для НАДРА расч. экв
    insert into PART_ZVT_DOC (FDAT,ISP,KV,TT,REF,stmt,NLSD,NLSK,BRANCH,TEMA,SQ,S)
    select p_FDAT, p.USERID, ad.KV, o.TT, p.REF, o.stmt, ad.nls NLSD, ak.nls NLSK,
        ZVT_B(ad.nbs,ak.NBS,ad.branch,ak.branch,p.branch ) BRANCH,
        ZVT_F(ad.nbs,ak.NBS,ad.branch,ak.branch,o.tt,p.MFOA,p.MFOB,p.TT) TEMA,
--------o.SQ,
        decode ( ad.kv, 980, o.SQ, gl.p_icurval (ad.kv, o.S, p_FDAT) ),
        o.S*sign(ZVT_F(ad.nbs,ak.NBS,ad.branch,ak.branch,o.tt,p.MFOA,p.MFOB,p.TT)) S
    from Tmp_zvt o,
         oper p,
        (select a.nbs, a.acc,a.kv,a.nls,a.branch from accounts a, saldoa s
         where  a.acc=s.acc and s.fdat=p_FDAT and s.dos >0) ad,
        (select a.nbs,a.acc,a.kv,a.nls,a.branch from accounts a, saldoa s
         where  a.acc=s.acc and s.fdat=p_FDAT and s.kos >0) ak
    where o.ref  = p.REF
      and o.accd = ad.acc
      and o.acck = ak.acc
      and ( ad.nbs not like '8%' or ak.nbs not like '8%');

 else
    -- для других реальн. экв из проводки
    insert into PART_ZVT_DOC (FDAT,ISP,KV,TT,REF,stmt,NLSD,NLSK,BRANCH,TEMA,SQ,S)
    select p_FDAT, p.USERID, ad.KV, o.TT, p.REF, o.stmt, ad.nls NLSD, ak.nls NLSK,
        ZVT_B(ad.nbs,ak.NBS,ad.branch,ak.branch,p.branch ) BRANCH,
        ZVT_F(ad.nbs,ak.NBS,ad.branch,ak.branch,o.tt,p.MFOA,p.MFOB,p.TT) TEMA,
        o.SQ,
--------decode ( ad.kv, 980, o.SQ, gl.p_icurval (ad.kv, o.S, p_FDAT) ),
        o.S*sign(ZVT_F(ad.nbs,ak.NBS,ad.branch,ak.branch,o.tt,p.MFOA,p.MFOB,p.TT)) S
    from Tmp_zvt o,
         oper p,
        (select a.nbs, a.acc,a.kv,a.nls,a.branch from accounts a, saldoa s
         where  a.acc=s.acc and s.fdat=p_FDAT and s.dos >0) ad,
        (select a.nbs,a.acc,a.kv,a.nls,a.branch from accounts a, saldoa s
         where  a.acc=s.acc and s.fdat=p_FDAT and s.kos >0) ak
    where o.ref  = p.REF
      and o.accd = ad.acc
      and o.acck = ak.acc
      and ( ad.nbs not like '8%' or ak.nbs not like '8%');

      update PART_ZVT_DOC set branch = substr(branch,1,8) where abs(tema) = 14 and fdat = p_FDAT;

 end if;

---------------------------------
 logger.trace ('PART_ZVT_DOC End-1 s_FDAT = '|| s_FDAT);


 for k in (select kv,nlsd,nlsk, rowid RI
           from PART_ZVT_DOC
           where FDAT = p_FDAT
             and ( nlsd like '86%' and nlsk not like '8%' or
                   nlsk like '86%' and nlsd not like '8%'
                 )
           )
 loop
   begin

     If k.nlsd like '86%' then

        select rod.nls
        into nls_
        from accounts rod, accounts doc
        where doc.kv = k.kv and doc.nls = k.nlsd and doc.accc = rod.acc;

        update PART_ZVT_DOC set nlsd = nls_ where rowid = k.RI;

     else
        select rod.nls into nls_
        from accounts rod, accounts doc
        where doc.kv = k.kv and doc.nls = k.nlsk and doc.accc = rod.acc;

        update PART_ZVT_DOC set nlsk = nls_ where rowid = k.RI;
     end if;
   EXCEPTION WHEN NO_DATA_FOUND THEN null;
   end;
 end loop;
 -- В будущем желательно убрать. чтобы не делать лишний поиск
        insert into part_zvt_doc (fdat, isp, kv, tt, ref, stmt, nlsd,nlsk,branch,tema,sq,s)
        select dat_alt, isp, kv, '024', -1,  0, decode (zn,1,nlsalt,nls),  decode(zn,1,nls,nlsalt), branch, 80, gl.p_icurval(kv,vx,p_FDAT), vx
        from (select dat_alt, isp, kv, ABS(fost(acc,(p_FDAT-1))) vx, sign(fost(acc,(p_FDAT-1))) zn,  nls, nlsalt, branch
              from accounts where nlsalt is not null and dat_alt = p_FDAT and fost(acc,(p_FDAT-1)) <>0 
              );
 logger.trace ('PART_ZVT_DOC End s_FDAT = '|| s_FDAT);

 -- сбор статистики
 dbms_stats.gather_table_stats('BARS', 'PART_ZVT_DOC');

end p_ZVT_DOC; 
/
show err;

PROMPT *** Create  grants  P_ZVT_DOC ***
grant EXECUTE                                                                on P_ZVT_DOC       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_ZVT_DOC       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ZVT_DOC.sql =========*** End ***
PROMPT ===================================================================================== 
