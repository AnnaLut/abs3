

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BL_BLOCK_DICT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BL_BLOCK_DICT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BL_BLOCK_DICT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BL_BLOCK_DICT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BL_BLOCK_DICT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BL_BLOCK_DICT ***
begin 
  execute immediate '
  CREATE TABLE BARS.BL_BLOCK_DICT 
   (	BLK NUMBER, 
	MESSAGE VARCHAR2(250 CHAR), 
	REPORT VARCHAR2(100 CHAR), 
	AUTHOR VARCHAR2(50 CHAR), 
	PROCESS VARCHAR2(50 CHAR), 
	COUNT_DAY NUMBER, 
	SIGN NUMBER(*,0), 
	SIGN_BL NUMBER(*,0), 
	REASON_GROUP NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BL_BLOCK_DICT ***
 exec bpa.alter_policies('BL_BLOCK_DICT');


COMMENT ON TABLE BARS.BL_BLOCK_DICT IS 'Довідник причин для блокування осіб';
COMMENT ON COLUMN BARS.BL_BLOCK_DICT.BLK IS 'Код блокування';
COMMENT ON COLUMN BARS.BL_BLOCK_DICT.MESSAGE IS 'опис коду';
COMMENT ON COLUMN BARS.BL_BLOCK_DICT.REPORT IS 'Повідомлення для менеджера';
COMMENT ON COLUMN BARS.BL_BLOCK_DICT.AUTHOR IS 'Автор';
COMMENT ON COLUMN BARS.BL_BLOCK_DICT.PROCESS IS 'Процес';
COMMENT ON COLUMN BARS.BL_BLOCK_DICT.COUNT_DAY IS 'Кількість днів';
COMMENT ON COLUMN BARS.BL_BLOCK_DICT.SIGN IS 'Ознака закінчення';
COMMENT ON COLUMN BARS.BL_BLOCK_DICT.SIGN_BL IS 'Перенесення в Black list';
COMMENT ON COLUMN BARS.BL_BLOCK_DICT.REASON_GROUP IS 'код для постановки в Black lіst';




PROMPT *** Create  constraint BL_BLOCK_DICT_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_BLOCK_DICT ADD CONSTRAINT BL_BLOCK_DICT_PK PRIMARY KEY (BLK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BL_BLOCK_DICT ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_BLOCK_DICT ADD CONSTRAINT CC_BL_BLOCK_DICT CHECK (( sign_bl= 1 AND reason_group IS NOT NULL )
        or  (sign_bl=0)
       ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_BLOCK_DICT_BLK ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_BLOCK_DICT MODIFY (BLK CONSTRAINT NN_BL_BLOCK_DICT_BLK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_BLOCK_DICT_MESSAGE ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_BLOCK_DICT MODIFY (MESSAGE CONSTRAINT NN_BL_BLOCK_DICT_MESSAGE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_BLOCK_DICT_REPORT ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_BLOCK_DICT MODIFY (REPORT CONSTRAINT NN_BL_BLOCK_DICT_REPORT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_BLOCK_DICT_DAY ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_BLOCK_DICT MODIFY (COUNT_DAY CONSTRAINT NN_BL_BLOCK_DICT_DAY NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index BL_BLOCK_DICT_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.BL_BLOCK_DICT_PK ON BARS.BL_BLOCK_DICT (BLK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BL_BLOCK_DICT ***
grant SELECT                                                                 on BL_BLOCK_DICT   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BL_BLOCK_DICT   to RBLOCK;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BL_BLOCK_DICT.sql =========*** End ***
PROMPT ===================================================================================== 
