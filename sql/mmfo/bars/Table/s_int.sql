

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S_INT.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S_INT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S_INT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''S_INT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''S_INT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S_INT ***
begin 
  execute immediate '
  CREATE TABLE BARS.S_INT 
   (	ACC NUMBER, 
	P080 VARCHAR2(4), 
	OB22 VARCHAR2(2), 
	MFO VARCHAR2(6), 
	R020_FA VARCHAR2(4), 
	KOR VARCHAR2(4)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S_INT ***
 exec bpa.alter_policies('S_INT');


COMMENT ON TABLE BARS.S_INT IS '';
COMMENT ON COLUMN BARS.S_INT.ACC IS '';
COMMENT ON COLUMN BARS.S_INT.P080 IS '';
COMMENT ON COLUMN BARS.S_INT.OB22 IS '';
COMMENT ON COLUMN BARS.S_INT.MFO IS '';
COMMENT ON COLUMN BARS.S_INT.R020_FA IS '';
COMMENT ON COLUMN BARS.S_INT.KOR IS '';




PROMPT *** Create  constraint SYS_C009188 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S_INT MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  S_INT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on S_INT           to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on S_INT           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S_INT.sql =========*** End *** =======
PROMPT ===================================================================================== 
