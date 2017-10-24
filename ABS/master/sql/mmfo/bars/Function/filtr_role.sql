
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/filtr_role.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FILTR_ROLE (p_XX int ) return int is
   -- 16.02.2017 Sta -- Пустые роли
   -- 02.12.2016 Sta ---------- Определение роли (1=да/0=нет) по  набору заданных ее атрибутов 

   l_ROL  int := to_number(PUL.GET( 'ROL' ) ) ;  -- по роли - вырожденный случай
   l_STA  int := to_number(PUL.GET( 'STA' ) ) ;  ----- по пользователю
   l_ARM  int := to_number(PUL.GET( 'ARM' ) ) ;  -- по Web-АРМ
   l_ACC  int := to_number(PUL.GET( 'ACC' ) ) ;  -- По группе доступа
   l_CHK  int := to_number(PUL.GET( 'CHK' ) ) ;  -- По группе контроля
   l_OTC  int := to_number(PUL.GET( 'OTC' ) ) ;  -- По отч.файлу
   l_TTS  int := to_number(PUL.GET( 'TTS' ) ) ;  -- По Операции
   l_FUN  int := to_number(PUL.GET( 'FUN' ) ) ;  --------- по Web-функции
   l_REF  int := to_number(PUL.GET( 'REF' ) ) ;  --------- по типу справочника
   l_REP  int := to_number(PUL.GET( 'REP' ) ) ;  --------- по папке печ.отчета
  ----------------------------------------------
  l_GT int ; l_GI int ; l_RT int ; l_RI int ; l_GRT int ;
  nTmp_ int := 0 ;
  l_Ret int := 0 ; 

  --Прямые связи
  function  XXX REturn int is  x_ret int;
  begin nTmp_  := nTmp_ + 1 ;
        begin select 1 into x_RET from ADM_RESOURCE where GRANTEE_TYPE_ID = l_GT and grantee_id = l_GI and resource_type_id = l_RT and resource_id = l_RI  ;
        EXCEPTION  WHEN NO_DATA_FOUND THEN x_Ret := 0 ;
        end;       RETURN x_Ret;
  end XXX; 

  --НЕпрямые связи
  function  YYY REturn int is  y_ret int;
  begin nTmp_  := nTmp_ + 1 ;
        begin select 1 into y_RET from ADM_RESOURCE G , ADM_RESOURCE R
              where G.GRANTEE_TYPE_ID  = l_GT  and  G.grantee_id  = l_GI 
                and G.resource_type_id = l_GRT and  G.resource_id = R.grantee_id
                and R.GRANTEE_TYPE_ID  = l_GRT and  R.resource_id = l_RI 
                and rownum = 1 ;
        EXCEPTION  WHEN NO_DATA_FOUND THEN y_Ret := 0 ;
        end;       RETURN y_Ret;
  end YYY; 
  -------------

begin
--logger.info('ROL*l_ROL=' ||l_ROL ||', l_STA=' ||l_STA ||', l_ARM=' ||l_ARM ||', l_ACC=' ||l_ACC ||', l_CHK=' ||l_CHK ||
--              ', l_OTC=' ||l_OTC ||', l_TTS=' ||l_TTS ||', l_FUN=' ||l_FUN ||', l_REF=' ||l_REF ||', l_REP=' ||l_REP ||'*');
--ROL*l_ROL=3784, l_STA=, l_ARM=87, l_ACC=, l_CHK=, l_OTC=, l_TTS=, l_FUN=, l_REF=, l_REP=*

  --------- по пользователю
  If l_STA is not null then  l_GT := resource_utl.get_resource_type_id('STAFF_USER') ; l_GI := l_STA ;
                             l_RT := resource_utl.get_resource_type_id('STAFF_ROLE') ; l_RI := p_XX  ;
     If  XXX = 0 then RETURN 0; end if;
  end if;                    l_GT := resource_utl.get_resource_type_id('STAFF_ROLE') ; l_GI := p_XX  ;


