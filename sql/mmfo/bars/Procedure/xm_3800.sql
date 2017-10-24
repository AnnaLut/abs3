CREATE OR REPLACE PROCEDURE BARS.XM_3800 
( p_MFO           varchar2 default null
, branch2_        varchar2 default null
, GL_BDATE        date     -- дата, которой надо отк счета и выполнить переброс остатков
) is
/*
05.02.2014 Новое по 6204 - резервы
01-03-2011 Укорочено назву рах.
23-02-2011 Sta на всякий випадок вiдкривають новi 3800 та 3801   дату вiдкриття меншою,
06-01-2011 Sta Обеспечить 100% наличие всех нужных сч 6204   при помощи процедуры OP_BS_OB1 (b.branch,'6204ХХ' ) ;
 Открыть новые 3800 и 3801 для  каждого бранча-2 и
 для металлов kv  (959,961,962) и  для ОБ22 in ('09' )
 заполняя одновременно VP_LIST.

 Предлагаю маску 3800_ББББОО,  3801_ББББООВВВ,
 ББББ - код бранча
 ОО   - код ОБ22
 ВВВ  - код вал

*/
  ern CONSTANT POSITIVE := 333;
  erm          VARCHAR2(280);
  MFO_         varchar2(6);
  nls3800_     varchar2(15);
  nms3800_     varchar2(38);
  acc3800_     number(38);
  nls3801_     varchar2(15);
  nms3801_     varchar2(38);
  acc3801_     number(38);
  p4_          number(38);
  acc6204_     number(38);
  acc_rrd_     number(38);
  acc_RRS_     number(38);
  nls6_        varchar2(15);
  nms6_        varchar2(38);
  OB62_        char(2);
  OB22_        char(2);
  RNK_         number(38);
  val_         varchar2(10);
  brG_         varchar2(15);
  branch_      varchar2(30);
  absadm_      number(38);
  mfo5_        varchar2(5);
  BBBB_        char(4);
  nms1_        varchar2(30);
