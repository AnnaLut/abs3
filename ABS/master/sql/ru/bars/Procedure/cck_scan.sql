

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CCK_SCAN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CCK_SCAN ***

  CREATE OR REPLACE PROCEDURE BARS.CCK_SCAN (p_prod varchar2 ) is

/*
 --30.11.2015 ���������� � ���.SQl-�������� �������������� ������-������ �� �� ��� ���������� ������������  ��
 -- ��������� ��������� ��������� �����-������� ��� SNO(ATO)
 -- From: ����� ������ �������� [mailto:MeshkoEI@oschadbank.ua]
 -- ���.: +380 (44) 249 31 43
*/

  n_Commit int := 100;  i_Commit int := 0;
  -- ���������� ������������ ������� � ������� ��� COMMIT; ��� ����� ������ ���� ��������� �����������,
  -- ��� �� �.�. ������� ������� - ����� �� ���� ����� ������� ����������. �  �� �� ������� ������� - ����� ����� ���.������ �� ���� ����� �������.

  sSql_ varchar2(2000);
  g_Dat date    ;
  g_del int     := 5  ;
  g_acc number  ;
  g_Kv  number  ;
  g_Ref number  ;
  g_Err varchar2(252) ;
begin
  for k in (select d.nd, c.pFINIS , substr(d.prod,1, 6) PROD  from cc_deal d, cck_ob22 c
            where d.sos >= 10 and d.sos < 15 and d.vidd in (1,2,3,11,12,13) and substr(d.prod,1, 6) = c.nbS||c.ob22
           )
  loop

     -- ������������ ��, � ������� ���������� �����-�����
     begin select to_date(t.txt,'dd/mm/yyyy'), a.acc, a.kv, ad.refp
           into    g_Dat, g_Acc, g_Kv, g_Ref
           from nd_txt t, accounts a , nd_acc n, cc_add ad
           where t.tag = 'GRACE' and t.nd = n.nd and n.acc = a.acc and a.tip ='SNO' and ad.nd = n.nd and ad.nd=k.nd;

           If g_Dat > (gl.bdate - g_Del) and  g_Dat <= gl.Bdate then
              SNO.ADD31 (p_acc => G_acc, p_REF => G_REF, p_kv => g_kv, S_err => g_Err ) ;
              SNO.ADD32 (p_acc => G_acc, p_REF => G_REF, p_kv => g_kv, p_Del => g_Del ) ;
           end if ;

     EXCEPTION WHEN NO_DATA_FOUND THEN null;
     end;


     If k.pFINIS is not null and k.PROD like p_prod then
        sSql_ := 'begin ' ||  replace ( k.pFINIS, ':ND', to_char(k.ND) ) || '; end ; '  ;
        SAVEPOINT sp_before_CL;
        -----------------------
        begin execute  immediate sSql_ ; i_Commit := i_Commit + 1 ; If i_Commit >= n_Commit then  COMMIT; i_Commit := 0 ;   end if ;
        EXCEPTION  WHEN OTHERS THEN      bars_audit.error('CCK_SCAN, ����.'|| k.pFINIS || ', ��='||k.nd|| '*' ||SQLERRM );
              ROLLBACK TO sp_before_CL ;
        end  ;
     end if  ;

  end loop   ;
end CCK_Scan ;
/
show err;

PROMPT *** Create  grants  CCK_SCAN ***
grant EXECUTE                                                                on CCK_SCAN        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CCK_SCAN.sql =========*** End *** 
PROMPT ===================================================================================== 
