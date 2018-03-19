CREATE OR REPLACE PACKAGE BARS.ZAY_FXE is
  --
  -- Purpose : ������������� ���������� �������� FXE
  -- 24.11.2017
--���������� ����������
procedure CREATE_FXE (p_dat date default trunc(sysdate));

--������ �������� ��� ���������� FXE
procedure ADD_DOC (p_dat date default trunc(sysdate));

--��������� �������� FXE
procedure PAY_FXE (p_state varchar2, p_pdat date, p_kv char,
                   p_s number, p_kurs_f number, p_kv2 char, p_s2 number);

procedure ZAY_NO_REF (p_pdat date default trunc(sysdate));

end ZAY_FXE;

----------------------------------
/

CREATE OR REPLACE PACKAGE BODY BARS.ZAY_FXE is
/*
����� ��� ������������� ���������� �������� FXE
�� ����� ���������� �� ���� ������� ������
24.11.2017
*/

procedure CREATE_FXE (p_dat date default trunc(sysdate)) is
/*
24.11.2017 ��������� ���������� �������� ��� ���������� FXE

--SELECT DECODE (z.dk, 3, '�������� ������', 4, '�������� ������', NULL) as state, o.fdat AS pdat, o.kv, SUM (o.s), z.kurs_f, z.kv2
*/
sSql varchar2 (32767);
sFdat date;
l_kv_base number;

begin

 IF SYS_CONTEXT ('bars_context', 'user_branch') <>'/300465/'
            THEN RAISE_APPLICATION_ERROR (-20000,'�������� �� ����� /300465/');
 END IF;

execute immediate 'ALTER SESSION SET NLS_DATE_FORMAT=''dd.mm.yyyy''';

sFdat := p_dat;

   -- ��������� ����� � ������� �� USER_ID
BEGIN
   DELETE FROM ZAY_FXE_GROUP
         WHERE USER_ID =
                  (SELECT SYS_CONTEXT ('bars_global', 'user_id') FROM DUAL);
