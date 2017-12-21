CREATE OR REPLACE function BARS.CC_O_NLS_EXT
  (bal_     in varchar2,
   RNK_     in int,
   sour_    in int,
   ND_      in int,
   kv_      in int,
   tip_bal_ in varchar2,
   tip3_    in varchar2,
   PROD_    in varchar2,
   TT_      in out varchar2
  )
RETURN number IS

 tip_      varchar2(3);
 tip_NLS   varchar2(3);
 tip_id  number:=0;   -- id проц карточки
 l_NBS_SD8  accounts.nbs%type; -- балансовый контр счет который будет использоваться
                               -- для сомнительных процентов и комиссий

 rTOBO_  varchar2(12);
 ACC_    accounts.acc%type :=null ;

  NBS_SD  accounts.NBS%type :=null ;
  OB2_SD  specparam_int.OB22%type  ;
  BRA_SS  accounts.tobo%type     :=null ;
  NBS_SS  accounts.NBS%type :=null ;
   KV_SS   accounts.KV%type :=null ;
  OB22_SS  specparam_int.OB22%type  ;
  l_newnbs number;
BEGIN
   l_newnbs := NEWNBS.GET_STATE;

   TT_:=substr(rtrim(ltrim(nvl(TT_,'%%1'))),1,3);
   tip_:=rtrim(ltrim(tip3_));
   tip_NLS:=rtrim(ltrim(tip_bal_));

   if substr(tip_,1,2)='SD' then
      tip_id:=nvl(to_number(substr(tip_,3,1)) ,0);
      tip_   :='SD';
   end if;

   ACC_:=NULL;
   -- Для быстрого поиска получаемых аргументов
   --RAISE_APPLICATION_ERROR (-20111,'TIP_ID='||to_char(tip_id)||' tip_='||to_char(tip_)||' tip_NLS='||to_char(tip_NLS)||' bal='||to_char(bal_));

   IF tip_='SN'               THEN
        select max(acc) into acc_ from accounts where
        acc=(select min(a.acc)  from accounts a,nd_acc n
              where a.acc=n.acc and n.nd=nd_ and a.kv=kv_
              and a.tip='SN ' and a.dazs is null
             );


ELSIF tip_='SK0'               THEN
      select max(acc) into acc_ from accounts where
      acc=(select min(a.acc)  from accounts a,nd_acc n
            where a.acc=n.acc and n.nd=nd_
            and a.tip='SK0' and a.dazs is null);

ELSIF tip_='SN8'               THEN

            select max(a.acc)
              into acc_
              from accounts a, nd_acc n
             where a.tip='SN8' and a.kv=kv_ and a.dazs is null
                   and a.acc=n.acc and n.nd=ND_ and rownum=1;

ELSIF tip_='S9N'               THEN

            select max(a.acc)
              into acc_
              from accounts a, nd_acc n
             where a.tip='S9N' and a.kv=kv_ and a.dazs is null
                   and a.acc=n.acc and n.nd=ND_ and rownum=1;

ELSIF tip_='S9K'               THEN

            select max(a.acc)
              into acc_
              from accounts a, nd_acc n
             where a.tip='S9K' and a.kv=kv_ and a.dazs is null
                   and a.acc=n.acc and n.nd=ND_ and rownum=1;


-- Счет доходов для комиссии многоразовой  (вызывается при открытии счета с типом SK0)
ELSIF tip_='SD'   and tip_id=2 and substr(bal_,1,4) = '8999' THEN

    begin
       select substr(prod,1,4),substr(prod,5,2),nvl(branch,SUBSTR (SYS_CONTEXT ('bars_context', 'user_branch'), 1, 30) )
       into  NBS_SS,OB22_SS,BRA_SS
       from cc_deal
       where nd=nd_;
           -- Для гарантий которые введены в Ощадбанке в КП (временно)добавлен код 9 --> 6118
           select acc
          into ACC_
          from
               (select a.acc
                  from accounts a--,specparam_int i
                 where /*i.acc=a.acc and*/ a.dazs is null and a.nbs=decode(substr(NBS_SS,1,1),'9',decode(l_newnbs,0,'6118','6518'),decode(l_newnbs,0,'6111','6511')) and
                      ( a.tobo =BRA_SS or a.tobo = substr(BRA_SS,1,length(BRA_SS)-7)
                        or a.tobo = substr(BRA_SS,1,length(BRA_SS)-7)||'000000/') and
                        a.ob22=(select SD_SK0 from cck_ob22 where nbs=NBS_SS and ob22=OB22_SS)
                 order by a.tobo desc
               ) where rownum=1;

    EXCEPTION WHEN NO_DATA_FOUND THEN acc_:=null ;
    end;

-- Счет доходов по пене
ELSIF tip_='SD' and tip_id=2 and (tip_nls in ('SP','SL','SPN','SLN','SK9','SN8') or tip_nls is null)  THEN

    begin
         select a.acc ,'%%1'
           into acc_  , tt_
           from accounts a
         where a.tip='SD8' and a.nbs='8006'
           and a.kv=KV_    and rownum=1;
    EXCEPTION WHEN NO_DATA_FOUND THEN acc_:=null;
    end;

