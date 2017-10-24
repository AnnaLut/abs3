

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OTKR3570_03.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OTKR3570_03 ***

  CREATE OR REPLACE PROCEDURE BARS.OTKR3570_03 (p_dat2 date) is
 acc_     NUMBER;        --  ACC 2600
 nls_     VARCHAR2(15);  --  NLS 2600
 acc1_    NUMBER;        --  ACC 3570
 nls_3570 VARCHAR2(15);  --  NLS 3570
 nms_     VARCHAR2(70);  --  NMS
 isp_     NUMBER;        --  ISP
 i        INT;
 tmp_3570 VARCHAR2(15);
 tobo_    VARCHAR2(30);
 grp_     NUMBER;
 tmp_     NUMBER;
 l_okpo   varchar2(12)  := f_ourokpo;
-------------------------------------------------------------------
--                        � � � � � � � �
--
--  ��������� �������� 3570/03 �� ��������, ������� 2560,2600,2603,2604,
--  2650,2620/07,2642,2643,2545 (� �� �� ���� �����).
--
--
--  1). ���������� (ACC1=null) �������� 3570/03
--
--  2). ���� ��������, � ������� ���� ���� �� ���� �� ������
--      2560,2600,2603,2604,2650, 2620/07,32 (�� ��� �� ������
--      3570/03) ��������� 3570/03.
--
--  3). ���� ������. ���������� 2620/32 �������� 3570/34
--
-------------------------------------------------------------------
Begin

-------   ������� �� RKO_LST.ACC1 �������� ACC1 (3570)  -------

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


---------------------  �������� 3570/03   -------------------------

  FOR k IN  ( Select distinct RNK
              FROM   Accounts
              WHERE
                     DAZS is NULL  and  KV=980
                 and ( NBS in ('2560','2600','2603','2604',
                               '2650','2642','2643','2545' )
                          or
                       NBS='2620' and OB22 in ('07','32')
                     )
                 and RNK not in (Select RNK from Accounts where
                                     NBS='3570'   and OB22='03' and
                                     DAZS is NULL and KV=980
                                )
                 and RNK not in (Select RNK from Customer where OKPO=gl.aOKPO)
            )

  LOOP

  BEGIN

     Select NLS ,ACC ,ISP ,NMS ,TOBO ,GRP
     into   nls_,acc_,isp_,nms_,tobo_,grp_
     From   Accounts
     where  RNK=k.RNK
       and  DAZS is NULL  and  KV=980
       and ( NBS in ('2560','2600','2603','2604',
                     '2650','2642','2643','2545' )
                or
             NBS='2620' and OB22 in ('07','32')
           )
       and  rownum=1;

     Begin

       nls_3570:= VKRZN(SUBSTR(gl.aMFO,1,5),'3570'||SUBSTR(nls_,5));

       Select NLS
       into   tmp_3570
       from   accounts
       where  NLS = nls_3570 and KV=980 and
              (RNK<>k.RNK  OR  OB22<>'03'  OR  DAZS is not NULL);

        --   C��� 3570<����� 2600> ��� ����:
        --        --  �� ������ RNK   ���
        --        --  � OB22<>'03'    ���
        --        --  �� ������ !
        --   ��������� ������ ���� �� �����:  3570 k S NN RRRRRR
        --   ���:  S  - 6-�� ����� �� 2600*

       i:= 1;

       LOOP

          nls_3570:= vkrzn(substr(gl.aMFO,1,5),
                  '3570'||'0'|| substr(nls_,6,1) ||
                  lpad(to_char(i),2,'0') || lpad(to_char(k.RNK),6,'0'));

          Begin    -- ���� �� ����� ���� ?

            Select NLS
            into   tmp_3570
            from   accounts
            where  NLS = nls_3570 and KV=980 and
                   (RNK<>k.RNK  OR  OB22<>'03'  OR  DAZS is not NULL);

          Exception when no_data_found then
            EXIT;     -- ������ ����� ��� ���, - ���������
          End;

          i := i + 1;
          if i = 100 then
             exit;
          end if;

       END LOOP;

     EXCEPTION when no_data_found then
       null;
     END;  ---------- END ������� ������ 3570*  -----


     OP_REG(99,0,0, grp_,tmp_, k.RNK, nls_3570, 980,
            substr('���.���.��� '||nms_,1,70),'ODB',isp_, acc1_);

     ----  ������������ ������� �� 2600:
     p_setAccessByAccmask(acc1_,acc_);

     ----  ���������� ������� �� GROUPS_NBS:
     For n in (Select ID From GROUPS_NBS where NBS='3570')
     Loop
        sec.addAgrp(acc1_, n.ID);
     End Loop;

     UPDATE accounts SET TOBO=tobo_ WHERE ACC=acc1_;

     BEGIN
       INSERT INTO Specparam (ACC,R013,S240)  VALUES (acc1_,'3','1');
     EXCEPTION WHEN OTHERS THEN
       UPDATE Specparam SET R013='3', S240='1', S180='1' WHERE  ACC=acc1_;
     END;

     BEGIN
       INSERT INTO Specparam_INT (ACC,OB22)  VALUES (acc1_,'03');
     EXCEPTION WHEN OTHERS THEN
       UPDATE Specparam_INT SET OB22='03'  WHERE  ACC=acc1_;
     END;

  EXCEPTION when no_data_found then
     null;
  END;


  END LOOP;


