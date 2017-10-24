/* 
Infragistics WebSchedule Common Script 
Version 1.1.20041.10
Copyright (c) 2003-2004 Infragistics, Inc. All Rights Reserved.
Comments:
Functions marked public are for use by developers and are documented and supported.
Functions marked private are for the internal use of the WebDatePicker component.  
Functions marked private should not be used directly by developers
and are not documented for use by developers and are not supported for use by developers
*/

function ig_DateFormatInfo(props){
	this.DayNames							= props[0];
	this.AbbreviatedDayNames				= props[1];
	this.MonthNames							= props[2];
	this.AbbreviatedMonthNames				= props[3];
	this.FullDateTimePattern				= props[4];
	this.LongDatePattern					= props[5];
	this.LongTimePattern					= props[6];
	this.MonthDayPattern					= props[7];
	this.RFC1123Pattern						= props[8];
	this.ShortDatePattern					= props[9];
	this.ShortTimePattern					= props[10];
	this.SortableDateTimePattern			= props[11];
	this.UniversalSortableDateTimePattern	= props[12];
	this.YearMonthPattern					= props[13];
	this.AMDesignator						= props[14];
	this.PMDesignator						= props[15];
	this.DateSeparator						= props[16];	
	this.TimeSeparator						= props[17];
}