-- Счет доходов для сомнительных(внебаланс)
ELSIF tip_='SD'   and tip_id=0 and tip_nls in ('SL','S9N','S9K') THEN

       if gl.amfo='380764' then
          l_NBS_SD8:='8910';
       else
          l_NBS_SD8:='8990';
       end if;



       select substr(prod,1,4),substr(prod,5,2),nvl(branch,SUBSTR (SYS_CONTEXT ('bars_context', 'user_branch'), 1, 30) )
       into  NBS_SS,OB22_SS,BRA_SS
       from cc_deal
       where nd=nd_;

    begin
    select acc into ACC_ from
       ( select acc from accounts
          where kv=KV_ and nbs=l_NBS_SD8 and dazs is null and
                ( tobo =BRA_SS or tobo = substr(BRA_SS,1,length(BRA_SS)-7)
                  or tobo = substr(BRA_SS,1,length(BRA_SS)-7)||'000000/'
                )
               order by tobo desc
        ) where rownum=1;
    EXCEPTION WHEN NO_DATA_FOUND THEN acc_:=null;
    end;

 -- Счет доходов для ком 9129
ELSIF tip_='SD'   and tip_id=0 and (substr(bal_,1,1) = '9' or tip_NLS='CR9') THEN

    begin
     select substr(prod,1,4),substr(prod,5,2),nvl(branch,SUBSTR (SYS_CONTEXT ('bars_context', 'user_branch'), 1, 30) )
       into  NBS_SS,OB22_SS,BRA_SS
       from cc_deal
      where nd=nd_;

         select acc
        into ACC_
        from
             (select a.acc
                from accounts a--,specparam_int i
               where /*i.acc=a.acc and*/ a.dazs is null and a.nbs=decode(l_newnbs,0,'6118','6518') and
                    ( a.tobo =BRA_SS or a.tobo = substr(BRA_SS,1,length(BRA_SS)-7)
                      or a.tobo = substr(BRA_SS,1,length(BRA_SS)-7)||'000000/') and
                      a.ob22=(select SD_9129 from cck_ob22 where nbs=NBS_SS and ob22=OB22_SS)
               order by a.tobo desc
             ) where rownum=1;
    EXCEPTION WHEN NO_DATA_FOUND THEN acc_:=null ;
    end;

-- аморт дисконта   + Дисконт для гарантій  Ошадбанку
ELSIF tip_='SD'   and (substr(bal_,4,1) = '5' or (substr(bal_,4,1) = '6') or (substr(bal_,1,4) = '3648')) THEN

    begin
       select substr(prod,1,4),substr(prod,5,2),nvl(branch,SUBSTR (SYS_CONTEXT ('bars_context', 'user_branch'), 1, 30) )
       into  NBS_SS,OB22_SS,BRA_SS
       from cc_deal
       where nd=nd_;

     If    nbs_SS in (case when l_newnbs = 0 then '2202' else '2203' end, '2203') then NBS_SD:= case when l_newnbs = 0 then '6042' else '6052' end;
     elsIf nbs_SS in ('2212', '2213') then NBS_SD:='6043';
     elsIf nbs_SS in ('2232', '2233') then NBS_SD:= case when l_newnbs = 0 then '6046' else '6055' end;
     elsIf nbs_SS in ('2020')         then NBS_SD:= case when l_newnbs = 0 then '6022' else '6023' end; -- Для вексельных кредитов
     elsIf nbs_SS in (case when l_newnbs = 0 then '2062' else '2063' end, '2063') then NBS_SD:=case when l_newnbs = 0 then '6026' else '6025' end;
     elsIf nbs_SS in ('2072', '2073') then NBS_SD:='6027';
     elsIf nbs_SS in (case when l_newnbs = 0 then '2082' else '2083' end, '2083') then NBS_SD:=case when l_newnbs = 0 then '6029' else '6027' end;
     elsIf nbs_SS in (case when l_newnbs = 0 then '9020' else '9000' end, case when l_newnbs = 0 then '9023' else '9003' end ,'9122') then NBS_SD:=case when l_newnbs = 0 then '6118' else '6518' end;
     end if;

    select acc
      into ACC_
      from
       (select a.acc
          from accounts a--,specparam_int i
         where /*i.acc=a.acc and*/ a.dazs is null and a.nbs=NBS_SD and
               ( a.tobo =BRA_SS or a.tobo = substr(BRA_SS,1,length(BRA_SS)-7)
                or a.tobo = substr(BRA_SS,1,length(BRA_SS)-7)||'000000/') and
               a.ob22=(select decode(KV_, gl.baseval, sd_m, sd_j)
                         from CCK_OB22
                        where nbs=NBS_SS and ob22=OB22_SS)
         order by a.tobo desc
       ) where rownum=1;


    EXCEPTION WHEN NO_DATA_FOUND THEN
      return null;
    end;

   RETURN ACC_;

