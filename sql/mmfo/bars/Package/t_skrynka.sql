
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/t_skrynka.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.T_SKRYNKA AS
  type t_col_SKRYNKA_TARIFF2
       is record(             TARIFF       NUMBER,
                              TARIFF_DATE  DATE,
                              DAYSFROM     NUMBER,
                              DAYSTO       NUMBER,
                              S            NUMBER,
                              FLAG1        NUMBER,
                              PROC         NUMBER,
                              PENY         NUMBER,
                              BRANCH       VARCHAR2(30),
                              KF           VARCHAR2(6)
                );

  TYPE t_SKRYNKA_TARIFF2 iS TABLE OF t_col_SKRYNKA_TARIFF2;

  type t_col_SKRYNKA_TIP
       is record(          O_SK        NUMBER,
                           NAME        VARCHAR2(25),
                           S           NUMBER(15,2),
                           BRANCH      VARCHAR2(30),
                           KF          VARCHAR2(6),
                           ETALON_ID   NUMBER(5),
                           CELL_COUNT  number(5)
                );

  TYPE t_SKRYNKA_TIP    iS TABLE OF t_col_SKRYNKA_TIP;


    type t_col_SKRYNKA_TARIFF
       is record( TARIFF  NUMBER,
				  NAME    VARCHAR2(100),
				  TIP     NUMBER,
				  O_SK    NUMBER,
				  BRANCH  VARCHAR2(30),
				  BASEY   INTEGER,
				  BASEM   INTEGER,
				  KF      VARCHAR2(6)
                );

  TYPE t_SKRYNKA_TARIFF iS TABLE OF t_col_SKRYNKA_TARIFF;


    type t_col_SKRYNKA_PORT
       is record( N_SK         NUMBER,
                  SNUM         VARCHAR2 (64 Char),
                  O_SK         NUMBER,
                  NAME         VARCHAR2 (25 Byte),
                  KEYUSED      NUMBER,
                  KEYNUMBER    VARCHAR2 (30 Byte),
                  KEYCOUNT     NUMBER,
                  S            NUMBER (15,2),
                  KV           NUMBER (3),
                  ACC          NUMBER (38),
                  NLS_2909     VARCHAR2 (15 Byte),
                  OSTC         NUMBER (24),
                  OSTB         NUMBER (24),
                  MDATE        DATE,
                  ND           NUMBER,
                  NDOC         VARCHAR2 (30 Byte),
                  SOS          VARCHAR2 (11 Byte),
                  TARIFF       NUMBER,
                  NLS_3600     VARCHAR2 (15 Byte),
                  FIO          VARCHAR2 (70 Byte),
                  CUSTTYPE     NUMBER,
                  OKPO1        VARCHAR2 (10 Byte),
                  DOKUM        VARCHAR2 (100 Byte),
                  ISSUED       VARCHAR2 (100 Byte),
                  ADRES        VARCHAR2 (100 Byte),
                  DATR         DATE,
                  MR           VARCHAR2 (100 Byte),
                  TEL          VARCHAR2 (30 Byte),
                  DOCDATE      DATE,
                  DAT_BEGIN    DATE,
                  DAT_END      DATE,
                  DAT_CLOSE    DATE,
                  S_ARENDA     NUMBER,
                  S_NDS        NUMBER,
                  SD           NUMBER,
                  PRSKIDKA     NUMBER,
                  PENY         NUMBER,
                  BRANCH       VARCHAR2 (30 Byte)
                );

  TYPE t_SKRYNKA_PORT iS TABLE OF t_col_SKRYNKA_PORT;


FUNCTION f_skrynka_TARIFF2  RETURN t_SKRYNKA_TARIFF2 PIPELINED PARALLEL_ENABLE;
function f_skrynka_tip     return t_SKRYNKA_TIP PIPELINED    PARALLEL_ENABLE;
FUNCTION f_skrynka_TARIFF  RETURN t_SKRYNKA_TARIFF PIPELINED PARALLEL_ENABLE;
FUNCTION f_SKRYNKA_PORT  RETURN t_SKRYNKA_PORT PIPELINED  PARALLEL_ENABLE;
END;
/
CREATE OR REPLACE PACKAGE BODY BARS.T_SKRYNKA AS

FUNCTION f_skrynka_TARIFF2  RETURN t_SKRYNKA_TARIFF2 PIPELINED  PARALLEL_ENABLE iS
  l_bra_u branch.branch%type;
  l_skrynka_TARIFF t_col_SKRYNKA_TARIFF2;
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

   l_bra_u := sys_context('bars_context','user_branch');
     for x in ( select * from branch where branch like l_bra_u||'%' )
     loop
        bc.subst_branch(x.branch);
          for k in ( select * from skrynka_tariff2 where branch = x.branch)
         loop


           l_skrynka_TARIFF.tariff      := k.TARIFF;
           l_skrynka_TARIFF.TARIFF_DATE := k.TARIFF_DATE;
           l_skrynka_TARIFF.daysfrom    := k.DAYSFROM;
           l_skrynka_TARIFF.daysto      := k.DAYSTO;
           l_skrynka_TARIFF.s           := k.S;
           l_skrynka_TARIFF.flag1       := k.FLAG1;
           l_skrynka_TARIFF.proc        := k.PROC;
           l_skrynka_TARIFF.peny        := k.PENY;
           l_skrynka_TARIFF.branch      := k.BRANCH;
           l_skrynka_TARIFF.kf          := k.KF;

            PIPE ROW(l_skrynka_TARIFF);
        END LOOP;
   end loop;

       bc.subst_branch(l_bra_u);

  RETURN;
