

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/REZ_BRA.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure REZ_BRA ***

  CREATE OR REPLACE PROCEDURE BARS.REZ_BRA ( Mode_ int, FLG_ int )  IS

  l_DAT31 date;
  l_DAT32 date;

  U_REZ_ REZ_PROTOCOL.USERID%type; -- \ юзер и дата по реальному расчету резервов
  D_REZ_ REZ_PROTOCOL.DAT%type   ; -- /

  l_NAME31   META_MONTH.NAME_PLAIN%type;
  l_NAME32   META_MONTH.NAME_PLAIN%type;

  l_OB22     specparam_int.OB22%type    ;
  l_NBS77    accounts.NBS%type          ;
  l_NLS77    accounts.NLS%type          ;
  l_NMS77    accounts.NMS%type          ;

  l_NLS77b   accounts.NLS%type          ;
  l_NMS77b   accounts.NMS%type          ;
  l_OST77b   accounts.OSTC%type         ;

  l_CUSTTYPE SREZERV.CUSTTYPE%type:=7   ;
  l_S080     SREZERV.s080%type    :='X' ;
  l_ID       SREZERV.id%type      :=-777;
  l_SPECREZ  SREZERV.SPECREZ%type :=-777;
  l_pkv      int                  :=-777;
  l_980      int                  := 980;

  l_S        oper.S%type   ;
  l_REF      oper.REF%type ;
  l_DK       oper.DK%type  ;
  l_TT       oper.TT%type  ;
  l_VOB      oper.VOB%type := 6;
  l_NAZN     oper.NAZN%type;

BEGIN

 --определить отчетную дату от текущей
 If to_char(gl.BDATE ,'dd')>'20' then
    l_DAT31 := gl.BDATE;
 else
    select max(fdat) into l_DAT31 from fdat
    where to_char(fdat,'YYYYMM') < to_char(gl.BDATE,'YYYYMM');
 end if;
 select NAME_PLAIN into l_NAME31
   from META_MONTH where n=to_number(to_char(l_DAT31,'MM'));

 l_DAT32 := add_months(l_DAT31, -1);
 select NAME_PLAIN into l_NAME32
   from META_MONTH where n=to_number(to_char(l_DAT32,'MM'));

--  юзер и дата по реальному расчету резервов
 begin
    select min(p.USERID), max(p.DAT)
    into U_REZ_, D_REZ_
    from REZ_PROTOCOL p
    where p.dat <= l_DAT31
      and to_char(p.dat,'yyyymm')=to_char(l_DAT31,'yyyymm')
      and exists (select 1 from TMP_REZ_RISK where DAT= p.DAT and id=p.USERID);
  EXCEPTION WHEN NO_DATA_FOUND THEN  null;
  end;
  If U_REZ_ is null then
     RAISE_APPLICATION_ERROR (-20001,
     'Не виконано загальний розрахунок резерву на дату '||to_char(l_DAT31,'dd/mm/yyyy') );
     return;
  end if;

  -- Корректирующие ?
  If To_char( l_DAT31,'YYYYMM') < To_char(gl.BDATE,'YYYYMM') then
     l_VOB :=96;
  end if;

--  Расформирование резерва со счетов бранчей
if MODE_=0 then
   FOR G in (select distinct
                    a.branch, a.nls, substr(a.nls,1,38) NMS, s.ob22, a.nbs
             from accounts a, specparam_int s
             where a.acc = s.acc and a.kv=l_980 and a.nls like '77%'
               and exists
               (select 1 from srezerv where s_FORM=a.NLS OR s_FORMV=a.NLS)
             )
   LOOP
      for B in (select a.nls, substr(a.nls,1,38) NMS, -a.OSTC S
                from accounts a, specparam_int s
                where a.acc =s.acc  and a.kv =l_980 and a.ostc=a.ostb
                  and s.ob22=G.OB22 and a.nbs=G.NBS and a.branch<>G.BRANCH
                  and a.ostc< 0
               )
      loop
         l_NAZN:='Розформований резерв за '|| l_NAME32 ||' '|| to_char(l_DAT32,'YYYY') ||'p.';
         gl.ref (l_REF);
         INSERT INTO oper
           (ref,tt  , vob    ,nd   ,dk   ,pdat   ,vdat   ,datd , S2,
            nam_a   , nlsa   ,mfoa ,nam_b,nlsb   ,mfob   ,kv   , s ,nazn)
         VALUES
         (l_REF,l_TT, l_VOB  ,l_REF,1    ,SYSDATE,l_DAT31,gl.bDATE,B.S,
          G.NMS,G.NLS,gl.aMFO,B.NMS,B.NLS,gl.aMFO,l_980  ,B.S,
          l_NAZN );
         gl.payV(0,l_REF,gl.BDATE,l_TT,1,l_980,G.NLS,B.S,l_980,B.NLS,B.S);
         If FLG_ =1  then
            gl.pay(2, l_REF, gl.BDATE);
         end if;
      end loop;
   END LOOP;

   return;