--  Дострокове погашення
ELSIF tip_='SD' and tip_id=4 THEN

     begin
      if nd_ is not null then
        select substr(prod,1,4),substr(prod,5,2),branch
         into  NBS_SS, ob22_SS, BRA_SS
         from cc_deal where nd=nd_;
      end if;
      if NBS_SS is null then
       select a.nbs, nvl(s.ob22,'01'), A.tobo
       into  NBS_SS, ob22_SS, BRA_SS
       from accounts a, nd_acc n, specparam_int s
       where n.nd=ND_ and a.acc=n.acc and a.tip='SS ' and a.acc=s.acc (+)
             and rownum=1;
      end if;
     exception when no_data_found then
       NBS_SS := Bal_;
       BRA_SS := SUBSTR (SYS_CONTEXT ('bars_context', 'user_branch'), 1, 30);
     end;

     BEGIN
        select sd_sk4 into OB2_SD  from CCK_OB22
        where nbs=NBS_SS and ob22=OB22_SS;
        begin
           select acc into ACC_ from
           (select a.acc from accounts a--, SPECPARAM_INT s
            where
              ( a.tobo =BRA_SS or a.tobo = substr(BRA_SS,1,length(BRA_SS)-7)
                or a.tobo = substr(BRA_SS,1,length(BRA_SS)-7)||'000000/')
              and a.KV=980 and a.nbs= decode(l_newnbs,0,'6110','6510')
              and /*a.acc=s.ACC and*/ a.ob22=OB2_SD
              and a.dazs is null
              order by a.tobo desc
            ) where rownum=1;
        exception when no_data_found then NULL;
        END;
     exception when no_data_found then null;
     end;


ELSIF tip_='SD'   and substr(bal_,1,1)<>9  THEN

        -- возможно счет доходов уже прикреплен к договору
    begin
     SELECT min(a.acc) into ACC_
     from accounts a,nd_acc n
     where a.acc=n.acc and n.nd=nd_ and a.tip='SD ' and a.dazs is null
           and rownum=1;
    EXCEPTION WHEN NO_DATA_FOUND THEN acc_:=null ;
    end;

     begin
      if nd_ is not null then
        select substr(prod,1,4),substr(prod,5,2),branch
         into  NBS_SS, ob22_SS, BRA_SS
         from cc_deal where nd=nd_;
      end if;
      if NBS_SS is null then
       select a.nbs, nvl(a.ob22,'01'), A.tobo
       into  NBS_SS, ob22_SS, BRA_SS
       from accounts a, nd_acc n--, specparam_int s
       where n.nd=ND_ and a.acc=n.acc and a.tip='SS ' --and a.acc=s.acc (+)
             and rownum=1;
      end if;
     exception when no_data_found then
       NBS_SS := Bal_;
       BRA_SS := SUBSTR (SYS_CONTEXT ('bars_context', 'user_branch'), 1, 30);
     end;

     If    nbs_SS in (case when l_newnbs = 0 then '2202' else '2203' end, '2203') then NBS_SD:= case when l_newnbs = 0 then '6042' else '6052' end;
     elsIf nbs_SS in ('2212', '2213') then NBS_SD:='6043';
     elsIf nbs_SS in ('2232', '2233') then NBS_SD:= case when l_newnbs = 0 then '6046' else '6055' end;
     elsIf nbs_SS in ('2020')         then NBS_SD:= case when l_newnbs = 0 then '6022' else '6023' end; -- Для вексельных кредитов
     elsIf nbs_SS in (case when l_newnbs = 0 then '2062' else '2063' end, '2063') then NBS_SD:=case when l_newnbs = 0 then '6026' else '6025' end;
     elsIf nbs_SS in ('2072', '2073') then NBS_SD:='6027';
     elsIf nbs_SS in (case when l_newnbs = 0 then '2082' else '2083' end, '2083') then NBS_SD:=case when l_newnbs = 0 then '6029' else '6027' end;
     end if;
     BEGIN
        select decode(KV_, 980, sd_n, sd_i) into OB2_SD  from CCK_OB22
        where nbs=NBS_SS and ob22=OB22_SS;
        begin
           select acc into ACC_ from
           (select a.acc from accounts a--, SPECPARAM_INT s
            where
              ( a.tobo =BRA_SS or a.tobo = substr(BRA_SS,1,length(BRA_SS)-7)
                or a.tobo = substr(BRA_SS,1,length(BRA_SS)-7)||'000000/')
              and a.KV=980 and a.nbs=NBS_SD
              and /*a.acc=s.ACC and*/ a.ob22=OB2_SD
              and a.dazs is null
              order by a.tobo desc
            ) where rownum=1;
        exception when no_data_found then NULL;
        END;
     exception when no_data_found then null;
     end;--  END IF;

END IF;

RETURN ACC_;
END CC_O_NLS_EXT;
/