COMMIT;
END;
-----------���������� ������� ������������ ������-------------
insert into ZAY_FXE_GROUP (STATE, PDAT, KV, S, KURS_F, KV2) select state, pdat, KV, sum(s) as s, kurs_f, kv2 from
(select DECODE (z.dk, 2, '������', NULL) as state ,trunc(O.PDAT) as pdat, O.KV2 as KV,sum(o.s) as s,z.kurs_f as kurs_f,cast('980' as number) as kv2
from oper o left join zayavka_ru z on (o.mfoa=Z.MFO and regexp_substr(regexp_substr (o.nazn, '[�][0-9]+'),'[0-9]+') = z.nd and o.s=Z.S2 and o.kv2=z.kv2)
where o.vdat = to_date (sFdat,'dd.mm.yyyy')and z.vdate = to_date (sFdat,'dd.mm.yyyy')
and o.nlsb in (select acc from ZAY_ACC_RU ) and o.kv2 <>980 and o.sos = 5 and o.kf='300465' and z.dk in (2) and z.viza not in (0,-1) and z.sos in (1,2)
group by DECODE (z.dk, 2, '������',NULL),trunc(O.PDAT),O.KV2,z.kurs_f
union all
SELECT DECODE (z.dk, 2, '������', NULL) as state, o.fdat AS pdat, o.kv, SUM(o.s), z.kurs_f, cast('980' as number) as kv2
FROM zayavka z LEFT JOIN opl o ON (z.REF = o.REF)
WHERE z.dk IN (2) AND o.dk = 1 AND z.viza NOT IN (0, -1) AND vdate = TO_DATE ( sFdat, 'dd.mm.yyyy') AND z.sos IN (1, 2)
AND o.sos = 5 AND o.tt = 'GO2'
GROUP BY DECODE (z.dk, 2, '������', NULL), o.fdat, o.kv, z.kurs_f,z.kv2
union all
--select DECODE (z.dk,3, '�������� ������',4, '�������� ������',NULL) as state, o.vdat as pdat, o.kv, sum(o.s)as s, z.kurs_f as kurs_f, z.kv2
--from zayavka_ru z left join oper o on ( o.ref_a = to_char(round(mod(z.ref_sps,1000000000))))
--where vdate = TO_DATE(sFdat, 'dd.mm.yyyy') and z.mfo in (select k.kf from mv_kf k) and z.viza NOT IN (0, -1) AND z.sos IN (1, 2)
--and z.dk in (3,4) and o.sos=5 and o.vdat = z.vdate
--group by DECODE (z.dk,3, '�������� ������',4, '�������� ������',NULL), o.vdat, o.kv, z.kurs_f, z.kv2
select DECODE (z.dk,3, '�������� ������',4, '�������� ������',NULL) as state, o.vdat as pdat, z.kv2 as kv, sum(z.s2) as s, z.kurs_f as kurs_f, z.kv_conv as kv2
from zayavka_ru z left join oper o on ( o.ref_a = to_char(round(mod(z.ref_sps,1000000000))))
where vdate = TO_DATE(sFdat, 'dd.mm.yyyy') and z.mfo in (select k.kf from mv_kf k) and z.viza NOT IN (0, -1) AND z.sos IN (1, 2)
and z.dk in (3,4) and o.sos=5 and o.vdat = z.vdate
group by DECODE (z.dk,3, '�������� ������',4, '�������� ������',NULL), o.vdat, z.kv2, z.kurs_f, z.kv_conv
union all
--select DECODE (z.dk,3, '�������� ������',4, '�������� ������',NULL) as state,o.vdat as pdat, o.kv, sum(o.s) as s, z.kurs_f as kurs_f, z.kv2
--from zayavka_ru z left join oper o on ( o.ref_a = to_char(z.ref_sps))
--where vdate = TO_DATE(sFdat, 'dd.mm.yyyy') and z.mfo not in (select k.kf from mv_kf k) and z.viza NOT IN (0, -1) AND z.sos IN (1, 2) and z.dk in (3,4)
--and o.sos=5 and o.vdat = z.vdate
--group by DECODE (z.dk,3, '�������� ������',4, '�������� ������',NULL), o.vdat, o.kv, z.kurs_f, z.kv2
select DECODE (z.dk,3, '�������� ������',4, '�������� ������',NULL) as state,o.vdat as pdat, z.kv2 as KV, sum(z.s2) as s, z.kurs_f as kurs_f, z.kv_conv as kv2
from zayavka_ru z left join oper o on ( o.ref_a = to_char(z.ref_sps))
where vdate = TO_DATE(sFdat, 'dd.mm.yyyy') and z.mfo not in (select k.kf from mv_kf k) and z.viza NOT IN (0, -1) AND z.sos IN (1, 2) and z.dk in (3,4)
and o.sos=5 and o.vdat = z.vdate
group by DECODE (z.dk,3, '�������� ������',4, '�������� ������',NULL), o.vdat, z.kv2, z.kurs_f, z.kv_conv
union all
SELECT DECODE (z.dk, 3, '�������� ������', 4, '�������� ������', NULL) as state, o.fdat AS pdat, z.kv2 as KV, SUM(z.s2) as S, z.kurs_f, z.kv_conv as kv2
FROM zayavka z LEFT JOIN opl o ON (z.REF = o.REF)
WHERE z.dk IN (3, 4) AND o.dk = 1 AND z.viza NOT IN (0, -1) AND vdate = TO_DATE ( sFdat, 'dd.mm.yyyy') AND z.sos IN (1, 2) AND o.sos = 5 AND o.tt = 'GO2' and o.fdat = z.vdate
GROUP BY DECODE (z.dk,3, '�������� ������', 4, '�������� ������', NULL), o.fdat, z.kv2, z.kurs_f, z.kv_conv 
union all
select state, pdat, kv, sum(s) as s , kurs_f, kv2
from (select DECODE (z.dk, 1, '������', NULL) as state, o.vdat as pdat, o.kv, sum(o.s) as s , z.kurs_f, z.kv2 from zayavka_ru z
left join oper o on ( o.ref_a = to_char(round(mod(z.ref_sps,1000000000))))
where vdate = TO_DATE(sFdat, 'dd.mm.yyyy') and z.mfo in (select k.kf from mv_kf k ) and o.mfoa = z.mfo and z.viza NOT IN (0, -1)
AND z.sos IN (1, 2) and z.dk in (1) and o.sos=5 and o.vdat = z.vdate
group by DECODE (z.dk, 1, '������', NULL), o.vdat, o.kv, z.kurs_f,z.kv2
union all
select DECODE (z.dk, 1, '������', NULL) as state, o.vdat as pdat, o.kv, sum(o.s) as s , z.kurs_f, z.kv2
from zayavka_ru z left join oper o on ( o.ref_a = to_char(z.ref_sps))
where vdate = TO_DATE(sFdat, 'dd.mm.yyyy') and z.mfo not in (select k.kf from mv_kf k) and o.mfoa = z.mfo
and z.viza NOT IN (0, -1) AND z.sos IN (1, 2) and z.dk in (1) and o.sos=5 and o.vdat = z.vdate
group by DECODE (z.dk, 1, '������', NULL), o.vdat, o.kv, z.kurs_f, z.kv2)
group by state, pdat, kv, kurs_f, kv2
union all
SELECT DECODE (z.dk,1, '������',NULL) as state, o.fdat AS pdat, o.kv, SUM (o.s), z.kurs_f, z.kv2
FROM zayavka z LEFT JOIN opl o ON (z.REF = o.REF)
WHERE z.dk IN (1) AND o.dk = 1 AND z.viza NOT IN (0, -1) AND vdate = TO_DATE ( sFdat, 'dd.mm.yyyy')
AND z.sos IN (1, 2) AND o.sos = 5 AND o.tt = 'GO2'
GROUP BY DECODE (z.dk,1, '������',NULL), o.fdat, o.kv, z.kurs_f,z.kv2
)z group by state, PDAT, KV, kurs_f, kv2;
commit;
-----------------------------------------------

