
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_codobl_branch.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CODOBL_BRANCH (branch_ IN varchar2, type_ IN NUMBER DEFAULT 1) RETURN VARCHAR2 deterministic IS
 -------------------------------------------------------------------
 -- ������:  23/10/2015
 -------------------------------------------------------------------
 -- ��� ������� ��� ������������� ��������� ��� ��� ������������� (������ BRANCH)
 -- ���������:
 --    branch_ - ��� �������������
 --    type_ - ��� ������ ���� ������� ��� ��
 --          =4 - ����� ������� ACCOUNTS ���� TOBO ++++++++++ (��� online - �������������) ++++++++++
 --          =5 - ���������� ��� ������� � ��� ������������� (�� ���� 4)
 ----------------------------------------------------------------
mfo_  VARCHAR2(12);
nbuc_ VARCHAR2(20):=NULL;
isp_  NUMBER;
type_branch_ NUMBER;
b040_ VARCHAR2(20);
bpos_ NUMBER;
pr_ NUMBER:=0;
nbs_  VARCHAR2(4);

sql_    VARCHAR2(1000);
TYPE CURSORType IS REF CURSOR;
CURS_ CURSORType;

r_type_ NUMBER;

BEGIN
   if branch_ is not null then
      select distinct NVL(trim(b.b040),'000000000000') nbuc
      into b040_
      from tobo b
      where b.tobo = branch_;

      IF b040_ IS NOT NULL THEN
         type_branch_ := TO_NUMBER(SUBSTR(b040_, 9, 1));

         IF type_branch_ = 0 THEN
            bpos_ := 4;
         ELSIF type_branch_ = 1 THEN
            bpos_ := 10;
         ELSE
            bpos_ := 15;
         END IF;

         -- ��� �������
         nbuc_:=SUBSTR(b040_, bpos_, 2);

         -- � ������� ���� �������+��� �������������
         IF r_type_ IN (3, 5) THEN
            nbuc_:=nbuc_ || SUBSTR(Trim(b040_), -12);
         END IF;
      ELSE
         nbuc_:=NULL;
      END IF;
   ELSE
      nbuc_:=NULL;
   END IF;

   RETURN nbuc_;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_codobl_branch.sql =========*** En
 PROMPT ===================================================================================== 
 