EXCEPTION   WHEN OTHERS THEN
    bc.subst_branch(l_bra_u);
    RAISE;

END;


function f_skrynka_tip  return   t_SKRYNKA_TIP PIPELINED  PARALLEL_ENABLE iS
  l_skrynka_tip t_col_SKRYNKA_TIP;
  l_bra_u branch.branch%type;
   PRAGMA AUTONOMOUS_TRANSACTION;
  begin
   l_bra_u := sys_context('bars_context','user_branch');

     for x in ( select * from branch where branch like l_bra_u||'%' )
     loop
        bc.subst_branch(x.branch);
          for k in ( select * from skrynka_tip where branch = x.branch)
          loop

           l_skrynka_tip.O_SK       :=  k.O_SK;
           l_skrynka_tip.NAME       :=  k.NAME;
           l_skrynka_tip.S          :=  k.S;
           l_skrynka_tip.BRANCH     :=  k.BRANCH;
           l_skrynka_tip.KF         :=  k.KF;
           l_skrynka_tip.ETALON_ID  :=  k.ETALON_ID;
           l_skrynka_tip.CELL_COUNT :=  k.CELL_COUNT;


           PIPE ROW(l_skrynka_tip);
          END LOOP;
   end loop;

       bc.subst_branch(l_bra_u);

    return;

EXCEPTION   WHEN OTHERS THEN
    bc.subst_branch(l_bra_u);
    RAISE;

end;


  FUNCTION f_skrynka_TARIFF  RETURN t_SKRYNKA_TARIFF PIPELINED  PARALLEL_ENABLE iS
  l_bra_u branch.branch%type;
  l_skrynka_TARIFF t_col_SKRYNKA_TARIFF;
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

   l_bra_u := sys_context('bars_context','user_branch');
     for x in ( select * from branch where branch like l_bra_u||'%' )
     loop
        bc.subst_branch(x.branch);
          for k in ( select * from skrynka_tariff where branch = x.branch)
         loop


           l_skrynka_TARIFF.tariff    := k.TARIFF;
           l_skrynka_TARIFF.NAME      := k.NAME;
           l_skrynka_TARIFF.TIP       := k.TIP;
           l_skrynka_TARIFF.O_SK      := k.O_SK;
           l_skrynka_TARIFF.BRANCH    := k.BRANCH;
           l_skrynka_TARIFF.BASEY     := k.BASEY;
           l_skrynka_TARIFF.BASEM     := k.BASEM;
           l_skrynka_TARIFF.kf        := k.KF;

            PIPE ROW(l_skrynka_TARIFF);
        END LOOP;
   end loop;

       bc.subst_branch(l_bra_u);

  RETURN;
EXCEPTION   WHEN OTHERS THEN
    bc.subst_branch(l_bra_u);
    RAISE;

END;

  FUNCTION f_SKRYNKA_PORT  RETURN t_SKRYNKA_PORT PIPELINED  PARALLEL_ENABLE iS
  l_bra_u branch.branch%type;
  l_skrynka_PORT t_col_SKRYNKA_PORT;

  l_sql varchar2(4000);
  c0    SYS_REFCURSOR;

   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

   l_bra_u := sys_context('bars_context','user_branch');
     for x in ( select b.* from branch b , branch_parameters p where b.branch = p.branch and p.tag  like 'DEP%SKRN' and b.branch like l_bra_u||'%' )
     loop
        bc.subst_branch(x.branch);
        l_sql := 'SELECT    s.n_sk,
          s.snum,
          s.o_sk,
          d.NAME,
          s.keyused,
          s.keynumber,
          n.KEYCOUNT,
          d.s,
          a.kv,
          a.acc,
          a.nls  nls_2909,
          a.ostc,
          a.ostb,
          a.MDATE,
          n.nd,
          n.NDOC,
          case n.sos when 0 then ''Діюча'' when 1 then ''Пролонгація'' when 15 then ''Закрита'' else ''Вільна'' end sos,
          n.TARIFF,
          sa.nls nls_3600,
          DECODE (n.custtype, 2, n.nmk, n.fio) fio,
          n.custtype,
          n.okpo1,
          n.DOKUM,
          n.ISSUED,
          n.ADRES,
          n.datr,
          n.mr,
          n.tel,
          n.docdate,
          n.dat_begin,
          n.dat_end,
          N.DAT_CLOSE dat_close,
          n.s_arenda,
          n.s_nds,
          n.sd,
          n.prskidka,
          n.peny,
          s.branch
     FROM skrynka s,
          skrynka_nd n,
          skrynka_nd_acc na,
          saldo sa,
          skrynka_tip d,
          skrynka_acc g,
          saldo a
    WHERE     s.n_sk = n.n_sk(+)
          AND s.o_sk = d.o_sk
          AND s.n_sk = g.n_sk
          AND a.acc = g.acc
          AND g.tip = ''M''
          --and n.n_sk is not null
          AND n.nd = na.nd(+)
          AND na.tip(+) = ''D''
          AND sa.acc(+) = na.acc';


           OPEN c0 FOR l_sql ;
		   LOOP
			 FETCH c0 INTO l_skrynka_PORT ;
			 EXIT WHEN c0%NOTFOUND;


			PIPE ROW(l_skrynka_PORT);
		   END loop;

   end loop;

       bc.subst_branch(l_bra_u);

  RETURN;
EXCEPTION   WHEN OTHERS THEN
    bc.subst_branch(l_bra_u);
    RAISE;

END;
END;
/
 show err;
 
PROMPT *** Create  grants  T_SKRYNKA ***
grant EXECUTE                                                                on T_SKRYNKA       to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/t_skrynka.sql =========*** End *** =
 PROMPT ===================================================================================== 
 