

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_SEGM_ACC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_SEGM_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_SEGM_ACC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ZAY_SEGM_ACC'', ''FILIAL'' , ''F'', ''F'', ''F'', null);
               bpa.alter_policy_info(''ZAY_SEGM_ACC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAY_SEGM_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAY_SEGM_ACC 
   (	SEGM NUMBER(1,0), 
	ACC NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAY_SEGM_ACC ***
 exec bpa.alter_policies('ZAY_SEGM_ACC');


COMMENT ON TABLE BARS.ZAY_SEGM_ACC IS 'Счета доходов за бирж.операции по сегментам клиента';
COMMENT ON COLUMN BARS.ZAY_SEGM_ACC.SEGM IS 'Сегмент клиента';
COMMENT ON COLUMN BARS.ZAY_SEGM_ACC.ACC IS 'Счет 6114';
COMMENT ON COLUMN BARS.ZAY_SEGM_ACC.KF IS 'Филиал';




PROMPT *** Create  constraint CC_ZAYSEGMACC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_SEGM_ACC MODIFY (KF CONSTRAINT CC_ZAYSEGMACC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ZAYSEGMACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_SEGM_ACC ADD CONSTRAINT PK_ZAYSEGMACC PRIMARY KEY (KF, SEGM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAYSEGMACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ZAYSEGMACC ON BARS.ZAY_SEGM_ACC (KF, SEGM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAY_SEGM_ACC ***
grant SELECT                                                                 on ZAY_SEGM_ACC    to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAY_SEGM_ACC    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAY_SEGM_ACC    to UPLD;
grant FLASHBACK,SELECT                                                       on ZAY_SEGM_ACC    to WR_REFREAD;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_SEGM_ACC    to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_SEGM_ACC.sql =========*** End *** 
PROMPT ===================================================================================== 
