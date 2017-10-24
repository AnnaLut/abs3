

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PK_2600.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PK_2600 ***

  CREATE OR REPLACE PROCEDURE BARS.PK_2600 (p_dat2 date) is
  acc_2608  integer;
  nls_2608  varchar2(15);
  nbs_2608  varchar2(4);
  segm_     varchar2(1);
  ob22_     varchar2(2);
  tmp_      NUMBER;
  nls_7020  varchar2(15);
  acc_7020  varchar2(15);
  nbs_7020  varchar2(4);
  stavka    number(20,4);
  kkk_      NUMERIC ;
  acr_dat1  date ;
  l_dazs    date ;
/*
 14.11.2016 Sta ����� �������� TIU_ZAPRET_26MFO �� ��
 ORA-20000: \ ���������� ��������/����������� ������� 26-� ����� �� ����� ���!

                        � � � � � � � �

  ��������� ������������ ����.�������� �� 2560,2600,2603,2604,2650
                (�������� � ������ �������� ���)

*/

Begin

begin   ---  1).  ������������ ACRA

  FOR k IN  ( Select a.ACC, a.NLS, a.NBS, a.KV, a.RNK, a.NMS, a.ISP, a.BRANCH, a.TOBO, i.ACRA, i.ACRB, a.OB22, a.grp
              FROM   Accounts a, INT_ACCN i, Accounts s
              WHERE  a.ACC=i.ACC  and  i.ID=1
                 and ACRN.FPROCN(a.ACC,1,gl.BDATE)>0   and a.DAZS is NULL
                 and ( a.NBS in ('2560','2600','2603','2604','2650')  or  a.NBS='2620' and a.OB22 in ('07','32')    )
                 and a.ACC not in (Select ACC from DPU_DEAL)
                 and i.ACRA is not NULL   and i.ACRA=s.ACC
                 and (s.RNK<>a.RNK  or substr(s.NLS,1,4) not in    ('2568','2628','2608','2658')                    )
                 and a.RNK in (Select RNK from Customer where DATE_OFF is NULL)
    UNION ALL
              Select a.ACC, a.NLS, a.NBS, a.KV, a.RNK, a.NMS,  a.ISP, a.BRANCH, a.TOBO,  i.ACRA, i.ACRB, a.OB22, a.grp
              FROM   Accounts a, INT_ACCN i
              WHERE  a.ACC=i.ACC  and  i.ID=1 and ACRN.FPROCN(a.ACC,1,gl.BDATE)>0   and a.DAZS is NULL
                 and ( a.NBS in ('2560','2600','2603','2604','2650')   or   a.NBS='2620' and a.OB22 in ('07','32')  )
                 and a.ACC not in (Select ACC from DPU_DEAL)
                 and a.RNK in (Select RNK from Customer where DATE_OFF is NULL)
                 and i.ACRA is NULL
            )

  LOOP    ob22_:='01';

    If     k.NBS='2560' then                  nbs_2608:='2568';
    elsif  k.NBS='2650' then                  nbs_2608:='2658';
    elsif  k.NBS='2620' and k.OB22='07' then  nbs_2608:='2628';    ob22_:='07';
    elsif  k.NBS='2620' and k.OB22='32' then  nbs_2608:='2628';    ob22_:='47';
    else                                      nbs_2608:='2608';
    End if;

