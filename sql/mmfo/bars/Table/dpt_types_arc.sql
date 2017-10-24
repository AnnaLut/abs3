

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_TYPES_ARC.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_TYPES_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_TYPES_ARC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_TYPES_ARC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_TYPES_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_TYPES_ARC 
   (	TYPE_ID NUMBER(38,0), 
	TYPE_NAME VARCHAR2(100), 
	DATE_OFF DATE DEFAULT sysdate, 
	USER_OFF NUMBER(38,0) DEFAULT sys_context(''bars_context'',''user_id''), 
	TYPE_CODE VARCHAR2(4), 
	SORT_ORD NUMBER(38,0), 
	FL_ACTIVE NUMBER(1,0), 
	FL_DEMAND NUMBER(1,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_TYPES_ARC ***
 exec bpa.alter_policies('DPT_TYPES_ARC');


COMMENT ON TABLE BARS.DPT_TYPES_ARC IS 'Типи депозитів фізичних осіб (Архів)';
COMMENT ON COLUMN BARS.DPT_TYPES_ARC.TYPE_ID IS 'Числ.код типу';
COMMENT ON COLUMN BARS.DPT_TYPES_ARC.TYPE_NAME IS 'Найменування типу';
COMMENT ON COLUMN BARS.DPT_TYPES_ARC.DATE_OFF IS 'Дата видалення в архів';
COMMENT ON COLUMN BARS.DPT_TYPES_ARC.USER_OFF IS 'Користувач, видаливший тип в архів';
COMMENT ON COLUMN BARS.DPT_TYPES_ARC.TYPE_CODE IS 'Симв.код типа договора';
COMMENT ON COLUMN BARS.DPT_TYPES_ARC.SORT_ORD IS 'Порядок сортировки';
COMMENT ON COLUMN BARS.DPT_TYPES_ARC.FL_ACTIVE IS 'Ознака активності продукту';
COMMENT ON COLUMN BARS.DPT_TYPES_ARC.FL_DEMAND IS 'Ознака депозитного продукту "До запитання"';




PROMPT *** Create  constraint CC_DPTTYPESARC_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TYPES_ARC MODIFY (TYPE_ID CONSTRAINT CC_DPTTYPESARC_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTYPESARC_USER_OFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TYPES_ARC MODIFY (USER_OFF CONSTRAINT CC_DPTTYPESARC_USER_OFF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTYPESARC_DATE_OFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TYPES_ARC MODIFY (DATE_OFF CONSTRAINT CC_DPTTYPESARC_DATE_OFF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTYPESARC_TYPENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TYPES_ARC MODIFY (TYPE_NAME CONSTRAINT CC_DPTTYPESARC_TYPENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_TYPES_ARC ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on DPT_TYPES_ARC   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_TYPES_ARC   to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_TYPES_ARC.sql =========*** End ***
PROMPT ===================================================================================== 
