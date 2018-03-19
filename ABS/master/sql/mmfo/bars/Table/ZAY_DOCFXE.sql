PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_DOCFXE.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_DOCFXE ***

BEGIN
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_DOCFXE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ZAY_DOCFXE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** CREATE TABLE to ZAY_DOCFXE ***

BEGIN
   EXECUTE IMMEDIATE q'[
            CREATE TABLE BARS.ZAY_DOCFXE (
                                             STATE   VARCHAR2 (30)  CONSTRAINT CC_ZAY_DOCFXE_STATE_NN NOT NULL  
                                            ,PDAT    DATE    
                                            ,REF     NUMBER(38)     CONSTRAINT CC_ZAY_DOCFXE_REF_NN NOT NULL
                                            ,TT      CHAR(3)
                                            ,MFOA    VARCHAR2(12)
                                            ,NLSA    VARCHAR2(15)   
                                            ,S       NUMBER(24)
                                            ,KV      VARCHAR2(3)  
                                            ,KURS_F  NUMBER         CONSTRAINT CC_ZAY_DOCFXE_KURS_F_NN NOT NULL  
                                            ,MFOB    VARCHAR2(12)
                                            ,NLSB    VARCHAR2(15)
                                            ,USER_ID NUMBER(38)     default SYS_CONTEXT('bars_global','user_id') CONSTRAINT CC_ZAY_DOCFXE_USER_ID_NN NOT NULL
            )]';
EXCEPTION
   WHEN OTHERS
   THEN
      IF SQLCODE = -955
      THEN
         NULL;
      ELSE
         RAISE;
      END IF;
END;
/


PROMPT *** ALTER_POLICIES to ZAY_DOCFXE ***
 exec bpa.alter_policies('ZAY_DOCFXE');


COMMENT ON TABLE BARS.ZAY_DOCFXE IS          '������� ��� ���������, �� ��������� ������ FXE';
COMMENT ON COLUMN BARS.ZAY_DOCFXE.STATE IS   '������, ������, �������� ������, �������� ������';
COMMENT ON COLUMN BARS.ZAY_DOCFXE.PDAT IS    '���� �������';
COMMENT ON COLUMN BARS.ZAY_DOCFXE.REF IS     '�������� �������� ���������';
COMMENT ON COLUMN BARS.ZAY_DOCFXE.TT IS      '��� ��������';
COMMENT ON COLUMN BARS.ZAY_DOCFXE.MFOA IS    '��� �';
COMMENT ON COLUMN BARS.ZAY_DOCFXE.NLSA IS    '������� �';
COMMENT ON COLUMN BARS.ZAY_DOCFXE.S IS       '���� ���������';
COMMENT ON COLUMN BARS.ZAY_DOCFXE.KV IS      '��� ������ �������� ���������';
COMMENT ON COLUMN BARS.ZAY_DOCFXE.KURS_F IS  '����';
COMMENT ON COLUMN BARS.ZAY_DOCFXE.MFOB IS    '��� �';
COMMENT ON COLUMN BARS.ZAY_DOCFXE.NLSB IS    '������� �';
COMMENT ON COLUMN BARS.ZAY_DOCFXE.USER_ID IS 'ID �����������';



PROMPT *** Create  grants  ZAY_DOCFXE ***

grant DELETE,INSERT,SELECT                                            on BARS.ZAY_DOCFXE         to BARS_ACCESS_DEFROLE;