---------------��������� � ������� �������� ������� �� �������� 29003 ��� �������� ��������----
   for k in (select kv, ostc from accounts where nls='29003' and dazs is null)
    loop
          for c in (select kv2 from ZAY_FXE_GROUP)
           loop

              if c.kv2 = k.kv then
                                    begin
                                    update ZAY_FXE_GROUP  z
                                    set z.OSTC_29003 = k.ostc
                                    where z.kv2 = k.kv and user_id = SYS_CONTEXT('bars_global','user_id');

                                    end;
              end if;

           end loop;

    end loop;

     
    for k in (select * from ZAY_FXE_GROUP where user_id = SYS_CONTEXT('bars_global','user_id')) 
    loop
         if (k.state like '�������� ������') or (k.state like '�������� ������') 
                            then 
                               begin
                                select kv_base into l_kv_base from zay_conv_kv where (kv1 = k.KV and kv2 = k.KV2) or (kv2 = k.KV and kv1 = k.KV2);
                                  exception when no_data_found then
                                   raise_application_error(-22222, '�� ������� ������� ������ ��� ������ ���� ����� � ���������!');
                               end;
                             -- c���� ���������� ������ � ��������
                              --k.s ���� ��� ��������� � ��� S2 � �������
                              if k.kv2 = l_kv_base 
                                                  then
                                                        begin
                                                        update ZAY_FXE_GROUP zfg set zfg.s2= round(k.s / k.kurs_f / power(10, 2) * 100) 
                                                        where user_id = SYS_CONTEXT('bars_global','user_id')
                                                              and ZFG.KV = k.kv
                                                              and ZFG.KV2 = k.kv2
                                                              and ZFG.KURS_F =k.kurs_f;
                                                        end; 
                                                  else
                                                        begin
                                                        update ZAY_FXE_GROUP zfg set zfg.s2=round(k.s * k.kurs_f / power(10, 2) * 100)  
                                                        where user_id = SYS_CONTEXT('bars_global','user_id')
                                                              and ZFG.KV = k.kv
                                                              and ZFG.KV2 = k.kv2
                                                              and ZFG.KURS_F =k.kurs_f;
                                                        end;
                              end if;
        end if;                                                                    
    end loop;
    
    commit;
   
    --����������� ���� �� ���� ��� �����������
    --select * from ZAY_FXE_GROUP where user_id=2009401
    update ZAY_FXE_GROUP
    set s2 = case when  kv =  980                  then (s/kurs_f)
                  when (kv <> 980 and kv2 =  980)  then (s*kurs_f)
             end
                  
    where user_id = SYS_CONTEXT('bars_global','user_id')
          and state in ('������','������');

   commit;