begin
 
  mfo_ := gl.aMFO;
    
  if ( mfo_ Is Null )
  then
    
    mfo_ := coalesce(  p_mfo, BC.EXTRACT_MFO( branch2_ ) );
    
    if ( mfo_ Is Null )
    then
      raise_application_error( -20666, 'Не вказано код філіалу!', true );
    else
      bc.subst_mfo( mfo_ );
    end if;
    
  end if;
  
  absadm_ := to_number( bars_sqnc.rukey( '20094', mfo_ ) );
  
  If GL_BDATE is not null 
  then -- установить нужную дату, как банковскую
     begin
       insert into fdat (fdat,stat) values (GL_BDATE,9);
     exception
       when OTHERS then  null;
     end;
     GL.PL_DAT( GL_BDATE );
  end if;
  
  mfo5_:= substr(gl.aMfo,1,5);
  brG_ := '/' || MFO_ || '/000000/';
  
  for o in ( select ob22, substr(txt,1,38) NMS 
               from sb_ob22
              where r020='3800' and ob22 in ('09','03') )
  loop
  
    for b in ( select branch from branch where length(branch)=15 )
    loop
      
      If NVL(branch2_, b.branch) <> b.branch 
      then goto NOT_B;  
      end if;
      
      BBBB_ := substr(b.branch,-5,4);
      
      --найти нужный РНК
      begin
         select VAL
           into val_
           from BRANCH_PARAMETERS
          where branch = b.branch
            and tag    = 'RNK';
      EXCEPTION 
        WHEN NO_DATA_FOUND THEN
          val_ := bars_sqnc.rukey( '1', MFO_ ); 
      end;
      
      rnk_ := to_number( val_ );
      
      for k in ( select kv from tabval where kv in (959,961,962) )
      loop
        
        --открыть нужный 3800/вал
        nls3800_ := vkrzn( mfo5_,'38000' || BBBB_ || o.ob22 );
        
        begin
          select acc into acc3800_  
            from accounts where nls=nls3800_ and kv=k.kv and dazs is not null;
          update accounts set dazs= null where acc=acc3800_;
        exception
          WHEN NO_DATA_FOUND THEN null;
        end;
  
        If    o.OB22 ='09' then nms1_ := ' купiвля-продаж БМ.';
        elsIf o.OB22 ='03' then nms1_ := ' дох/витр в БМ.';
        else                    nms1_ := ' iнше в БМ.';
        end if;
  
        nms3800_ := substr( 'ВП  '|| k.KV || ' '|| nms1_ || 'Бранч '||BBBB_,1,38);
        op_reg( 99,0,0,18,p4_,RNK_,nls3800_,k.kv,nms3800_,'ODB',absadm_,acc3800_ );
        
        update accounts
           set tobo = b.branch
             , daos = daos-10
             , ob22 = o.OB22
         where acc  = acc3800_;
        
        --открыть нужный 3801/980
        nls3801_ := vkrzn( mfo5_,'38010'||substr(nls3800_,6,9)|| k.kv );
        
        begin
          select acc into acc3801_  from accounts where nls=nls3801_ and kv=980 and dazs is not null;
          update accounts set dazs= null where acc=acc3801_;
        exception
          WHEN NO_DATA_FOUND THEN null;
        end;
  
        nms3801_ :='ЕВП '|| k.KV || ' '|| nms1_ || 'Бранч '||BBBB_;
        
        op_reg( 99,0,0,18,p4_,RNK_,nls3801_,980,nms3801_,'ODB',absadm_,acc3801_ );
  
        update accounts 
          set tobo = b.branch
            , daos = daos-10
            , ob22 = o.OB22
        where acc  = acc3801_;
  
        --HKP-1) найти нужный 6204 -1
        acc6204_ := null;
        
        if ( o.ob22 = '16' )
        then ob62_ := '18';
        else ob62_ := '15';
        end if;
        
        OP_BS_OB1( b.branch, '6204'||ob62_ ) ;
        
        begin
          nls6_:=NvL( nbs_ob22_null('6204',ob62_,b.branch),  nbs_ob22_null('6204',ob62_,brG_) );
          select acc into acc6204_ from accounts where kv=980 and nls=nls6_  and dazs is null;
        exception
          WHEN OTHERS THEN null;
        end;
  
        If acc6204_ is null then
           nls6_ := vkrzn( mfo5_,'62040'   || BBBB_  || ob62_ );
           nms6_ := ob62_||':НКР-1. Бранч '|| BBBB_;
           op_reg (99,0,0,18,p4_,RNK_,nls6_,980,nms6_,'ODB',absadm_,acc6204_);
           update accounts
              set tobo = b.branch
                , daos = daos-10
                , ob22 = OB62_
            where acc  = acc6204_;
        end if;
  
        --2 ) HKP-2) найти нужный 6204 -2
        acc_rrd_ := null;
        if ( o.ob22 = '16' )
        then ob62_ := '18';
        else ob62_ := '07';
        end if;
        
        OP_BS_OB1( b.branch, '6204'||ob62_ );
        
        begin
           nls6_:=Nvl( nbs_ob22_null('6204',ob62_,b.branch),  nbs_ob22_null('6204',ob62_,brG_)      );
           select acc into acc_RRd_ from accounts   where kv=980 and nls=nls6_  and dazs is null;
        exception
          WHEN OTHERS THEN null;
        end;
  
        If acc_rrd_ is null 
        then
          nls6_ := vkrzn( mfo5_,'62040'   || BBBB_  || ob62_ );
          nms6_ := ob62_||':НКР-2. Бранч '|| BBBB_;
          op_reg( 99,0,0,18,p4_,RNK_,nls6_,980,nms6_,'ODB',absadm_,acc_rrd_ );
          update accounts
             set tobo = b.branch
               , daos = daos-10
               , ob22 = OB62_
           where acc  = acc_rrd_;
        end if;
  
        -- 3) PKP-3 найти нужный 6204 -3
        acc_rrs_ := null;
        if ( o.ob22 = '16' )
        then ob62_ := '18';
        else ob62_ := '06';
        end if;
        
        OP_BS_OB1( b.branch, '6204'||ob62_ ) ;
        
        begin
          nls6_:=Nvl( nbs_ob22_null('6204','06',b.branch), nbs_ob22_null('6204','06',brG_) );
          select acc into acc_RRs_ from accounts where kv=980 and nls=nls6_  and dazs is null;
        exception
          WHEN OTHERS THEN null;
        end;
  
        If acc_rrs_ is null 
        then
          nls6_ := vkrzn( mfo5_,'62040'   || BBBB_  || ob62_ );
          nms6_ := ob62_||':РКР-3. Бранч '|| BBBB_;
          op_reg( 99,0,0,18,p4_,RNK_,nls6_,980,nms6_,'ODB',absadm_,acc_rrs_ );
          update accounts
             set tobo = b.branch
               , daos = daos-10
               , ob22 = OB62_
           where acc  = acc_rrs_;
        end if;
  
        -- вставить в VP_LIST
        update vp_list
           set COMM = substr(nms3800_,1,30)
             , ACC3801 = acc3801_
             , ACC6204 = acc6204_
             , ACC_RRR = acc_rrd_
             , ACC_RRD = acc_rrd_
             , ACC_RRS = acc_rrs_
         where ACC3800 = acc3800_;
        
        if SQL%rowcount = 0 then
           insert into vp_list ( ACC3800,COMM,ACC3801,ACC6204,ACC_RRR,ACC_RRD,ACC_RRS )
           values (acc3800_,substr(nms3800_,1,30),   acc3801_,acc6204_,acc_rrd_, acc_rrd_,acc_rrs_);
        end if;
  
      end loop; -- k
  
      <<NOT_B>> null;
  
    end loop;   -- b
    
  end loop;     -- o
  
  bc.set_context;
  
end xm_3800;
/

show err;
