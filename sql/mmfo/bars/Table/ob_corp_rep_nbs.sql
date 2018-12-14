

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OB_CORP_REP_NBS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OB_CORP_REP_NBS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OB_CORP_REP_NBS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OB_CORP_REP_NBS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OB_CORP_REP_NBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OB_CORP_REP_NBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.OB_CORP_REP_NBS 
   (USERID NUMBER DEFAULT sys_context(''bars_global'', ''user_id''), 
    CORP_ID NUMBER, 
    REP_ID NUMBER, 
    NBS VARCHAR2(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OB_CORP_REP_NBS ***
 exec bpa.alter_policies('OB_CORP_REP_NBS');


COMMENT ON TABLE BARS.OB_CORP_REP_NBS IS 'Налаштування звітів корпоративних клієнтів';
COMMENT ON COLUMN BARS.OB_CORP_REP_NBS.USERID IS 'Ід користувача';
COMMENT ON COLUMN BARS.OB_CORP_REP_NBS.CORP_ID IS 'Ід Корпорації';
COMMENT ON COLUMN BARS.OB_CORP_REP_NBS.REP_ID IS 'Ід звіту';
COMMENT ON COLUMN BARS.OB_CORP_REP_NBS.NBS IS 'Балансовий рахуноу';




PROMPT *** Create  index PK_OB_CORP_REP_NBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OB_CORP_REP_NBS ON BARS.OB_CORP_REP_NBS (USERID, CORP_ID, REP_ID, NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OB_CORP_REP_NBS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OB_CORP_REP_NBS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OB_CORP_REP_NBS.sql =========*** End *
PROMPT ===================================================================================== 