end;

procedure ADD_DOC (p_dat date default trunc(sysdate)) is
/*
 - 24.11.2017 - ��������� ���������� ������� ������ �� ����� ���� ���������� ��� ��� ��������� �������� FXE
*/
l_dat       date;
 begin

     IF SYS_CONTEXT ('bars_context', 'user_branch') <>'/300465/'
                THEN RAISE_APPLICATION_ERROR (-20000,'�������� �� ����� /300465/');
     END IF;

  execute immediate 'ALTER SESSION SET NLS_DATE_FORMAT=''dd.mm.yyyy''';

  l_dat := p_dat;

   -- ��������� ����� � ������� �� USER_ID
    BEGIN
       DELETE FROM ZAY_DOCFXE
             WHERE USER_ID =
                      (SELECT SYS_CONTEXT ('bars_global', 'user_id') FROM DUAL);
    COMMIT;
    END;

 --������� �� �������� �� ����� ���� ������ ��������� �������� FXE---------------
   for k in (SELECT DECODE (z.dk, 2, '������', NULL) AS state,
       TRUNC (O.PDAT) AS pdat,
       O.REF,
       o.tt,
       O.MFOA,
       O.NLSA,
       o.s AS s,
       O.KV2 AS KV,
       z.kurs_f AS kurs_f,
       O.MFOB,
       O.NLSB
  FROM oper o
       LEFT JOIN zayavka_ru z
          ON (    o.mfoa = Z.MFO
              AND REGEXP_SUBSTR (REGEXP_SUBSTR (o.nazn, '[�][0-9]+'),
                                 '[0-9]+') = z.nd
              AND o.s = Z.S2
              AND o.kv2 = z.kv2)
 WHERE     o.vdat = TO_DATE ( l_dat, 'dd.mm.yyyy')
       AND z.vdate = TO_DATE ( l_dat, 'dd.mm.yyyy')
       AND o.nlsb IN (select acc from ZAY_ACC_RU)
       AND o.kv2 <> 980
       AND o.sos = 5
       AND o.kf = '300465'
       AND z.dk IN (2)
       AND z.viza NOT IN (0, -1)
       AND z.sos IN (1, 2)
UNION ALL
SELECT DECODE (z.dk, 2, '������', NULL) AS state,
       o.fdat AS pdat,
       O.REF,
       o.tt,
       (SELECT mfoa
          FROM oper
         WHERE REF = z.REF)
          AS MFOA,
       (SELECT nls
          FROM opl
         WHERE REF = z.REF AND dk = 0 AND tt = 'GO2')
          AS NLSA,
       o.s,
       o.kv,
       z.kurs_f,
       (SELECT mfob
          FROM oper
         WHERE REF = z.REF)
          AS MFOB,
        (SELECT nls
          FROM opl
         WHERE REF = z.REF AND dk = 1 AND tt = 'GO2')
          AS NLSB  
  FROM zayavka z LEFT JOIN opl o ON (z.REF = o.REF)
 WHERE     z.dk IN (2)
       AND o.dk = 1
       AND z.viza NOT IN (0, -1)
       AND vdate = TO_DATE ( l_dat, 'dd.mm.yyyy')
       AND z.sos IN (1, 2)
       AND o.sos = 5
       AND o.tt = 'GO2'
UNION ALL
SELECT DECODE (z.dk,
               3, '�������� ������',
               4, '�������� ������',
               NULL)
          AS state,
       o.vdat AS pdat,
       O.REF,
       o.tt,
       O.MFOA,
       O.NLSA,
       o.s AS s,
       o.kv,
       z.kurs_f AS kurs_f,
       O.MFOB,
       O.NLSB
  FROM zayavka_ru z
       LEFT JOIN oper o
          ON (o.ref_a = TO_CHAR (ROUND (MOD (z.ref_sps, 1000000000))))
 WHERE     vdate = TO_DATE ( l_dat, 'dd.mm.yyyy')
       AND z.mfo IN (SELECT k.kf
                       FROM mv_kf k)
       AND z.viza NOT IN (0, -1)
       AND z.sos IN (1, 2)
       AND z.dk IN (3, 4)
       AND o.sos = 5
       AND o.vdat = z.vdate
UNION ALL
SELECT DECODE (z.dk,
               3, '�������� ������',
               4, '�������� ������',
               NULL)
          AS state,
       o.vdat AS pdat,
       O.REF,
       o.tt,
       O.MFOA,
       O.NLSA,
       o.s AS s,
       o.kv,
       z.kurs_f AS kurs_f,
       O.MFOB,
       O.NLSB
  FROM zayavka_ru z LEFT JOIN oper o ON (o.ref_a = TO_CHAR (z.ref_sps))
 WHERE     vdate = TO_DATE ( l_dat, 'dd.mm.yyyy')
       AND z.mfo NOT IN (SELECT k.kf
                           FROM mv_kf k)
       AND z.viza NOT IN (0, -1)
       AND z.sos IN (1, 2)
       AND z.dk IN (3, 4)
       AND o.sos = 5
       AND o.vdat = z.vdate
UNION ALL
SELECT DECODE (z.dk,
               3, '�������� ������',
               4, '�������� ������',
               NULL)
          AS state,
       o.fdat AS pdat,
       O.REF,
       o.tt,
       (SELECT mfoa
          FROM oper
         WHERE REF = z.REF)
          AS MFOA,
       (SELECT nls
          FROM opl
         WHERE REF = z.REF AND dk = 0 AND tt = 'GO2')
          AS NLSA,
       o.s,
       o.kv,
       z.kurs_f,
             (SELECT mfob
          FROM oper
         WHERE REF = z.REF)
          AS MFOB,
       (SELECT nls
          FROM opl
         WHERE REF = z.REF AND dk = 1 AND tt = 'GO2')
          AS NLSB
  FROM zayavka z LEFT JOIN opl o ON (z.REF = o.REF)
 WHERE     z.dk IN (3, 4)
       AND o.dk = 1
       AND z.viza NOT IN (0, -1)
       AND vdate = TO_DATE ( l_dat, 'dd.mm.yyyy')
       AND z.sos IN (1, 2)
       AND o.sos = 5
       AND o.tt = 'GO2'
       AND o.fdat = z.vdate
UNION ALL
SELECT DECODE (z.dk, 1, '������', NULL) AS state,
       o.vdat AS pdat,
       O.REF,
       o.tt,
       O.MFOA,
       O.NLSA,
       o.s AS s,
       o.kv,
       z.kurs_f AS kurs_f,
       O.MFOB,
       O.NLSB
  FROM zayavka_ru z
       LEFT JOIN oper o
          ON (o.ref_a = TO_CHAR (ROUND (MOD (z.ref_sps, 1000000000))))
 WHERE     vdate = TO_DATE ( l_dat, 'dd.mm.yyyy')
       AND z.mfo IN (SELECT k.kf
                       FROM mv_kf k)
       AND o.mfoa = z.mfo
       AND z.viza NOT IN (0, -1)
       AND z.sos IN (1, 2)
       AND z.dk IN (1)
       AND o.sos = 5
       AND o.vdat = z.vdate
UNION ALL
SELECT DECODE (z.dk, 1, '������', NULL) AS state,
       o.vdat AS pdat,
       O.REF,
       o.tt,
       O.MFOA,
       O.NLSA,
       o.s AS s,
       o.kv,
       z.kurs_f AS kurs_f,
       O.MFOB,
       O.NLSB
  FROM zayavka_ru z LEFT JOIN oper o ON (o.ref_a = TO_CHAR (z.ref_sps))
 WHERE     vdate = TO_DATE ( l_dat, 'dd.mm.yyyy')
       AND z.mfo NOT IN (SELECT k.kf
                           FROM mv_kf k)
       AND o.mfoa = z.mfo
       AND z.viza NOT IN (0, -1)
       AND z.sos IN (1, 2)
       AND z.dk IN (1)
       AND o.sos = 5
       AND o.vdat = z.vdate
UNION ALL
SELECT DECODE (z.dk, 1, '������', NULL) AS state,
       o.fdat AS pdat,
       O.REF,
       o.tt,
       (SELECT mfoa
          FROM oper
         WHERE REF = z.REF)
          AS MFOA,
       (SELECT nls
          FROM opl
         WHERE REF = z.REF AND dk = 0 AND tt = 'GO2')
          AS NLSA,
       o.s,
       o.kv,
       z.kurs_f,
     (SELECT mfob
          FROM oper
         WHERE REF = z.REF)
          AS MFOB,
       (SELECT nls
          FROM opl
         WHERE REF = z.REF AND dk = 1 AND tt = 'GO2')
          AS NLSB
  FROM zayavka z LEFT JOIN opl o ON (z.REF = o.REF)
 WHERE     z.dk IN (1)
       AND o.dk = 1
       AND z.viza NOT IN (0, -1)
       AND vdate = TO_DATE ( l_dat, 'dd.mm.yyyy')
       AND z.sos IN (1, 2)
       AND o.sos = 5
       AND o.tt = 'GO2' )

       loop

       INSERT INTO ZAY_DOCFXE (STATE, PDAT, REF, TT, MFOA, NLSA, S,KV, KURS_F, MFOB, NLSB)
        values (k.STATE, k.PDAT, k.REF, k.TT, k.MFOA, k.NLSA, k.S, k.KV, k.KURS_F, k.MFOB, k.NLSB);

       end loop;

   COMMIT;

 end;


