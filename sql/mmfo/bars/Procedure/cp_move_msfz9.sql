create or replace procedure cp_move_msfz9 is
   -- v.1.2 22.06.2018
   l_title    constant varchar2(15) := 'CP_MOVE_MSFZ9';
   l_valdate  constant date         := to_date('29.12.2017','DD.MM.YYYY');  
   B_4621     constant varchar2(15) := '37392555';
   GRP_       constant number       := 22;
   
   IO_          int;
   ACRB_D       int;   
   ACRB_P       int; 
   l_sos        oper.sos%type;   
   kk           cp_kod%rowtype;
   dd           cp_deal%rowtype;
   pf           cp_pf%rowtype;
   RNK1_        number;
   ac2          cp_accc%rowtype; -- приймаючий суб.пф
   nNBS2_       number(4);
   REF_         oper.ref%type;
   s8_          varchar2(9);
   NLSGA_       varchar2(15);
   NLS_         accounts.nls%type;   
   NMS_         varchar2(38); 
   S_4621       varchar2(38);   
   NAZN_        oper.nazn%type;   
   NLSN_        accounts.nls%type;
   NMSN_        accounts.nms%type;
   accc_        accounts.acc%type;
   acc_         accounts.accc%type;
   r1_          number;
   l_init_ref   cp_deal.initial_ref%type;
   l_dat_bay    date;   
   
   accD_        number;   
   accR_        number;   
   accP_        number;   
   accR2_       number;   
   accR3_       number;      
   accS_        number;                      
   accS2_       number;   
   
   SD_ number;  --  сума по рах-х D
   SP_ number;  --  сума по рах-х P
   SR_ number;  --  сума по рах-х R
   VD_ number;  -- віртуал
   VP_ number;  -- вірт  
   
----------------------------------------------------------------------
    type t_cp_warrantyrec is record (REF_    cp_deal.ref%type,
                                     PAWN    CC_PAWN.pawn%type,
                                     NLS     accounts.nls%type,
                                     KV      accounts.kv%type,
                                     acc     cc_accp.acc%type,
                                     accs    cc_accp.accs%type,
                                     S       oper.s%type,
                                     IDZ     pawn_acc.idz%type,
                                     CC_IDZ  pawn_acc.cc_idz%type,
                                     SDATZ   DATE,
                                     RNK     customer.rnk%type,
                                     CP_WAR  varchar2(200),
                                     ob22    accounts.ob22%type);
    --l_cp_warrantyrec        t_cp_warrantyrec;
    type t_cp_warrantyset   is table of t_cp_warrantyrec;
    l_cp_warrantyset        t_cp_warrantyset;
----------------------------------------------------------------------   
    r_refw cp_refw%rowtype; 

    procedure INS_CP_ACCOUNTS
         (p_ref int, p_type varchar2, p_acc int, p_ostc number default 0, p_ostcr number default 0) is
    begin
       begin
       insert into cp_accounts (cp_ref,cp_acctype,cp_acc,ostc,ostcr)
       values
       (p_ref,p_type,p_acc, nvl(p_ostc,0), nvl(p_ostcr,0));
       exception when dup_val_on_index then null;
       end;
    end INS_CP_ACCOUNTS;
   
