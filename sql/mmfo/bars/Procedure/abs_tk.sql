

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/ABS_TK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure ABS_TK ***

  CREATE OR REPLACE PROCEDURE BARS.ABS_TK (
 mfo_    IN     varchar2,  -- ��� ����� ������           :  303398
 branch_ IN     varchar2,  -- ������ BRANCH ����� ������ : /303398/020036/
 VALW_   IN     INT     ,  -- ���������� ��� ��� ��� �������   NULL = 840 , 0 - ����� ������
 kv_     IN OUT INT     ,  -- IN - ���.������(980), OUT - ���.�����������
 S_      IN OUT number  ,  -- IN - ����� � ����.(980), OUT - ����� � ����.(���)
 bday_   IN     date    ,  -- ���� ����.( ���� ������)
 NLS_       OUT varchar2,  -- ���� 2906(TK) � ��� ��� ������.
 NMS_       OUT varchar2,  -- ������������ ����� 2906(TK) � ��� ��� ������.
 OKPO_      OUT varchar2,  -- ���� ����� 2906(TK) � ��� ��� ������.
 p_currency in integer default null  -- ������ ������� 2 (���� ������, �� ������� ������ ������ ���������� ������)
 )       IS

  ---
  MFO_RU_ varchar2(12);
  rnk_ int ;
  sn_ number;

  ----------------------------------------
  -- 02.06.2008 ������. �� ��������� � �����������:
  -- ��� ������ �� 840 (� ������ ����� ���� � ���)
  -- ����� ������ ����  08.01.2008
  DAT_ date := to_date('08-01-2008','dd-mm-yyyy');
  -----------------------------------------------


  si_ number;

BEGIN

  if VALW_=980 and (p_currency is not null and p_currency<>980) then
    raise_application_error(-20000, '������������� ��������� VALW_ �� p_currency � �������� ABS_TK()');
  end if;
/*
������� ������� ����� 2906 � ����� ������ � ��� ���
��� ������������ � ��� ����� ����������� ������ ���������

������� � ����� �� ���-���    (�� ����� - ��� SBER    )
���������� ��� ���� �� �� ���.(�� ����� - ��� DEPSBR10)

*/

  --bars_audit.info('abs_tk: kv_='||kv_||', s_='||s_||', VALW_='||VALW_);


  if s_ <=0 then
     RAISE_APPLICATION_ERROR (-20001, 'ABS_TK: Sum ='|| S_ );
     return;
  end if;

  BEGIN
     SELECT decode (mfop,gl.aMFO, MFO, MFOP ) into MFO_RU_
     from banks where mfo=MFO_;
  EXCEPTION WHEN NO_DATA_FOUND THEN
     RAISE_APPLICATION_ERROR (-20001,
     'ABS_TK: MFO_RU_NOT_FOUND for MFO='|| MFO_);
     return;
  END;
  -------------
-- logger.info('TK-1: mfo_ru='||mfo_ru_);

  BEGIN
     SELECT a.rnk into rnk_
     from accounts a, bank_acc b
     where a.tip='L00' and a.kv=980 and a.acc=b.acc and b.mfo=MFO_RU_;
  EXCEPTION WHEN NO_DATA_FOUND THEN
     RAISE_APPLICATION_ERROR (-20001,
     'ABS_TK: RNK_NOT_FOUND for MFO_RU='|| MFO_RU_);
     return;
  END;
  --------
-- logger.info('TK-2: rnk_='||rnk_);



------------------------------------
/*
   ���� ��� ������ �����
   02.06.2008 ������. �� ��������� � �����������
   DAT_:= gl.BDATE;
*/

-----------------------------------

  kv_:= nvl(kv_,980);
  --
  If   kv_=980 then sn_:=                   S_;
  else              sn_:= gl.p_icurval(kv_, S_, DAT_);
  end if;
  --------
  Si_:=0; NLS_:=to_char(null); NMS_:=to_char(null); OKPO_:=to_char(null);

  -- ���� ������ ���� (840, 978, 980 ) � ����������� ������.
  --                ��������� �� ������

  -- nvl(VALW_,840) ���������� ��� ��� ��� �������   NULL = 840 , 0 - ����� ������

  for k in (select KV,NLS,substr(nms,1,38) NMS
            from accounts where
              -- SERG 28.08.2008  �� �������� ������� ���������
              --tip=decode(VALW_,980,'TK3','TK ')
              tip = 'TK '
              and rnk=rnk_
              and decode(kv,980, ostb, gl.p_icurval(kv,ostb, DAT_ )) > SN_
              --AND kv= DECODE ( nvl(VALW_,840), 0, KV,   nvl(VALW_,840) )
              and kv = case
                       when p_currency is null then 980
                       else p_currency
                       end
            order by kv )
  loop
    If si_ = 0 then
-- logger.info('TK-3: '||k.kv||' '||k.nls);

       -- ���������� �� �������� ����������
       If   kv_ = k.kv then si_:= S_;
       else kv_:= k.kv;     si_:= gl.p_ncurval(k.kv, SN_, DAT_);
       end if;

/*
          ����� ����� �����������
       If   kv_ = k.kv then si_:= S_;
       else kv_:= k.kv;     si_:=   ROUND (GL.P_NCURVAL(k.kv,SN_*100, GL.BD) / 100 - 0.5 ,0) ;
       end if;
*/

       NLS_:=k.nls;
       NMS_:=k.nms;
       select okpo into OKPO_ from customer where rnk=rnk_;
    end if;
  end loop;
  S_:= si_;
END ABS_TK;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/ABS_TK.sql =========*** End *** ==
PROMPT ===================================================================================== 
