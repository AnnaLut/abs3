

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/FOREX_OB.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure FOREX_OB ***

  CREATE OR REPLACE PROCEDURE BARS.FOREX_OB 
 ( p_Mode  INT,
   p_1819  accounts.NLS%type,
   p_DAT   date default bankdate
   ) is

/*

19-11-2013   Квас  При переходе на новую схему БД заменила код операции на CV7 вместо 049 
27-08-07-2010 Сухова + Хихлуха Д.

Для ГОУ Ощадбанка/ По результатам встречи и постановке
- Безродная Светлана Васил 247-84-49
- Притуп Юрий Нииколаевич  247-86-60  8-067-693-09-35
p_Mode = 1 - выведение торгового рез по Центрам инициаторов операций
             CP_OB_INITIATOR за период с пред по p_DAT
*/

  INIC_  CP_OB_INITIATOR.code%type  := '12'    ; -- по умолчанию для 280,290
  tag_   operw.tag%type             := 'CP_IN' ;
  DAT1_ CP_OB_INITIATOR.FX_DATP%type;

  value_ operw.value%type  ;
  S_     oper.S%type       ;
  Q_     oper.S%type       ;
  REF_   oper.REF%type     ;
  NAZN_  oper.NAZN%type    ;
  TT_    oper.TT%type      := 'CV7';
  n980_  int               ;
  NLSk_  accounts.NLS%type ;
  DK_    oper.DK%type      ;

  ern CONSTANT POSITIVE := 333;    erm VARCHAR2(80);

begin

--logger.info ('FFF 1*' || p_Mode  ||','||  p_1819 ||','||   p_DAT  );
  n980_ := gl.baseval;

If p_Mode <>  1 then RETURN; end if;
------------------------------------

--------- 0. Дата пред выполнения  процедуры
begin
  select FX_DATP + 1 into DAT1_ from CP_OB_INITIATOR where FX_DATP is not null
     and rownum  = 1;
EXCEPTION WHEN NO_DATA_FOUND THEN DAT1_ := gl.bdate;
end;

--------- I. СНАЧАЛА ПРОВЕРИМ НА ДОП.РЕКВИЗИТ
FOR D IN ( SELECT o.dk, o.stmt, o.REF  FROM OPLDOK O, accounts a
           where o.acc=a.acc and a.nls = p_1819
             and o.fdat >= DAT1_ and o.fdat <= p_DAT  )
loop

   begin

       select value into value_ from operw where ref=d.REF and tag=tag_;


      -- заполнен -- а допустим ли по справочнику ?
      begin
         select FX_3800 into NLSk_ from CP_OB_INITIATOR
         where FX_3800 is not null and FX_6204 is not null and code = value_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         raise_application_error(-(20000+333),'\' ||
         'Реф=' || d.ref ||' доп.рекв ' || value_ ||
         ' не найдено в заповненому дов.CP_OB_INITIATOR',
         TRUE);
      end;

   EXCEPTION WHEN NO_DATA_FOUND THEN

      -- не заполнен -- а кто корреспондент ?
      begin
         select a.nls into NLSk_  from opldok o, accounts a
         where a.acc = o.acc and o.dk = 1-d.dk
           and o.stmt=d.stmt and o.ref=d.ref ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         raise_application_error(-(20000+333),'\' ||
         'Реф='||d.ref ||' stmt='||d.stmt || ' не найдено пару в проводке',
          TRUE);
      end;

      -- заносим умолчательное значение
      If substr(nlsk_,1,3) in ('280', '290') then
         begin
           insert into operw (ref, tag, value) values (d.REF, TAG_,INIC_ );
         exception when dup_val_on_index then null;
         end;
      else
         raise_application_error(-(20000+333),'\' ||
         'Реф='||d.ref ||' не определен доп.рекв '|| TAG_,
         TRUE);
      end if;

   end;

end loop ; ----D
------- конец проверки. она прошла успешно. Все доп.рекв есть ---------

