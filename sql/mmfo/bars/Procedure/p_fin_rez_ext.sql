

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FIN_REZ_EXT.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FIN_REZ_EXT ***

  CREATE OR REPLACE PROCEDURE BARS.P_FIN_REZ_EXT 
(p_kor  int , -- =10 - ���-�� ���� ����.����.
 p_DAT1 varchar2, -- ���� "�"
 p_DAT2 varchar2, -- ���� "��"
 p_mode int
 ) Is

  /*
  18.06.2014 O���������� ������ ��� ���/���� 6399
  05.02.2014 ������� �� ����� ����.
  08.05.2013 ��������� TXT -> BRANCH
  02-08-2012 ���� nada6v  �������� �� tmp_nada6v
  25.07.2012 p_mode= 2 -- 973 6v.���-3V(XLS).������ (��������_���������)
                          ExportCatQuery( 973,"",8,"",TRUE)
             ����� ����� ��� ��.���/SQL=
  21.02.2012 ������ ������� ���. = ����� �� 35*
*/
 -- ���������� ���������� �� �������� �������  -- � �.�. �� �������� ������
  DAT1_ date ; --  ���� "�"
  DAT2_ date ;  -- ���� "��"
  kor_   int := p_kor   ;

  ACC_ accounts.acc%type; BRANCH_ accounts.branch%type; n1_ number; n2_ number; a_NAME1 varchar2(17);  b_NAME1 varchar2(17) ;
  vob_    oper.vob%type ; nazn_   oper.nazn%type      ; vdat_ oper.vdat%type  ; mfoa_ oper.mfoa%type;  mfob_ oper.mfoa%type ;
  nlsk_   oper.nlsb%type; kvk_    oper.kv%type        ; kvi_  oper.kv%type    ; tt_   oper.tt%type  ;  SSql_ varchar2(2000) ;
  l_col   char(2)       ; l_tabl  varchar2(30)        ;
-------------------------------
 TYPE r1 IS RECORD ( n1 number, n2 number)   ;
 TYPE m1 IS TABLE OF r1 INDEX BY VARCHAR2(31);
 tmp1 m1 ;  -- CCK_AN_TMP --  p_mode = 1
-------------------------------
 ind_ VARCHAR2(31) ;

/*
���.6/7 ����� �i�������� �� �����-2. �� � ��������� i ��i������ �i���� �� ������.
��� �i�������� �� ����� ������� � ��i�i ��� ������_� 6/7 ����� � ����i�i �����i�-3
 - �� �� � ���������� �������� ����� � ����i � ������ ���� ��i�.
�� ������� ������ ���������:
------------------------------------------------------------------------------------------
� �����| �����                  | ��������
------------------------------------------------------------------------------------------
   1   |<�i��� ���������� �����>| ����� ���.2638, 2208, 3578,...
   2   |<�i��� ����� ������i�>  | �����, �� ����� ������i� :���/���, ������ ���,...
   3   |<��������� ���������>   | ���������� ������ (����,�����,...) �� ��������� <���-3>
   4   |<�i��� �������� ���6/7> | ������ �����-2 ������� 6/7 �����
------------------------------------------------------------------------------------------
��� ����� ��� ����i����� �i ��������� (�� �i� ������), � ����:

��������i: 60/70 - ������ �i���� � ����� = 1
���i�i��i: 61/71 - ���� ���.���-������������� ������ �� 3*8 , �� � ����� = 1,
                 - i����� � ����� = 2
��������.: 62    - ������ �i���� � ����� = 2
I��i     : 6/7   - ���� ������ <��������� ���������> �� � ����� = 3,
                 - i����� � ����� = 4

� �� ���i��, ��� �� ��������� ������i������ ������� ����i����� ��� � ����� (1,2,3,4)
�� ����� ���� 6###/��22 �� 7###/��22 ����� ���_���� SB_OB22.

*/

