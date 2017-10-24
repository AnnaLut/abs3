

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_FA7_REZ1.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_FA7_REZ1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_FA7_REZ1'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_FA7_REZ1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_FA7_REZ1 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.OTCN_FA7_REZ1 
   (	ND NUMBER, 
	ACC NUMBER, 
	NLS VARCHAR2(15), 
	KV NUMBER(*,0), 
	KODP VARCHAR2(20), 
	ZNAP VARCHAR2(200), 
	SUMA NUMBER, 
	SUMD NUMBER, 
	SUMP NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_FA7_REZ1 ***
 exec bpa.alter_policies('OTCN_FA7_REZ1');


COMMENT ON TABLE BARS.OTCN_FA7_REZ1 IS '��������� ������� ��� ���������/������';
COMMENT ON COLUMN BARS.OTCN_FA7_REZ1.ND IS '';
COMMENT ON COLUMN BARS.OTCN_FA7_REZ1.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_FA7_REZ1.NLS IS '';
COMMENT ON COLUMN BARS.OTCN_FA7_REZ1.KV IS '';
COMMENT ON COLUMN BARS.OTCN_FA7_REZ1.KODP IS '';
COMMENT ON COLUMN BARS.OTCN_FA7_REZ1.ZNAP IS '';
COMMENT ON COLUMN BARS.OTCN_FA7_REZ1.SUMA IS '';
COMMENT ON COLUMN BARS.OTCN_FA7_REZ1.SUMD IS '';
COMMENT ON COLUMN BARS.OTCN_FA7_REZ1.SUMP IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_FA7_REZ1.sql =========*** End ***
PROMPT ===================================================================================== 
