DECLARE
   L_accrow    accounts%ROWTYPE;
   l_nls_new   VARCHAR2 (15);
   l_trace    varchar2(500):= 'FORM_NLS: ';
FUNCTION get_nls_new (p_accrow accounts%ROWTYPE)
      RETURN VARCHAR2
   IS
    L_NLS   VARCHAR2 (15);
    l_tries    number := 0;
    l_count    number;

   BEGIN
      L_NLS := p_accrow.nls;

      L_NLS := vkrzn( substr( p_accrow.kf, 1,5),  '3578'||'0' || substr( p_accrow.nls, 6,9));
    

    l_tries :=0;
    while l_tries < 100 loop
                l_count := 0 ;
                select count(*) into l_count from
                ( select 1  from accounts                   where nls      = L_NLS   and kf = p_accrow.kf
                  union all
                  select 1 from TRANSFORM_2017_FORECAST     where new_nls  = L_NLS   and kf = p_accrow.kf
                );

                -- ���� ����� ���� ����� ��� � ����� ��� � �����������������
                -- �������� ��� ��� ���������
                if l_count = 0 then
                   -- �����, ���� ���������
                   --bars_audit.info(l_trace||'���� ���������');
                   exit;
                end if;
                l_tries := l_tries + 1;
                L_NLS := vkrzn( substr( p_accrow.kf, 1,5), '3578'||'0' || trunc ( dbms_random.value ( 100000000, 999999999 ) )) ;
     end loop;

    if l_tries < 100 then
      RETURN l_nls;
    else 
      L_NLS := p_accrow.nls;
      RETURN l_nls;
    end if;
   END;
BEGIN
   --tuda;bc.go (300465);
 FOR k IN (SELECT kf FROM mv_kf)
   LOOP
      bc.go (k.kf);

      FOR c
         IN (SELECT a.*
               FROM accounts a
              WHERE     a.nlsalt LIKE '3579%'
                    AND a.nls LIKE '3570%'
                    AND a.nbs = '3578'
                    AND a.dazs IS NULL
                    AND EXISTS
                           (SELECT 1
                              FROM transfer_2017
                             WHERE     a.nbs = r020_new
                                   AND a.ob22 = ob_new
                                   AND r020_old = '3579'))
      LOOP
        
       
       l_nls_new := get_nls_new(c);
       
       bars_audit.info(l_trace||'NLS = '||l_nls_new||' ACC = '||c.acc);

       if l_nls_new like '3578%' and l_nls_new <> c.nls then
         UPDATE accounts
            SET nls = l_nls_new
          WHERE acc = c.acc AND kf = c.kf;

         UPDATE accounts_update a
            SET a.nls = l_nls_new
          WHERE     a.acc = c.acc
                AND a.kf = c.kf
                AND A.CHGACTION <> 3
                AND A.EFFECTDATE >= gl.bd;
       end if;
      END LOOP;                                                           -- c
   END LOOP;
   bc.home;                                                              -- k
END;
/
commit;