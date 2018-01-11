

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VIDSBLK.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VIDSBLK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VIDSBLK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''VIDSBLK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''VIDSBLK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VIDSBLK ***
begin 
  execute immediate '
  CREATE TABLE BARS.VIDSBLK 
   (	BLK NUMBER(*,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VIDSBLK ***
 exec bpa.alter_policies('VIDSBLK');


COMMENT ON TABLE BARS.VIDSBLK IS '';
COMMENT ON COLUMN BARS.VIDSBLK.BLK IS '';
COMMENT ON COLUMN BARS.VIDSBLK.NAME IS '';




PROMPT *** Create  constraint SYS_C009982 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIDSBLK MODIFY (BLK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VIDSBLK ***
grant SELECT                                                                 on VIDSBLK         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VIDSBLK         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VIDSBLK         to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on VIDSBLK         to VIDSBLK;
grant FLASHBACK,SELECT                                                       on VIDSBLK         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VIDSBLK.sql =========*** End *** =====
PROMPT ===================================================================================== 
