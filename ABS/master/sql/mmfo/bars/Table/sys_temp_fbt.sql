

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SYS_TEMP_FBT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SYS_TEMP_FBT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SYS_TEMP_FBT ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.SYS_TEMP_FBT 
   (	SCHEMA VARCHAR2(32), 
	OBJECT_NAME VARCHAR2(32), 
	OBJECT# NUMBER, 
	RID UROWID (4000), 
	ACTION CHAR(1)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SYS_TEMP_FBT ***
 exec bpa.alter_policies('SYS_TEMP_FBT');


COMMENT ON TABLE BARS.SYS_TEMP_FBT IS '';
COMMENT ON COLUMN BARS.SYS_TEMP_FBT.SCHEMA IS '';
COMMENT ON COLUMN BARS.SYS_TEMP_FBT.OBJECT_NAME IS '';
COMMENT ON COLUMN BARS.SYS_TEMP_FBT.OBJECT# IS '';
COMMENT ON COLUMN BARS.SYS_TEMP_FBT.RID IS '';
COMMENT ON COLUMN BARS.SYS_TEMP_FBT.ACTION IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SYS_TEMP_FBT.sql =========*** End *** 
PROMPT ===================================================================================== 
