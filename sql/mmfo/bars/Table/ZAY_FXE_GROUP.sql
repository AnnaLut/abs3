PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_FXE_GROUP_GROUP.sql =========*** Run *** =====
PROMPT ===================================================================================== 



PROMPT *** ALTER_POLICY_INFO to ZAY_FXE_GROUP ***

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_FXE_GROUP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ZAY_FXE_GROUP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** CREATE TABLE to ZAY_FXE_GROUP ***

BEGIN
   EXECUTE IMMEDIATE q'[
            CREATE TABLE BARS.ZAY_FXE_GROUP (
                                             STATE      VARCHAR2(30)  CONSTRAINT CC_ZAY_FXE_GROUP_STATE_NN NOT NULL  
                                            ,PDAT       DATE
                                            ,KV         VARCHAR2(3)  
                                            ,S          NUMBER(24)
                                            ,KURS_F     NUMBER         CONSTRAINT CC_ZAY_FXE_GROUP_KURS_F_NN NOT NULL
                                            ,KV2        VARCHAR2(3)
                                            ,S2         NUMBER(24)
                                            ,OSTC_29003 NUMBER(24)
                                            ,USER_ID    NUMBER(38)     default SYS_CONTEXT('bars_global','user_id') CONSTRAINT CC_ZAY_FXE_GROUP_USER_ID_NN NOT NULL
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


PROMPT *** ALTER_POLICIES to ZAY_FXE_GROUP ***
exec bpa.alter_policies('ZAY_FXE_GROUP');


COMMENT ON TABLE BARS.ZAY_FXE_GROUP IS             'Згруповані дані для формування FXE';
COMMENT ON COLUMN BARS.ZAY_FXE_GROUP.STATE IS      'Купівля, Продаж, Конверсія купівля, Конверсія продаж';
COMMENT ON COLUMN BARS.ZAY_FXE_GROUP.PDAT IS       'Дата проводкі';
COMMENT ON COLUMN BARS.ZAY_FXE_GROUP.KV IS         'Код валюти вхідного документа';
COMMENT ON COLUMN BARS.ZAY_FXE_GROUP.S IS          'Сума документу';
COMMENT ON COLUMN BARS.ZAY_FXE_GROUP.KURS_F IS     'Курс';
COMMENT ON COLUMN BARS.ZAY_FXE_GROUP.KV2 IS        'Код валюти кредиту документа';
COMMENT ON COLUMN BARS.ZAY_FXE_GROUP.S2 IS         'Сума кредиту документу';
COMMENT ON COLUMN BARS.ZAY_FXE_GROUP.OSTC_29003 IS 'Залишок на 29003';
COMMENT ON COLUMN BARS.ZAY_FXE_GROUP.USER_ID IS 'ID користувача';



PROMPT *** Create  grants  ZAY_FXE_GROUP ***

grant DELETE,INSERT,SELECT                                            on BARS.ZAY_FXE_GROUP         to BARS_ACCESS_DEFROLE;