end if;
-------------------
  for k in (select t.CUSTTYPE,      t.S080,    t.idr  ID,
               decode(t.kv,l_980,0,1) PKV,
               rez.id_specrez(t.wdate,t.istval,t.kv,t.idr,t.custtype) SPECREZ,
               a.branch,
               sum(NVL (sz1, sz)) SZ
            from accounts a,  tmp_rez_risk t
            where t.acc=a.acc and t.dat = D_REZ_ and t.id=U_REZ_
            group by t.CUSTTYPE,    t.S080,    t.idr,
                     decode(t.kv,l_980,0,1),
                     rez.id_specrez(t.wdate,t.istval,t.kv,t.idr,t.custtype),
                     a.branch
            Order by 1,2,3,4,5,6
            )

  loop
     --найти котловой счет - один раз для всех бранчей
     if l_CUSTTYPE <>k.CUSTTYPE OR l_S080 <>k.S080 OR l_ID<>k.ID  OR
        l_SPECREZ  <>k.SPECREZ  OR l_pkv  <>k.PKV then
        begin

           select decode(k.pkv,0, S_FORM, S_FORMV)
           into l_NLS77
           from srezerv
           where CUSTTYPE=k.CUSTTYPE and  S080=k.S080 and  ID =k.ID
             and SPECREZ =k.SPECREZ
             and decode(k.pkv,0, S_FORM, S_FORMV) is not null;

           select substr(a.nms,1,38),s.ob22, a.nbs
           into   l_NMS77,           l_OB22, l_NBS77
           from accounts a, specparam_int s
           where a.kv=l_980 and a.nls=l_NLS77 and a.dazs is null
             and a.acc=s.acc and a.branch<>k.BRANCH ;

           l_CUSTTYPE := k.CUSTTYPE ;
           l_S080     := k.S080     ;
           l_ID       := k.ID       ;
           l_SPECREZ  := k.SPECREZ  ;
           l_pkv      := k.PKV      ;

           If k.S080 ='1' then l_TT :='ARE';
           else                l_TT :='AR*';
           end if;

        EXCEPTION WHEN NO_DATA_FOUND THEN goto NextRec;
        END;
     end if;

     -- найти счет своего бранча (или вышестоящего бранча)
     begin
        select a.nls , substr(a.nms,1,38), a.ostc
        into l_NLS77b, l_NMS77b  ,         l_OST77b
        from accounts a, specparam_int s
        where s.ob22  =l_OB22   and a.nbs= l_NBS77 and a.dazs is null
          and a.branch=k.branch and a.nls<>l_NLS77 and rownum=1;
     EXCEPTION WHEN NO_DATA_FOUND THEN
        begin
          select a.nls , substr(a.nms,1,38), a.ostc
          into l_NLS77b, l_NMS77b  ,         l_OST77b
          from accounts a, specparam_int s
          where s.ob22=l_OB22 and a.nbs=l_NBS77 and a.dazs is null
            and a.branch=substr(k.branch, 1, length(k.branch)-7 )
            and a.nls<>l_NLS77 and rownum=1;
        EXCEPTION WHEN NO_DATA_FOUND THEN goto NextRec;
        END;
     END;
-----------------------------------------
--         l_S :=  k.SZ + l_OST77b ;

           l_S :=  k.SZ + 0 ;
     If    l_S  =  0 then  goto NextRec;
     ElsIf l_S  >  0 then  l_DK :=1;              l_NAZN :='Формування';
     ElsIf l_S  <  0 then  l_DK :=0; l_S:= - l_S; l_NAZN :='Зменшення' ;
     end if;
     ---------------------------------------------------
     l_NAZN := l_NAZN ||
          ' суми резерву за '|| l_NAME31 ||' '|| to_char(l_DAT31,'YYYY') ||'p.';
     gl.ref (l_REF);
     INSERT INTO oper
        (ref,tt  , vob     , nd     , dk     , pdat   , vdat   , datd ,
         nam_a   , nlsa    , mfoa   , nam_b  , nlsb   , mfob   , kv   , s ,nazn)
     VALUES
      (l_REF,l_TT, l_VOB   , l_REF  , l_DK   , SYSDATE, l_DAT31, gl.bDATE,
       l_NMS77b  , l_NLS77b, gl.aMFO, l_NMS77, l_NLS77, gl.aMFO, l_980,l_S,
       l_NAZN );

     gl.payV(0,l_REF,gl.BDATE,l_TT,l_DK,l_980,l_NLS77b,l_S,l_980,l_NLS77,l_S);

     If FLG_ =1  then
        gl.pay(2, l_REF, gl.BDATE);
     end if;
     ------------------------------------------
     <<NextRec>> null;
  end loop;

END REZ_BRA ;
/
show err;

PROMPT *** Create  grants  REZ_BRA ***
grant EXECUTE                                                                on REZ_BRA         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on REZ_BRA         to RCC_DEAL;
grant EXECUTE                                                                on REZ_BRA         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/REZ_BRA.sql =========*** End *** =
PROMPT ===================================================================================== 