---------  �������� 3570/34 ������������� ���������� (2620/32) -------------------------


  FOR k IN  ( Select distinct RNK
              FROM   Accounts
              WHERE
                     DAZS is NULL  and  KV=980
                 and NBS = '2620'  and  OB22='32'
                 and RNK not in (Select RNK from Accounts where
                                        NBS='3570'   and OB22='34'
                                    and DAZS is NULL and KV=980
                                )
                 and RNK not in (Select RNK from Customer where OKPO=gl.aOKPO)
            )

  LOOP

  BEGIN

     Select NLS ,ACC ,ISP ,NMS ,TOBO ,GRP
     into   nls_,acc_,isp_,nms_,tobo_,grp_
     From   Accounts
     where
            RNK=k.RNK
       and  DAZS is NULL  and  KV=980
       and  NBS = '2620'  and  OB22='32'
       and  rownum=1;

     Begin

       nls_3570:= VKRZN(SUBSTR(gl.aMFO,1,5),'3570'||SUBSTR(nls_,5));

       Select NLS
       into   tmp_3570
       from   accounts
       where  NLS = nls_3570 and KV=980 and
              (RNK<>k.RNK  or  OB22<>'34'  or  DAZS is not NULL);

        --   C��� 3570<����� 2600> ��� ����:
        --        --  �� ������ RNK   ���
        --        --  � OB22<>'34'    ���
        --        --  �� ������ !
        --   ��������� ������ ���� �� �����:  3570 k S NN RRRRRR
        --   ���:  S  - 6-�� ����� �� 2600*

       i:= 1;

       LOOP

          nls_3570:= vkrzn(substr(gl.aMFO,1,5),
                  '3570'||'0'|| substr(nls_,6,1) ||
                  lpad(to_char(i),2,'0') || lpad(to_char(k.RNK),6,'0'));

          Begin    -- ���� �� ����� ���� ?

            Select NLS
            into   tmp_3570
            from   accounts
            where  NLS = nls_3570 and KV=980 and
                   (RNK<>k.RNK  OR  OB22<>'34'  OR  DAZS is not NULL);

          Exception when no_data_found then
            EXIT;     -- ������ ����� ��� ���, - ���������
          End;

          i := i + 1;
          if i = 100 then
             exit;
          end if;

       END LOOP;

     EXCEPTION when no_data_found then
       null;
     END;  ---------- END ������� ������ 3570*  -----


     OP_REG(99,0,0, grp_,tmp_, k.RNK, nls_3570, 980,
            substr('�� �������.�����  '||nms_,1,70),'ODB',isp_, acc1_);

     ----  ������������ ������� �� 2600:
     p_setAccessByAccmask(acc1_,acc_);

     ----  ���������� ������� �� GROUPS_NBS:
     For n in (Select ID From GROUPS_NBS where NBS='3570')
     Loop
        sec.addAgrp(acc1_, n.ID);
     End Loop;


     UPDATE accounts SET TOBO=tobo_ WHERE ACC=acc1_;

     BEGIN
       INSERT INTO Specparam (ACC,R013,S240)  VALUES (acc1_,'3','1');
     EXCEPTION WHEN OTHERS THEN
       UPDATE Specparam SET R013='3', S240='1', S180='1' WHERE  ACC=acc1_;
     END;

     BEGIN
       INSERT INTO Specparam_INT (ACC,OB22)  VALUES (acc1_,'34');
     EXCEPTION WHEN OTHERS THEN
       UPDATE Specparam_INT SET OB22='34'  WHERE  ACC=acc1_;
     END;

  EXCEPTION when no_data_found then
     null;
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