procedure PAY_FXE (p_state varchar2, p_pdat date, p_kv char,
                   p_s number, p_kurs_f number, p_kv2 char, p_s2 number ) is
/*
16.12.2017 �������� ������ ��� ��������� ����� ��� �������
ZAY_FXE_GROUP. � ��� ��� ��������� ���� ��������, ����������� 
�������� �������. 
06.12.2017 p_state ��� �������� (������, ������....), 
           p_pdat ���� ��������� , 
           p_kv ������ ������ ,
           p_s ���� ���������� � �������, 
           p_kurs_f ���� , 
           p_kv2 ������� ������
29.11.2017 ��� �������� �������� ������ ������� �� ����� '/300465/000010/' (bc.subst_branch('/300465/000010/'))
��� ���� ���������� ���������� 3800 ��(25), �����  (nbs_ob22('3800','25')), ���� ������� � �������� FXE
24.11.2017 ��������� �������� �� ����� ������������ �����
*/
l_flag       number;
l_ref        number;
l_row_a      bars.accounts%rowtype; --������ ������� � ����� �������
l_row_b      bars.accounts%rowtype; --������ ������� ���� ����������
l_tt         varchar2(3);
l_vob        number;
l_bankdate   date;
l_dk         number;
l_err        varchar2(4000);
l_s2         number;
 -- �������� �������� �� ������ ���� ���������, ����������� ������ �������
 -- ���������� ��������� �� ������� ����.
 begin

  bc.subst_branch('/300465/000010/'); --������������� ��������� /300465/000010/

  /* ��������� �������� FXE*/
  --  select * from accounts where nls='29003'
  l_tt := 'FXE';
  l_vob:= 13;
  l_bankdate := gl.bd;
  l_dk :=1;
  select * into l_row_a from accounts where nls = '29003' and kv=p_kv  and dazs is null;
  select * into l_row_b from accounts where nls = '29003' and kv=p_kv2 and dazs is null;

      BEGIN
         SELECT SUBSTR (flags, 38, 1)
           INTO l_flag
           FROM tts
         WHERE tt = l_tt;
       EXCEPTION
          WHEN NO_DATA_FOUND
          THEN
             l_flag := 0;
       END;

  /************************/
   begin
   savepoint sp_before;

    if p_s>0 then --������ ���� ��������
             begin
               if p_kv <> 980 and p_kv2 = 980
               --�������� �������� state
                    then
                      begin
                       --������ ������ ������� ������
                       gl.ref(l_ref);

                       gl.in_doc3(l_ref,
                             l_tt,
                             l_vob,
                             l_ref,
                             sysdate,
                             l_bankdate,
                             l_dk,
                             p_kv, --������ ������ � ������� KV
                             p_s, -- ������ ������ � ������� S
                             p_kv2, --������� ������ � ������� KV2
                             (p_s * p_kurs_f), --����������� ���� �� ����
                             null,
                             l_bankdate,
                             l_bankdate,
                             l_row_a.nms, --����� ������� �
                             l_row_a.nls,
                             l_row_a.kf,
                             l_row_b.nms,
                             l_row_b.nls,
                             l_row_b.kf,
                             '������ ������ �� ����� '||p_kurs_f, --l_nazn ����������� ����� ��������� ����� case
                             null,
                             '00032129',
                             '00032129',
                             null,
                             null,
                             0,
                             0,
                             null);

                        paytt (l_flag, l_ref,  gl.bDATE, l_tt, l_dk, p_kv, l_row_a.nls, p_s, p_kv2, l_row_b.nls, (p_s * p_kurs_f)  );
                       end;
                 end if;

               --�� ���� ��������  ������ ������� - ������
                   if p_kv = 980 and p_kv2 <> 980
                     --�������� �������� state
                    then
                      begin
                       --������ ������ ������� ������  
                       gl.ref(l_ref);

                       gl.in_doc3(l_ref,
                             l_tt,
                             l_vob,
                             l_ref,
                             sysdate,
                             l_bankdate,
                             l_dk,
                             p_kv, --������ ������ � ������� KV
                             p_s, -- ������ ������ � ������� S
                             p_kv2, --������� ������ � ������� KV2
                             (p_s / p_kurs_f), --������� ���� �� ���� (������ ������ ������� ������)
                             null,
                             l_bankdate,
                             l_bankdate,
                             l_row_a.nms, --����� ������� �
                             l_row_a.nls,
                             l_row_a.kf,
                             l_row_b.nms,
                             l_row_b.nls,
                             l_row_b.kf,
                             '������ ������ �� ����� '||p_kurs_f, --l_nazn ����������� ����� ��������� ����� case
                             null,
                             '00032129',
                             '00032129',
                             null,
                             null,
                             0,
                             0,
                             null);

                        paytt (l_flag, l_ref,  gl.bDATE, l_tt, l_dk, p_kv, l_row_a.nls, p_s, p_kv2, l_row_b.nls, (p_s / p_kurs_f)  );
                       end;
               end if;

              if p_kv <> 980 and p_kv2 <> 980
                       --�������� �������� state
                    then
                      begin
                       --������ ������ ������� ������ (�������� �����)
                       gl.ref(l_ref);
                        /*
                         p_kv char, - ������ �
                         p_s number, - ���� �   
                         p_kv2 char - ������ �, 
                         p_s2 number - ���� �)
                         select * from zay_fxe_group where state = '�������� ������'
                        */
                        gl.in_doc3(l_ref,
                             l_tt,
                             l_vob,
                             l_ref,
                             sysdate,
                             l_bankdate,
                             l_dk,
                             p_kv2, --������ ������ � ������� KV
                             p_s2, -- ������ ������ � ������� S2
                             p_kv, --������� ������ � ������� KV2
                             p_s, --������ ��������� �� �� 
                             null,
                             l_bankdate,
                             l_bankdate,
                             l_row_b.nms, --����� ������� �
                             l_row_b.nls,
                             l_row_b.kf,
                             l_row_a.nms,
                             l_row_a.nls,
                             l_row_a.kf,
                             '�������� ������ �� ����� '|| to_char(to_number(p_kurs_f),'9990D999999'), --l_nazn ����������� ����� ��������� ����� case
                             null,
                             '00032129',
                             '00032129',
                             null,
                             null,
                             0,
                             0,
                             null);
                                    
                        paytt (l_flag, l_ref,  gl.bDATE, l_tt, l_dk, p_kv2, l_row_b.nls, p_s2, p_kv, l_row_a.nls, p_s  );
                        
                     end;  
                 end if;
       end;
    end if;

    --��������� ������� � ������� ���� ��� ����������
       if  l_ref is not null
                then
                    begin
                    logger.info ('FXE DOC: ' || l_ref);
                       delete from zay_fxe_group
                        where     state   = p_state
                              and pdat    = p_pdat
                              and kv      = p_kv
                              and s       = p_s
                              and kurs_f  = p_kurs_f
                              and kv2     = p_kv2
                              and s2      = p_s2
                              and user_id =  SYS_CONTEXT ('bars_global', 'user_id');
                       commit;
                    end;
        end if;
  end;
 end;