--logger.info('ROL*l_GT='|| l_GT||' ,  l_GI ='||l_GI||' ,  l_RT='|| l_RT ||' , l_RI='|| l_RI||'*');
--ROL*l_GT=10 ,  l_GI =3195 ,  l_RT= , l_RI=*

  --------- по роли - вырожденный случай
  If l_ROL is not null then nTmp_ := nTmp_ + 1 ; If p_XX = l_ROL then l_RET := 1 ; else  RETURN 0 ;  end if ;  end if ;

  -------- по Web-АРМ
  If l_ARM is not null then  l_RT := resource_utl.get_resource_type_id('ARM_WEB')    ; l_RI := l_ARM ;   If XXX = 0 then RETURN 0; end if;  end if;

  -------- По группе доступа
  If l_ACC is not null then  l_RT := resource_utl.get_resource_type_id('ACCOUNT_GROUP'); l_RI := l_ACC ; If XXX = 0 then RETURN 0; end if;  end if;

  --------- По группе контроля
  If l_CHK is not null then  l_RT := resource_utl.get_resource_type_id('CHKLIST')    ; l_RI := l_CHK ;   If XXX = 0 then RETURN 0; end if;  end if;

  -------- По отч.файлу
  If l_OTC is not null then  l_RT := resource_utl.get_resource_type_id('KLF')        ; l_RI := l_OTC ;   If XXX = 0 then RETURN 0; end if;  end if;

  -- По Операции
  If l_TTS is not null then  l_RT := resource_utl.get_resource_type_id('TTS')        ; l_RI := l_TTS ;   If XXX = 0 then RETURN 0; end if;  end if;

  --------- по Web-функции
  If l_FUN is not null then l_GRT := resource_utl.get_resource_type_id('ARM_WEB')    ; 
     l_RT := resource_utl.get_resource_type_id('FUNCTION_WEB');                        l_RI := l_FUN ;  If YYY = 0 then RETURN 0; end if;    end if;

  -- по типу справочника
  If l_REF is not null then l_GRT := resource_utl.get_resource_type_id('ARM_WEB')    ; l_RT := resource_utl.get_resource_type_id('DIRECTORIES') ; l_RI := l_REF ;
     nTmp_  := nTmp_ + 1 ;
     begin select 1 into l_RET from ADM_RESOURCE G , ADM_RESOURCE R, REFERENCES x 
           where G.GRANTEE_TYPE_ID  = l_GT  and  G.grantee_id  = l_GI   
             and G.resource_type_id = l_GRT and  G.resource_id = R.grantee_id
             and R.GRANTEE_TYPE_ID  = l_GRT and  R.resource_id = x.tabid and x.type = l_RI 
             and rownum = 1 ;
     EXCEPTION  WHEN NO_DATA_FOUND THEN l_Ret := 0 ;  RETURN 0; 
     end ;
  end if;

  -- по папке печ.отчета  
  If l_REP is not null then l_GRT := resource_utl.get_resource_type_id('ARM_WEB')    ; l_RT := resource_utl.get_resource_type_id('REPORTS') ; l_RI := l_REP ;
     nTmp_  := nTmp_ + 1 ;
     begin select 1 into l_RET from ADM_RESOURCE G, ADM_RESOURCE R, REPORTS  x 
           where G.GRANTEE_TYPE_ID  = l_GT  and  G.grantee_id  = l_GI  
             and G.resource_type_id = l_GRT and  G.resource_id = R.grantee_id
             and R.GRANTEE_TYPE_ID  = l_GRT and  R.resource_id = x.id and x.IDF = l_RI 
             and rownum = 1 ;
     EXCEPTION  WHEN NO_DATA_FOUND THEN l_Ret := 0 ;  RETURN 0; 
     end ;
  end if;


  RETURN least ( 1, nTmp_) ;

end FILTR_ROLE ;
/
 show err;
 
PROMPT *** Create  grants  FILTR_ROLE ***
grant EXECUTE                                                                on FILTR_ROLE      to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/filtr_role.sql =========*** End ***
 PROMPT ===================================================================================== 
 