--- ����/��������� ���� 2608* �� ��� ����� �� �������:
    If length (k.branch) = 8 then k.branch := k.branch ||'000000/' ; end if;

    BEGIN Select ACC, dazs  into acc_2608, l_dazs from Accounts  where NBS=nbs_2608 and KV=k.KV  and  RNK=k.RNK  and rownum=1;
          If l_dazs is not null then
             Update Accounts set DAZS = null where ACC = acc_2608 ;
             Update Accounts set NMS  = substr('�����.%% '||k.NMS,1,70), ISP=k.ISP, tobo  = k.branch where ACC=acc_2608;
          end if;
    EXCEPTION WHEN OTHERS then   nls_2608 := VKRZN(SUBSTR(gl.aMFO,1,5),nbs_2608||SUBSTR(k.NLS,5));
       -- OP_REG(99,0,0,NULL, tmp_, k.RNK, nls_2608, k.KV, substr('�����.%% '||k.NMS,1,70),'ODB',k.ISP,acc_2608);
          op_reg_exfl
            ( mod_ => 99,    --      INTEGER,   -- Opening mode : 0, 1, 2, 3, 4, 9, 99, 77
              p1_  => 0 ,    --      INTEGER,   -- 1st Par      : 0-inst_num   1-nd   2-nd   3-main acc   4-mfo
              p2_  => 0 ,    --      INTEGER,   -- 2nd Par      : -    -    pawn   4-acc
              p3_  => k.grp, --      INTEGER,   -- 3rd Par (Grp): -    -    mpawn
              p4_  => tmp_,  -- IN OUT INTEGER,   -- 4th Par      : -    -    ndz(O)
             rnk_  => k.RNK, --      INTEGER,   -- Customer number
             nls_  => nls_2608, --     VARCHAR2,  -- Account  number
             kv_   =>k.kv,   --     SMALLINT,  -- Currency code
             nms_  => substr('�����.%% '||k.NMS,1,70), --      VARCHAR2,  -- Account name
             tip_  =>'ODB',  --   CHAR,      -- Account type
             isp_  => k.ISP, --       SMALLINT,
             accR_ => acc_2608, --   OUT INTEGER,
        --   nbsnull_        VARCHAR2 DEFAULT '1',
        --   pap_            NUMBER   DEFAULT NULL,
        --   vid_            NUMBER   DEFAULT NULL,
        --   pos_            NUMBER   DEFAULT NULL,
        --   sec_            NUMBER   DEFAULT NULL,
        --   seci_           NUMBER   DEFAULT NULL,
        --   seco_           NUMBER   DEFAULT NULL,
        --   blkd_           NUMBER   DEFAULT NULL,
        --   blkk_           NUMBER   DEFAULT NULL,
        --   lim_            NUMBER   DEFAULT NULL,
        --   ostx_           VARCHAR2 DEFAULT NULL,       -- 'NULL' for update
        --   nlsalt_           VARCHAR2 DEFAULT NULL,       -- 'NULL' for update
            tobo_ =>k.Branch  --, VARCHAR2 DEFAULT NULL,
        --  accc_           NUMBER   DEFAULT NULL,
        --  fl_             number   default null
             ) ;
    End;

    BEGIN INSERT INTO Specparam_INT (ACC,OB22)  VALUES (acc_2608, ob22_);
    EXCEPTION WHEN OTHERS THEN  UPDATE Specparam_INT SET OB22=ob22_  WHERE  ACC=acc_2608;
    END;

    BEGIN  INSERT INTO Specparam (ACC,   R011, S180, S240) VALUES   (acc_2608, '1',  '1', '1' );
    EXCEPTION WHEN OTHERS THEN   UPDATE Specparam SET  R011='1',S180='1',S240='1' WHERE  ACC=acc_2608;
    END;

    Update INT_ACCN set   ACRA=acc_2608   where ACC=k.ACC and ID=1;

  END LOOP ;  -- k

end;    --- end 1)

------------------------------------------------------------------------

