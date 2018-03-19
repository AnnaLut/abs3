PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_REF_NULL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_REF_NULL ***

BEGIN
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_REF_NULL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ZAY_REF_NULL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** CREATE TABLE to ZAY_REF_NULL ***

BEGIN
   EXECUTE IMMEDIATE q'[
            CREATE TABLE BARS.ZAY_REF_NULL (
                                             STATE   VARCHAR2 (30)  CONSTRAINT CC_ZAY_REF_NULL_STATE_NN NOT NULL  
                                            ,MFO     VARCHAR2(12)
                                            ,ND      VARCHAR2(15)
                                            ,KV2     VARCHAR2(3)
                                            ,S       NUMBER(24)  
                                            ,KURS_F  NUMBER         CONSTRAINT CC_ZAY_REF_NULL_KURS_F_NN NOT NULL  
                                            ,PDAT    DATE
                                            ,USER_ID NUMBER(38)     default SYS_CONTEXT('bars_global','user_id') CONSTRAINT CC_ZAY_REF_NULL_USER_ID_NN NOT NULL
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


PROMPT *** ALTER_POLICIES to ZAY_REF_NULL ***
 exec bpa.alter_policies('ZAY_REF_NULL');


COMMENT ON TABLE BARS.ZAY_REF_NULL IS          'Заявки які не враховані при формуванні FXE';
COMMENT ON COLUMN BARS.ZAY_REF_NULL.STATE IS   'Купівля, Продаж, Конверсія купівля, Конверсія продаж';
COMMENT ON COLUMN BARS.ZAY_REF_NULL.MFO IS     'МФО заявки';
COMMENT ON COLUMN BARS.ZAY_REF_NULL.ND IS      'Номер заявки';
COMMENT ON COLUMN BARS.ZAY_REF_NULL.KV2 IS     'Валюта заявки';
COMMENT ON COLUMN BARS.ZAY_REF_NULL.S IS       'Сума заявки';
COMMENT ON COLUMN BARS.ZAY_REF_NULL.KURS_F IS  'Курс';
COMMENT ON COLUMN BARS.ZAY_REF_NULL.PDAT IS    'Дата заявки';
COMMENT ON COLUMN BARS.ZAY_REF_NULL.USER_ID IS 'ID користувача';



PROMPT *** Create  grants  ZAY_REF_NULL ***

grant DELETE,INSERT,SELECT                                            on BARS.ZAY_REF_NULL         to BARS_ACCESS_DEFROLE;