------- II. выведение торгового рез по Центрам инициаторов операций
for c in (select i.code, trim(i.FX_3800) FX_3800,  r.nls NLSR, i.TXT,
                 substr(t.nms,1,38) NMST, substr(r.nms,1,38) NMSR
          from CP_OB_INITIATOR i, accounts t, accounts r
          where i.FX_3800 is not null and i.FX_6204 is not null
            and t.kv=n980_ and t.nls = p_1819    and t.dazs is null
            and r.kv=n980_ and r.nls = i.FX_6204 and r.dazs is null
           )
loop
   --logger.info ('FFF 2*' || c.code||',' || c.FX_3800 ||','||
   --             c.NLSR   ||',' || DAT1_ ||','||
   --             c.NMST   || ',' ||c.NMSR );

   for k in  (SELECT a.kv, Sum( decode(o.dk,1,1,-1) * o.s  ) S,
                           Sum( decode(o.dk,1,1,-1) * o.sq ) SQ
              FROM accounts a, opldok o, operw w
              WHERE a.acc = o.acc and a.nls = p_1819
                and o.ref = w.ref and w.tag = TAG_ and w.value =c.CODE
                and o.sos = 5
                and o.fdat >= DAT1_ and o.fdat <= p_DAT
              GROUP BY a.kv
              HAVING Sum( decode(o.dk,1,1,-1) * o.s ) <> 0
              )

   loop
     --logger.info ('FFF 3*'|| k.kv ||','||   k.s   ||','|| k.sq );

     GL.REF (REF_);
     NAZN_ := k.KV || '/Торг.результат FOREX по центру '|| c.TXT ||
              ' за перiод ' ||
              to_char(DAT1_,'dd.mm.yyyy') ||' - ' ||
              to_char(p_DAT ,'dd.mm.yyyy');
     If k.S > 0 then DK_ := 1;
     else            DK_ := 0;
     end if;

     S_ := Abs(k.S );
     Q_ := Abs(k.SQ);

     GL.IN_DOC3  (REF_,TT_,6,REF_,
         SYSDATE,GL.BDATE,DK_,n980_,Q_,n980_,Q_,null,GL.BDATE,GL.BDATE,
         c.NMST ,p_1819 ,gl.AMFO,   c.NMSR,c.NLSR,gl.AMFO,  NAZN_,
         NULL, gl.aOKPO, gl.aOKPO,  null, null, null, null, gl.auid);

     If k.kv = n980_ then

        GL.PAYV(0,REF_,GL.BDATE,TT_,DK_,k.kv,p_1819,Q_,k.kv,c.NLSR,Q_);

     else

        begin
           select b.nls into NLSk_
           from accounts a, accounts b, vp_list v
           where v.acc3800 = a.acc and b.acc=v.acc3801
             and a.kv=k.kv and a.nls = c.FX_3800;
        EXCEPTION WHEN NO_DATA_FOUND THEN
           raise_application_error(-(20000+333),'\' ||
           'Сч.'||c.FX_3800||'/'|| k.kv || ' НЕ описан в VP_LIST',
            TRUE);
        end;

        GL.PAYV(0,REF_,GL.BDATE,TT_,DK_,k.kv ,p_1819, S_,k.kv ,c.FX_3800,S_);
        GL.PAYV(0,REF_,GL.BDATE,TT_,DK_,n980_,NLSk_ , Q_,n980_,c.NLSR   ,Q_);

     end if;

     insert into operw (ref, tag, value) values (REF_, TAG_, c.CODE);

   END LOOP;  ------ K

   update CP_OB_INITIATOR set  FX_DATP = gl.bdate where code = c.CODE;

end loop; ---- C


end FOREX_OB;
/
show err;

PROMPT *** Create  grants  FOREX_OB ***
grant EXECUTE                                                                on FOREX_OB        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FOREX_OB        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/FOREX_OB.sql =========*** End *** 
PROMPT ===================================================================================== 