begin

  DAT1_    := nvl ( to_date ( p_DAT1, 'dd-mm-yyyy' ) , gl.bdate ) ;
  DAT2_    := nvl ( to_date ( p_DAT2, 'dd-mm-yyyy' ) , gl.bdate ) ;
  a_NAME1  := 'F' || to_char ( DAT1_, 'YYYYMMDD' ) ||  to_char ( DAT2_, 'YYYYMMDD' ) ;

If p_mode = 1    then l_tabl := 'CCK_AN_TMP'; tmp1.DELETE;
   -- ������ �� �������������. �.�.������� ������ � ����������
   begin  select NAME1 into b_NAME1 from CCK_AN_TMP where rownum=1;
     If   b_NAME1 = a_NAME1 then goto KIN ;   else  EXECUTE IMMEDIATE 'TRUNCATE TABLE ' || l_tabl ;   end if;
   exception when no_data_found then  NULL;
   end;
elsIf p_mode = 2 then l_tabl := 'tmp_nada6v';       EXECUTE IMMEDIATE 'TRUNCATE TABLE ' || l_tabl ;
end if;

  -- ���� �� �������
  If to_char(DAT2_,'MM') = '12' then   kor_   := 20 ;  end if;

  logger.info('FIN-1'|| ' ' ||  kor_|| '**'|| To_char(DAT1_,'dd-mm-yyyy') ||'****'|| To_char(DAT2_,'dd-mm-yyyy') ) ;

  for k in (select a.NBS, a.nls, a.ob22, a.branch , substr(a.nbs,2,1) B2, a.nms, o.fdat, o.acc, o.dk, o.s, o.ref, o.txt
            from opldok o, v_gl a    where a.acc=o.acc  and a.nbs  >  '5999' and o.tt not like 'ZG_'  and a.nbs  <  '8000'
--and o.ref = 123263746
              and o.fdat >= DAT1_   and o.fdat <= (DAT2_+ kor_)
               )
  loop
     select branch ,tt, vdat ,vob ,mfoa ,mfob , decode(nlsb,k.nls,nlsa,nlsb),  decode(nlsb,k.nls,kv,kv2 ),
            NVL(decode (kv,gl.baseval, nvl(kv2, kv), KV ) , gl.baseval) ,      nazn
     into   BRANCH_,tt_,vdat_,vob_,mfoa_,mfob_, nlsk_, kvk_, kvi_, nazn_       from   oper where  ref = k.ref;

     If vob_ in (96,99) then If vdat_  < DAT1_  then  goto NextRec; end if;   -- ��� ������� �������� �������
     else                    If k.fdat > DAT2_  then  goto NextRec; end if;   -- ��� ������� �������� �������
     end if;

     If k.nbs='6204' and kvi_=gl.baseval and mfoa_=mfob_ and nlsk_ like '3801%' and tt_<>'REV' then kvi_:=to_number(substr(nlsk_,12,3) ) ;
     end if;

     -- ���� ���������� �����, ���� ����������� ��� ���/����  !!!!! ��� �������� � OPLDOK -- ����� �������
     If nazn_ like '����������� ������� �%' and tt_ ='024' then BRANCH_ := k.branch;      -- �������_� ������� - �� ����� �������� �����
     elsIf    k.txt like '/' || gl.amfo || '/%' then    BRANCH_ := SUBSTR(k.txt,1,30) ;   -- 3  |<��������� ���������>   | ���������� ������ (����,�����,...) �� ��������� <���-3>
     elsIf k.b2 = '0'                                                                     --   ����������
        OR k.b2 = '1' and nlsk_ like '35%' then                                           --   ������������ (�� ������ ����������)
                                                                                          -- 1  |<�i��� ���������� �����>| ����� ���.2638, 2208, 3578,...����������
        begin     select branch into BRANCH_ from accounts where kv=KVK_ and nls=NLSK_;
        EXCEPTION WHEN NO_DATA_FOUND THEN null;
        end;
     ElsIf k.b2 >'2' OR mfoa_<>mfob_ OR length(branch_)=8 then                            -- 4   |<�i��� �������� ���6/7> | ������ �����-2 ������� 6/7 �����
        If length(BRANCH_) < 15 then BRANCH_  := k.branch; end if;
     end if;
                                                                                          -- 2   |<�i��� ����� ������i�>  | �����, �� ����� ������i� :���/���, ������ ���,...
                                                                                          --      ��������� - �� ��������� - �� ����� ������������� ��������  BRANCH_  := oper.branch
     If k.dk=0 then n1_ := k.S ; n2_ := 0; else n1_ := 0; n2_ := k.s; end if;

     If p_mode = 1 then
        -- �������� ������� ���� ���������� ����-��������� CCCCOOVVV/BBBBBB/BBBBBB/BBBBBB/
        ind_ := k.nbs||k.ob22||substr('000'||kvi_,-3)||branch_ ;
        if tmp1.EXISTS (ind_) then tmp1(ind_).n1 := tmp1(ind_).n1 + n1_; tmp1(ind_).n2 := tmp1(ind_).n2 + n2_;
        else                       tmp1(ind_).n1 :=                 n1_; tmp1(ind_).n2 :=               + n2_;
        end if;
     elsIf p_mode = 2 then If vob_ in (96,99) then l_col := 'CR'; else l_col := to_char(k.fdat,'DD'); end if;

        begin
           SSql_ := 'update '||  l_tabl  ||
                                 ' set D'|| l_col  || ' = nvl(D'   ||l_col || ',0) +'  || n1_ || ' / 100, ' ||
                                     ' K'|| l_col  || ' = nvl(K'   ||l_col || ',0) +'  || n2_ || ' / 100  ' ||
                    ' where BRANCH= '''  || branch_|| ''' and kv=' || KVI_ || ' and nls='''|| k.nls||'''' ;
           EXECUTE IMMEDIATE SSql_;
           if SQL%rowcount = 0 then SSql_:= 'insert into '||l_tabl||' (MFO,BRANCH,KV,NBS,NLS,NMS,OB22,D'|| l_col ||',K'|| l_col ||
               ') values (''' ||gl.aMFO|| ''','''||branch_||''','  || kvi_   ||   ',''' || k.nbs || ''','''
                              ||k.nls  || ''','''||k.nms  ||''','''|| k.ob22 || ''','   || n1_   || ' /100 , '|| n2_ ||' /100 )';
              EXECUTE IMMEDIATE SSql_;
           end if;
        exception when others then     logger.info('P_FIN_REZ_EXT: sql='|| SSql_);
           raise_application_error(-20100,'\���='||k.ref||'.��.���/SQL='|| SSql_);
        end;
     end if ;
     <<NextRec>> NULL;
  end loop;
  ----------------------
  logger.info('FIN-2');
  If p_mode = 1 then
     --- �������� ��� �� ������� ����-��������
     ind_ := tmp1.FIRST; -- ���������� ������ ��  ������ ������
     WHILE ind_   IS NOT NULL
     LOOP
        branch_ := substr(ind_,10,22); kvi_ := to_number(substr(ind_,7,3));  n1_ := tmp1(ind_).n1;  n2_ := tmp1(ind_).n2 ;
        insert  into CCK_AN_TMP (nls,branch,kv,n1,n2,NAME1) values (substr(ind_,1,6), branch_, kvi_, n1_, n2_, a_NAME1 ) ;
        ind_    := tmp1.NEXT(ind_); -- ���������� ������ �� ����.���� ������
     end loop;
  end if;
  ------------------
  <<KIN>> null;
  logger.info('FIN-3');

  If p_mode = 2 then
     commit;
     SSql_ :=
    'update '|| l_tabl || ' n set zn50 =(select zn50 from sb_ob22 where r020=n.nbs and ob22= n.ob22), kod_b=substr(n.nls,6,6)';
     commit;
  logger.info('FIN-4');
  end if;

end p_fin_rez_ext;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FIN_REZ_EXT.sql =========*** End
PROMPT ===================================================================================== 