procedure ZAY_NO_REF (p_pdat date default trunc(sysdate))

is 
/*
10.12.2017 - �������� ��� ����������� �� ����� ������, �� �� ����� 
��������� (��� ���� ���� ������). 
*/
l_dat date;
begin
 execute immediate 'ALTER SESSION SET NLS_DATE_FORMAT=''dd.mm.yyyy''';

 l_dat := p_pdat;
 
-- logger.info('p_pdat: '||p_pdat);
-- logger.info('l_dat: '||l_dat);
 

 -- ��������� ����� � ������� �� USER_ID
    BEGIN
       DELETE FROM ZAY_REF_NULL
             WHERE USER_ID =
                      (SELECT SYS_CONTEXT ('bars_global', 'user_id') FROM DUAL);
    COMMIT;
    END;

insert into ZAY_REF_NULL (STATE, MFO, ND, KV2, S, KURS_F, PDAT)
                   select STATE, MFO, ND, KV2, S, KURS_F, PDAT from 
                                ( select DECODE (z.dk,
                                          1, '������',
                                          2, '������',
                                          3, '�������� ������',
                                          4, '�������� ������',
                                          NULL) as state , to_char(Z.MFO) as MFO ,Z.ND, z.kv2, Z.S2 as S, Z.KURS_F, z.vdate as PDAT  from zayavka_ru z 
                            where  z.vdate = TO_DATE ( l_dat, 'dd.mm.yyyy') and
                                z.ref_sps is null and  
                                z.viza NOT IN (0, -1)
                               AND z.sos IN (1, 2)
                          union all
                        select DECODE (z.dk,
                                          1, '������',
                                          2, '������',
                                          3, '�������� ������',
                                          4, '�������� ������',
                                          NULL) as state, '300465' as MFO, z.nd, Z.KV2, Z.S2 as S , Z.KURS_F, Z.VDATE as PDAT from zayavka z 
                            where  z.vdate = TO_DATE ( l_dat, 'dd.mm.yyyy') and
                             z.viza NOT IN (0, -1)  
                               AND z.sos IN (1, 2)
                               and z.ref is null);
   commit;                           
       
       
end;
       
end ZAY_FXE;
/