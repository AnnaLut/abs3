

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OTKR3570_03.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OTKR3570_03 ***

  CREATE OR REPLACE PROCEDURE BARS.OTKR3570_03 (p_dat2 date) is
 acc1_    NUMBER;        --  ACC 3570
 nls_3570 VARCHAR2(15);  --  NLS 3570
 acc_     NUMBER;        --  ACC 2600
 i        NUMBER;
 tmp_3570 VARCHAR2(15);
 tmp_     NUMBER;
----------------------------------------------------------------------------------------------
--
--  ���� ��������, � ������� ���� ���� �� ���� �� ������ 2560,2600,2603,2604,2650, 2620/07,32
--  �� ��� �� ������ 3570/03, ��������� 3570/03.
--
-- 1). 3570/03 ��������� � ������� BRANCH-�� 2-�� ������ (���� � ������� ���� ����� 2600 �� ���� ������
--                                                        �������, �� ��������� ��� ��� ����� 3570/03 )
--
-- 2). ���������� ������ ������� �� �� RKO_3570 !  �� ��� 3570 ������������� "�������".
--
---============================================================================================

FUNCTION Get_NLS_random  (p_R4 accounts.NBS%type ) return accounts.NLS%type   is   --��������� � ���.�� �� ����.������
                          nTmp_ number ;            l_nls accounts.NLS%type ;
begin
  While 1<2        loop nTmp_ := trunc ( dbms_random.value (1, 999999999 ) ) ;
     begin select 1 into nTmp_ from accounts where nls like p_R4||'_'||nTmp_  ;
     EXCEPTION WHEN NO_DATA_FOUND THEN EXIT ;
     end;
  end loop;         l_nls := vkrzn ( substr(gl.aMfo,1,5) , p_R4||'0'||nTmp_ );
  RETURN l_Nls ;
end Get_NLS_random ;

-----------------------------------------------------------------------------------------------

Begin

  -------   ������� �� RKO_LST �������� ACC1 (3570/03) �  ACC2 (3570/37)  -------

  For k in ( Select r.ACC1, r.ACC
             from   RKO_LST r, Accounts a
             where  nvl(r.ACC1,0)>0
               and  r.ACC1 = a.ACC
               and  a.DAZS is not NULL
           )

  Loop

    Update RKO_LST set ACC1=null where ACC=k.ACC ;

    Commit;

  End Loop;

  -----------------------------------------------

  For k in ( Select r.ACC2, r.ACC
             from   RKO_LST r, Accounts a
             where  nvl(r.ACC2,0)>0
               and  r.ACC2 = a.ACC
               and  a.DAZS is not NULL
           )

  Loop

    Update RKO_LST set ACC2=null where ACC=k.ACC ;

    Commit;

  End Loop;

  ----------------------------------------------------------------------------------------


  FOR k IN  ( Select NLS, KV, ACC, ISP, NMS, TOBO, GRP, RNK, BRANCH
              FROM   Accounts
              WHERE  DAZS is NULL  and  KV=980
                 and ( NBS in ('2560','2600','2603','2604','2650',
                               '2642','2643','2545','2520','2530')
                          or
                       NBS='2620' and OB22 in ('07','32')
                      )
                 and  RNK not in (Select RNK from Customer where OKPO=gl.aOKPO)
                 and  ACC not in (Select ACC from RKO_3570)  --- ���������� ������ ������� �� �� RKO_3570
                 and  ACC not in (Select ACC from RKO_LST where ACC1 is not NULL)
            )

  LOOP

    Begin
                             --- 3570/03 ���� �� ������ �� ���, � �� ��� �� BRANCH-2, ��� � � 2600
      Select ACC into acc1_
      from   Accounts
      where  DAZS is NULL  and  NBS='3570' and  OB22='03' and
             substr(BRANCH,1,15) = substr(k.BRANCH,1,15)  and  RNK = k.RNK  and  rownum=1 ;


                ---  ���� 3570/03 �� ���� RNK �� ���� BRANCH !
      Begin

         Select ACC into i      ---  ���� 2600 ���� � RKO_LST � �� - � ������ ���1
         from   RKO_LST
         where  ACC = k.ACC  and ACC1 is NULL;

         Begin

           Select ACC into i    ---  ���� 3570/03 ���� � RKO_LST � ������ �� RKO_3570
           from   RKO_LST                                        --------------------
           where  ACC1 = acc1_ and ACC in (select ACC from RKO_3570) and  rownum=1;

         EXCEPTION when no_data_found then

           UPDATE rko_lst SET  ACC1 = acc1_   WHERE  ACC1 is NULL  and  ACC = k.ACC;

         End;

      EXCEPTION when no_data_found then
        null;
      End;


    EXCEPTION when no_data_found then


       nls_3570 := Get_NLS_random ('3570') ;  -- ��������� � ���.�� 3570/03 �� ����.������

       OP_REG(99,0,0,k.GRP,tmp_,k.RNK,nls_3570,980,substr('���.���.��� '||k.NMS,1,70),'ODB',k.ISP,acc1_);
       p_setAccessByAccmask(acc1_, k.ACC);
       Accreg.setAccountSParam( acc1_, 'OB22', '03' ) ;
       Accreg.setAccountSParam( acc1_, 'R013', '3'  ) ;
       Accreg.setAccountSParam( acc1_, 'S240', '1'  ) ;

       UPDATE accounts set TOBO = k.BRANCH WHERE acc=acc1_;

       -----------------------------------------------------------------------------
       ---  ����������� ���� 3570 � RKO_LST � 2600, ���� � ���� ���1 ������
       -----------------------------------------------------------------------------
       UPDATE rko_lst SET  ACC1 = acc1_   WHERE  ACC1 is NULL  and  ACC = k.ACC;


    END;


  END LOOP;


END otkr3570_03;
/
show err;

PROMPT *** Create  grants  OTKR3570_03 ***
grant EXECUTE                                                                on OTKR3570_03     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OTKR3570_03     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OTKR3570_03.sql =========*** End *
PROMPT ===================================================================================== 