begin   ---  2).  ������������ ACRB

  FOR k IN  ( Select a.ACC, a.NLS, a.NBS, a.KV, a.RNK, a.NMS,
                     a.ISP, a.BRANCH, a.TOBO, a.OB22,
                     i.ACRA, i.ACRB, r.IR, r.BR
              FROM   Accounts a, INT_ACCN i, INT_RATN r
              WHERE  length(a.BRANCH) > 8
                 and a.ACC=i.ACC  and  i.ID=1
                 and a.ACC=r.ACC  and  r.ID=1
                 and ACRN.FPROCN(a.ACC,1,gl.BDATE)>0
                 and a.DAZS is NULL
                 and ( a.NBS in ('2560','2600','2603','2604','2650')
                          or
                       a.NBS='2620' and a.OB22 in ('07','32')
                     )
                 and a.ACC not in (Select ACC from DPU_DEAL)
                 and ( i.ACRB is NULL
                          or
                       i.ACRB not in (Select ACC
                                      from   Accounts
                                      where  substr(NLS,1,1)='7' and DAZS is NULL
                                     )
                     )
                 and a.RNK in (Select RNK from Customer where DATE_OFF is NULL)
            )

  LOOP

  kkk_:=0;       ----  ���������� kkk_  -  K�� ����. �������
  BEGIN
    Select KODK  Into  kkk_
    From   RNKP_KOD
    Where  RNK=k.RNK and RNK is not NULL and KODK is not NULL and rownum=1;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    kkk_:=0;
  END;


---  ���� ���� 7020 �� BRANCH-� ����� �����:

    BEGIN

      nbs_7020:='7020';

      If      k.NBS='2560'                then        ---  ��� 2560:  7030/06
              --------------
              nbs_7020:='7030';
              ob22_:='06';


      Elsif   k.NBS in ('2600','2603') and k.KV=980 then --- 2600/���: 7020/06
              --------------------------------------     --- 2603/���

         if    kkk_=0  then     --  ������� ��
               ob22_:='06';
         elsif kkk_=2  then     --  ��������
               ob22_:='13';
         elsif kkk_=5  then     --  ���������
               ob22_:='17';
         elsif kkk_=6  then     --  ���
               ob22_:='19';
         elsif kkk_=8  then     --  ���
               ob22_:='20';
         elsif kkk_=11 then     --  �����
               ob22_:='21';
         else
               ob22_:='06';
         end if;


      Elsif   k.NBS='2600' and k.KV<>980  then   ---  2600/���:  7020/07
              --------------------------

         if    kkk_=2  then     --  ��������
               ob22_:='18';
         else
               ob22_:='07';
         end if;


      Elsif   k.NBS='2604'                then   ---  2604:  7020/03
             ----------------
         if    kkk_=2  then        --  ��������

               if nvl(k.IR,0)>5.00 or nvl(k.BR,0)=100 then
                  ob22_:='12';         -- ������ ��� 7.5%
               else
                  ob22_:='14';         -- 4%
               end if;

         else
               ob22_:='03';
         end if;


      Elsif   k.NBS='2650'                then   ---  2650:  7070/01
              --------------
              nbs_7020:='7070';
              ob22_:='01';


      Elsif   k.NBS='2620'                then   ---  2620/07
              ---------------
              nbs_7020:='7040';
              ob22_:='08';

      End If;

      Select ACC into acc_7020
      from   Accounts
      where  BRANCH = substr(k.BRANCH,1,15) and
             NBS=nbs_7020  and  OB22=ob22_  and
             DAZS is NULL and rownum=1;

      UPDATE INT_ACCN set  ACRB=acc_7020   where ACC=k.ACC and ID=1;

    EXCEPTION WHEN OTHERS then

       Begin

          Select ACC into acc_7020
          from   Accounts
          where  BRANCH = substr(k.BRANCH,1,15) and
                 NBS='7020' and OB22='06'  and
                 DAZS is NULL and rownum=1;

          UPDATE INT_ACCN set  ACRB=acc_7020   where ACC=k.ACC and ID=1;

       EXCEPTION WHEN OTHERS then
          null;
       END;

    END;

  END LOOP;

end;   --- end 2)

---***END IF;     ---  IF to_char(gl.bdate,'DD')='27','28'

END PK_2600;
/
show err;

PROMPT *** Create  grants  PK_2600 ***
grant EXECUTE                                                                on PK_2600         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on PK_2600         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PK_2600.sql =========*** End *** =
PROMPT ===================================================================================== 
