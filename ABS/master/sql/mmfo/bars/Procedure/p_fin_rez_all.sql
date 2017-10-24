

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FIN_REZ_ALL.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FIN_REZ_ALL ***

  CREATE OR REPLACE PROCEDURE BARS.P_FIN_REZ_ALL 
(p_BR   varchar2, --  ����� ��� ������ ������� 1,2,3
 p_BL   varchar2, -- � ��� ��
 p_kv   varchar2, --  c ��� 1   , ��� ��� =0
 p_ob   varchar2, --  c ob22 =1 , ��� = 0
 p_DAT1 varchar2, -- ���� "�"
 p_DAT2 varchar2  -- ���� "��"
 ) Is

 v_sql varchar2(4000) ;
 p_kor  int     :=10  ; --- ���-�� ���� ����.����.
 L_br char(1)         ;   L_kv char(1) ;   L_ob char(1);  L_bl char(1);

 m_branch branch.branch%type ;

begin
 m_branch  := trim(sys_context('bars_context','user_branch'));

 If p_br is null then

    If length( m_branch) <=8 then  l_br := 2;
    else                           l_br := 3;
    end if;
 else                              l_br := p_br;
 end if;

 If l_br not in ('1','2','3') then
    raise_application_error( -20100,'\8999 "�i�.������" �.�. �i����: 1,2,3 ');
 end if;

 L_kv    := nvl(p_kv,'0');
 If l_kv not in ('0','1') then
     raise_application_error(-20100,'\8999 ��������� "� ���" �.�. �i����: 0,1');
 end if;

 L_bl :=    nvl(p_bl,'0');
 If l_bl not in ('0','1') then
     raise_application_error(-20100,'\8999 ��������� "� ���" �.�. �i����: 0,1');
 end if;

 If L_bl ='0' then l_ob := '0';
 else              L_ob := nvl(p_ob,'0');
    If l_ob not in ('0','1') then
       raise_application_error(-20100,'\8999 ��������� "� ��22" �.�. �i����: 0,1');
    end if;
 end if;

  p_FIN_REZ_branch ( p_kor  => p_kor,  -- =10 - ���-�� ���� ����.����.
                     p_DAT1 => p_DAT1, -- varchar2, -- ���� "�"
                     p_DAT2 => p_DAT2  -- varchar2  -- ���� "��"
                    ) ;
  EXECUTE IMMEDIATE  'truncate table TMP_FIN_REZ ';

  v_sql  :=
   'insert into TMP_FIN_REZ ' ||
   '(nbs,ob22,nls,kv,branch,n1,n2,n3,dat1,dat2) select ';

  If l_bl = '1' then v_sql :=  v_sql || ' substr(nls,1,4), ';
  else               v_sql :=  v_sql || ' null           , ';
  end if;

  If l_ob = '1' then v_sql :=  v_sql || ' substr(nls,5,2), nls , ';
  else               v_sql :=  v_sql || ' null           , null, ';
  end if;

  If l_kv = '1' then v_sql :=  v_sql || 'kv  , ';
  else               v_sql :=  v_sql || 'null, ';
  end if;

  v_sql := v_sql || ' substr(branch,1,1+7*' || l_br || '), '||
 ' sum(n1)/100, sum (n2)/100 , sum(n2-n1)/100 ,
  to_date( substr(name1, 2, 8),''yyyymmdd''),to_date( substr(name1,10, 8),''yyyymmdd'')
  from CCK_AN_TMP where branch like '''||m_branch||'%''
  group by name1, ';

  If l_bl = '1' then v_sql :=  v_sql || 'substr(nls,1,4), ';  end if;
  If l_ob = '1' then v_sql :=  v_sql || 'nls, ';              end if;
  If l_kv = '1' then v_sql :=  v_sql || 'kv, ' ;              end if;

  v_sql :=  v_sql || ' substr(branch,1,1+7*' || l_br || ') ';

  logger.info( 'V_SQL=' ||v_sql);

  EXECUTE IMMEDIATE  v_sql ;

end p_FIN_REZ_all;
/
show err;

PROMPT *** Create  grants  P_FIN_REZ_ALL ***
grant EXECUTE                                                                on P_FIN_REZ_ALL   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FIN_REZ_ALL   to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FIN_REZ_ALL.sql =========*** End
PROMPT ===================================================================================== 
