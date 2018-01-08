

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NAL_IT.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NAL_IT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NAL_IT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''NAL_IT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NAL_IT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NAL_IT ***
begin 
  execute immediate '
  CREATE TABLE BARS.NAL_IT 
   (	RNK NUMBER(38,0), 
	GG NUMBER(38,0), 
	DD VARCHAR2(2), 
	RR VARCHAR2(4), 
	S1 NUMBER(10,1), 
	S2 NUMBER(10,1), 
	S3 NUMBER(10,1), 
	S4 NUMBER(10,1)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NAL_IT ***
 exec bpa.alter_policies('NAL_IT');


COMMENT ON TABLE BARS.NAL_IT IS '';
COMMENT ON COLUMN BARS.NAL_IT.RNK IS '';
COMMENT ON COLUMN BARS.NAL_IT.GG IS '';
COMMENT ON COLUMN BARS.NAL_IT.DD IS '';
COMMENT ON COLUMN BARS.NAL_IT.RR IS '';
COMMENT ON COLUMN BARS.NAL_IT.S1 IS '';
COMMENT ON COLUMN BARS.NAL_IT.S2 IS '';
COMMENT ON COLUMN BARS.NAL_IT.S3 IS '';
COMMENT ON COLUMN BARS.NAL_IT.S4 IS '';




PROMPT *** Create  constraint SYS_C009045 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAL_IT MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009046 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAL_IT MODIFY (GG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009047 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAL_IT MODIFY (DD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009048 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAL_IT MODIFY (RR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NAL_IT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NAL_IT          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on NAL_IT          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NAL_IT.sql =========*** End *** ======
PROMPT ===================================================================================== 
