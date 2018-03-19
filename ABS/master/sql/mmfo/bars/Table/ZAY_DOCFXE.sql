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


COMMENT ON TABLE BARS.ZAY_DOCFXE IS          'Таблиця для документів, які складають основу FXE';
COMMENT ON COLUMN BARS.ZAY_DOCFXE.STATE IS   'Купівля, Продаж, Конверсія купівля, Конверсія продаж';
COMMENT ON COLUMN BARS.ZAY_DOCFXE.PDAT IS    'Дата проводкі';
COMMENT ON COLUMN BARS.ZAY_DOCFXE.REF IS     'Референс вхідного документу';
COMMENT ON COLUMN BARS.ZAY_DOCFXE.TT IS      'Код операції';
COMMENT ON COLUMN BARS.ZAY_DOCFXE.MFOA IS    'МФО А';
COMMENT ON COLUMN BARS.ZAY_DOCFXE.NLSA IS    'Рахунок А';
COMMENT ON COLUMN BARS.ZAY_DOCFXE.S IS       'Сума документу';
COMMENT ON COLUMN BARS.ZAY_DOCFXE.KV IS      'Код валюти вхідного документа';
COMMENT ON COLUMN BARS.ZAY_DOCFXE.KURS_F IS  'Курс';
COMMENT ON COLUMN BARS.ZAY_DOCFXE.MFOB IS    'МФО Б';
COMMENT ON COLUMN BARS.ZAY_DOCFXE.NLSB IS    'Рахунок Б';
COMMENT ON COLUMN BARS.ZAY_DOCFXE.USER_ID IS 'ID користувача';



PROMPT *** Create  grants  ZAY_DOCFXE ***

grant DELETE,INSERT,SELECT                                            on BARS.ZAY_DOCFXE         to BARS_ACCESS_DEFROLE;
