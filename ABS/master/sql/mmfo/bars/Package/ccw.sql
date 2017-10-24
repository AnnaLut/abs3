
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/ccw.sql =========*** Run *** =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CCW IS  
  G_HEADER_VERSION  CONSTANT VARCHAR2(64)  :=  'ver.1.0 22.06.2016';

/*
23.06.2016 Добавки к ССК
*/
function DOP_SEM (p_txt varchar2, p_tab varchar2, p_sk varchar2, p_fk varchar2) return varchar2;

function header_version return varchar2;
function body_version   return varchar2;
-------------------
END ccw;
/
CREATE OR REPLACE PACKAGE BODY BARS.CCW IS  
 G_BODY_VERSION  CONSTANT VARCHAR2(64)  :='ver.1.0 22.06.2016';    g_errN number := -20203 ; g_errS varchar2(5) := 'CCW:' ;

/*
22.06.2016 Сухова Добавки к ССК в связи с пере6ходом на ВЕЮ и ММФО
*/
nlchr char(2) := chr(13)||chr(10) ;
---====================================================================
function DOP_SEM (p_txt varchar2, p_tab varchar2, p_sk varchar2, p_fk varchar2) return varchar2 is
  l_sem varchar2(250);
begin
 If p_txt is not null and p_tab is not null and p_sk is not null and p_fk is not null then
    bars_audit.info('CCW p_fk=' || p_fk || ' p_tab '|| p_tab || '  p_sk ' || p_sk || ' p_txt '|| p_txt);
    begin EXECUTE IMMEDIATE 'select ' || p_fk || ' from '|| p_tab || ' where ' || p_sk || ' = '''|| p_txt||'''' into l_sem ;
    EXCEPTION WHEN NO_DATA_FOUND THEN null;
    end ;
 end if ;

 RETURN l_Sem;

end DOP_SEM;


/*
procedure upd (
 p_rnk number, 
 p_cc_id varchar2, 
 p_s number, 
 p_kv int, 
 p_freq int, 
 p_freqP int,
p_DATNP
) is 
  s_eRR  varchar2 (500);
  l_ND   number ;
  l_acc8 number ;
begin;
  If p_RNK   is Null              then s_eRR  := s_ERR||'Позичальник'      ||nlchr ;  end if;
  If p_CC_ID is Null              then s_eRR  := s_ERR||'№ дог'            ||nlchr ;  end if;
  If p_S     is Null              then s_eRR  := s_ERR||'Сума дог'         ||nlchr ;  end if;
  If p_KV    is Null              then s_eRR  := s_ERR||'Вал дог'          ||nlchr ;  end if;
  If p_FREQ  is Null              then s_eRR  := s_ERR||'Період погаш тіла'||nlchr ;  end if;
  If p_FREQP is Null              then s_eRR  := s_ERR||'Період погаш %% ' ||nlchr ;  end if;
  If p_DATNP is Null              then s_eRR  := s_ERR||'Перша дата погаш.'||nlchr ;  end if;
  If p_VID   is Null              then s_eRR  := s_ERR||'Вид договору'     ||nlchr ;  end if;
  If p_Den   is Null              then s_eRR  := s_ERR||'День погашення'   ||nlchr ;  end if;
  If p_ISTO  is Null              then s_eRR  := s_ERR||'Джерело залучення'||nlchr ;  end if;
  If p_Prod  is Null              then s_eRR  := s_ERR||'Код продукту'     ||nlchr ;  end if;
  If p_FIN   is Null              then s_eRR  := s_ERR||'фінансовий стан ' ||nlchr ;  end if;
  If p_PROC= is Null              then s_eRR  := s_ERR||'Процентна ставка' ||nlchr ;  end if;
  If p_Basey is Null              then s_eRR  := s_ERR||'база нарахування' ||nlchr ;  end if;
  If p_INIC  is Null              then s_eRR  := s_ERR||'Ініціатива'       ||nlchr ;  end if;
  If p_CEL   is Null              then s_eRR  := s_ERR||'ціль кредитування'||nlchr ;  end if;
  If p_RANG  is Null              then s_eRR  := s_ERR||'шаблон погашення' ||nlchr ;  end if;
  If p_FLAS  is Null              then s_eRR  := s_ERR||'Деталі для ГПК'   ||nlchr ;  end if;
  If p_KOM>0 and nvl(m_KOM, 0) =0 then s_eRR  := s_ERR||'метод щоміс.коміс'||nlchr ;  end if;
  If ( p_KOM>0 or p_CR9>0) and nvl(V_CR9, 0) =0                        
                                  then s_eRR  := s_ERR||'валюта ком/доход' ||nlchr ;  end if;

  If s_Err is not null            then raise_application_error(g_errn,g_errS||s_Err); end if;
  --------------------------------------------------------------------------------------------
  If nvl(p_ND,0)=0                then --- ! !!! создание КД
     CCK.CC_OPEN (l_ND, p_RNK, trim(p_CC_ID), p_DAT1, p_DAT4, p_DAT1, p_DAT1, p_KV, p_S, p_VID, p_ISTO, p_CEL, p_Prod, p_FIN,p_OBS,
                  p_Aim, gl.auid, p_NLS,p_BANK, p_FREQ, p_PROC, p_Basey, p_Den, p_DATNP, p_FREQP, p_KOM );
  else                                 --- ! !!! коррекция КД
    begin select acc into l_acc8 from nd_acc n, accounts a where a.tip= 'LIM' and a.acc= n.acc and n.nd = p_ND;
    EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(g_errn,g_errS||'Не знайдено рах LIM для ' ||p_nd);
    end;

    CCK.CC_KOR     (l_ACC8, p_ND, p_RNK, p_CC_ID, p_DAT1, p_DAT4, p_DAT1, p_DAT1, p_KV,p_S, p_VID, p_ISTO, p_CEL, p_Prod, p_FIN, p_OBS, 
                  p_Aim, '', p_KOM, p_NLS, p_BANK, p_FREQ, p_PROC, p_Basey, p_Den, p_DATNP, p_FREQP )" ) 
  end if;

  --! !!! Общее для Создания КД и для Коррекции КД 
  CCK.MULTI_INT_EX( p_ND, p_BR_ID, p_an, p_KV1, p_PROC1, p_KV2, p_PROC2, p_KV3, p_PROC3, p_KV4, p_PROC4);

  update cc_deal set PROD= p_Prod,fin= p_FIN where nd= p_ND;
  CCK_APP.SET_ND_TXT(p_ND, 'INIC' , p_INIC  );
  CCK_APP.SET_ND_TXT(p_ND, 'FLAGS', p_FLAGS );
  CCK_APP.SET_ND_TXT(p_ND, 'EMAIL', p_Email );
  CCK_APP.SET_ND_TXT(p_ND, 'CCRNG', p_RANG  );

  CCK_APP.SET_ND_TXT(p_ND, 'CCRNG', p_RANG  );

  -- комиссия
  DELETE from nd_txt where nd= p_ND and tag in (
  CCK_APP.SET_ND_TXT(p_ND, 'S_SDI', S_SDI  ) ;
  CCK_APP.SET_ND_TXT(p_ND, 'R_CR9', R_CR9  ) ;
  CCK_APP.SET_ND_TXT(p_ND, 'I_CR9', I_CR9  ) ;
  CCK_APP.SET_ND_TXT(p_ND, 'SN8_R', SN8_Pr ) ;
  CCK_APP.SET_ND_TXT(p_ND, 'DATSN', DATNPSN) ;
  CCK_APP.SET_ND_TXT(p_ND, 'DAYSN', DenSN  ) ;
  If p_KOM > 0              then update int_accn  set  METR=m_KOM), BASEY=0, FREQ=1 where acc= l_ACC8 and id=2; end if;
  If p_KOM > 0 or R_CR9 >0  then   CCK_APP.SET_ND_TXT(p_ND, 'V_CR9', v_CR9 ); end if;

  If SK4_Pr >0 or R_CR9 > 0 then DELETE from int_ratn where acc = l_ACC8 and id = 4 ; 
                                 DELETE from int_accn where acc = l_ACC8 and id = 4 ;
                             INSERT INTO int_accn(acc,id,metr,basey,freq,acrb) Values 
                                                  (l_ACC8,4,0,0,1, cc_o_nls('8999',p_RNK,p_ISTO,p_ND,p_KV,'SD4') 
                                                     );
                                 INSERT INTO int_ratn(acc,id,bdat,ir) Values (p_ACC8,4, p_DAT1,SK4_Pr );
  end if;

  begin select s260 into sTmp_ from cc_potra where id=p_Prod;   CCK_APP.SET_ND_TXT(p_ND, 'S260', sTmp_  ) ;
  EXCEPTION WHEN NO_DATA_FOUND THEN null;
  end;
end upd;
*/

function header_version return varchar2 is begin  return 'Package header CCW '||G_HEADER_VERSION; end header_version;
function body_version   return varchar2 is begin  return 'Package body CCW '  ||G_BODY_VERSION  ; end body_version;

---Аномимный блок --------------
begin                                                                    
  null;
END CCW;
/
 show err;
 
PROMPT *** Create  grants  CCW ***
grant EXECUTE                                                                on CCW             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CCW             to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/ccw.sql =========*** End *** =======
 PROMPT ===================================================================================== 
 