begin
  bars_audit.info(l_title||' Запуск');

  begin
    select to_number(val) into RNK1_ from params  where par = 'RNK_CP' ;
    exception 
      when  NO_DATA_FOUND then
        bars_audit.error(l_title||' Немає в параметрах RNK_CP');
        raise_application_error(-20001,  'Немає в параметрах RNK_CP ' );     
  end;   
  begin
    select substr(nms,1,38) into S_4621 from accounts where  kv = 980 and nls=B_4621;  
    exception 
      when  NO_DATA_FOUND then
        bars_audit.error(l_title||' Немає транзитного рахунку '||B_4621);
        raise_application_error(-20001, ' Немає транзитного рахунку '||B_4621);     
  end; 
    
  select * into pf from cp_pf where pf = 4; --перемыщаэмо у 4.ПТ.Портфель Торговий
  
  for cm in (select * from v_cp_move_msfz9)
  loop
    bars_audit.info(l_title||' Обробка REF '||cm.ref);
    if cm.active = 'Ні' then
      bars_audit.info(l_title||' REF '||cm.ref||' Пропускаю, угода неактивна');
      continue;
    end if;  
    if cm.ref_move is not null then
      select o.sos into l_sos from oper o where o.ref = cm.ref_move;
      if l_sos >= 5 then
        bars_audit.info(l_title||' REF '||cm.ref||' Пропускаю, створена угода переміщення, операція завізована.');
        continue;
        elsif l_sos >= 0 then
          bars_audit.info(l_title||' REF '||cm.ref||' Пропускаю, створена угода переміщення, операція потребує візу');
          continue;
      end if;  
    end if;  
    select * into kk from cp_kod where id = cm.id;
    kk.rnk := nvl(kk.rnk,RNK1_);
    select * into dd from cp_deal where ref = cm.ref;    
    select a.nls, substr(a.nms, 1, 38) into NLSGA_, NMS_ from cp_accc c, accounts a where vidd=substr(cm.nlsn, 1, 4) and ryn=dd.ryn and emi=kk.emi and c.nlsa = a.nls and a.kv = kk.kv;    
    begin
      nNBS2_ := case substr(cm.nlsn, 1, 4) when '1420' then '1400' when '3113' then '3013' end;
      select a.* into ac2 from cp_accc a where a.vidd=nNBS2_ and a.ryn=dd.ryn and a.emi=kk.emi;
      exception
        when NO_DATA_FOUND then
          bars_audit.error(l_title||' REF '||cm.ref||' Пропускаю, не знайшов запис у cp_accc для vidd '||nNBS2_||' ryn '||dd.ryn||' emi '||kk.emi);
          continue;
    end;  
    
    --перевірити настройки на приймаючому портфелі
    if ac2.nlss is null then
      bars_audit.error(l_title||' REF '||cm.ref||' Пропускаю, не знайшов консолідований рахунок переоцінки у cp_accc для vidd '||nNBS2_||' ryn '||dd.ryn||' emi '||kk.emi);
      continue;      
    end if;     
    if ac2.nlss2 is null then
      bars_audit.error(l_title||' REF '||cm.ref||' Пропускаю, не знайшов консолідований рахунок переоцінки опціону у cp_accc для vidd '||nNBS2_||' ryn '||dd.ryn||' emi '||kk.emi);
      continue;      
    end if;       
    if ac2.nlsr is null then
      bars_audit.error(l_title||' REF '||cm.ref||' Пропускаю, не знайшов консолідований рахунок R у cp_accc для vidd '||nNBS2_||' ryn '||dd.ryn||' emi '||kk.emi);
      continue;      
    end if;     
    if ac2.nlsr2 is null and cm.ostr2 != 0 then
      bars_audit.error(l_title||' REF '||cm.ref||' Пропускаю, не знайшов консолідований рахунок R2 у cp_accc для vidd '||nNBS2_||' ryn '||dd.ryn||' emi '||kk.emi);
      continue;      
    end if;       
    if ac2.nlsr3 is null and cm.ostr3 != 0 then
      bars_audit.error(l_title||' REF '||cm.ref||' Пропускаю, не знайшов консолідований рахунок R3 у cp_accc для vidd '||nNBS2_||' ryn '||dd.ryn||' emi '||kk.emi);
      continue;      
    end if;       
    if ac2.nlsp is null and cm.ostp != 0 then
      bars_audit.error(l_title||' REF '||cm.ref||' Пропускаю, не знайшов консолідований рахунок премії у cp_accc для vidd '||nNBS2_||' ryn '||dd.ryn||' emi '||kk.emi);
      continue;      
    end if;   
    if ac2.nlsd is null and cm.ostd != 0 then
      bars_audit.error(l_title||' REF '||cm.ref||' Пропускаю, не знайшов консолідований рахунок дисконту у cp_accc для vidd '||nNBS2_||' ryn '||dd.ryn||' emi '||kk.emi);
      continue;      
    end if;       
    
    
    gl.ref(REF_); 
    s8_:= substr('000000000'|| REF_CP_NBU(REF_), -8 );
    --відкрити рахунок номіналу для угоди переміщення
    begin 
      select acc, substr(nls,1,5)||'0'||s8_, substr(cm.cp_id||'/'||nms,1,38) into accc_,NLSN_,NMSN_ from accounts where nls=ac2.nlsA and kv=kk.kv;
      exception 
        when NO_DATA_FOUND then    
          bars_audit.error(l_title||' REF '||cm.ref||' Пропускаю, не знайшов рахунок консалідованого номіналу '||ac2.nlsA);
          continue;
    end;
    cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.rnk, NLSN_,kk.kv,NMSN_,'ODB',gl.aUid,acc_);
    update accounts set mdate=kk.datp,accc=accc_, seci=4, pos=1, daos=gl.bDATE, pap=3  where acc=acc_;
    cp.cp_inherit_specparam (acc_, accc_, 0);

    --створити операцію
    NAZN_ := 'Переведення ЦП '||cm.cp_id||' у звязку з рекласифікацією відповідно до вимог МСФЗ 9 01.01.2018';
    insert into oper(ref ,tt   ,vob,               nd         ,dk,pdat   ,vdat     ,datd    ,datp    ,nam_a,nlsa  ,mfoa   ,kv   ,s           ,nam_b ,nlsb  ,mfob   ,kv2  ,s2          ,nazn ,userid ,sign        ,id_a    , id_b)
              values(REF_,'FXB', 6 ,'FRS9$'||substr(REF_,-5),0 ,sysdate,l_valdate,gl.bDATE,gl.bDATE,NMS_ ,NLSGA_,gl.AMFO,kk.kv,abs(cm.ostn)*100,S_4621,B_4621,gl.AMFO,kk.kv,abs(cm.ostn)*100,NAZN_,gl.aUid, GetAutoSign,gl.aOkpo, gl.aOkpo );
    begin
      insert into cp_payments(cp_ref, op_ref)
      values (REF_, REF_);
      exception 
        when others then null;
    end;         
    --звернути номінал 
    payTT(0,REF_,l_valdate,'FXB',0,kk.kv,cm.nlsn,abs(cm.ostn)*100,kk.kv, B_4621, abs(cm.ostn)*100);

    --розвернути
    payTT(0,REF_,l_valdate,'FXB',1,kk.kv,NLSN_,abs(cm.ostn)*100,kk.kv, B_4621,abs(cm.ostn)*100);    
    
    --відкрити рахунки
    --S
    begin 
      select acc, substr(nls,1,5)||'0'||s8_, substr(cm.cp_id||'/'||nms,1,38) into accc_,NLS_,NMS_ from accounts where nls=ac2.nlsS and kv=kk.KV;
      exception 
        when NO_DATA_FOUND then 
          bars_audit.error(l_title||' REF '||cm.ref||' Стоп, Невказаний рах. переоцінки S ИСХ в ФУ '||ac2.nlsS);
          raise_application_error(-20001, ' Невказаний рах. переоцінки S ИСХ в ФУ  '||ac2.nlsS);    
    end;     
    cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.RNK, NLS_,kk.KV,NMS_,'ODB',gl.aUid,accs_);
    update accounts set mdate=kk.DATP,accc=ACCC_, seci=4, pos=1, daos=l_valdate, pap=3  where acc=accs_;   
    cp.cp_inherit_specparam (accs_, accc_, 0);    
    --S2
    begin 
      select acc, substr(nls,1,5)||'1'||s8_, substr(cm.cp_id||'/'||nms,1,38) into accc_,NLS_,NMS_ from accounts where nls=ac2.nlsS2 and kv=kk.KV;
      exception 
        when NO_DATA_FOUND then 
          bars_audit.error(l_title||' REF '||cm.ref||' Стоп, Невказаний рах. переоцінки по опціону S2 ИСХ в ФУ '||ac2.nlsS2);
          raise_application_error(-20001, ' Невказаний рах. переоцінки по опціону S2 ИСХ в ФУ  '||ac2.nlsS2);    
    end;     
    cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.RNK, NLS_,kk.KV,NMS_,'ODB',gl.aUid,accs2_);
    update accounts set mdate=kk.DATP,accc=ACCC_, seci=4, pos=1, daos=l_valdate, pap=3  where acc=accs2_;   
    cp.cp_inherit_specparam (accs2_, accc_, 0);
    --R
    begin 
      select acc, substr(nls,1,5)||'0'||s8_, substr(cm.cp_id||'/'||nms,1,38) into accc_,NLS_,NMS_ from accounts where nls=ac2.nlsR and kv=kk.kv;
      exception 
        when NO_DATA_FOUND then    
          bars_audit.error(l_title||' REF '||cm.ref||' Стоп, не знайшов рахунок консалідованого купону R '||ac2.nlsR);
          raise_application_error(-20001, ' Немає консалідованого рахунку купону R  '||ac2.nlsR);     
    end;
    cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.rnk, NLS_,kk.kv,NMS_,'ODB',gl.aUid,accR_);
    update accounts set mdate= kk.DNK-1,accc=accc_, seci=4,daos=l_valdate, pos=1 WHERE acc=accR_;
    cp.cp_inherit_specparam (accR_, accc_, 0);    
    --R2
    if cm.ostr2 != 0 then
      begin
        select acc, substr(cm.cp_id||'/'||nms, 1, 38), substr(nls, 1, 5)||'2'|| s8_ into accc_, NMS_, NLS_ from accounts where nls = ac2.nlsR2 AND kv = kk.kv;
        exception 
          when NO_DATA_FOUND then    
            bars_audit.error(l_title||' REF '||cm.ref||' Стоп, не знайшов рахунок консалідованого накопиченого купону R2 '||ac2.nlsR2);
            raise_application_error(-20001, ' Немає консалідованого рахунку накопиченого купону R2  '||ac2.nlsR2);     
      end;
      cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.rnk ,nls_, kk.kv ,NMS_,'ODB',gl.aUid,accR2_);
      UPDATE accounts SET mdate= kk.DNK-1,accc=accc_,seci=4,daos=l_valdate, pos=1 WHERE acc=accR2_;
      cp.cp_inherit_specparam (accR2_, accc_, 0);
    end if;    
    --R3
    if cm.ostr3 != 0 then
      begin
        select acc, substr(cm.cp_id||'/'||nms, 1, 38), substr(nls, 1, 5)||'3'|| s8_ into accc_, NMS_, NLS_ from accounts where nls = ac2.nlsR3 AND kv = kk.kv;
        exception 
          when NO_DATA_FOUND then    
            bars_audit.error(l_title||' REF '||cm.ref||' Стоп, не знайшов рахунок консалідованого кривого купону R3 '||ac2.nlsR3);
            raise_application_error(-20001, ' Немає консалідованого рахунку кривого купону R3  '||ac2.nlsR3);     
      end;
      cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.rnk ,nls_, kk.kv ,NMS_,'ODB',gl.aUid,accR3_);
      UPDATE accounts SET mdate= kk.DNK-1,accc=accc_,seci=4,daos=l_valdate, pos=1 WHERE acc=accR3_;
      cp.cp_inherit_specparam (accR3_, accc_, 0);
    end if; 
    --P
    if cm.ostp != 0 then        
      begin
        select acc, substr(cm.cp_id||'/'||nms, 1, 38), substr(nls, 1, 5)||'0'|| s8_ into accc_, NMS_, NLS_ from accounts where nls = ac2.nlsP AND kv = kk.kv;
        exception 
          when NO_DATA_FOUND then    
            bars_audit.error(l_title||' REF '||cm.ref||' Стоп, не знайшов рахунок консалідованого премія '||ac2.nlsP);
            raise_application_error(-20001, ' Немає консалідованого рахунку премія  '||ac2.nlsP);     
      end;
      cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.rnk ,nls_, kk.kv ,NMS_,'ODB',gl.aUid,accP_);
      UPDATE accounts SET mdate=kk.DATP,accc=accc_,seci=4,daos=l_valdate, pos=1      WHERE acc=accP_;
      cp.cp_inherit_specparam (accP_, accc_, 0);   
      if pf.no_a <> 1  then
        select ad.acc, ap.acc into   ACRB_D, ACRB_P  from accounts aD, accounts aP
        where aD.kv = gl.baseval and aD.nls=ac2.s605 and aP.kv = gl.baseval and aP.nls = ac2.s605P ;        
        
        select nvl(p.io,0) into IO_ from proc_dr$base p where p.nbs = nNBS2_;
        
        insert into int_accn (acc ,acra ,acrb  ,id,metr,ACR_DAT   , s ,STP_DAT, IO , basey, freq )
                      values (ACC_,ACCP_,ACRB_P, 3,   6,gl.bdate-1, cm.osts,kk.DATP-1, IO_, 0,     1);
      end if;         
    end if;  
    --D
    if cm.ostd != 0 then        
      begin
        select acc, substr(cm.cp_id||'/'||nms, 1, 38), substr(nls, 1, 5)||'0'|| s8_ into accc_, NMS_, NLS_ from accounts where nls = ac2.nlsD AND kv = kk.kv;
        exception 
          when NO_DATA_FOUND then    
            bars_audit.error(l_title||' REF '||cm.ref||' Стоп, не знайшов рахунок консалідованого дискнот '||ac2.nlsD);
            raise_application_error(-20001, ' Немає консалідованого рахунку дисконт  '||ac2.nlsD);     
      end;
      cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.rnk ,nls_, kk.kv ,NMS_,'ODB',gl.aUid,accD_);
      UPDATE accounts SET mdate=kk.DATP,accc=accc_,seci=4,daos=l_valdate, pos=1      WHERE acc=accD_;
      cp.cp_inherit_specparam (accD_, accc_, 0);   
      if pf.no_a <> 1  then
        select ad.acc, ap.acc into   ACRB_D, ACRB_P  from accounts aD, accounts aP
        where aD.kv = gl.baseval and aD.nls=ac2.s605 and aP.kv = gl.baseval and aP.nls = ac2.s605P ;        
        
        select nvl(p.io,0) into IO_ from proc_dr$base p where p.nbs = nNBS2_;
        
        insert into int_accn (acc ,acra ,acrb  ,id,metr,ACR_DAT   , s ,STP_DAT, IO , basey, freq )
                      values (ACC_,ACCD_,ACRB_D, 2,   6,gl.bdate-1, cm.ostd,kk.DATP-1, IO_, 0,     1);
      end if;         
    end if;      
      
    
    l_init_ref := case when dd.op = 3 then dd.initial_ref else dd.ref end;
    l_dat_bay  := case when dd.op = 3 then dd.dat_bay else dd.dat_ug end;    
    insert into cp_deal(id   ,ryn   ,acc ,accd , accp ,accr ,accr2 , accr3, accs ,accs6 ,accs5, accexpn, accexpr, ref, erat, initial_ref, dat_bay)
                 values(cm.id,dd.ryn,acc_,accd_, accp_,accr_, accr2_, accr3_,accs_, null, null,    null,    null, REF_,null, l_init_ref , l_dat_bay);

    for k8 in (
              select ref, 'N' l_type, acc from cp_deal where ref=ref_
              union all
              select ref, 'R', accr from cp_deal where ref=ref_ and accr is not null
              union all
              select ref, 'R2', accr2 from cp_deal where ref=ref_ and accr2 is not null
              union all
              select ref, 'S', accs from cp_deal where ref=ref_ and accs is not null
              union all
              select ref, 'D', accd from cp_deal where ref=ref_ and accd is not null
              union all
              select ref, 'P', accp from cp_deal where ref=ref_ and accp is not null
              union all
              select ref, 'R3', accr3 from cp_deal where ref=ref_  and accr3 is not null
              union all
              select ref_, 'S2', accs2_ from dual where accs2_ is not null
              )

    loop
       INS_CP_ACCOUNTS (p_ref =>ref_, p_type =>k8.l_type, p_acc =>k8.acc);
    end loop;

    --суми в момент переміщення
    SD_ := cm.ostd*100;
    SP_ := cm.ostp*100;
    SR_ := cm.ostr*100;
    begin
      select ostc into VD_ from cp_ref_acc r, accounts a  where r.ref=cm.ref and r.acc=a.acc and a.tip='2VD' and a.ostc>0;
      exception when NO_DATA_FOUND then null;
    end;    
    begin
      select ostc into VP_ from cp_ref_acc r, accounts a  where r.ref=cm.ref and r.acc=a.acc and a.tip='2VP' and a.ostc<0;
      exception when NO_DATA_FOUND then null;      
    end;   
    --? if SD_ > SP_ ? 

    -- перемещение в портфелях OP = 3
    insert into cp_arch(ref, id, dat_ug, dat_opl, dat_roz,  n,  d,  p,  r, vd, vp, str_ref, op)
                 values(REF_,cm.id,gl.bdate,gl.bdate,gl.bdate, abs(cm.ostn)*100,SD_,SP_,SR_,VD_, VP_, REF_, 3 );    
    
    
     -- переоформляем гарантии
    /* cp_warranty_method.id = 1 -- полное удаление гарантии
    cp_warranty_method.id = 2 -- уменьшение гарантии в удельном весе */
    begin
       select cd.REF,
              sz.pawn,
              A.nls,
              A.kv,
              p.acc,
              p.accs,
              ABS(A.ostb),
              SZ.idz,
              SZ.cc_idz,
              SZ.sdatz,
              C.rnk,
              AW.VALUE,
              A.OB22
        bulk collect
        into l_cp_warrantyset
        from  cc_accp P,
              pawn_acc SZ,
              accounts A,
              accountsw aw,
              customer C,
              cp_deal cd
        where     SZ.acc = p.acc
              and p.rnk = C.rnk
              and a.acc = aw.acc
              and aw.tag = 'CP_WARR'
              and a.acc = P.acc
              and cd.acc = p.accs
              and cd.ref = p.nd
              and cd.ref = cm.ref
              and to_number(AW.VALUE) in (1,2);

      exception 
        when NO_DATA_FOUND then bars_audit.trace('CP: для пересмотра нет гарантий пакета REF='|| to_char(cm.ref));
    end;

    if l_cp_warrantyset.count > 0
     then
      for w in 1..l_cp_warrantyset.count
      loop
        bars_audit.info('CP_MOVE_MSFZ9 l_cp_warrantyset (l_cp_warrantyset(w).cp_war+1 = ' || to_char(l_cp_warrantyset(w).cp_war+1) || ' l_cp_warrantyset(w).s = ' ||to_char(l_cp_warrantyset(w).s)||' )');
         -- со старого пакета удаляем
            p_cp_addwarranty(p_mode    => 2,                               -- 0-вставка, 1-изменение, 2-удаление, 3-пропорциональное уменьшение
                             p_ref     => cm.ref,                           -- референс сделки с ЦП
                             p_pawn    => l_cp_warrantyset(w).pawn,        -- вид обеспечения                                                   |
                             p_kv      => l_cp_warrantyset(w).kv,          -- валюта                                                            | для открытия счета гарантии
                           --p_ob22    => l_cp_warrantyset(w).ob22,        -- OB22                                                              |
                             p_CP_WAR  => l_cp_warrantyset(w).cp_war,      -- параметр вида изменения гарантии при частичном погашении/продаже  |
                             p_rnk     => l_cp_warrantyset(w).rnk,         -- РНК третьего лица, дающего гарантии
                             p_s       => l_cp_warrantyset(w).s,           -- сумма гарантии
                             p_ccnd    => l_cp_warrantyset(w).CC_IDZ,      -- номер договора гарантии
                             p_sdate   => l_cp_warrantyset(w).sdatz,       -- дата договора гарантии
                             p_nls     => l_cp_warrantyset(w).nls);        -- счет 9 класса
          -- на новый пакет открываем
            p_cp_addwarranty(p_mode    => 0,                               -- 0-вставка, 1-изменение, 2-удаление, 3-пропорциональное уменьшение
                             p_ref     => ref_,                            -- референс сделки с ЦП
                             p_pawn    => l_cp_warrantyset(w).pawn,        -- вид обеспечения                                                   |
                             p_kv      => l_cp_warrantyset(w).kv,          -- валюта                                                            | для открытия счета гарантии
                           --p_ob22    => l_cp_warrantyset(w).ob22,        -- OB22                                                              |
                             p_CP_WAR  => l_cp_warrantyset(w).cp_war,      -- параметр вида изменения гарантии при частичном погашении/продаже  |
                             p_rnk     => l_cp_warrantyset(w).rnk,         -- РНК третьего лица, дающего гарантии
                             p_s       => l_cp_warrantyset(w).s/100,       -- сумма гарантии (обычно она заводится с интерфейса в гривнах, но тут - копейки - делим на 100)
                             p_ccnd    => l_cp_warrantyset(w).CC_IDZ,      -- номер договора гарантии
                             p_sdate   => l_cp_warrantyset(w).sdatz,       -- дата договора гарантии
                             p_nls     => l_cp_warrantyset(w).nls);        -- счет 9 класса
        bars_audit.trace('CP_MOVE_MSFZ9: пересмотрена гарантия пакета REF='|| to_char(l_cp_warrantyset(w).ref_)|| ' на сумму '|| to_char(l_cp_warrantyset(w).s) || ' по счету '|| l_cp_warrantyset(w).nls);
      end loop;
    end if;

    begin
        select ref_, 'PORTF',           -- convert
        case
        when substr(nNBS2_,1,3) in ('141','143','310','311','312') then 1
        when substr(nNBS2_,1,3) in ('142','144','321') then 3
        when substr(nNBS2_,1,3) in ('140','300','301') then 4
        when substr(nNBS2_,1,3) in ('410','420') then 2
        else null  end
        into r_refw.ref, r_refw.tag, r_refw.value
        from dual;
    end;

    if r_refw.value is not null then
       CP.CP_SET_TAG(r_refw.ref,r_refw.tag,r_refw.value,3);
    end if;
    
    /*не будуэ поки не завізовано
    begin
      value_paper.calc_many(ref_);
      exception 
        when others then
          bars_audit.error(l_title||'Не побудував потоки. Потрібно вручну '||SQLERRM||','||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
    end;
    */  
    
    bars_audit.info(l_title||' Кінець обробки REF '||cm.ref||' Створено документ переміщення '||ref_);
  end loop;    
  
  bars_audit.info(l_title||' Кінець');
  
  exception
    when others then
      bars_audit.error(l_title||SQLERRM||','||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
      bars_audit.error(l_title||' Кінець з помилками');
      raise;
end;
/
show err;

grant EXECUTE                                                                on cp_move_msfz9          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on cp_move_msfz9          to CP_ROLE;